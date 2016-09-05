package ni.org.ics.umich.hai.web.controller;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import ni.org.ics.umich.hai.domain.audit.AuditTrail;
import ni.org.ics.umich.hai.service.AuditTrailService;
import ni.org.ics.umich.hai.service.UsuarioService;
import ni.org.ics.umich.hai.users.model.Rol;
import ni.org.ics.umich.hai.users.model.UserAccess;
import ni.org.ics.umich.hai.users.model.UserSistema;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

/**
 * Controlador web de peticiones relacionadas a usuarios
 * 
 * @author William Avilés
 */
@Controller
@RequestMapping("/admin/users/*")
public class AdminUsuariosController {
	private static final Logger logger = LoggerFactory.getLogger(AdminUsuariosController.class);
	@Resource(name="usuarioService")
	private UsuarioService usuarioService;	
	@Resource(name="auditTrailService")
	private AuditTrailService auditTrailService;	
    
	@RequestMapping(value = "/", method = RequestMethod.GET)
    public String obtenerUsuarios(Model model) throws ParseException { 	
    	logger.debug("Mostrando Usuarios en JSP");
    	List<UserSistema> usuarios = usuarioService.getUsers();
    	model.addAttribute("usuarios", usuarios);
    	return "admin/users/list";
	}
	
	
	/**
     * Custom handler for adding an user.
     *
     * @param username the ID of the user to display
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping(value = "newUser", method = RequestMethod.GET)
	public String initAddUserForm(Model model) {
    	List<Rol> roles = usuarioService.getRoles();
	    model.addAttribute("roles", roles);
	    model.addAttribute("agregando",true);
		return "admin/users/enterForm";
	}
	
	/**
     * Custom handler for editing an user.
     *
     * @param username the ID of the user to display
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping(value = "editUser/{username}", method = RequestMethod.GET)
	public String initUpdateUserForm(@PathVariable("username") String username, Model model) {
		UserSistema usuarioEditar = this.usuarioService.getUsuarioEditar(username);
		if(usuarioEditar!=null){
			model.addAttribute("user",usuarioEditar);
			List<Rol> roles = usuarioService.getRoles();
	    	model.addAttribute("roles", roles);
	    	model.addAttribute("editando",true);
			return "admin/users/enterForm";
		}
		else{
			return "403";
		}
	}
    
    
    @RequestMapping( value="saveUser", method=RequestMethod.POST)
	public ResponseEntity<String> processUpdateUserForm( @RequestParam(value="username", required=true ) String userName
	        , @RequestParam( value="completeName", required=true ) String completeName
	        , @RequestParam( value="confirm_password", required=false ) String confirmPassword
	        , @RequestParam( value="password", required=false, defaultValue="" ) String password
	        , @RequestParam( value="email", required=true, defaultValue="" ) String email
	        , @RequestParam( value="authorities", required=false, defaultValue="") List<String> authorities
	        )
	{
    	try{
	    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
			//UserSistema user = this.usuarioService.getUsuarioEditar(userName,usuarioActual);
	    	UserSistema user = this.usuarioService.getUser(userName);
	    	if (user==null){
	    		user = new UserSistema();
	    		user.setUsername(userName);
	    		user.setCompleteName(completeName);
	    		user.setEmail(email);
	    		user.setCreated(new Date());
	    		user.setCreatedBy(usuarioActual.getUsername());
	    		user.setModified(new Date());
	    		user.setModifiedBy(usuarioActual.getUsername());
	    		user.setLastCredentialChange(new Date());
	    	}
	    	else{
				user.setModifiedBy(usuarioActual.getUsername());
				user.setCompleteName(completeName);
				user.setEmail(email);
				user.setModified(new Date());
				user.setAuthorities(null);
				this.usuarioService.saveUser(user);
	    	}
			
			return createJsonResponse(user);
    	}
    	catch(Exception e){
    		Gson gson = new Gson();
    	    String json = gson.toJson(e.toString());
    		return new ResponseEntity<String>( json, HttpStatus.CREATED);
    	}
	}
    
	/**
     * Custom handler for enabling/disabling an user.
     *
     * @param username the ID of the user to enable
     * @return a String
     */
    @RequestMapping("/habdes/{accion}/{username}")
    public String enableUser(@PathVariable("username") String username, 
    		@PathVariable("accion") String accion, RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	boolean hab;
    	if (accion.matches("enable1")){
    		redirecTo = "redirect:/admin/users/";
    		hab = true;
    		redirectAttributes.addFlashAttribute("usuarioHabilitado", true);
        }
        else if (accion.matches("enable2")){
        	redirecTo = "redirect:/admin/users/{username}";
    		hab = true;
    		redirectAttributes.addFlashAttribute("usuarioHabilitado", true);
        }
        else if(accion.matches("disable1")){
        	redirecTo = "redirect:/admin/users/";
    		hab = false;
    		redirectAttributes.addFlashAttribute("usuarioDeshabilitado", true);
        }
        else if(accion.matches("disable2")){
        	redirecTo = "redirect:/admin/users/{username}";
    		hab = false;
    		redirectAttributes.addFlashAttribute("usuarioDeshabilitado", true);
        }
        else{
        	return redirecTo;
        }
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
		UserSistema user = this.usuarioService.getUsuarioEditar(username);
    	if(user!=null){
    		user.setModified(new Date());
    		user.setModifiedBy(usuarioActual.getUsername());
    		user.setEnabled(hab);
    		this.usuarioService.saveUser(user);
    		redirectAttributes.addFlashAttribute("nombreUsuario", username);
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
    
    /**
     * Custom handler for locking/unlocking an user.
     *
     * @param username the ID of the user to lock/unlock
     * @return a String
     */
    @RequestMapping("/lockunl/{accion}/{username}")
    public String lockUnlockUser(@PathVariable("username") String username, 
    		@PathVariable("accion") String accion, RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	boolean lock;
    	if (accion.matches("lock1")){
    		redirecTo = "redirect:/admin/users/";
    		lock = true;
    		redirectAttributes.addFlashAttribute("usuarioBloqueado", true);
        }
        else if (accion.matches("lock2")){
        	redirecTo = "redirect:/admin/users/{username}";
    		lock = true;
    		redirectAttributes.addFlashAttribute("usuarioBloqueado", true);
        }
        else if(accion.matches("unlock1")){
        	redirecTo = "redirect:/admin/users/";
    		lock = false;
    		redirectAttributes.addFlashAttribute("usuarioNoBloqueado", true);
        }
        else if(accion.matches("unlock2")){
        	redirecTo = "redirect:/admin/users/{username}";
    		lock = false;
    		redirectAttributes.addFlashAttribute("usuarioNoBloqueado", true);
        }
        else{
        	return redirecTo;
        }
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
		UserSistema user = this.usuarioService.getUsuarioEditar(username);
    	if(user!=null){
    		user.setModified(new Date());
    		user.setModifiedBy(usuarioActual.getUsername());
    		user.setAccountNonLocked(!lock);
    		this.usuarioService.saveUser(user);
    		redirectAttributes.addFlashAttribute("nombreUsuario", username);
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
    
    /**
     * Custom handler for displaying an user.
     *
     * @param username the ID of the user to display
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping("/{username}")
    public ModelAndView showUser(@PathVariable("username") String username) {
    	ModelAndView mav;
		UserSistema user = this.usuarioService.getUsuarioEditar(username);
        if(user==null){
        	mav = new ModelAndView("403");
        }
        else{
        	mav = new ModelAndView("admin/users/user");
            List<UserAccess> accesosUsuario = usuarioService.getUserAccess(username);
            List<AuditTrail> bitacoraUsuario = auditTrailService.getBitacora(username);
            mav.addObject("user",user);
            mav.addObject("accesses",accesosUsuario);
            mav.addObject("bitacora",bitacoraUsuario);
        }
        return mav;
    }
    
    private ResponseEntity<String> createJsonResponse( Object o )
	{
	    HttpHeaders headers = new HttpHeaders();
	    headers.set("Content-Type", "application/json");
	    Gson gson = new Gson();
	    String json = gson.toJson(o);
	    return new ResponseEntity<String>( json, headers, HttpStatus.CREATED );
	}
	
}
