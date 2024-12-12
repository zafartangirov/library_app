package uz.pdp.demo13.servlets;

import jakarta.persistence.EntityManager;
import uz.pdp.demo13.entity.User;
import uz.pdp.demo13.repo.UserRepo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Objects;

import static uz.pdp.demo13.MyListener.EMF;

@WebServlet("/status/set")
public class SetStatusServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (
                EntityManager entityManager = EMF.createEntityManager()
        ) {
            String search = Objects.requireNonNullElse(req.getParameter("search"), "");
            int page = Integer.parseInt(Objects.requireNonNullElse(req.getParameter("page"), "1"));
            Integer userId = Integer.parseInt(req.getParameter("userId"));
            entityManager.getTransaction().begin();
            User user = entityManager.find(User.class, userId);
            if (!user.getStatus().equals("in")){
                user.setStatus("in");
                entityManager.getTransaction().commit();
                resp.sendRedirect("/library.jsp?search=" + search + "&" + "page=" + page);
            }else{
                user.setStatus("out");
                entityManager.getTransaction().commit();
                resp.sendRedirect("/library.jsp?search=" + search + "&" + "page=" + page);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
