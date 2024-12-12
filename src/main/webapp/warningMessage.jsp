<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Warning message</title>
</head>
<body>

<div class="alert alert-warning alert-dismissible fade show w-100" role="alert">
    <strong>Warning</strong> User allaqachon chiqib bo'lgan
    <%
        String search = Objects.requireNonNullElse(request.getParameter("search"), "");
        int pagejon = Integer.parseInt(Objects.requireNonNullElse(request.getParameter("page"), "1"));
    %>
    <a href="library.jsp?page=<%=pagejon%>&search=<%=search%>">Back to library</a>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>

</body>
</html>
