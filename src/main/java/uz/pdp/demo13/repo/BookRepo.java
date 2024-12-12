package uz.pdp.demo13.repo;

import jakarta.persistence.EntityManager;
import uz.pdp.demo13.entity.Book;
import uz.pdp.demo13.entity.User;

import static uz.pdp.demo13.MyListener.EMF;

public class BookRepo extends BaseRepo<Book>{

    public Book findById(Integer bookId) {
        try (
                EntityManager entityManager = EMF.createEntityManager()
        ) {
            return (Book)entityManager.createQuery("from Book where id = :userId").setParameter("userId", bookId).getSingleResult();
        }
    }
}
