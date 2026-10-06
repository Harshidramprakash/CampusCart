<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp" />

<div class="orders-container">
    <h2>Your Orders</h2>
    
    <c:if test="${not empty param.success}">
        <div class="alert alert-success">Order placed successfully!</div>
    </c:if>
    
    <c:choose>
        <c:when test="${empty orders}">
            <p>You haven't placed any orders yet.</p>
        </c:when>
        <c:otherwise>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Total Amount</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>#${order.orderId}</td>
                            <td>${order.orderDate}</td>
                            <td><span class="status-badge ${order.status}">${order.status}</span></td>
                            <td>₹${order.totalAmount}</td>
                            <td>
                                <a href="orders?action=detail&id=${order.orderId}" class="btn btn-outline btn-sm">View Details</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="footer.jsp" />
