package com.campuscart.servlet;

import com.campuscart.dao.CartDAO;
import com.campuscart.dao.OrderDAO;
import com.campuscart.model.CartItem;
import com.campuscart.model.Order;
import com.campuscart.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Handles checkout and viewing orders.
 * Protected by AuthenticationFilter.
 */
public class OrderServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");
        
        String action = req.getParameter("action");
        
        if ("checkout".equals(action)) {
            // Load cart for checkout summary
            List<CartItem> cartItems = cartDAO.getCartItems(user.getUserId());
            if (cartItems.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/cart");
                return;
            }
            req.setAttribute("cartItems", cartItems);
            req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
        } else if ("detail".equals(action)) {
            // Show single order detail
            try {
                int orderId = Integer.parseInt(req.getParameter("id"));
                Order order = orderDAO.getOrderById(orderId);
                
                // Ensure the user owns this order
                if (order == null || order.getUserId() != user.getUserId()) {
                    resp.sendRedirect(req.getContextPath() + "/orders");
                    return;
                }
                
                req.setAttribute("order", order);
                req.getRequestDispatcher("/order-details.jsp").forward(req, resp);
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/orders");
            }
        } else {
            // List user orders
            List<Order> orders = orderDAO.getOrdersByUser(user.getUserId());
            req.setAttribute("orders", orders);
            req.getRequestDispatcher("/orders.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");
        
        String action = req.getParameter("action");
        
        if ("placeOrder".equals(action)) {
            String address = req.getParameter("shippingAddress");
            String paymentMethod = req.getParameter("paymentMethod");
            
            if (address == null || address.trim().isEmpty()) {
                req.setAttribute("error", "Shipping address is required.");
                doGet(req, resp);
                return;
            }
            
            List<CartItem> cartItems = cartDAO.getCartItems(user.getUserId());
            if (cartItems.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/cart");
                return;
            }
            
            int orderId = orderDAO.placeOrder(user.getUserId(), address, paymentMethod, cartItems);
            
            if (orderId > 0) {
                resp.sendRedirect(req.getContextPath() + "/orders?action=detail&id=" + orderId + "&success=true");
            } else {
                req.setAttribute("error", "Order placement failed. Some items might be out of stock.");
                doGet(req, resp);
            }
        }
    }
}
