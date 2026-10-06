<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp" />

<div class="product-detail-container">
    <div class="product-detail-image">
        <img src="${product.imageUrl}" alt="${product.name}">
    </div>
    <div class="product-detail-info">
        <span class="category-tag">${product.category}</span>
        <h2>${product.name}</h2>
        <p class="price-large">₹${product.price}</p>
        
        <div class="description-box">
            <h3>Description</h3>
            <p>${product.description}</p>
        </div>
        
        <div class="stock-info">
            <c:choose>
                <c:when test="${product.stock > 10}">
                    <span class="in-stock">In Stock (${product.stock} available)</span>
                </c:when>
                <c:when test="${product.stock > 0}">
                    <span class="low-stock">Low Stock (Only ${product.stock} left!)</span>
                </c:when>
                <c:otherwise>
                    <span class="out-of-stock">Out of Stock</span>
                </c:otherwise>
            </c:choose>
        </div>
        
        <c:if test="${product.stock > 0}">
            <form action="cart" method="POST" class="add-to-cart-form">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="productId" value="${product.productId}">
                
                <div class="qty-control">
                    <label for="qty">Quantity:</label>
                    <input type="number" id="qty" name="quantity" value="1" min="1" max="${product.stock}">
                </div>
                
                <button type="submit" class="btn btn-primary btn-large" ${empty sessionScope.user ? 'disabled' : ''}>
                    ${empty sessionScope.user ? 'Login to Add to Cart' : 'Add to Cart'}
                </button>
            </form>
        </c:if>
    </div>
</div>

<jsp:include page="footer.jsp" />
