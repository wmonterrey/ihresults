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
        Query query = session.createQuery("FROM Detalle d where d.encabezado.id = :id");
        query.setParameter("id",idEncabezado);
        return query.list();
    }

}
