<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Register</title>
</head>
<body>

<%
    Object object = request.getAttribute("errors");
    Map<String, String> errors = new HashMap<>();
    if (object != null) {
        errors = (Map<String, String>) object;
    }
    String search = Objects.requireNonNullElse(request.getParameter("search"), "");
    int pagejon = Integer.parseInt(Objects.requireNonNullElse(request.getParameter("page"), "1"));
%>

<div id="loader-container" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(255, 255, 255, 0.9); display: flex; justify-content: center; align-items: center; z-index: 9999;">
    <dotlottie-player
            src="https://lottie.host/53e6b418-33ba-41cb-a9da-457e6edc55b7/R1PeEK9a6Y.lottie"
            background="transparent"
            speed="1"
            style="width: 300px; height: 300px"
            loop
            autoplay
    ></dotlottie-player>
</div>

<div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
    <div class="card shadow p-4" style="width: 100%; max-width: 500px;">
        <h3 class="text-center mb-4">Register</h3>
        <form action="/auth/register" method="post">
            <div class="mb-3">
                <input type="text" class="form-control" name="firstName" placeholder="firstName">
                <span style="color: red"><%=Objects.requireNonNullElse(errors.get("firstName"), "")%></span>
            </div>
            <div class="mb-3">
                <input type="text" class="form-control" name="lastName" placeholder="lastName">
                <span style="color: red"><%=Objects.requireNonNullElse(errors.get("lastName"), "")%></span>
            </div>
            <div class="mb-3">
                <input type="email" class="form-control" name="email" placeholder="Email" >
                <span style="color: red"><%=Objects.requireNonNullElse(errors.get("email"), "")%></span>
            </div>
            <div class="mb-3">
                <input type="password" class="form-control" name="password" placeholder="Password">
                <span style="color: red"><%=Objects.requireNonNullElse(errors.get("password"), "")%></span>
            </div>
            <div class="mb-3">
                <input type="password" class="form-control" name="passwordRepeat" placeholder="Password Repeat">
                <span style="color: red"><%=Objects.requireNonNullElse(errors.get("passwordRepeat"), "")%></span>
            </div>
            <button type="submit" class="btn btn-success w-100">Register</button>
        </form>
        <a href="/library.jsp?search=<%=search%>&page=<%=pagejon%>">
        <button type="submit" class="btn btn-success w-100">Back</button>
        </a>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", () => {
        setTimeout(() => {
            const loaderContainer = document.getElementById("loader-container");
            if (loaderContainer) {
                loaderContainer.style.transition = "opacity 0.5s ease";
                loaderContainer.style.opacity = "0";
                setTimeout(() => {
                    loaderContainer.style.display = "none";
                }, 500);
            }
        }, 3000);
    });
</script>
<script
        src="https://unpkg.com/@dotlottie/player-component@2.7.12/dist/dotlottie-player.mjs"
        type="module"
></script>

</body>
</html>
