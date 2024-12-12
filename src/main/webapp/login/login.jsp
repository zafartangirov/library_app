<%@ page import="java.util.Objects" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Login</title>
</head>
<body>

<%
    Object object = request.getAttribute("errors");
    Map<String, String> errors = new HashMap<>();
    if (object != null) {
        errors = (Map<String, String>) object;
    }
%>

<div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
    <div class="card shadow p-4" style="width: 100%; max-width: 400px;">
        <h3 class="text-center mb-4">Login</h3>
        <form action="/auth/login" method="post">
            <div class="mb-3">
                <input type="email" class="form-control" placeholder="Email" name="email">
                <span style="color: red"><%=Objects.requireNonNullElse(errors.get("email"), "")%></span>
            </div>
            <div class="mb-3">
                <input type="password" class="form-control" placeholder="Password" name="password">
                <span style="color: red"><%=Objects.requireNonNullElse(errors.get("password"), "")%></span>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</body>
</html>
