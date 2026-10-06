<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CIT CampusCart</title>
    <!-- Modern clean styling -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <header class="navbar">
        <div class="nav-brand">
            <a href="${pageContext.request.contextPath}/index.jsp">CIT CampusCart</a>
        </div>
        
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
            <a href="${pageContext.request.contextPath}/products">Products</a>
            <a href="${pageContext.request.contextPath}/xml-demo.jsp">XML Demo</a>
            
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/cart">Cart (<span id="cart-count">0</span>)</a>
                    <a href="${pageContext.request.contextPath}/orders">Orders</a>
                    <a href="${pageContext.request.contextPath}/profile.jsp">Profile</a>
                    
                    <c:if test="${sessionScope.user.role == 'admin'}">
                        <a href="${pageContext.request.contextPath}/admin?action=dashboard" class="admin-link">Admin</a>
                    </c:if>
                    
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline">Login</a>
                    <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-primary">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </header>
    <main class="container">
