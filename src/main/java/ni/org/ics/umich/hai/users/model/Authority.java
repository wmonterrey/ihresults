package ni.org.ics.umich.hai.users.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;



import ni.org.ics.umich.hai.domain.BaseMetaData;
import ni.org.ics.umich.hai.domain.audit.Auditable;

import org.hibernate.annotations.ForeignKey;

/**
 * Simple objeto de dominio que representa un rol para un usuario
 * 
 * @author William Aviles
 **/

@Entity
@Table(name = "users_roles", catalog = "hai")
public class Authority extends BaseMetaData implements Auditable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private AuthorityId authId;
	private UserSistema user;
	private Rol rol;
	
	
	@Id
	public AuthorityId getAuthId() {
		return authId;
	}
	public void setAuthId(AuthorityId authId) {
		this.authId = authId;
	}
	
	@ManyToOne
	@JoinColumn(name="NOMBRE_USUARIO", insertable = false, updatable = false)
	@ForeignKey(name = "ROLES_USUARIOS_FK")
	public UserSistema getUser() {
		return user;
	}
	
	public void setUser(UserSistema user) {
		this.user = user;
	}
	@ManyToOne
	@JoinColumn(name="ROL", insertable = false, updatable = false)
	@ForeignKey(name = "ROLES_ROL_FK")
	public Rol getRol() {
		return rol;
	}
	public void setRol(Rol rol) {
		this.rol = rol;
	}
	
	@Override
	public String toString(){
		return authId.getAuthority();
	}
	@Override
	public boolean isFieldAuditable(String fieldname) {
		//Campos no auditables en la tabla
		if(fieldname.matches("recordDate")||fieldname.matches("recordUser")){
			return false;
		}		
		return true;
	}

}
