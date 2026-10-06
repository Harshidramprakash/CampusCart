<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp" />

<div class="products-header">
    <h2>Campus Products</h2>
    <div class="search-bar">
        <input type="text" id="searchInput" placeholder="Search products (live search)..." onkeyup="searchProducts()">
    </div>
</div>

<div class="category-filters">
    <a href="products" class="btn ${empty selectedCategory ? 'btn-primary' : 'btn-outline'}">All</a>
    <c:forEach var="cat" items="${categories}">
        <a href="products?category=${cat}" class="btn ${selectedCategory == cat ? 'btn-primary' : 'btn-outline'}">${cat}</a>
    </c:forEach>
</div>

<div class="products-grid" id="productsGrid">
    <c:choose>
        <c:when test="${empty products}">
            <p>No products found.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="p" items="${products}">
                <div class="product-card">
                    <img src="${p.imageUrl}" alt="${p.name}" class="product-img">
                    <div class="product-info">
                        <span class="category-tag">${p.category}</span>
                        <h3>${p.name}</h3>
                        <p class="price">₹${p.price}</p>
                        
                        <div class="product-actions">
                            <a href="products?action=detail&id=${p.productId}" class="btn btn-outline">View Details</a>
                            <c:if test="${p.stock > 0}">
                                <form action="cart" method="POST" style="display:inline;">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="productId" value="${p.productId}">
                                    <button type="submit" class="btn btn-primary" ${empty sessionScope.user ? 'disabled title="Login to buy"' : ''}>Add to Cart</button>
                                </form>
                            </c:if>
                            <c:if test="${p.stock <= 0}">
                                <span class="out-of-stock">Out of Stock</span>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="footer.jsp" />
