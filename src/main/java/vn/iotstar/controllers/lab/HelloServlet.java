package vn.iotstar.controllers.lab;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/hello", "/xin-chao" })
public class HelloServlet extends HttpServlet {
    private String message;

    @Override
    public void init() throws ServletException {
        message = "Hello World - Lập Trình Web Java Servlet HCMUTE";
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter printW = resp.getWriter();
        printW.println("<!DOCTYPE html>");
        printW.println("<html><head><meta charset='UTF-8'><title>Hello Servlet</title>");
        printW.println("<style>body{font-family:Arial,sans-serif;padding:30px;background:#f4f6f9;} .card{background:#fff;padding:25px;border-radius:10px;box-shadow:0 4px 6px rgba(0,0,0,0.1);max-width:600px;margin:auto;text-align:center;} a{color:#4361ee;text-decoration:none;font-weight:bold;}</style>");
        printW.println("</head><body>");
        printW.println("<div class='card'>");
        printW.println("<h1>" + message + "</h1>");
        printW.println("<p>Slide 17, 21, 22 - Giới thiệu Java Servlet</p>");
        printW.println("<p><a href='" + req.getContextPath() + "/'>&larr; Quay về Trang Chủ</a></p>");
        printW.println("</div></body></html>");
        printW.close();
    }

    @Override
    public void destroy() {
    }
}
