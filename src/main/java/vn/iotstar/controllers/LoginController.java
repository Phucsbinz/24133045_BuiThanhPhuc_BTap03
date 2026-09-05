package vn.iotstar.controllers;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/login")
public class LoginController extends HttpServlet {

    private final UserService service = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("account") != null) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        // Kiểm tra Cookie Remember Me
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(Constant.COOKIE_REMEMBER)) {
                    String username = cookie.getValue();
                    try {
                        username = URLDecoder.decode(cookie.getValue(), StandardCharsets.UTF_8);
                    } catch (Exception ignored) {
                    }
                    User user = service.get(username);
                    if (user != null && user.getStatus() == 1) {
                        session = req.getSession(true);
                        session.setAttribute("account", user);
                        session.setAttribute(Constant.SESSION_USERNAME, username);
                        resp.sendRedirect(req.getContextPath() + "/waiting");
                        return;
                    }
                }
            }
        }

        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        boolean isRememberMe = false;
        String remember = req.getParameter("remember");

        if ("on".equals(remember) || "true".equalsIgnoreCase(remember)) {
            isRememberMe = true;
        }

        String alertMsg = "";

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            alertMsg = "Tài khoản hoặc mật khẩu không được rỗng";
            req.setAttribute("alert", alertMsg);
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        User user = service.login(username.trim(), password.trim());

        if (user != null) {
            // Kiểm tra trạng thái kích hoạt tài khoản
            if (user.getStatus() == 0) {
                alertMsg = "Tài khoản chưa được kích hoạt mã OTP qua Email!";
                req.setAttribute("alert", alertMsg);
                req.setAttribute("inactiveUsername", user.getUserName());
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
                return;
            }

            HttpSession session = req.getSession(true);
            session.setAttribute("account", user);
            session.setAttribute(Constant.SESSION_USERNAME, user.getUserName());

            if (isRememberMe) {
                saveRememberMe(resp, username.trim());
            }

            resp.sendRedirect(req.getContextPath() + "/waiting");
        } else {
            alertMsg = "Tài khoản hoặc mật khẩu không đúng";
            req.setAttribute("alert", alertMsg);
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }

    private void saveRememberMe(HttpServletResponse response, String username) {
        try {
            String encodedUsername = URLEncoder.encode(username, StandardCharsets.UTF_8);
            Cookie cookie = new Cookie(Constant.COOKIE_REMEMBER, encodedUsername);
            cookie.setMaxAge(30 * 60); // 30 phút
            cookie.setPath("/");
            response.addCookie(cookie);
        } catch (Exception ignored) {
        }
    }
}
