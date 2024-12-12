package uz.pdp.demo13;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import uz.pdp.demo13.entity.Book;
import uz.pdp.demo13.entity.User;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.List;

@WebListener
public class MyListener implements ServletContextListener {
    public static EntityManagerFactory EMF;
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        EMF = Persistence.createEntityManagerFactory("default");
        try (
                EntityManager entityManager = EMF.createEntityManager()
        ) {

            List<Book> fromBooks = entityManager.createQuery("from Book", Book.class).getResultList();
            if (fromBooks.isEmpty()){
               entityManager.getTransaction().begin();
               Book book1 = new Book("Harry Potter");
               Book book2 = new Book("Oq kema");
               Book book3 = new Book("Robinzon Kruzo");
               Book book4 = new Book("Romeo va Juletta");
               entityManager.persist(book1);
               entityManager.persist(book2);
               entityManager.persist(book3);
               entityManager.persist(book4);
               entityManager.getTransaction().commit();
            }
            List<User> fromUsers = entityManager.createQuery("from User", User.class).getResultList();
            if (fromUsers.isEmpty()){
                entityManager.getTransaction().begin();
                User user1 = new User("Eshmatbek", "Toshmatov", "eshmat@gmail.com", "12345678", "1234", "out", "USER");
                User user2 = new User("Toshmatbek", "Eshmatov", "toshmat@gmail.com", "87654321", "4321", "USER");
                User user3 = new User("Olmosbek", "To'rayev", "olmos@gmail.com", "56788765", "0987", "in", "USER");
                User user4 = new User("Shuhrat", "Talatov", "shuhrat@gmail.com", "10000000", "3456", "in", "USER");
                User user5 = new User("Surat", "Hakimov", "surat@gmail.com", "pwd12345", "5432", "out", "USER");
                User user6 = new User("Safarbek", "Shamshotov", "safarbek@gmail.com", "78949494", "2245", "out", "USER");
                User user7 = new User("To'rabek", "Saitov", "to'rabek@gmail.com", "12345678", "0987", "in", "USER");
                User user8 = new User("Pirmat", "Shoymatov", "pirmat@gmail.com", "12345678", "4567", "out", "USER");
                User user9 = new User("Ahmat", "To'xtasinov", "ahmat@gmail.com", "89071234", "6789", "out", "USER");
                User user10 = new User("Shavkat", "Mirzahakimov", "shavkat@gmail.com", "12345678", "0987", "in", "USER");
                User user11 = new User("Zufar", "Hatamov", "zufar@gmail.com", "098765432", "7789", "out", "USER");
                User admin = new User("Zafar", "Tangirov", "tangirovzafar203@gmail.com", "12345678", null, "out", "ADMIN");
                entityManager.persist(user1);
                entityManager.persist(user2);
                entityManager.persist(user3);
                entityManager.persist(user4);
                entityManager.persist(user5);
                entityManager.persist(user6);
                entityManager.persist(user7);
                entityManager.persist(user8);
                entityManager.persist(user9);
                entityManager.persist(user10);
                entityManager.persist(user11);
                entityManager.persist(admin);
                entityManager.getTransaction().commit();
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
