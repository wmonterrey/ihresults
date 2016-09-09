package ni.org.ics.umich.hai.domain.results;

import com.google.gson.annotations.Expose;
import ni.org.ics.umich.hai.domain.BaseMetaData;
import ni.org.ics.umich.hai.domain.audit.Auditable;
import ni.org.ics.umich.hai.domain.catalogs.Titulo;
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
@Table(name = "detalle", catalog = "hai")
public class Detalle extends BaseMetaData implements Serializable, Auditable {

    @Expose
    private int id;
    @Expose
    private String codigoMx;
    @Expose
    private Titulo titulo;
    @Expose
    private Encabezado encabezado;

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

    @Column(name = "CODIGO_MX", length = 100, nullable = false)
    public String getCodigoMx() {
        return codigoMx;
    }

    public void setCodigoMx(String codigoMx) {
        this.codigoMx = codigoMx;
    }

    @ManyToOne(optional = false)
    @JoinColumn(name = "ID_TITULO", referencedColumnName = "ID")
    @ForeignKey(name = "TITULO_DETALLE_FK")
    public Titulo getTitulo() {
        return titulo;
    }

    public void setTitulo(Titulo titulo) {
        this.titulo = titulo;
    }

    @ManyToOne(optional = false)
    @JoinColumn(name = "ID_ENCABEZADO",referencedColumnName = "ID")
    @ForeignKey(name = "ENCABEZADO_DETALLE_FK")
    public Encabezado getEncabezado() {
        return encabezado;
    }

    public void setEncabezado(Encabezado encabezado) {
        this.encabezado = encabezado;
    }

    @Override
    public String toString() {
        return "id=" + id + "'";
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Detalle)) return false;

        Detalle detalle = (Detalle) o;

        if (id != detalle.id) return false;

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
