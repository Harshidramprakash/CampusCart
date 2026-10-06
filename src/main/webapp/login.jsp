<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp" />

<div class="auth-container">
    <div class="auth-card">
        <h2>Login to CampusCart</h2>
        
        <c:if test="${not empty param.message}">
            <div class="alert alert-success">${param.message}</div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger">${param.error}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <form action="login" method="POST" id="loginForm" onsubmit="return validateLoginForm()">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" value="${cookie.rememberedEmail.value != null ? cookie.rememberedEmail.value : email}" required>
                <div class="error-msg" id="email-error"></div>
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
                <div class="error-msg" id="password-error"></div>
            </div>
            
            <div class="form-group checkbox">
                <input type="checkbox" id="remember" name="remember" ${cookie.rememberedEmail.value != null ? 'checked' : ''}>
                <label for="remember">Remember my email</label>
            </div>
            
            <button type="submit" class="btn btn-primary btn-full">Login</button>
        </form>
        
        <div class="auth-footer">
            <p>Don't have an account? <a href="register.jsp">Register here</a></p>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
