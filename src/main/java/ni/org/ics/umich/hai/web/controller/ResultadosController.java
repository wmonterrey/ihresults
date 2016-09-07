package ni.org.ics.umich.hai.web.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import ni.org.ics.umich.hai.domain.catalogs.Antigeno;
import ni.org.ics.umich.hai.domain.catalogs.Titulo;
import ni.org.ics.umich.hai.domain.results.Detalle;
import ni.org.ics.umich.hai.domain.results.Encabezado;
import ni.org.ics.umich.hai.service.CatalogoService;
import ni.org.ics.umich.hai.service.ResultadoService;
import ni.org.ics.umich.hai.service.UsuarioService;
import ni.org.ics.umich.hai.users.model.UserSistema;
import org.apache.commons.lang3.text.translate.UnicodeEscaper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
    private UsuarioService usuarioService;

    @RequestMapping(value = "newResult", method = RequestMethod.GET)
    public String showUser(Model model) {
        List<Antigeno> antigenos = catalogoService.getAntigens();
        model.addAttribute("antigenos",antigenos);
        List<Titulo> titulos = catalogoService.getTitles();
        model.addAttribute("titulos",titulos);
        return "results/enterForm";
    }

    @RequestMapping(value = "addResult", method = RequestMethod.POST)
    protected ResponseEntity<String> addResult(
            @RequestParam( value="id", required=true ) Integer id
            ,@RequestParam(value="rundate", required=true ) Date rundate
            , @RequestParam( value="runnumber", required=true ) Integer runnumber
            , @RequestParam( value="antigeno", required=false ) int antigeno
            , @RequestParam( value="positivecontrol", required=false ) String positivecontrol,
              @RequestParam( value="negativecontrol", required=false ) String negativecontrol
    ) throws Exception {
        try{
            Encabezado encabezado = null;

            if (id!=null) encabezado = resultadoService.getHeaderById(id);
            if (encabezado == null)
                encabezado = new Encabezado();

            encabezado.setAntigeno(catalogoService.getAntigenById(antigeno));
            encabezado.setCtrlNegativo(negativecontrol);
            encabezado.setCtrlPositivo(positivecontrol);
            encabezado.setFechaCorrida(rundate);
            encabezado.setNumCorrida(runnumber);
            //usuario autenticado
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            UserSistema usuario = this.usuarioService.getUser(authentication.getName());
            encabezado.setUsuarioRegistro(usuario);

            resultadoService.saveHeader(encabezado);

            return createJsonResponse(encabezado);
        }catch(Exception e){
            e.printStackTrace();
            Gson gson = new Gson();
            String json = gson.toJson(e.toString());
            return new ResponseEntity<String>( json, HttpStatus.CREATED);
        }
    }

    @RequestMapping(value = "addResultDetail", method = RequestMethod.POST)
    protected ResponseEntity<String> addResultDetail(@RequestParam(value="codigoMx", required=true ) String codigoMx
            , @RequestParam( value="idEncabezado", required=true ) int idEncabezado
            , @RequestParam( value="titulo", required=false ) int idTitulo) throws Exception {
        try{
            Detalle detalle = new Detalle();
            detalle.setCodigoMx(codigoMx);
            detalle.setEncabezado(resultadoService.getHeaderById(idEncabezado));
            detalle.setTitulo(catalogoService.getTitleById(idTitulo));
            //usuario autenticado
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            UserSistema usuario = this.usuarioService.getUser(authentication.getName());
            detalle.setUsuarioRegistro(usuario);

            resultadoService.saveDetail(detalle);

            return createJsonResponse(detalle);
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
}
