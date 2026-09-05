package vn.iotstar.controllers.lab;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/CheckBoxAction" })
public class CheckBoxAction extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        String title = "Đọc dữ liệu từ CheckBox trong Servlet";
        String docType = "<!doctype html>\n";

        String toan = request.getParameter("toan");
        String ly = request.getParameter("ly");
        String hoa = request.getParameter("hoa");

        out.println(docType + "<html>\n" + "<head><meta charset='UTF-8'><title>" + title + "</title>"
                + "<style>body{font-family:Arial,sans-serif;padding:30px;background:#f0f2f5;} .box{background:#fff;padding:25px;border-radius:10px;max-width:500px;margin:auto;box-shadow:0 2px 10px rgba(0,0,0,0.1);}</style>"
                + "</head>\n"
                + "<body>\n"
                + "<div class='box'>"
                + "<h2 align='center'>" + title + "</h2>\n"
                + "<ul>\n"
                + "  <li><b>Toán : </b>: " + (toan != null ? toan : "Chưa chọn") + "</li>\n"
                + "  <li><b>Vật Lý: </b>: " + (ly != null ? ly : "Chưa chọn") + "</li>\n"
                + "  <li><b>Hóa Học: </b>: " + (hoa != null ? hoa : "Chưa chọn") + "</li>\n"
                + "</ul>\n"
                + "<p><a href='" + request.getContextPath() + "/labs/CheckBox.html'>&larr; Quay lại Form CheckBox</a> | <a href='" + request.getContextPath() + "/'>Trang chủ</a></p>"
                + "</div></body>\n"
                + "</html>");
    }
}
