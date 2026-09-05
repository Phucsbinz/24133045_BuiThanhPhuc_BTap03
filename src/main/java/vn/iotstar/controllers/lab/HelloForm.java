package vn.iotstar.controllers.lab;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/helloform" })
public class HelloForm extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        String ten = request.getParameter("ten");
        String holot = request.getParameter("holot");

        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html><html><head><meta charset='UTF-8'><title>Kết Quả Form GET</title>");
        out.println("<style>body{font-family:sans-serif;padding:30px;background:#f0f2f5;} .box{background:#fff;padding:20px;border-radius:8px;max-width:500px;margin:auto;box-shadow:0 2px 10px rgba(0,0,0,0.1);}</style></head><body>");
        out.println("<div class='box'>");
        out.println("<h2>Kết quả nhận được từ GET:</h2>");
        out.println("<p><b>First Name (Tên)</b>: " + (ten != null ? ten : "") + "</p>");
        out.println("<p><b>Last Name (Họ lót)</b>: " + (holot != null ? holot : "") + "</p>");
        out.println("<br><a href='" + request.getContextPath() + "/'>&larr; Trang chủ</a>");
        out.println("</div></body></html>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        String ten = request.getParameter("ten");
        String holot = request.getParameter("holot");

        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html><html><head><meta charset='UTF-8'><title>Kết Quả Form POST</title>");
        out.println("<style>body{font-family:sans-serif;padding:30px;background:#f0f2f5;} .box{background:#fff;padding:20px;border-radius:8px;max-width:500px;margin:auto;box-shadow:0 2px 10px rgba(0,0,0,0.1);}</style></head><body>");
        out.println("<div class='box'>");
        out.println("<h2>Kết quả nhận được từ POST:</h2>");
        out.println("<p><b>First Name (Tên)</b>: " + (ten != null ? ten : "") + "</p>");
        out.println("<p><b>Last Name (Họ lót)</b>: " + (holot != null ? holot : "") + "</p>");
        out.println("<br><a href='" + request.getContextPath() + "/'>&larr; Trang chủ</a>");
        out.println("</div></body></html>");
    }
}
