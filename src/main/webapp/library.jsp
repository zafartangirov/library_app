<%@ page import="uz.pdp.demo13.repo.UserRepo" %>
<%@ page import="uz.pdp.demo13.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Objects" %>
<%@ page import="uz.pdp.demo13.repo.UserBookRepo" %>
<%@ page import="uz.pdp.demo13.entity.UserBook" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Library</title>

    <style>
        *, *:before, *:after {
            box-sizing: border-box;
        }
        html {
            height: 20%;
        }

        body {
            align-items: center;
            justify-content: center;
            min-height: 50%;
        }

        .logo-container {
            position: relative;

            &:before {
                content: "";
                position: absolute;
                top: calc(100% - 2px);
                width: 25%;
                height: 3px;
                margin-left: 550px;
                background-color: #cf0000;
                transform-origin: center center;
                transform: scaleX(0);

                animation: line-animation 3s ease infinite alternate;
            }

            h1#page-logo {
                font: bold 2rem 'Arial', sans-serif;

                animation: clip-path-reveal-1 3s ease infinite alternate;
            }
        }

        @keyframes line-animation {
            0% {
                transform: scaleX(0);
            }
            15% {
                transform: scaleX(0);
            }
            20%, 25% {
                transform: scaleX(1);
                top: calc(100% - 2px);
            }
            50% {
                transform: scaleX(1);
                top: 0px;
            }
            70% {
                transform: scaleX(0.2);
                top: 0px;
            }
            80%, 100% {
                transform: scaleX(0.2);
                top: 0px;
            }
        }

        @keyframes clip-path-reveal-1 {
            0%, 25% {
                clip-path: polygon(0 100%, 100% 100%, 100% 100%, 0% 100%);
            }
            50% {
                clip-path: polygon(0 0, 100% 0, 100% 100%, 0% 100%);
            }
        }
    </style>
</head>
<body>

<%
    UserRepo userRepo = new UserRepo();

    String search = Objects.requireNonNullElse(request.getParameter("search"), "");
    int pagejon = Integer.parseInt(Objects.requireNonNullElse(request.getParameter("page"), "1"));

    UserBookRepo userBookRepo = new UserBookRepo();
    List<UserBook> userBooks = userBookRepo.findAll();

    List<User> users = userRepo.getUsersList(pagejon, search);

    User sessionUser = (User) session.getAttribute("currentUser");
%>

<div id="loader-container"
     style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(255, 255, 255, 0.9); display: flex; justify-content: center; align-items: center; z-index: 9999;">
    <dotlottie-player
            src="https://lottie.host/278b5ef5-c004-4705-8f69-84b57fa5d7e0/h5Kla1Eqbd.lottie"
            background="transparent"
            speed="1"
            style="width: 300px; height: 300px"
            loop
            autoplay
    ></dotlottie-player>
</div>


<div class="bg-dark text-white p-3 logo-container">
    <h1 style="text-align: center" id="page-logo">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
             stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
             class="lucide lucide-library-big">
            <rect width="8" height="18" x="3" y="3" rx="1"/>
            <path d="M7 3v18"/>
            <path d="M20.4 18.9c.2.5-.1 1.1-.6 1.3l-1.9.7c-.5.2-1.1-.1-1.3-.6L11.1 5.1c-.2-.5.1-1.1.6-1.3l1.9-.7c.5-.2 1.1.1 1.3.6Z"/>
        </svg>
        Library
    </h1>
</div>

<div class="w-25 p-4">
    <form action="">
        <div class="input-group">
            <input name="search" class="form-control" type="text" placeholder="Search...">
            <button
                    class="btn btn-dark position-relative"
                    style="transition: transform 0.3s ease, background-color 0.3s ease"
                    onmouseover="this.style.transform='scale(1.1)'; this.style.backgroundColor='#343a40';"
                    onmouseout="this.style.transform='scale(1)'; this.style.backgroundColor='black';"
                    onclick="this.style.transform='scale(0.9)'; setTimeout(() => this.style.transform='scale(1)', 200);"
            >
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                     stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                     class="lucide lucide-user-search">
                    <circle cx="10" cy="7" r="4"/>
                    <path d="M10.3 15H7a4 4 0 0 0-4 4v2"/>
                    <circle cx="17" cy="17" r="3"/>
                    <path d="m21 21-1.9-1.9"/>
                </svg>
                Search
            </button>
        </div>
    </form>
</div>

<div>
    <form action="register/register.jsp" style="position: absolute; top: 100px; right: 210px;">
        <input type="hidden" name="search" value="<%=search%>">
        <input type="hidden" name="page" value="<%=pagejon%>">
        <button
                class="btn btn-dark position-relative"
                style="transition: transform 0.3s ease, background-color 0.3s ease;"
                onmouseover="this.style.transform='scale(1.1)'; this.style.backgroundColor='#343a40';"
                onmouseout="this.style.transform='scale(1)'; this.style.backgroundColor='black';"
                onclick="this.style.transform='scale(0.9)'; setTimeout(() => this.style.transform='scale(1)', 200);"
        >
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                 stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                 class="lucide lucide-user-round-plus">
                <path d="M2 21a8 8 0 0 1 13.292-6"/>
                <circle cx="10" cy="8" r="5"/>
                <path d="M19 16v6"/>
                <path d="M22 19h-6"/>
            </svg>
            Register
        </button>
    </form>
</div>

<div class="dropdown" style="position: absolute; top: 100px; right: 70px;">
    <button
            class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown"
            aria-expanded="false">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
             stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
             class="lucide lucide-circle-user-round">
            <path d="M18 20a6 6 0 0 0-12 0"/>
            <circle cx="12" cy="10" r="4"/>
            <circle cx="12" cy="12" r="10"/>
        </svg>
        Admin
    </button>
    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
        <li><a class="dropdown-item" href="settings.jsp?search=<%=search%>&page=<%=pagejon%>">Sozlamalar</a></li>
        <li><a class="dropdown-item" href="/login/login.jsp">Chiqish</a></li>
    </ul>
</div>

<hr>

<table class="table offset-1 table-striped table-hover table-bordered table-sm w-75">
    <thead class="thead-dark">
    <tr>
        <th scope="col">Id</th>
        <th scope="col">FirstName</th>
        <th scope="col">LastName</th>
        <th scope="col">Actions</th>
    </tr>
    </thead>

    <tbody>
    <%
        for (User user : users) {
            if (user.getRole().equals("USER")) {
    %>
    <tr>
        <td><%=user.getId()%>
        </td>
        <td><%=user.getFirstName()%>
        </td>
        <td><%=user.getLastName()%>
        </td>
        <td>
            <div class="btn-group">
                <form action="userBook.jsp">
                    <input type="hidden" name="search" value="<%=search%>">
                    <input type="hidden" name="page" value="<%=pagejon%>">
                    <input type="hidden" name="userId" value="<%=user.getId()%>">
                    <button class="btn btn-<%=user.getStatus().equals("in") ? "success" : "secondary"%> mx-2" <%=user.getStatus().equals("out") ? "disabled" : ""%>>
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                             class="lucide lucide-book-copy">
                            <path d="M2 16V4a2 2 0 0 1 2-2h11"/>
                            <path d="M22 18H11a2 2 0 1 0 0 4h10.5a.5.5 0 0 0 .5-.5v-15a.5.5 0 0 0-.5-.5H11a2 2 0 0 0-2 2v12"/>
                            <path d="M5 14H4a2 2 0 1 0 0 4h1"/>
                        </svg>
                        Book
                    </button>
                </form>

                <form action="/status/set" method="post">
                    <input type="hidden" name="search" value="<%=search%>">
                    <input type="hidden" name="page" value="<%=pagejon%>">
                    <input type="hidden" name="userId" value="<%=user.getId()%>">
                    <button class="btn btn-<%=user.getStatus().equals("in") ? "primary" : "secondary"%> mx-2">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                             class="lucide lucide-circle-arrow-right">
                            <circle cx="12" cy="12" r="10"/>
                            <path d="M8 12h8"/>
                            <path d="m12 16 4-4-4-4"/>
                        </svg>
                        In
                    </button>
                </form>

                <%
                    boolean userHasBook = false;
                    for (UserBook userBook : userBooks) {
                        if (userBook.getUser().equals(user) ) {
                            userHasBook = true;
                            break;
                        }
                    }
                %>
                <form action="/check/user" method="post">
                    <input type="hidden" name="page" value="<%=pagejon%>">
                    <input type="hidden" name="search" value="<%=search%>">
                    <input type="hidden" name="userId" value="<%= user.getId() %>">
                    <button class="btn <%= userHasBook && !user.getStatus().equals("out") ? "btn-secondary" : "disabled"%> mx-2">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                             class="lucide lucide-square-arrow-left">
                            <rect width="18" height="18" x="3" y="3" rx="2"/>
                            <path d="m12 8-4 4 4 4"/>
                            <path d="M16 12H8"/>
                        </svg>
                        Out
                    </button>
                </form>

                <form action="/user/remove" method="post">
                    <input type="hidden" name="search" value="<%=search%>">
                    <input type="hidden" name="page" value="<%=pagejon%>">
                    <input type="hidden" name="userId" value="<%=user.getId()%>">
                    <button class="btn btn-danger mx-2">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                             class="lucide lucide-user-x">
                            <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/>
                            <circle cx="9" cy="7" r="4"/>
                            <line x1="17" x2="22" y1="8" y2="13"/>
                            <line x1="22" x2="17" y1="8" y2="13"/>
                        </svg>
                        Remove user
                    </button>
                </form>
            </div>
        </td>
    </tr>
    <%
            }
        }
    %>
    </tbody>
</table>

<%
    long count = UserRepo.count(search);
    int pageCount = (int) Math.ceil(count / 10.0);
    for (int i = 1; i <= pageCount; i++) {
%>

<a href="?page=<%=i%>&search=<%=search%>" class="btn btn-dark"><%=i%>
</a>

<%
    }
%>

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
        }, 2000);
    });
</script>

<script src="https://unpkg.com/@dotlottie/player-component@2.7.12/dist/dotlottie-player.mjs" type="module"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" defer></script>

</body>
</html>
