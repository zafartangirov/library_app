package uz.pdp.demo13.repo;

import jakarta.persistence.EntityManager;
import uz.pdp.demo13.entity.User;

import java.lang.reflect.ParameterizedType;
import java.util.List;

import static uz.pdp.demo13.MyListener.EMF;

public class BaseRepo<T> {
    private final Class<T> persistenceClass;

    public BaseRepo() {
        Class<T> clazz = (Class<T>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
        this.persistenceClass = clazz;
    }

    public void save(T entity){
        try (EntityManager entityManager = EMF.createEntityManager()) {
            entityManager.getTransaction().begin();
            entityManager.persist(entity);
            entityManager.getTransaction().commit();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public void remove(T entity, Integer id){
        try (EntityManager entityManager = EMF.createEntityManager()) {
            entityManager.getTransaction().begin();
            Object object = entityManager.find(entity.getClass(), id);
            entityManager.remove(object);
            entityManager.getTransaction().commit();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public void removee(T entity){
        try (EntityManager entityManager = EMF.createEntityManager()) {
            entityManager.getTransaction().begin();
            Object object = entityManager.find(entity.getClass(), entity);
            entityManager.remove(object);
            entityManager.getTransaction().commit();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<T> findAll(){
        try (
                EntityManager entityManager = EMF.createEntityManager()
        ) {
            return entityManager.createQuery("from %s".formatted(persistenceClass.getSimpleName()), persistenceClass).getResultList();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
