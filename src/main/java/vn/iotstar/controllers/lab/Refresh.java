package vn.iotstar.controllers.lab;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.GregorianCalendar;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/Refresh" })
public class Refresh extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set refresh, autoload time as 5 seconds
        response.setIntHeader("Refresh", 5);
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        // Get current time
        Calendar calendar = new GregorianCalendar();
        String am_pm = calendar.get(Calendar.AM_PM) == 0 ? "AM" : "PM";
        int hour = calendar.get(Calendar.HOUR);
        int minute = calendar.get(Calendar.MINUTE);
        int second = calendar.get(Calendar.SECOND);
        String CT = String.format("%02d:%02d:%02d %s", (hour == 0 ? 12 : hour), minute, second, am_pm);

        PrintWriter out = response.getWriter();
        String title = "Auto Refresh Header Setting (Tự động tải lại mỗi 5 giây)";
        String docType = "<!doctype html>\n";
        out.println(docType + "<html>\n"
                + "<head><meta charset='UTF-8'><title>" + title + "</title>"
                + "<style>body{font-family:Arial,sans-serif;padding:30px;background:#f0f2f5;} .box{background:#fff;padding:30px;border-radius:10px;max-width:500px;margin:auto;text-align:center;box-shadow:0 4px 6px rgba(0,0,0,0.1);} .time{font-size:28px;color:#e63946;font-weight:bold;margin:20px 0;}</style>"
                + "</head>\n"
                + "<body>\n"
                + "<div class='box'>"
                + "<h2>" + title + "</h2>\n"
                + "<p>Thời gian hệ thống hiện tại:</p>"
                + "<div class='time'>" + CT + "</div>\n"
                + "<p style='color:#6c757d;'>Trang này đang tự động reload mỗi 5s bằng <code>response.setIntHeader(\"Refresh\", 5)</code></p>"
                + "<br><a href='" + request.getContextPath() + "/'>&larr; Quay về Trang Chủ</a>"
                + "</div>\n</body></html>");
    }
}
