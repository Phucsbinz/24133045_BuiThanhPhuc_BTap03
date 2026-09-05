package vn.iotstar.controllers;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/forgot-password")
public class ForgotPasswordController extends HttpServlet {

    private final UserService service = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String account = req.getParameter("account");

        if (account == null || account.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập Username hoặc Email tài khoản của bạn!");
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            return;
        }

        boolean success = service.sendForgotPasswordOtp(account.trim());

        if (success) {
            User user = service.findByUsernameOrEmail(account.trim());
            req.getSession().setAttribute("msgInfo", "Mã OTP đã được gửi đến email [" + user.getEmail() + "]. Hãy nhập OTP để đặt mật khẩu mới.");
            resp.sendRedirect(req.getContextPath() + "/reset-password?username=" + URLEncoder.encode(user.getUserName(), StandardCharsets.UTF_8));
        } else {
            req.setAttribute("alert", "Không tìm thấy tài khoản hoặc email này trong hệ thống!");
            req.setAttribute("account", account);
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
        }
    }
}
