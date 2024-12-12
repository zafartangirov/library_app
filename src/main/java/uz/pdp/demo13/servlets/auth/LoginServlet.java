package uz.pdp.demo13.servlets.auth;

import jakarta.persistence.EntityManager;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import uz.pdp.demo13.entity.DB;
import uz.pdp.demo13.entity.User;
import uz.pdp.demo13.repo.UserRepo;

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

@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (EntityManager entityManager = EMF.createEntityManager()) {
            String email = req.getParameter("email");
            String password = req.getParameter("password");

            Map<String, String> map = new HashMap<>();
            Validator validator = Validation.buildDefaultValidatorFactory().getValidator();
            Set<ConstraintViolation<User>> validateEmail = validator.validateValue(User.class, "email", email);
            for (ConstraintViolation<User> validation : validateEmail) {
                map.put("email", validation.getMessage());
            }
            Set<ConstraintViolation<User>> validatePassword = validator.validateValue(User.class, "password", password);
            for (ConstraintViolation<User> validation : validatePassword) {
                map.put("password", validation.getMessage());
            }
            if (!map.isEmpty()){
                req.setAttribute("errors", map);
                req.getRequestDispatcher("/login/login.jsp").forward(req, resp);
                return;
            }

            User foundUser = null;
            try {
                foundUser = entityManager.createQuery("from User where email = :email and password = :password", User.class)
                        .setParameter("email", email)
                        .setParameter("password", password).getSingleResult();

                if (foundUser == null){
                    resp.sendRedirect("/login/login.jsp");
                }else{
                    req.getSession().setAttribute("currentUser", foundUser);
                    resp.sendRedirect("/emailActivation.jsp?email=" + foundUser.getEmail());
                }
            }catch (Exception e){
                throw new ServletException("user topilmadi!");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
