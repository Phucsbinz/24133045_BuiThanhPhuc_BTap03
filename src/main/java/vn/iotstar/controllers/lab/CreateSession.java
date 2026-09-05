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
@WebServlet(urlPatterns = { "/createsession" })
public class CreateSession extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Khởi tạo session
        HttpSession s = req.getSession();

        // Gán dữ liệu vào session (slide 89)
        s.setAttribute("ten", "Nguyễn Hữu Trung");
        s.setAttribute("tuoi", Integer.valueOf(40));

        // Thiết lập thời gian tồn tại session (30 giây)
        s.setMaxInactiveInterval(30);

        // Hiển thị thông báo lên web
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();

        out.println("<!DOCTYPE html><html><head><meta charset='UTF-8'><title>Tạo Session</title>");
        out.println("<style>body{font-family:Arial,sans-serif;padding:30px;background:#f0f2f5;} .box{background:#fff;padding:25px;border-radius:10px;max-width:500px;margin:auto;box-shadow:0 2px 10px rgba(0,0,0,0.1);text-align:center;}</style></head><body>");
        out.println("<div class='box'>");
        out.println("<h2 style='color:#2a9d8f;'>Xin chào bạn! Session đã được tạo thành công.</h2>");
        out.println("<p>Đã lưu <code>ten = 'Nguyễn Hữu Trung'</code> và <code>tuoi = 40</code> (Hết hạn sau 30 giây).</p>");
        out.println("<p><a href='" + req.getContextPath() + "/showsession'>Xem dữ liệu Session (/showsession)</a></p>");
        out.println("<a href='" + req.getContextPath() + "/'>&larr; Trang chủ</a>");
        out.println("</div></body></html>");
        out.close();
    }
}
