package ni.org.ics.umich.hai.service;

import ni.org.ics.umich.hai.domain.results.Detalle;
import ni.org.ics.umich.hai.domain.results.Encabezado;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by FIRSTICT on 9/6/2016.
 * V1.0
 */
@Service("resultadoService")
@Transactional
public class ResultadoService {

    @Resource(name="sessionFactory")
    private SessionFactory sessionFactory;

    public void saveHeader(Encabezado encabezado){
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(encabezado);
    }

    public void saveDetail(Detalle detalle){
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(detalle);
    }

    public Encabezado getHeaderById(int id){
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM Encabezado e where e.id = :id");
        query.setParameter("id",id);
        return (Encabezado)query.uniqueResult();
    }

    public List<Detalle> getDetailByHeader(int idEncabezado){
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM Detalle d where d.encabezado.id = :id and pasive = '0'");
        query.setParameter("id",idEncabezado);
        return query.list();
    }

    public boolean validateCode(String code){
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM Muestra where codigo = :codigo");
        query.setParameter("codigo",code);
        return query.list().size()>0;
    }

    public List<Encabezado> getHeaders(){
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM Encabezado where pasive = '0' ");
        return query.list();
    }

    public Detalle getDetailById(int id){
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM Detalle where id = :id ");
        query.setParameter("id",id);
        return (Detalle)query.uniqueResult();
    }

    public Integer deleteDetailByIdHeader(Integer id) {
        // Retrieve session from Hibernate
        Session s = sessionFactory.getCurrentSession();
        String hqlBaja = "update Detalle set pasive='1' where encabezado.id = :id  and pasive = '0' ";
        int updateEntities = s.createQuery( hqlBaja )
                .setParameter("id", id)
                .executeUpdate();
        return updateEntities;
    }
}
