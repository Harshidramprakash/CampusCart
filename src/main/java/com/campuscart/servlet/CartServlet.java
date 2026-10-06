package com.campuscart.servlet;

import com.campuscart.dao.CartDAO;
import com.campuscart.model.CartItem;
import com.campuscart.model.User;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Handles shopping cart operations.
 * Protected by AuthenticationFilter.
 */
public class CartServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");
        
        List<CartItem> cartItems = cartDAO.getCartItems(user.getUserId());
        req.setAttribute("cartItems", cartItems);
        req.getRequestDispatcher("/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");
        
        String action = req.getParameter("action");
        boolean isAjax = "XMLHttpRequest".equals(req.getHeader("X-Requested-With"));

        try {
            if ("add".equals(action)) {
                int productId = Integer.parseInt(req.getParameter("productId"));
                int quantity = 1;
                String qtyStr = req.getParameter("quantity");
                if (qtyStr != null && !qtyStr.isEmpty()) {
                    quantity = Integer.parseInt(qtyStr);
                }
                
                boolean success = cartDAO.addToCart(user.getUserId(), productId, quantity);
                
                if (isAjax) {
                    sendJsonResponse(resp, success, success ? "Added to cart" : "Failed to add to cart");
                    return;
                } else {
                    resp.sendRedirect(req.getContextPath() + "/cart");
                    return;
                }
                
            } else if ("update".equals(action)) {
                int cartId = Integer.parseInt(req.getParameter("cartId"));
                int quantity = Integer.parseInt(req.getParameter("quantity"));
                
                boolean success = cartDAO.updateQuantity(cartId, user.getUserId(), quantity);
                
                if (isAjax) {
                    sendJsonResponse(resp, success, success ? "Quantity updated" : "Failed to update");
                    return;
                }
                
            } else if ("remove".equals(action)) {
                int cartId = Integer.parseInt(req.getParameter("cartId"));
                
                boolean success = cartDAO.removeFromCart(cartId, user.getUserId());
                
                if (isAjax) {
                    sendJsonResponse(resp, success, success ? "Item removed" : "Failed to remove");
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (isAjax) {
                sendJsonResponse(resp, false, "Invalid parameters");
                return;
            }
        }
        
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void sendJsonResponse(HttpServletResponse resp, boolean success, String message) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        JsonObject json = new JsonObject();
        json.addProperty("status", success ? "success" : "error");
        json.addProperty("message", message);
        try (PrintWriter out = resp.getWriter()) {
            out.print(json.toString());
            out.flush();
        }
    }
}
