package uz.pdp.demo13.servlets;

import jakarta.persistence.EntityManager;
import uz.pdp.demo13.entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Objects;

import static uz.pdp.demo13.MyListener.EMF;

@WebServlet("/update/info")
public class UpdateUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (
                EntityManager entityManager = EMF.createEntityManager()
        ) {
            Integer userId = Integer.parseInt(req.getParameter("userId"));
            String firstName = req.getParameter("firstName");
            String lastName = req.getParameter("lastName");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String search = Objects.requireNonNullElse(req.getParameter("search"), "");
            int pagejon = Integer.parseInt(Objects.requireNonNullElse(req.getParameter("page"), "1"));

            entityManager.getTransaction().begin();
            User user = entityManager.find(User.class, userId);
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setEmail(email);
            user.setPassword(password);
            entityManager.getTransaction().commit();

            req.getSession().setAttribute("currentUser", user);

            resp.sendRedirect("/settings.jsp?search=" + search + "&" + "page=" + pagejon);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
