<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp" />

<div class="auth-container">
    <div class="auth-card register-card">
        <h2>Create an Account</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form action="register" method="POST" id="registerForm" onsubmit="return validateRegisterForm()">
            <div class="form-group">
                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName" value="${fullName}" required>
                <div class="error-msg" id="name-error"></div>
            </div>
            
            <div class="form-group">
                <label for="regEmail">Email Address</label>
                <input type="email" id="regEmail" name="email" value="${email}" onblur="checkEmailAvailability()" required>
                <div class="error-msg" id="email-error"></div>
                <div class="success-msg" id="email-success"></div>
            </div>
            
            <div class="form-group">
                <label for="regPassword">Password</label>
                <input type="password" id="regPassword" name="password" required>
                <div class="error-msg" id="password-error"></div>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
                <div class="error-msg" id="confirm-error"></div>
            </div>
            
            <div class="form-group">
                <label for="phone">Phone Number (10 digits)</label>
                <input type="tel" id="phone" name="phone" value="${phone}">
                <div class="error-msg" id="phone-error"></div>
            </div>
            
            <div class="form-group">
                <label for="address">Hostel / Shipping Address</label>
                <textarea id="address" name="address" rows="3">${address}</textarea>
            </div>
            
            <button type="submit" class="btn btn-primary btn-full" id="regSubmitBtn">Register</button>
        </form>
        
        <div class="auth-footer">
            <p>Already have an account? <a href="login.jsp">Login here</a></p>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
