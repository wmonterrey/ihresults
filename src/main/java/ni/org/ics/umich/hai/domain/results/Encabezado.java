package ni.org.ics.umich.hai.domain.results;

import com.google.gson.annotations.Expose;
import ni.org.ics.umich.hai.domain.audit.Auditable;
import ni.org.ics.umich.hai.domain.catalogs.Antigeno;
import ni.org.ics.umich.hai.users.model.UserSistema;
import org.hibernate.annotations.ForeignKey;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by FIRSTICT on 9/5/2016.
 * V1.0
 */
@Entity
@Table(name = "encabezado", catalog = "hai")
public class Encabezado implements Serializable, Auditable {
    @Expose
    private int id;
    @Expose
    private Date fechaCorrida;
    @Expose
    private Integer numCorrida;
    @Expose
    private Antigeno antigeno;
    @Expose
    private String ctrlPositivo;
    @Expose
    private String ctrlNegativo;
    @Expose
    private Date fechaRegistro = new Date();

    private UserSistema usuarioRegistro;

    @Id
    @GenericGenerator(name="idautoinc3" , strategy="increment")
    @GeneratedValue(generator="idautoinc3")
    @Column(name="ID")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Column(name = "FECHA_CORRIDA")
    public Date getFechaCorrida() {
        return fechaCorrida;
    }

    public void setFechaCorrida(Date fechaCorrida) {
        this.fechaCorrida = fechaCorrida;
    }

    @Column(name ="NUM_CORRIDA", nullable = true)
    public Integer getNumCorrida() {
        return numCorrida;
    }

    public void setNumCorrida(Integer numCorrida) {
        this.numCorrida = numCorrida;
    }

    @ManyToOne(optional = false)
    @JoinColumn(name = "ID_ANTIGENO", referencedColumnName = "ID")
    @ForeignKey(name = "ANTIGENO_ENCABEZADO_FK")
    public Antigeno getAntigeno() {
        return antigeno;
    }

    public void setAntigeno(Antigeno antigeno) {
        this.antigeno = antigeno;
    }

    @Column(name = "CONTROL_POSITIVO", length = 150, nullable = false)
    public String getCtrlPositivo() {
        return ctrlPositivo;
    }

    public void setCtrlPositivo(String ctrlPositivo) {
        this.ctrlPositivo = ctrlPositivo;
    }

    @Column(name = "CONTROL_NEGATIVO", length = 150, nullable = false)
    public String getCtrlNegativo() {
        return ctrlNegativo;
    }

    public void setCtrlNegativo(String ctrlNegativo) {
        this.ctrlNegativo = ctrlNegativo;
    }

    @Column(name = "FECHA_REGISTRO", nullable = false)
    public Date getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Date fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    @ManyToOne(optional = false)
    @JoinColumn(name = "USUARIO_REGISTRO", referencedColumnName = "NOMBRE_USUARIO")
    @ForeignKey(name = "USUARIO_ENCABEZADO_FK")
    public UserSistema getUsuarioRegistro() {
        return usuarioRegistro;
    }

    public void setUsuarioRegistro(UserSistema usuarioRegistro) {
        this.usuarioRegistro = usuarioRegistro;
    }

    @Override
    public String toString() {
        return "'" + id + "'";
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Encabezado)) return false;

        Encabezado that = (Encabezado) o;

        if (id != that.id) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return id;
    }

    @Override
    public boolean isFieldAuditable(String fieldname) {
        if (fieldname.matches("fechaRegistro") || fieldname.matches("usuarioRegistro"))
            return false;
        else
            return true;
    }
}
