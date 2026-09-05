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
@WebServlet(urlPatterns = { "/ReadParamsAction" })
public class ReadParamsAction extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        String title = "Reading All Form Parameters (Đọc tất cả Parameters)";
        String docType = "<!doctype html>\n";

        out.println(docType + "<html>\n<head><meta charset='UTF-8'><title>" + title + "</title>"
                + "<style>body{font-family:Arial,sans-serif;padding:30px;background:#f8f9fa;} table{width:80%;margin:20px auto;border-collapse:collapse;background:#fff;} th,td{border:1px solid #ddd;padding:12px;text-align:left;} th{background:#4361ee;color:#fff;} .container{max-width:800px;margin:auto;background:#fff;padding:20px;border-radius:8px;box-shadow:0 2px 10px rgba(0,0,0,0.1);}</style></head>\n"
                + "<body>\n<div class='container'><h2 align='center'>" + title + "</h2>\n"
                + "<table align='center'>\n"
                + "<tr><th>Param Name</th><th>Param Value(s)</th></tr>\n");

        Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            out.print("<tr><td><b>" + paramName + "</b></td>\n<td>");
            String[] paramValues = request.getParameterValues(paramName);
            if (paramValues.length == 1) {
                String paramValue = paramValues[0];
                if (paramValue.length() == 0) {
                    out.println("<i>No Value</i>");
                } else {
                    out.println(paramValue);
                }
            } else {
                out.println("<ul>");
                for (int i = 0; i < paramValues.length; i++) {
                    out.println("<li>" + paramValues[i] + "</li>");
                }
                out.println("</ul>");
            }
            out.println("</td></tr>\n");
        }

        out.println("</table>\n<p align='center'><a href='" + request.getContextPath() + "/labs/ReadParams.html'>&larr; Quay lại Form</a> | <a href='" + request.getContextPath() + "/'>Trang chủ</a></p></div>\n</body></html>");
    }
}
