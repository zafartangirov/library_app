<%@ page import="uz.pdp.demo13.repo.UserRepo" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Warning</title>
</head>
<body>

<div class="alert alert-warning alert-dismissible fade show w-100" role="alert">
    <strong>Warning</strong> Avval kitobni topshirsin
    <%
        String search = Objects.requireNonNullElse(request.getParameter("search"), "");
        int pagejon = Integer.parseInt(Objects.requireNonNullElse(request.getParameter("page"), "1"));
    %>
    <a href="library.jsp?page=<%=pagejon%>&search=<%=search%>">Back to library</a>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>

</body>
</html>