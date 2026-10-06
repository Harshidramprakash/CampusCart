<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<jsp:include page="header.jsp" />

<div class="container" style="text-align: center; padding-top: 5rem; min-height: 50vh;">
    <h1 style="color: var(--danger); font-size: 3rem;">Oops! Something went wrong.</h1>
    <p style="font-size: 1.25rem; color: var(--text-muted); margin-bottom: 2rem;">
        We're sorry, but the page you are looking for cannot be found or an error occurred.
    </p>
    
    <c:if test="${not empty requestScope['javax.servlet.error.message']}">
        <p><strong>Error Details:</strong> ${requestScope['javax.servlet.error.message']}</p>
    </c:if>
    
    <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-large">Return to Home</a>
</div>

<jsp:include page="footer.jsp" />
