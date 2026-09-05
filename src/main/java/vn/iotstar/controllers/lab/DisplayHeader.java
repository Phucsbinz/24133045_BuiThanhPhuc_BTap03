package vn.iotstar.controllers.lab;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/DisplayHeader" })
public class DisplayHeader extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        String title = "Ví dụ đọc thông tin HTTP Header";
        String docType = "<!doctype html>\n";

        out.println(docType + "<html>\n" + "<head><meta charset='UTF-8'><title>" + title + "</title>"
                + "<style>body{font-family:Arial,sans-serif;padding:30px;background:#f8f9fa;} table{width:90%;margin:20px auto;border-collapse:collapse;background:#fff;} th,td{border:1px solid #ddd;padding:10px;text-align:left;} th{background:#2b2d42;color:#fff;} .container{max-width:900px;margin:auto;background:#fff;padding:25px;border-radius:10px;box-shadow:0 2px 10px rgba(0,0,0,0.1);}</style>"
                + "</head>\n"
                + "<body>\n"
                + "<div class='container'><h2 align='center'>" + title + "</h2>\n"
                + "<table border='1' align='center'>\n"
                + "<tr><th>Header Name</th><th>Header Value(s)</th></tr>\n");

        Enumeration<String> headerNames = request.getHeaderNames();
        while (headerNames.hasMoreElements()) {
            String paramName = headerNames.nextElement();
            out.print("<tr><td><b>" + paramName + "</b></td>\n");
            String paramValue = request.getHeader(paramName);
            out.println("<td>" + paramValue + "</td></tr>\n");
        }

        out.println("</table>\n<p align='center'><a href='" + request.getContextPath() + "/'>&larr; Quay về Trang Chủ</a></p></div>\n</body></html>");
    }
}
