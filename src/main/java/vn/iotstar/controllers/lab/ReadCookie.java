package vn.iotstar.controllers.lab;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/readcookie" })
public class ReadCookie extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Cookie cookie = null;
        Cookie[] cookies = null;

        // Get an array of Cookies associated with this domain
        cookies = request.getCookies();

        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html><html><head><meta charset='UTF-8'><title>Đọc Cookie</title>");
        out.println("<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css'>");
        out.println("</head><body style='background:#f9f9f9; padding-top:40px;'>");
        out.println("<div class='container' style='max-width:500px;'>");
        out.println("<div class='panel panel-info'>");
        out.println("<div class='panel-heading'><h3 class='panel-title'>Danh Sách Cookies Tìm Thấy</h3></div>");
        out.println("<div class='panel-body'>");

        if (cookies != null && cookies.length > 0) {
            out.println("<ul class='list-group'>");
            for (int i = 0; i < cookies.length; i++) {
                cookie = cookies[i];
                String decodedVal = cookie.getValue();
                try {
                    decodedVal = URLDecoder.decode(cookie.getValue(), StandardCharsets.UTF_8);
                } catch (Exception ignored) {
                }
                out.print("<li class='list-group-item'><b>" + cookie.getName() + "</b>: " + decodedVal + "</li>");
            }
            out.println("</ul>");
        } else {
            out.println("<div class='alert alert-warning'>Không tìm thấy cookies nào!</div>");
            out.println("<p><a href='" + request.getContextPath() + "/createcookie?ten=Trung&holot=NguyenHuu'>Tạo Cookie mẫu</a></p>");
        }

        out.println("<hr>");
        out.println("<a href='" + request.getContextPath() + "/deletecookie' class='btn btn-danger btn-sm'>Xóa Cookie (/deletecookie)</a> ");
        out.println("<a href='" + request.getContextPath() + "/' class='btn btn-default btn-sm'>Trang chủ</a>");
        out.println("</div></div></div></body></html>");
        out.close();
    }
}
