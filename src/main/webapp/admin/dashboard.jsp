<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - CIT CampusCart</title>
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
            <a href="${pageContext.request.contextPath}/admin?action=orders">Orders</a>
            <a href="${pageContext.request.contextPath}/products" target="_blank">View Site</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline">Logout</a>
        </div>
    </header>
    
    <main class="container admin-container">
        <h2>Dashboard Overview</h2>
        <div class="dashboard-stats">
            <div class="stat-card">
                <h3>Total Users</h3>
                <p class="stat-value">${userCount}</p>
            </div>
            <div class="stat-card">
                <h3>Total Products</h3>
                <p class="stat-value">${productCount}</p>
            </div>
            <div class="stat-card">
                <h3>Total Orders</h3>
                <p class="stat-value">${orderCount}</p>
            </div>
            <div class="stat-card">
                <h3>Total Revenue</h3>
                <p class="stat-value">₹${revenue}</p>
            </div>
        </div>
    </main>
</body>
</html>
