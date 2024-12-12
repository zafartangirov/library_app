package uz.pdp.demo13.filter;

import uz.pdp.demo13.entity.User;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

@WebFilter("/*")
public class Filter extends HttpFilter {

    private static final Set<String> openPaths = new HashSet<>(
            Set.of(
                    "/login/login.jsp",
                    "/register/register.jsp",
                    "/auth/register",
                    "/auth/login",
                    "/auth/verify",
                    "/emailActivation.jsp",
                    "/errorMessage.jsp",
                    "/verification.jsp"
            )
    );

    private static final Set<String> adminPaths = new HashSet<>(
            Set.of(
                    "/register/register.jsp",
                    "/library.jsp",
                    "/settings.jsp",
                    "/userBook.jsp",
                    "/warning.jsp",
                    "/book/add",
                    "/check/user",
                    "/user/remove",
                    "/status/set",
                    "/book/take",
                    "/update/info"
            )
    );

    @Override
    protected void doFilter(HttpServletRequest req, HttpServletResponse res, FilterChain chain) throws IOException, ServletException {
        String path = req.getRequestURI();

        if (openPaths.contains(path)) {
            chain.doFilter(req, res);
            return;
        }

        HttpSession session = req.getSession(false);
        Object currentUser = (session != null) ? session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            res.sendRedirect("/login/login.jsp");
            return;
        }else{
            User user = (User)currentUser;
            if (adminPaths.contains(path) && user.getRole().equals("ADMIN")) {
                chain.doFilter(req, res);
                return;
            }
        }
        chain.doFilter(req, res);
    }
}
