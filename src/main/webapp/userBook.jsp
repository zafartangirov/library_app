<%@ page import="uz.pdp.demo13.repo.UserBookRepo" %>
<%@ page import="uz.pdp.demo13.entity.UserBook" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.demo13.repo.BookRepo" %>
<%@ page import="uz.pdp.demo13.entity.Book" %>
<%@ page import="uz.pdp.demo13.repo.UserRepo" %>
<%@ page import="uz.pdp.demo13.entity.User" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Add book</title>
</head>
<body>

<%
    Integer userId = Integer.parseInt(request.getParameter("userId"));
    UserBookRepo userBookRepo = new UserBookRepo();
    List<UserBook> userBooks = userBookRepo.findById(userId);

    BookRepo bookRepo = new BookRepo();
    List<Book> books = bookRepo.findAll();

    String search = Objects.requireNonNullElse(request.getParameter("search"), "");
    int pagejon = Integer.parseInt(Objects.requireNonNullElse(request.getParameter("page"), "1"));

    UserRepo userRepo = new UserRepo();
    User user = userRepo.findAll().stream().filter(item -> item.getId().equals(userId)).findFirst().orElseThrow();
%>
<div class="container mt-5 w-50 h-70">
    <div class="card">
        <div class="card-header text-center bg-primary text-white">
            <h2><%=userBooks.isEmpty() ? "Add book" : "User's book"%>
            </h2>
        </div>
        <div class="card-body">
            <form action="/book/add" method="post">
                <input type="hidden" name="search" value="<%=search%>">
                <input type="hidden" name="page" value="<%=pagejon%>">
                <input type="hidden" name="userId" value="<%=user.getId()%>">
                <div class="mb-3">
                        <% if (userBooks.isEmpty()) { %>
                    <p><%=user.getFirstName() + " " + user.getLastName()%>
                    </p>
                    <select class="form-select w-25" name="bookId">
                        <option selected disabled>Select book</option>
                        <% for (Book book : books) { %>
                        <option value="<%=book.getId()%>"><%=book.getName()%>
                        </option>
                        <% } %>
                    </select>
                    <div class="text-center" style="float: right">
                        <button type="submit" class="btn btn-success">Add Book</button>
                    </div>
                        <% } else {
                for (UserBook userBook : userBooks) { %>
            </form>
            <form action="/book/take" method="post">
                <input type="hidden" name="search" value="<%=search%>">
                <input type="hidden" name="page" value="<%=pagejon%>">
                <input type="hidden" name="userId" value="<%=user.getId()%>">
                <p><%=userBook.getUser().getFirstName() + " " + userBook.getUser().getLastName()%>
                </p>
                <p><%=userBook.getBook().getName()%>
                </p>
                <button class="btn btn-success" style="float: right">Topshirish</button>
            </form>
            <% }
            } %>
        </div>
        </form>
        <div>
            <a href="library.jsp?search=<%=search%>&page=<%=pagejon%>">
                <button type="submit" class="btn btn-success mx-2" style="float: right">Back</button>
            </a>
        </div>
    </div>
</div>
</div>
</div>

</body>
</html>
