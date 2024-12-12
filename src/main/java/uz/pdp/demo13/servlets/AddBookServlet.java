package uz.pdp.demo13.servlets;


import uz.pdp.demo13.entity.Book;
import uz.pdp.demo13.entity.User;
import uz.pdp.demo13.entity.UserBook;
import uz.pdp.demo13.repo.BookRepo;
import uz.pdp.demo13.repo.UserBookRepo;
import uz.pdp.demo13.repo.UserRepo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Objects;

@WebServlet("/book/add")
public class AddBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer userId = Integer.parseInt(req.getParameter("userId"));
        Integer bookId = Integer.parseInt(req.getParameter("bookId"));
        String search = Objects.requireNonNullElse(req.getParameter("search"), "");
        int pagejon = Integer.parseInt(Objects.requireNonNullElse(req.getParameter("page"), "1"));
        UserRepo userRepo = new UserRepo();
        User user = userRepo.findById(userId);
        BookRepo bookRepo = new BookRepo();
        Book book = bookRepo.findById(bookId);
        UserBook userBook = new UserBook(
                book,
                user
        );
        UserBookRepo userBookRepo = new UserBookRepo();
        userBookRepo.save(userBook);
        resp.sendRedirect("/userBook.jsp?userId=" + userId + "&" + "search=" + search + "&" + "page=" + pagejon);
    }
}
