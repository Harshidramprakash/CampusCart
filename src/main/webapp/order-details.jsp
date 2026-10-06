<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp" />

<div class="order-detail-container">
    <div class="order-header">
        <h2>Order #${order.orderId}</h2>
        <span class="status-badge ${order.status}">${order.status}</span>
    </div>
    
    <div class="order-info-grid">
        <div class="info-card">
            <h3>Order Info</h3>
            <p><strong>Date:</strong> ${order.orderDate}</p>
            <p><strong>Payment Method:</strong> ${order.paymentMethod}</p>
            <p><strong>Total Amount:</strong> ₹${order.totalAmount}</p>
        </div>
        <div class="info-card">
            <h3>Shipping Address</h3>
            <p>${order.shippingAddress}</p>
        </div>
    </div>
    
    <h3>Items in this Order</h3>
    <table class="data-table">
        <thead>
            <tr>
                <th>Product</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Subtotal</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${order.items}">
                <tr>
                    <td>
                        <div class="cart-product-info">
                            <img src="${item.productImage}" alt="${item.productName}" width="40">
                            <span>${item.productName}</span>
                        </div>
                    </td>
                    <td>₹${item.unitPrice}</td>
                    <td>${item.quantity}</td>
                    <td>₹${item.subtotal}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <div style="margin-top: 20px;">
        <a href="orders" class="btn btn-outline">Back to Orders</a>
    </div>
</div>

<jsp:include page="footer.jsp" />
