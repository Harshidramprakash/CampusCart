<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />

<div class="profile-container">
    <h2>Your Profile</h2>
    <div class="info-card">
        <p><strong>Name:</strong> ${sessionScope.user.fullName}</p>
        <p><strong>Email:</strong> ${sessionScope.user.email}</p>
        <p><strong>Phone:</strong> ${sessionScope.user.phone}</p>
        <p><strong>Address:</strong> ${sessionScope.user.address}</p>
        <p><strong>Role:</strong> ${sessionScope.user.role}</p>
        <p><strong>Member Since:</strong> ${sessionScope.user.createdAt}</p>
    </div>
</div>

<jsp:include page="footer.jsp" />
