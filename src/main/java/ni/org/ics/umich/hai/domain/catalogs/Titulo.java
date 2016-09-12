package ni.org.ics.umich.hai.domain.catalogs;

import ni.org.ics.umich.hai.domain.audit.Auditable;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by FIRSTICT on 9/5/2016.
 * V1.0
 */
@Entity
@Table(name = "catalogo_titulo", catalog = "hai")
public class Titulo implements Serializable, Auditable {
    private int id;
    private String valor;
    private Boolean activo;

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

    @Column(name = "VALOR", nullable = false, length =150)
    public String getValor() {
        return valor;
    }

    public void setValor(String valor) {
        this.valor = valor;
    }

    @Column(name = "HABILITADO", nullable = false)
    public Boolean getActivo() {
        return activo;
    }

    public void setActivo(Boolean activo) {
        this.activo = activo;
    }

    @Override
    public String toString() {
        return "'" + id + "'";
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Titulo)) return false;

        Titulo titulo = (Titulo) o;

        if (id != titulo.id) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return id;
    }

    @Override
    public boolean isFieldAuditable(String fieldname) {
        return true;
    }
}
