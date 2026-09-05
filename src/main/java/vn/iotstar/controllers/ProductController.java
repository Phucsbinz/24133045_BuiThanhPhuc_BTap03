package vn.iotstar.controllers;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.ProductServiceImpl;
import vn.iotstar.util.Constant;

@MultipartConfig()
@WebServlet(urlPatterns = { "/admin/products", "/admin/product/add", "/admin/product/insert",
        "/admin/product/edit", "/admin/product/update", "/admin/product/delete" })
public class ProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IProductService productService = new ProductServiceImpl();
    private final ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();

        if (url.contains("/admin/products")) {
            List<Product> list = productService.findAll();
            req.setAttribute("listproduct", list);
            req.getRequestDispatcher("/views/admin/product-list.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/add")) {
            List<Category> categories = cateService.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.findById(id);
            List<Category> categories = cateService.findAll();
            req.setAttribute("product", product);
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                productService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();

        if (url.contains("/admin/product/insert")) {
            String productName = req.getParameter("productName");
            String description = req.getParameter("description");
            double price = 0;
            try {
                price = Double.parseDouble(req.getParameter("price"));
            } catch (Exception ignored) {
            }
            int quantity = 0;
            try {
                quantity = Integer.parseInt(req.getParameter("quantity"));
            } catch (Exception ignored) {
            }
            int status = 1;
            try {
                status = Integer.parseInt(req.getParameter("status"));
            } catch (Exception ignored) {
            }
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));
            String images = req.getParameter("images");

            Category category = cateService.findById(categoryId);

            Product product = new Product();
            product.setProductName(productName);
            product.setDescription(description);
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setStatus(status);
            product.setCategory(category);
            product.setCreatedDate(new Date(System.currentTimeMillis()));

            String fname = "";
            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            try {
                Part part = req.getPart("images1");
                if (part != null && part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = filename.substring(index + 1);
                    fname = System.currentTimeMillis() + "." + ext;

                    part.write(uploadPath + File.separator + fname);
                    product.setImages(fname);
                } else if (images != null && !images.trim().isEmpty()) {
                    product.setImages(images.trim());
                } else {
                    product.setImages("product.png");
                }
            } catch (FileNotFoundException fne) {
                fne.printStackTrace();
            }

            productService.insert(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }

        if (url.contains("/admin/product/update")) {
            int productId = Integer.parseInt(req.getParameter("productId"));
            String productName = req.getParameter("productName");
            String description = req.getParameter("description");
            double price = 0;
            try {
                price = Double.parseDouble(req.getParameter("price"));
            } catch (Exception ignored) {
            }
            int quantity = 0;
            try {
                quantity = Integer.parseInt(req.getParameter("quantity"));
            } catch (Exception ignored) {
            }
            int status = 1;
            try {
                status = Integer.parseInt(req.getParameter("status"));
            } catch (Exception ignored) {
            }
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));
            String images = req.getParameter("images");

            Product product = productService.findById(productId);
            if (product != null) {
                String fileold = product.getImages();
                Category category = cateService.findById(categoryId);

                product.setProductName(productName);
                product.setDescription(description);
                product.setPrice(price);
                product.setQuantity(quantity);
                product.setStatus(status);
                product.setCategory(category);

                String fname = "";
                String uploadPath = Constant.DIR;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                try {
                    Part part = req.getPart("images1");
                    if (part != null && part.getSize() > 0) {
                        if (fileold != null && !fileold.startsWith("http")) {
                            try {
                                Files.deleteIfExists(Paths.get(uploadPath + File.separator + fileold));
                            } catch (Exception ignored) {
                            }
                        }

                        String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                        int index = filename.lastIndexOf(".");
                        String ext = filename.substring(index + 1);
                        fname = System.currentTimeMillis() + "." + ext;

                        part.write(uploadPath + File.separator + fname);
                        product.setImages(fname);
                    } else if (images != null && !images.trim().isEmpty()) {
                        product.setImages(images.trim());
                    } else {
                        product.setImages(fileold);
                    }
                } catch (FileNotFoundException fne) {
                    fne.printStackTrace();
                }

                productService.update(product);
            }

            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }
}
