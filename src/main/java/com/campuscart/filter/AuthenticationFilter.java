package com.campuscart.filter;

import com.campuscart.model.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Authentication filter — protects cart, checkout, orders, profile, and admin pages.
 * Demonstrates: Experiment 4 — Session management and authorization.
 */
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpServletResponse httpResp = (HttpServletResponse) response;
        HttpSession session = httpReq.getSession(false);

        String uri = httpReq.getRequestURI();
        String ctx = httpReq.getContextPath();

        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // Not logged in → redirect to login
        if (user == null) {
            httpResp.sendRedirect(ctx + "/login.jsp?error=Please+login+first");
            return;
        }

        // Admin pages require admin role
        if (uri.startsWith(ctx + "/admin")) {
            if (!user.isAdmin()) {
                httpResp.sendRedirect(ctx + "/index.jsp?error=Admin+access+required");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
