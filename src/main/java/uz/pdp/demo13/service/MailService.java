package uz.pdp.demo13.service;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.io.IOException;
import java.util.Properties;

public class MailService {

    public static void sendMessage(String txt, String gmail) throws MessagingException, IOException {
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "465");
        properties.put("mail.smtp.ssl.enable", "true");
        properties.put("mail.smtp.auth", "true");

        String username = "javauchun01@gmail.com";
        String password = "pxjuqlovskpasxlp";

        Session session = getSession(properties, username, password);

        Message message = new MimeMessage(session);
        message.setSubject("Verify your email");
        message.setContent(txt, "text/html");
        message.setFrom(new InternetAddress(username));
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(gmail));

        Transport.send(message);
    }

    private static Session getSession(Properties properties, String username, String password){
        return Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });
    }
}
