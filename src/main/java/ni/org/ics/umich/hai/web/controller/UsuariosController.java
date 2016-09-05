package ni.org.ics.umich.hai.web.controller;

import java.util.List;

import javax.annotation.Resource;



import ni.org.ics.umich.hai.service.UsuarioService;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * Controlador web de peticiones relacionadas a usuarios
 * 
 * @author William Avilés
 */
@Controller
@RequestMapping("/users/*")
public class UsuariosController {
	@Resource(name="usuarioService")
	private UsuarioService usuarioService;
	
	
	@RequestMapping(value="checkcredential", method=RequestMethod.GET)
	public @ResponseBody boolean getCredential(@RequestParam String userName) {
	    return this.usuarioService.checkCredential(userName);
	}
	
	@RequestMapping(value = "forcechgpass", method = RequestMethod.GET)
    public String initForceChangePassForm() {
	    return "forceChgPass";
    }
	
	/**
     * Custom handler for displaying an user.
     *
     * @param username the ID of the user to display
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping("profile")
    public ModelAndView showUser() {
        ModelAndView mav = new ModelAndView("users/user");
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        ni.org.ics.umich.hai.users.model.UserSistema user = this.usuarioService.getUser(authentication.getName());
        List<ni.org.ics.umich.hai.users.model.UserAccess> accesosUsuario = usuarioService.getUserAccess(authentication.getName());
        mav.addObject("user",user);
        mav.addObject("accesses",accesosUsuario);
        return mav;
    }
	
}
