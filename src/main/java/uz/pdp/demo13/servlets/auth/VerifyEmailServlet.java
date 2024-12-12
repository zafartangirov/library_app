package uz.pdp.demo13.servlets.auth;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/auth/verify")

public class VerifyEmailServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String enteredCode = req.getParameter("enteredCode");
        String code = req.getParameter("code");

        if (enteredCode.equals(code)){
            resp.sendRedirect("/library.jsp");
        }else{
            resp.sendRedirect("/errorMessage.jsp");
        }
    }
}
