package vn.iotstar.controllers.lab;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/showsession" })
public class ShowSession extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();

        String ten = "";
        HttpSession s = req.getSession(false); // lấy session hiện tại

        if (s == null || s.getAttribute("ten") == null) {
            resp.sendRedirect(req.getContextPath() + "/createsession");
            return;
        }

        Object obj = s.getAttribute("ten");
        if (obj != null) {
            ten = String.valueOf(obj);
        }

        Integer tuoiObj = (Integer) s.getAttribute("tuoi");
        int tuoi = (tuoiObj != null) ? tuoiObj : 0;

        out.println("<!DOCTYPE html><html><head><meta charset='UTF-8'><title>Hiển Thị Session</title>");
        out.println("<style>body{font-family:Arial,sans-serif;padding:30px;background:#f0f2f5;} .box{background:#fff;padding:25px;border-radius:10px;max-width:500px;margin:auto;box-shadow:0 2px 10px rgba(0,0,0,0.1);text-align:center;}</style></head><body>");
        out.println("<div class='box'>");
        out.println("<h2>Thông Tin Từ Session:</h2>");
        out.println("<p style='font-size:18px;'><b>Xin chào bạn:</b> <span style='color:#4361ee;font-weight:bold;'>" + ten + "</span> | <b>Tuổi:</b> <span style='color:#e63946;font-weight:bold;'>" + tuoi + "</span></p>");
        out.println("<br><p><a href='" + req.getContextPath() + "/createsession'>Tạo lại session (/createsession)</a> | <a href='" + req.getContextPath() + "/'>Trang chủ</a></p>");
        out.println("</div></body></html>");
        out.close();
    }
}
