package com.campuscart.dao;

import com.campuscart.model.CartItem;
import com.campuscart.model.Order;
import com.campuscart.model.OrderItem;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for the 'orders' and 'order_items' tables.
 * Checkout is handled as a transaction.
 */
public class OrderDAO {

    /**
     * Place an order from the current cart contents.
     * Runs inside a transaction: inserts order → order_items → decreases stock → clears cart.
     */
    public int placeOrder(int userId, String shippingAddress, String paymentMethod,
                          List<CartItem> cartItems) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // 1. Calculate total
            BigDecimal total = BigDecimal.ZERO;
            for (CartItem ci : cartItems) {
                total = total.add(ci.getProductPrice().multiply(BigDecimal.valueOf(ci.getQuantity())));
            }

            // 2. Insert order
            String orderSql = "INSERT INTO orders (user_id, total_amount, shipping_address, payment_method, status) "
                            + "VALUES (?, ?, ?, ?, 'pending')";
            int orderId;
            try (PreparedStatement ps = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, userId);
                ps.setBigDecimal(2, total);
                ps.setString(3, shippingAddress);
                ps.setString(4, paymentMethod);
                ps.executeUpdate();
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (!keys.next()) throw new SQLException("Failed to get order ID");
                    orderId = keys.getInt(1);
                }
            }

            // 3. Insert order items & decrease stock
            String itemSql = "INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES (?, ?, ?, ?)";
            String stockSql = "UPDATE products SET stock = stock - ? WHERE product_id = ? AND stock >= ?";
            for (CartItem ci : cartItems) {
                try (PreparedStatement ps = conn.prepareStatement(itemSql)) {
                    ps.setInt(1, orderId);
                    ps.setInt(2, ci.getProductId());
                    ps.setInt(3, ci.getQuantity());
                    ps.setBigDecimal(4, ci.getProductPrice());
                    ps.executeUpdate();
                }
                try (PreparedStatement ps = conn.prepareStatement(stockSql)) {
                    ps.setInt(1, ci.getQuantity());
                    ps.setInt(2, ci.getProductId());
                    ps.setInt(3, ci.getQuantity());
                    int rows = ps.executeUpdate();
                    if (rows == 0) {
                        conn.rollback();
                        return -1; // insufficient stock
                    }
                }
            }

            // 4. Clear cart
            String clearSql = "DELETE FROM cart WHERE user_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(clearSql)) {
                ps.setInt(1, userId);
                ps.executeUpdate();
            }

            conn.commit();
            return orderId;
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ignored) {}
            }
            return -1;
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); } catch (SQLException ignored) {}
                DBConnection.close(conn);
            }
        }
    }

    /**
     * Get all orders for a user.
     */
    public List<Order> getOrdersByUser(int userId) {
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) orders.add(mapOrderRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    /**
     * Get all orders (admin).
     */
    public List<Order> getAllOrders() {
        String sql = "SELECT o.*, u.full_name AS user_name, u.email AS user_email "
                   + "FROM orders o JOIN users u ON o.user_id = u.user_id "
                   + "ORDER BY o.order_date DESC";
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order o = mapOrderRow(rs);
                o.setUserName(rs.getString("user_name"));
                o.setUserEmail(rs.getString("user_email"));
                orders.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    /**
     * Get a single order by ID.
     */
    public Order getOrderById(int orderId) {
        String sql = "SELECT o.*, u.full_name AS user_name, u.email AS user_email "
                   + "FROM orders o JOIN users u ON o.user_id = u.user_id "
                   + "WHERE o.order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order o = mapOrderRow(rs);
                    o.setUserName(rs.getString("user_name"));
                    o.setUserEmail(rs.getString("user_email"));
                    o.setItems(getOrderItems(orderId));
                    return o;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Get line items for an order.
     */
    public List<OrderItem> getOrderItems(int orderId) {
        String sql = "SELECT oi.*, p.name AS product_name, p.image_url AS product_image "
                   + "FROM order_items oi JOIN products p ON oi.product_id = p.product_id "
                   + "WHERE oi.order_id = ?";
        List<OrderItem> items = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setItemId(rs.getInt("item_id"));
                    item.setOrderId(rs.getInt("order_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setUnitPrice(rs.getBigDecimal("unit_price"));
                    item.setProductName(rs.getString("product_name"));
                    item.setProductImage(rs.getString("product_image"));
                    items.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    /**
     * Update order status (admin).
     */
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Count total orders.
     */
    public int countOrders() {
        String sql = "SELECT COUNT(*) FROM orders";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Total revenue.
     */
    public BigDecimal getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(total_amount), 0) FROM orders WHERE status != 'cancelled'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getBigDecimal(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    // ---- Helper ----
    private Order mapOrderRow(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setOrderId(rs.getInt("order_id"));
        o.setUserId(rs.getInt("user_id"));
        o.setTotalAmount(rs.getBigDecimal("total_amount"));
        o.setShippingAddress(rs.getString("shipping_address"));
        o.setPaymentMethod(rs.getString("payment_method"));
        o.setStatus(rs.getString("status"));
        o.setOrderDate(rs.getTimestamp("order_date"));
        o.setUpdatedAt(rs.getTimestamp("updated_at"));
        return o;
    }
}
