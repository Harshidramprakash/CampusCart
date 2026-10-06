package com.campuscart.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * CartItem model — maps to the 'cart' table with joined product info.
 */
public class CartItem {

    private int cartId;
    private int userId;
    private int productId;
    private int quantity;
    private Timestamp addedAt;

    // Joined fields for display
    private String productName;
    private BigDecimal productPrice;
    private String productImage;
    private int productStock;

    public CartItem() {}

    // ---- Getters & Setters ----

    public int getCartId() { return cartId; }
    public void setCartId(int cartId) { this.cartId = cartId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public Timestamp getAddedAt() { return addedAt; }
    public void setAddedAt(Timestamp addedAt) { this.addedAt = addedAt; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public BigDecimal getProductPrice() { return productPrice; }
    public void setProductPrice(BigDecimal productPrice) { this.productPrice = productPrice; }

    public String getProductImage() { return productImage; }
    public void setProductImage(String productImage) { this.productImage = productImage; }

    public int getProductStock() { return productStock; }
    public void setProductStock(int productStock) { this.productStock = productStock; }

    /**
     * Returns line total = price × quantity.
     */
    public BigDecimal getSubtotal() {
        if (productPrice == null) return BigDecimal.ZERO;
        return productPrice.multiply(BigDecimal.valueOf(quantity));
    }
}
