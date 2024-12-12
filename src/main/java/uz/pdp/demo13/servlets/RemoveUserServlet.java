package uz.pdp.demo13.servlets;

import uz.pdp.demo13.entity.User;
import uz.pdp.demo13.repo.UserBookRepo;
import uz.pdp.demo13.repo.UserRepo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Objects;

@WebServlet("/user/remove")
public class RemoveUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer userId = Integer.parseInt(req.getParameter("userId"));
        String search = Objects.requireNonNullElse(req.getParameter("search"), "");
        int pagejon = Integer.parseInt(Objects.requireNonNullElse(req.getParameter("page"), "1"));
        UserRepo userRepo = new UserRepo();
        User user = new User();
        userRepo.remove(user, userId);
        resp.sendRedirect("/library.jsp?search=" + search + "&" + "page=" + pagejon);
    }
}
