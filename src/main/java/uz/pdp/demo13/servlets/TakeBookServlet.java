package uz.pdp.demo13.servlets;

import uz.pdp.demo13.entity.User;
import uz.pdp.demo13.entity.UserBook;
import uz.pdp.demo13.repo.UserBookRepo;
import uz.pdp.demo13.repo.UserRepo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Objects;

@WebServlet("/book/take")
public class TakeBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer userId = Integer.parseInt(req.getParameter("userId"));
        String search = Objects.requireNonNullElse(req.getParameter("search"), "");
        int pagejon = Integer.parseInt(Objects.requireNonNullElse(req.getParameter("page"), "1"));
        UserRepo userRepo = new UserRepo();
        User user = userRepo.findById(userId);
        UserBookRepo userBookRepo = new UserBookRepo();
        List<UserBook> userBooks = userBookRepo.findById(user.getId());
        for (UserBook userBook : userBooks) {
            if (userBook.getUser().equals(user)){
                userBookRepo.remove(userBook, userBook.getId());
                resp.sendRedirect("/userBook.jsp?userId=" + userId + "&" + "search=" + search + "&" + "page=" + pagejon);
            }
        }
    }
}
