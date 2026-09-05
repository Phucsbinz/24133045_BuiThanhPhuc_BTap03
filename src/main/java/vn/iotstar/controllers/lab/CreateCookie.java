package vn.iotstar.controllers.lab;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/createcookie" })
public class CreateCookie extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        String ten = request.getParameter("ten");
        String holot = request.getParameter("holot");

        if (ten == null || ten.trim().isEmpty()) ten = "Trung";
        if (holot == null || holot.trim().isEmpty()) holot = "NguyenHuu";

        // Encode cookie value để tránh lỗi khoảng trắng (ASCII 32) trên Tomcat 10/11 (Slide 76)
        String encodedTen = URLEncoder.encode(ten.trim(), StandardCharsets.UTF_8);
        String encodedHolot = URLEncoder.encode(holot.trim(), StandardCharsets.UTF_8);

        // Create cookies for first and last names (Slide 77)
        Cookie firstName = new Cookie("ten", encodedTen);
        Cookie lastName = new Cookie("holot", encodedHolot);

        // Set expiry date after 24 Hrs for both cookies
        firstName.setMaxAge(60 * 60 * 24);
        lastName.setMaxAge(60 * 60 * 24);
        firstName.setPath("/");
        lastName.setPath("/");

        // Add both cookies in the response header
        response.addCookie(firstName);
        response.addCookie(lastName);

        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html><html><head><meta charset='UTF-8'><title>Tạo Cookie Thành Công</title>");
        out.println("<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css'>");
        out.println("</head><body style='background:#f9f9f9; padding-top:40px;'>");
        out.println("<div class='container' style='max-width:500px;'>");
        out.println("<div class='panel panel-success'>");
        out.println("<div class='panel-heading'><h3 class='panel-title'>Tạo Cookie Thành Công (24h)</h3></div>");
        out.println("<div class='panel-body'>");
        out.println("<p><b>First Name</b>: " + ten + " - <b>Last Name</b>: " + holot + "</p>");
        out.println("<hr>");
        out.println("<a href='" + request.getContextPath() + "/readcookie' class='btn btn-primary btn-sm'>Đọc Cookie (/readcookie)</a> ");
        out.println("<a href='" + request.getContextPath() + "/deletecookie' class='btn btn-danger btn-sm'>Xóa Cookie (/deletecookie)</a> ");
        out.println("<a href='" + request.getContextPath() + "/' class='btn btn-default btn-sm'>Trang chủ</a>");
        out.println("</div></div></div></body></html>");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
