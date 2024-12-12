<%@ page import="uz.pdp.demo13.entity.User" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Settings</title>
</head>
<body>

<%
    String search = Objects.requireNonNullElse(request.getParameter("search"), "");
    int pagejon = Integer.parseInt(Objects.requireNonNullElse(request.getParameter("page"), "1"));

    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("/login/login.jsp");
    }
%>

<div id="loader-container"
     style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(255, 255, 255, 0.9); display: flex; justify-content: center; align-items: center; z-index: 9999;">
    <dotlottie-player
            src="https://lottie.host/ad634144-46f7-4225-8fea-2719585c675f/xgqtTubTnG.lottie"
            background="transparent"
            speed="1"
            style="width: 300px; height: 300px"
            loop
            autoplay
    ></dotlottie-player>
</div>

<div class="container mt-5 w-50">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Settings</h4>
        </div>
        <div class="card-body">
            <form action="/update/info" method="post">
                <input type="hidden" name="search" value="<%=search%>">
                <input type="hidden" name="page" value="<%=pagejon%>">
                <input type="hidden" value="<%=user != null ? user.getId() : ""%>" name="userId">
                <div class="mb-3">
                    <p>FirstName</p>
                    <input type="text" class="form-control" value="<%=user.getFirstName()%>" name="firstName"
                           placeholder="FirstName">
                </div>
                <div class="mb-3">
                    <p>LastName</p>
                    <input type="text" class="form-control" value="<%=user.getLastName()%>" name="lastName"
                           placeholder="LastName">
                </div>
                <div class="mb-3">
                    <p>Email</p>
                    <input type="text" class="form-control" value="<%=user.getEmail()%>" name="email"
                           placeholder="email">
                </div>
                <div class="mb-3">
                    <p>Password</p>
                    <input type="text" class="form-control" value="<%=user.getPassword()%>" name="password"
                           placeholder="Password">
                </div>
                <div class="text-end">
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
            <a href="library.jsp?search=<%=search%>&page=<%=pagejon%>">
                <div class="text-end" style="float: right">
                    <button type="submit" class="btn btn-primary">Back</button>
                </div>
            </a>
        </div>
    </div>
</div>

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
        }, 5000);
    });
</script>

<script
        src="https://unpkg.com/@dotlottie/player-component@2.7.12/dist/dotlottie-player.mjs"
        type="module"
></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
