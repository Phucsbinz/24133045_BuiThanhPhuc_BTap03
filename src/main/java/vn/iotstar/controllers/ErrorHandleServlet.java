package vn.iotstar.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/error" })
public class ErrorHandleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer statusCode = (Integer) req.getAttribute("jakarta.servlet.error.status_code");
        if (statusCode == null) {
            statusCode = (Integer) req.getAttribute("javax.servlet.error.status_code");
        }

        Throwable throwable = (Throwable) req.getAttribute("jakarta.servlet.error.exception");
        if (throwable == null) {
            throwable = (Throwable) req.getAttribute("javax.servlet.error.exception");
        }

        String requestUri = (String) req.getAttribute("jakarta.servlet.error.request_uri");
        if (requestUri == null) {
            requestUri = (String) req.getAttribute("javax.servlet.error.request_uri");
        }

        req.setAttribute("statusCode", statusCode != null ? statusCode : 500);
        req.setAttribute("exception", throwable);
        req.setAttribute("requestUri", requestUri);

        if (statusCode != null && statusCode == 404) {
            req.getRequestDispatcher("/views/loi404.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/views/loi500.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
