package com.campuscart.servlet;

import com.campuscart.dao.ProductDAO;
import com.campuscart.model.Product;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Handles product listing and detail views.
 * GET → list products or show single product details.
 *
 * Demonstrates: Experiment 2 (Servlet), Experiment 3 (JSP forwarding).
 */
public class ProductServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("detail".equals(action)) {
            showProductDetail(req, resp);
        } else {
            listProducts(req, resp);
        }
    }

    private void listProducts(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String category = req.getParameter("category");
        List<Product> products;

        if (category != null && !category.isEmpty()) {
            products = productDAO.getProductsByCategory(category);
            req.setAttribute("selectedCategory", category);
        } else {
            products = productDAO.getAllProducts();
        }

        List<String> categories = productDAO.getAllCategories();

        req.setAttribute("products", products);
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/products.jsp").forward(req, resp);
    }

    private void showProductDetail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idStr = req.getParameter("id");
        if (idStr == null) {
            resp.sendRedirect(req.getContextPath() + "/products");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            Product product = productDAO.getProductById(id);
            if (product == null) {
                resp.sendRedirect(req.getContextPath() + "/products");
                return;
            }
            req.setAttribute("product", product);
            req.getRequestDispatcher("/product-details.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/products");
        }
    }
}
