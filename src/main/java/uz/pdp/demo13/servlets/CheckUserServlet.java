package uz.pdp.demo13.servlets;

import jakarta.persistence.EntityManager;
import uz.pdp.demo13.entity.User;
import uz.pdp.demo13.entity.UserBook;
import uz.pdp.demo13.repo.UserBookRepo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Objects;

import static uz.pdp.demo13.MyListener.EMF;

@WebServlet("/check/user")
public class CheckUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (
                EntityManager entityManager = EMF.createEntityManager()
        ) {
            Integer userId = Integer.parseInt(req.getParameter("userId"));
            String search = Objects.requireNonNullElse(req.getParameter("search"), "");
            int pagejon = Integer.parseInt(Objects.requireNonNullElse(req.getParameter("page"), "1"));
            entityManager.getTransaction().begin();
            User user = entityManager.find(User.class, userId);
            UserBookRepo userBookRepo = new UserBookRepo();
            List<UserBook> userBooks = userBookRepo.findById(user.getId());
            for (UserBook userBook : userBooks) {
                if (userBook.getUser().getId().equals(user.getId())) {
                    user.setStatus("in");
                    entityManager.getTransaction().commit();
                    resp.sendRedirect("/warning.jsp?search=" + search + "&" + "page=" + pagejon);
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
