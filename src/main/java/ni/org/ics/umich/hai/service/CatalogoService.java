package ni.org.ics.umich.hai.service;

import ni.org.ics.umich.hai.domain.catalogs.Antigeno;
import ni.org.ics.umich.hai.domain.catalogs.Titulo;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.classic.Session;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by FIRSTICT on 9/6/2016.
 * V1.0
 */
@Service("catalogoService")
@Transactional
public class CatalogoService {

    @Resource(name="sessionFactory")
    private SessionFactory sessionFactory;

    public List<Antigeno> getAntigens(){
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM Antigeno ant where ant.activo is true");
        return query.list();
    }

    public List<Titulo> getTitles(){
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM Titulo t where t.activo is true");
        return query.list();
    }

    public Titulo getTitleById(int id){
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM Titulo t where t.id = :id");
        query.setParameter("id",id);
        return (Titulo)query.uniqueResult();
    }

    public Antigeno getAntigenById(int id){
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM Antigeno ant where ant.id = :id");
        query.setParameter("id",id);
        return (Antigeno)query.uniqueResult();
    }
}
