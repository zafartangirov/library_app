package uz.pdp.demo13.repo;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import uz.pdp.demo13.entity.UserBook;

import java.util.List;

import static uz.pdp.demo13.MyListener.EMF;

public class UserBookRepo extends BaseRepo<UserBook>{

    public List<UserBook> findById(Integer userId) {
        try (EntityManager entityManager = EMF.createEntityManager()) {
            Query query = entityManager.createNativeQuery("select * from userbook where user_id = %d".formatted(userId), UserBook.class);
            return query.getResultList();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
