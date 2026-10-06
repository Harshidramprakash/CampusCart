package com.campuscart.servlet;

import com.campuscart.dao.OrderDAO;
import com.campuscart.dao.ProductDAO;
import com.campuscart.dao.UserDAO;
import com.campuscart.model.Order;
import com.campuscart.model.Product;
import com.campuscart.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

/**
 * Handles admin functionality.
 * Protected by AuthenticationFilter (requires 'admin' role).
 */
public class AdminServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final OrderDAO orderDAO = new OrderDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        String action = req.getParameter("action");
        if (action == null) action = "dashboard";
        
        switch (action) {
            case "dashboard":
                showDashboard(req, resp);
                break;
            case "products":
                listProducts(req, resp);
                break;
            case "orders":
                listOrders(req, resp);
                break;
            default:
                showDashboard(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        String action = req.getParameter("action");
        
        if ("updateOrderStatus".equals(action)) {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            String status = req.getParameter("status");
            orderDAO.updateOrderStatus(orderId, status);
            resp.sendRedirect(req.getContextPath() + "/admin?action=orders&success=Order+updated");
        } else if ("addProduct".equals(action)) {
            // Add basic product
            try {
                HttpSession session = req.getSession(false);
                User user = (User) session.getAttribute("user");
                
                Product p = new Product();
                p.setName(req.getParameter("name"));
                p.setDescription(req.getParameter("description"));
                p.setPrice(new BigDecimal(req.getParameter("price")));
                p.setCategory(req.getParameter("category"));
                p.setImageUrl(req.getParameter("imageUrl"));
                p.setStock(Integer.parseInt(req.getParameter("stock")));
                p.setSellerId(user.getUserId());
                p.setActive(true);
                
                productDAO.addProduct(p);
                resp.sendRedirect(req.getContextPath() + "/admin?action=products&success=Product+added");
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/admin?action=products&error=Failed+to+add+product");
            }
        } else if ("toggleProduct".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("productId"));
                Product p = productDAO.getProductById(id);
                if (p != null) {
                    p.setActive(!p.isActive());
                    productDAO.updateProduct(p);
                }
                resp.sendRedirect(req.getContextPath() + "/admin?action=products");
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/admin?action=products&error=Failed+to+toggle");
            }
        } else if ("deleteProduct".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("productId"));
                productDAO.deleteProduct(id);
                resp.sendRedirect(req.getContextPath() + "/admin?action=products&success=Product+deleted");
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/admin?action=products&error=Failed+to+delete");
            }
        }
    }

    private void showDashboard(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("userCount", userDAO.countUsers());
        req.setAttribute("productCount", productDAO.countProducts());
        req.setAttribute("orderCount", orderDAO.countOrders());
        req.setAttribute("revenue", orderDAO.getTotalRevenue());
        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
    }

    private void listProducts(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Product> products = productDAO.getAllProductsAdmin();
        req.setAttribute("products", products);
        req.getRequestDispatcher("/admin/products.jsp").forward(req, resp);
    }

    private void listOrders(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Order> orders = orderDAO.getAllOrders();
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/admin/orders.jsp").forward(req, resp);
    }
}
