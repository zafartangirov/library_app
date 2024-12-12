package uz.pdp.demo13.servlets.auth;

import jakarta.persistence.EntityManager;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import uz.pdp.demo13.entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import static uz.pdp.demo13.MyListener.EMF;

@WebServlet("/auth/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String passwordRepeat = req.getParameter("passwordRepeat");

        if (password.equals(passwordRepeat)) {
            User user = new User(
                    firstName,
                    lastName,
                    email,
                    password,
                    ""
            );
            try (
                    EntityManager entityManager = EMF.createEntityManager()
            ) {
                Map<String, String> map = new HashMap<>();
                Validator validator = Validation.buildDefaultValidatorFactory().getValidator();
                Set<ConstraintViolation<User>> validate = validator.validate(user);
                for (ConstraintViolation<User> validation : validate) {
                    map.put(validation.getPropertyPath().toString(), validation.getMessage());
                }
                if (!map.isEmpty()){
                    req.setAttribute("errors", map);
                    req.getRequestDispatcher("/register/register.jsp").forward(req, resp);
                    return;
                }
                entityManager.getTransaction().begin();
                entityManager.persist(user);
                entityManager.getTransaction().commit();
                resp.sendRedirect("/library.jsp");
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }else{
            resp.sendRedirect("/register/register.jsp");
        }
    }
}
