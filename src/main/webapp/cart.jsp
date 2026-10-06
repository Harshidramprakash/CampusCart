<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp" />

<div class="cart-container">
    <h2>Your Shopping Cart</h2>
    
    <c:choose>
        <c:when test="${empty cartItems}">
            <div class="empty-cart">
                <p>Your cart is empty.</p>
                <a href="products" class="btn btn-primary">Continue Shopping</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="cart-layout">
                <div class="cart-items">
                    <table class="cart-table">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Subtotal</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="total" value="0" />
                            <c:forEach var="item" items="${cartItems}">
                                <tr>
                                    <td>
                                        <div class="cart-product-info">
                                            <img src="${item.productImage}" alt="${item.productName}" width="50">
                                            <span>${item.productName}</span>
                                        </div>
                                    </td>
                                    <td>₹${item.productPrice}</td>
                                    <td>
                                        <form action="cart" method="POST" class="update-qty-form">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="cartId" value="${item.cartId}">
                                            <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.productStock}" onchange="this.form.submit()">
                                        </form>
                                    </td>
                                    <td>₹${item.subtotal}</td>
                                    <td>
                                        <form action="cart" method="POST">
                                            <input type="hidden" name="action" value="remove">
                                            <input type="hidden" name="cartId" value="${item.cartId}">
                                            <button type="submit" class="btn btn-danger btn-sm">Remove</button>
                                        </form>
                                    </td>
                                </tr>
                                <c:set var="total" value="${total + item.subtotal}" />
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <div class="cart-summary">
                    <h3>Order Summary</h3>
                    <div class="summary-row">
                        <span>Total Items:</span>
                        <span>${cartItems.size()}</span>
                    </div>
                    <div class="summary-row total-row">
                        <span>Total Amount:</span>
                        <span>₹${total}</span>
                    </div>
                    <a href="orders?action=checkout" class="btn btn-primary btn-full">Proceed to Checkout</a>
                    <a href="products" class="btn btn-outline btn-full" style="margin-top: 10px;">Continue Shopping</a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="footer.jsp" />
