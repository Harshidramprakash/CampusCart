package com.campuscart.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Handles user logout — invalidates session and clears cookies.
 * Demonstrates: Experiment 4 — Session invalidation.
 */
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Set a preference cookie to remember the theme
        Cookie themeCookie = new Cookie("preferredTheme", "dark");
        themeCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days
        themeCookie.setPath(req.getContextPath() + "/");
        resp.addCookie(themeCookie);

        resp.sendRedirect(req.getContextPath() + "/login.jsp?message=Logged+out+successfully");
    }
}
