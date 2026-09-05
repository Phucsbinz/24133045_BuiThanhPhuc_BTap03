package vn.iotstar.controllers;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/resend-otp")
public class ResendOtpController extends HttpServlet {

    private final UserService service = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        if (username != null && !username.trim().isEmpty()) {
            boolean success = service.resendOtp(username.trim());
            if (success) {
                req.getSession().setAttribute("msgInfo", "Mã OTP mới đã được gửi lại vào email của bạn. Vui lòng kiểm tra hộp thư!");
            } else {
                req.getSession().setAttribute("msgError", "Không tìm thấy tài khoản hoặc không thể gửi mã OTP!");
            }
            resp.sendRedirect(req.getContextPath() + "/verify-otp?username=" + URLEncoder.encode(username.trim(), StandardCharsets.UTF_8));
        } else {
            resp.sendRedirect(req.getContextPath() + "/register");
        }
    }
}
