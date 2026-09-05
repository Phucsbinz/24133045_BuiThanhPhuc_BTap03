package vn.iotstar.controllers;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/verify-otp")
public class VerifyOtpController extends HttpServlet {

    private final UserService service = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        if (username != null && !username.trim().isEmpty()) {
            User user = service.get(username.trim());
            if (user != null) {
                req.setAttribute("userEmail", user.getEmail());
            }
        }
        req.setAttribute("username", username);
        req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String otp = req.getParameter("otp");

        if (username == null || username.trim().isEmpty() || otp == null || otp.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập đầy đủ tên tài khoản và mã OTP!");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        boolean isVerified = service.verifyOtp(username.trim(), otp.trim());

        if (isVerified) {
            req.getSession().setAttribute("msgSuccess", "Chúc mừng! Tài khoản [" + username + "] đã được kích hoạt thành công! Hãy đăng nhập ngay.");
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            User user = service.get(username.trim());
            if (user != null) {
                req.setAttribute("userEmail", user.getEmail());
            }
            req.setAttribute("alert", "Mã OTP không chính xác hoặc đã hết hiệu lực (5 phút). Vui lòng kiểm tra lại hoặc bấm 'Gửi lại mã OTP'.");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
        }
    }
}
