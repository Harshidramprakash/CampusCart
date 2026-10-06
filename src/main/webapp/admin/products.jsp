<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <header class="navbar admin-navbar">
        <div class="nav-brand">
            <a href="${pageContext.request.contextPath}/admin?action=dashboard">CIT CampusCart Admin</a>
        </div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin?action=dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin?action=products" style="font-weight: bold;">Products</a>
            <a href="${pageContext.request.contextPath}/admin?action=orders">Orders</a>
            <a href="${pageContext.request.contextPath}/products" target="_blank">View Site</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline">Logout</a>
        </div>
    </header>
    
    <main class="container admin-container">
        <h2>Manage Products</h2>
        
        <c:if test="${not empty param.success}">
            <div class="alert alert-success">${param.success}</div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger">${param.error}</div>
        </c:if>
        
        <div class="admin-panel">
            <h3>Add New Product</h3>
            <form action="${pageContext.request.contextPath}/admin" method="POST" class="admin-form">
                <input type="hidden" name="action" value="addProduct">
                <input type="text" name="name" placeholder="Product Name" required>
                <input type="text" name="category" placeholder="Category" required>
                <input type="number" step="0.01" name="price" placeholder="Price" required>
                <input type="number" name="stock" placeholder="Stock" required>
                <input type="url" name="imageUrl" placeholder="Image URL" value="https://placehold.co/400x400/2563eb/ffffff?text=Product">
                <textarea name="description" placeholder="Description" rows="2"></textarea>
                <button type="submit" class="btn btn-primary">Add Product</button>
            </form>
        </div>

        <table class="data-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${products}">
                    <tr>
                        <td>${p.productId}</td>
                        <td>${p.name}</td>
                        <td>${p.category}</td>
                        <td>₹${p.price}</td>
                        <td>${p.stock}</td>
                        <td>
                            <span class="${p.active ? 'status-badge delivered' : 'status-badge cancelled'}">
                                ${p.active ? 'Active' : 'Inactive'}
                            </span>
                        </td>
                        <td>
                            <form action="${pageContext.request.contextPath}/admin" method="POST" style="display:inline;">
                                <input type="hidden" name="action" value="toggleProduct">
                                <input type="hidden" name="productId" value="${p.productId}">
                                <button type="submit" class="btn btn-sm ${p.active ? 'btn-outline' : 'btn-primary'}">
                                    ${p.active ? 'Deactivate' : 'Activate'}
                                </button>
                            </form>
                            <form action="${pageContext.request.contextPath}/admin" method="POST" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this product?');">
                                <input type="hidden" name="action" value="deleteProduct">
                                <input type="hidden" name="productId" value="${p.productId}">
                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </main>
</body>
</html>
