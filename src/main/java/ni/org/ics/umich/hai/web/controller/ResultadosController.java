package ni.org.ics.umich.hai.web.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import ni.org.ics.umich.hai.domain.catalogs.Antigeno;
import ni.org.ics.umich.hai.domain.catalogs.Titulo;
import ni.org.ics.umich.hai.domain.results.Detalle;
import ni.org.ics.umich.hai.domain.results.Encabezado;
import ni.org.ics.umich.hai.language.MessageResource;
import ni.org.ics.umich.hai.service.CatalogoService;
import ni.org.ics.umich.hai.service.MessageResourceService;
import ni.org.ics.umich.hai.service.ResultadoService;
import org.apache.commons.lang3.text.translate.UnicodeEscaper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by FIRSTICT on 9/5/2016.
 * V1.0
 */
@Controller
@RequestMapping("results")
public class ResultadosController {

    @Autowired
    private CatalogoService catalogoService;

    @Autowired
    private ResultadoService resultadoService;

    @Autowired
    private MessageResourceService messageResourceService;

    @RequestMapping(value = "newResult", method = RequestMethod.GET)
    public String newResult(Model model) {
        List<Antigeno> antigenos = catalogoService.getAntigens();
        model.addAttribute("antigenos",antigenos);
        List<Titulo> titulos = catalogoService.getTitles();
        model.addAttribute("titulos",titulos);
        model.addAttribute("editando",false);
        return "results/enterForm";
    }

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String list(Model model) {
        List<Encabezado> encabezados = resultadoService.getHeaders();
        model.addAttribute("encabezados",encabezados);
        return "results/list";
    }

    @RequestMapping(value = "editResult/{id}", method = RequestMethod.GET)
    public String editResult(@PathVariable("id") int id, Model model) {
        Encabezado encabezado = resultadoService.getHeaderById(id);
        model.addAttribute("encabezado",encabezado);
        List<Antigeno> antigenos = catalogoService.getAntigens();
        model.addAttribute("antigenos",antigenos);
        List<Titulo> titulos = catalogoService.getTitles();
        model.addAttribute("titulos",titulos);
        model.addAttribute("editando",true);
        return "results/enterForm";
    }

    @RequestMapping(value = "saveResult", method = RequestMethod.POST)
    protected ResponseEntity<String> saveResult(
            @RequestParam( value="id", required=true ) Integer id
            ,@RequestParam(value="rundate", required=true ) String rundate
            , @RequestParam( value="runnumber", required=true ) Integer runnumber
            , @RequestParam( value="antigeno", required=false ) int antigeno
            , @RequestParam( value="positivecontrol", required=false ) String positivecontrol,
              @RequestParam( value="negativecontrol", required=false ) String negativecontrol
    ) throws Exception {
        try{
            Encabezado encabezado = null;

            if (id!=null) encabezado = resultadoService.getHeaderById(id);
            if (encabezado == null){
                encabezado = new Encabezado();
                //usuario autenticado
                Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
                encabezado.setRecordUser(authentication.getName());
                encabezado.setRecordDate(new Date());
                encabezado.setPasive('0');
            }

            encabezado.setAntigeno(catalogoService.getAntigenById(antigeno));
            encabezado.setCtrlNegativo(negativecontrol);
            encabezado.setCtrlPositivo(positivecontrol);
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy");
            Date fecha = simpleDateFormat.parse(rundate);
            encabezado.setFechaCorrida(fecha);
            encabezado.setNumCorrida(runnumber);

            resultadoService.saveHeader(encabezado);

            return createJsonResponse(encabezado);
        }catch(Exception e){
            e.printStackTrace();
            Gson gson = new Gson();
            String json = gson.toJson(e.toString());
            return new ResponseEntity<String>( json, HttpStatus.CREATED);
        }
    }

    @RequestMapping(value = "saveResultDetail", method = RequestMethod.POST)
    protected ResponseEntity<String> saveResultDetail(HttpServletRequest request
            , @RequestParam(value = "idDetalle", required = true) Integer id
            , @RequestParam(value="codigoMx", required=true ) String codigoMx
            , @RequestParam( value="idEncabezado", required=true ) int idEncabezado
            , @RequestParam( value="titulo", required=false ) int idTitulo) throws Exception {
        try{
            if (resultadoService.validateCode(codigoMx)){
                Detalle detalle = null;
                if (id !=null) detalle = resultadoService.getDetailById(id);
                if (detalle==null) {
                    detalle = new Detalle();
                    detalle.setEncabezado(resultadoService.getHeaderById(idEncabezado));
                    //usuario autenticado
                    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
                    detalle.setRecordUser(authentication.getName());
                    detalle.setRecordDate(new Date());
                    detalle.setPasive('0');
                }

                detalle.setCodigoMx(codigoMx);
                detalle.setTitulo(catalogoService.getTitleById(idTitulo));

                resultadoService.saveDetail(detalle);

                return createJsonResponse(detalle);
            }else {
                //informar a usuario que no se encontró codigo de muestra en inventario
                throw new Exception(getMessageCodeNotFoundException(request.getCookies(),codigoMx));
            }
        }catch(Exception e){
            Gson gson = new Gson();
            String json = gson.toJson(e.toString());
            return new ResponseEntity<String>( json, HttpStatus.CREATED);
        }
    }

    @RequestMapping(value = "getDetailByHeader", method = RequestMethod.GET, produces = "application/json")
    public
    @ResponseBody
    String getDetailByHeader(@RequestParam(value = "idEncabezado", required = false) int idEncabezado) throws Exception {
        return detalleToJson(resultadoService.getDetailByHeader(idEncabezado));
    }

    @RequestMapping(value = "getDetailById", method = RequestMethod.GET, produces = "application/json")
    public
    @ResponseBody
    Detalle getDetailById(@RequestParam(value = "id", required = false) int id) throws Exception {
        return resultadoService.getDetailById(id);
    }

    @RequestMapping("deleteHeader/{id}")
    public String deleteHeader(@PathVariable("id") int id
                             , RedirectAttributes redirectAttributes) {

       Encabezado encabezado = resultadoService.getHeaderById(id);
        if(encabezado!=null){
            encabezado.setPasive('1');
            try {
                resultadoService.saveHeader(encabezado);
                try {
                    resultadoService.deleteDetailByIdHeader(id);
                    redirectAttributes.addFlashAttribute("eliminado", true);
                }catch (Exception ex){
                    //si dio error al pasivar detalle, activar encabezado
                    encabezado.setPasive('0');
                    resultadoService.saveHeader(encabezado);
                    ex.printStackTrace();
                    redirectAttributes.addFlashAttribute("eliminado", false);
                }
            }catch (Exception ex){
                ex.printStackTrace();
                redirectAttributes.addFlashAttribute("eliminado", false);
            }
        }else{
            redirectAttributes.addFlashAttribute("eliminado", false);
        }

        return "redirect:/results/list/";
    }

    @RequestMapping("deleteDetail/{id}")
    public String deleteDetail(@PathVariable("id") int id
            , RedirectAttributes redirectAttributes) {
        String idEncabezado="";
        Detalle detalle = resultadoService.getDetailById(id);
        if(detalle!=null){
            detalle.setPasive('1');
            resultadoService.saveDetail(detalle);
            redirectAttributes.addFlashAttribute("eliminado", true);
            idEncabezado = String.valueOf(detalle.getEncabezado().getId());
        }else{
            redirectAttributes.addFlashAttribute("eliminado", false);
        }

        return "redirect:/results/editResult/"+idEncabezado;
    }

    private ResponseEntity<String> createJsonResponse( Object o )
    {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");
        Gson gson = new GsonBuilder()
                .excludeFieldsWithoutExposeAnnotation()
                .create();
        String json = gson.toJson(o);
        return new ResponseEntity<String>( json, headers, HttpStatus.CREATED );
    }

    private String detalleToJson(List<Detalle> detalleList) {
        String jsonResponse = "";
        Map<Integer, Object> mapResponse = new HashMap<Integer, Object>();
        Integer indice = 0;
        if (detalleList != null) {
            for (Detalle det : detalleList) {
                Map<String, String> map = new HashMap<String, String>();
                map.put("id", String.valueOf(det.getId()));
                map.put("codigoMx", det.getCodigoMx());
                map.put("titulo",det.getTitulo().getValor());
                mapResponse.put(indice, map);
                indice++;
            }
        }
        jsonResponse = new Gson().toJson(mapResponse);
        UnicodeEscaper escaper = UnicodeEscaper.above(127);
        return escaper.translate(jsonResponse);
    }

    private String getMessageCodeNotFoundException(Cookie[] cookies, String codigoMx){
        String lan = "es"; //por defecto tomar español
        if (cookies != null) {
            for (int i = 0; i < cookies.length; i++) {
                if (cookies[i].getName().equalsIgnoreCase("prLang")) {
                    lan = cookies[i].getValue();
                }
            }
        }
        MessageResource message = messageResourceService.getMessage("codenotfound");
        String msg = "Código no encontrado: ?"; //mensaje por defecto si no se logra obtener desde BD
        if (message!=null){
            if (lan.matches("es")) msg = message.getSpanish();
            else msg = message.getEnglish();
        }
        return msg.replaceAll("\\?",codigoMx);
    }
}
