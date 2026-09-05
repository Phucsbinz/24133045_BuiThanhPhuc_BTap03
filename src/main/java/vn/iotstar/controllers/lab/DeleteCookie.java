package vn.iotstar.controllers.lab;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/deletecookie" })
public class DeleteCookie extends HttpServlet {

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

        out.println("<!DOCTYPE html><html><head><meta charset='UTF-8'><title>Xóa Cookie</title>");
        out.println("<style>body{font-family:Arial,sans-serif;padding:30px;background:#f0f2f5;} .box{background:#fff;padding:25px;border-radius:10px;max-width:500px;margin:auto;box-shadow:0 2px 10px rgba(0,0,0,0.1);}</style></head><body>");
        out.println("<div class='box'>");

        if (cookies != null) {
            out.println("<h2>Quá trình xóa Cookies:</h2><ul>");
            for (int i = 0; i < cookies.length; i++) {
                cookie = cookies[i];
                if ((cookie.getName()).equals("ten") || (cookie.getName()).equals("holot")
                        || (cookie.getName()).equals("username")) {
                    // delete cookie
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                    out.print("<li style='color:green;'>Đã xóa cookie: <b>" + cookie.getName() + "</b></li>");
                } else {
                    out.print("<li>Giữ lại cookie khác: " + cookie.getName() + "</li>");
                }
            }
            out.println("</ul>");
        } else {
            out.println("<p>Không có cookie để xóa.</p>");
        }

        out.println("<br><p><a href='" + request.getContextPath() + "/readcookie'>Kiểm tra lại (/readcookie)</a> | <a href='" + request.getContextPath() + "/'>Trang chủ</a></p>");
        out.println("</div></body></html>");
        out.close();
    }
}
