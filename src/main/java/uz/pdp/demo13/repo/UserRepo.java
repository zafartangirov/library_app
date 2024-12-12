package uz.pdp.demo13.repo;


import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import uz.pdp.demo13.entity.User;

import java.util.List;

import static uz.pdp.demo13.MyListener.EMF;

public class UserRepo extends BaseRepo<User>{

    public List<User> getUsersList(int pagejon, String search) {
        pagejon--;
        try (
                EntityManager entityManager = EMF.createEntityManager()
        ) {
            Query selectUFromUser = entityManager.createNativeQuery("select * from users where firstname ilike '%'|| :search ||'%' limit 10 offset :off", User.class)
                    .setParameter("off", pagejon * 10)
                    .setParameter("search", search);

            return selectUFromUser.getResultList();
        }
    }

    public static long count(String search) {
        try (
                EntityManager entityManager = EMF.createEntityManager()
        ) {
            Query selectTFromTodoT = entityManager.createNativeQuery("select count(*) from users where firstname ilike '%'|| :search ||'%'", Long.class)
                    .setParameter("search", search);
            return (Long)selectTFromTodoT.getSingleResult();
        }
    }

    public User findById(Integer userId) {
        try (
                EntityManager entityManager = EMF.createEntityManager()
        ) {
            return (User)entityManager.createQuery("from User where id = :userId").setParameter("userId", userId).getSingleResult();
        }
    }
}
