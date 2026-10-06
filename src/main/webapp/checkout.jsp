<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp" />

<div class="checkout-container">
    <h2>Checkout</h2>
    
    <div class="checkout-layout">
        <div class="checkout-form">
            <h3>Shipping Details</h3>
            <form action="orders" method="POST" id="checkoutForm">
                <input type="hidden" name="action" value="placeOrder">
                
                <div class="form-group">
                    <label for="shippingAddress">Full Shipping/Hostel Address</label>
                    <textarea id="shippingAddress" name="shippingAddress" rows="4" required>${sessionScope.user.address}</textarea>
                </div>
                
                <div class="form-group">
                    <label>Payment Method (Academic Demo)</label>
                    <div class="radio-group">
                        <input type="radio" id="cod" name="paymentMethod" value="Cash on Delivery" checked>
                        <label for="cod">Cash on Delivery</label>
                    </div>
                    <div class="radio-group">
                        <input type="radio" id="demo" name="paymentMethod" value="Demo Online Payment">
                        <label for="demo">Demo Online Payment</label>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary btn-large">Place Order</button>
            </form>
        </div>
        
        <div class="checkout-summary">
            <h3>Order Summary</h3>
            <table class="summary-table">
                <c:set var="total" value="0" />
                <c:forEach var="item" items="${cartItems}">
                    <tr>
                        <td>${item.productName} (x${item.quantity})</td>
                        <td class="align-right">₹${item.subtotal}</td>
                    </tr>
                    <c:set var="total" value="${total + item.subtotal}" />
                </c:forEach>
                <tr class="total-row">
                    <td><strong>Total Amount</strong></td>
                    <td class="align-right"><strong>₹${total}</strong></td>
                </tr>
            </table>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
