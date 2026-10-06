<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <header class="navbar admin-navbar">
        <div class="nav-brand">
            <a href="${pageContext.request.contextPath}/admin?action=dashboard">CIT CampusCart Admin</a>
        </div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin?action=dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin?action=products">Products</a>
            <a href="${pageContext.request.contextPath}/admin?action=orders" style="font-weight: bold;">Orders</a>
            <a href="${pageContext.request.contextPath}/products" target="_blank">View Site</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline">Logout</a>
        </div>
    </header>
    
    <main class="container admin-container">
        <h2>Manage Orders</h2>
        
        <c:if test="${not empty param.success}">
            <div class="alert alert-success">${param.success}</div>
        </c:if>
        
        <table class="data-table">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>User</th>
                    <th>Date</th>
                    <th>Amount</th>
                    <th>Status</th>
                    <th>Update Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="o" items="${orders}">
                    <tr>
                        <td>#${o.orderId}</td>
                        <td>
                            ${o.userName}<br>
                            <small>${o.userEmail}</small>
                        </td>
                        <td>${o.orderDate}</td>
                        <td>₹${o.totalAmount}</td>
                        <td><span class="status-badge ${o.status}">${o.status}</span></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/admin" method="POST">
                                <input type="hidden" name="action" value="updateOrderStatus">
                                <input type="hidden" name="orderId" value="${o.orderId}">
                                <select name="status" onchange="this.form.submit()">
                                    <option value="pending" ${o.status == 'pending' ? 'selected' : ''}>Pending</option>
                                    <option value="confirmed" ${o.status == 'confirmed' ? 'selected' : ''}>Confirmed</option>
                                    <option value="shipped" ${o.status == 'shipped' ? 'selected' : ''}>Shipped</option>
                                    <option value="delivered" ${o.status == 'delivered' ? 'selected' : ''}>Delivered</option>
                                    <option value="cancelled" ${o.status == 'cancelled' ? 'selected' : ''}>Cancelled</option>
                                </select>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </main>
</body>
</html>
