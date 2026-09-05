package vn.iotstar.controllers;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.Product;
import vn.iotstar.entity.User;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.impl.ProductServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/home", "/admin/home", "/manager/home", "/member/myaccount", "/profile" })
public class HomeController extends HttpServlet {

    private final IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("account") : null;

        if ("/admin/home".equals(path)) {
            if (user == null || user.getRoleid() != 1) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }
            req.getRequestDispatcher("/views/admin-home.jsp").forward(req, resp);
        } else if ("/manager/home".equals(path)) {
            if (user == null || (user.getRoleid() != 1 && user.getRoleid() != 2)) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }
            req.getRequestDispatcher("/views/manager-home.jsp").forward(req, resp);
        } else if ("/member/myaccount".equals(path) || "/profile".equals(path)) {
            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }
            req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
        } else {
            // /home - Hiển thị 10 sản phẩm mới nhất lên trang chủ
            List<Product> top10 = productService.findTop10Latest();
            req.setAttribute("top10Products", top10);
            req.getRequestDispatcher("/views/home.jsp").forward(req, resp);
        }
    }
}
