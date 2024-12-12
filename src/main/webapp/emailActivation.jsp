<%@ page import="java.util.Random" %>
<%@ page import="uz.pdp.demo13.entity.User" %>
<%@ page import="java.util.Objects" %>
<%@ page import="uz.pdp.demo13.service.MailService" %>
<%@ page import="jakarta.mail.MessagingException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Email Activation</title>
</head>
<body>

<%
    User user = (User)Objects.requireNonNullElse(session.getAttribute("currentUser"), new User());
    Random random = new Random();
    String code = random.nextInt(1000, 10000) + "";
    user.setTempCode(code);
    String htmlContent = "<!DOCTYPE html>" +
            "<html lang=\"en\">" +
            "<head>" +
            "    <meta charset=\"UTF-8\">" +
            "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">" +
            "    <title>Email Verification</title>" +
            "    <style>" +
            "        /* General Body Styling */" +
            "        body {" +
            "            font-family: Arial, sans-serif;" +
            "            margin: 0;" +
            "            padding: 0;" +
            "            background-color: #f4f7fc;" +
            "            color: #333;" +
            "            display: flex;" +
            "            justify-content: center;" +
            "            align-items: center;" +
            "            height: 100vh;" +
            "        }" +
            "        /* Container Styling */" +
            "        .email-container {" +
            "            background-color: white;" +
            "            padding: 40px;" +
            "            border-radius: 10px;" +
            "            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);" +
            "            max-width: 600px;" +
            "            text-align: center;" +
            "        }" +
            "        /* Title Styling */" +
            "        .email-container h2 {" +
            "            color: #4CAF50;" +
            "            font-size: 28px;" +
            "            margin-bottom: 20px;" +
            "        }" +
            "        /* Description Text Styling */" +
            "        .email-container p {" +
            "            color: #555;" +
            "            font-size: 18px;" +
            "            margin-bottom: 30px;" +
            "        }" +
            "        /* Code Box Styling */" +
            "        .verification-code {" +
            "            background-color: #007bff;" +
            "            color: white;" +
            "            font-size: 32px;" +
            "            font-weight: bold;" +
            "            padding: 20px;" +
            "            border-radius: 8px;" +
            "            margin-bottom: 30px;" +
            "        }" +
            "        /* Footer Styling */" +
            "        .footer {" +
            "            font-size: 14px;" +
            "            color: #777;" +
            "        }" +
            "        .footer a {" +
            "            color: #007bff;" +
            "            text-decoration: none;" +
            "        }" +
            "        .footer a:hover {" +
            "            text-decoration: underline;" +
            "        }" +
            "        /* Responsive Design for Mobile Devices */" +
            "        @media (max-width: 600px) {" +
            "            .email-container {" +
            "                padding: 20px;" +
            "            }" +
            "            .email-container h2 {" +
            "                font-size: 24px;" +
            "            }" +
            "            .email-container p {" +
            "                font-size: 16px;" +
            "            }" +
            "            .verification-code {" +
            "                font-size: 28px;" +
            "                padding: 15px;" +
            "            }" +
            "        }" +
            "    </style>" +
            "</head>" +
            "<body>" +
            "    <div class=\"email-container\">" +
            "        <h2>Email Verification</h2>" +
            "        <p>Please use the following code to verify your account:</p>" +
            "        <div class=\"verification-code\">" +
            "            <strong>" + user.getTempCode() + "</strong>" +
            "        </div>" +
            "        <p class=\"footer\">If you did not request this verification, please ignore this email. <br> <a href=\"#\">Contact Support</a></p>" +
            "    </div>" +
            "</body>" +
            "</html>";
    try {
        MailService.sendMessage(htmlContent, user.getEmail());
    } catch (MessagingException e) {
        throw new RuntimeException(e);
    }
%>

<div class="alert alert-success alert-dismissible fade show w-100" role="alert">
    <strong>Success</strong> Kod yuborildi
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>

<div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
    <div class="card shadow p-4" style="width: 100%; max-width: 400px;">
        <h3 class="text-center mb-4">Emailni Tasdiqlash</h3>
        <form action="/auth/verify" method="post">
            <div class="mb-3">
                <label for="code" class="form-label">Emailingizga yuborilgan kodni kiriting</label>
                <input type="text" class="form-control" name="enteredCode" id="code" placeholder="Kod" required>
                <input type="hidden" name="code" value="<%=code%>">
                <br>
                <p>Kodni olmadingizmi?<a href="emailActivation.jsp">Qayta yuborish</a></p>
            </div>
            <button type="submit" class="btn btn-primary w-100">Tasdiqlash</button>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
