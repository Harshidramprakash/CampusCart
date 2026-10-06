package com.campuscart.servlet;

import com.campuscart.dao.UserDAO;
import com.campuscart.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Handles user login.
 * GET  → display login form (forward to login.jsp)
 * POST → authenticate user, create session, set cookie.
 *
 * Demonstrates: Experiment 2 (Servlet), Experiment 4 (Session + Cookie).
 */
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String remember = req.getParameter("remember");

        // Server-side validation
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Email and password are required.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        User user = userDAO.login(email.trim(), password);

        if (user != null) {
            // Create session
            HttpSession session = req.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userRole", user.getRole());

            // Remember-me cookie (Experiment 4)
            if ("on".equals(remember)) {
                Cookie emailCookie = new Cookie("rememberedEmail", email.trim());
                emailCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days
                emailCookie.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
                emailCookie.setHttpOnly(true);
                resp.addCookie(emailCookie);
            } else {
                Cookie emailCookie = new Cookie("rememberedEmail", "");
                emailCookie.setMaxAge(0);
                emailCookie.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
                emailCookie.setHttpOnly(true);
                resp.addCookie(emailCookie);
            }

            // Redirect admin to dashboard, students to home
            if (user.isAdmin()) {
                resp.sendRedirect(req.getContextPath() + "/admin?action=dashboard");
            } else {
                resp.sendRedirect(req.getContextPath() + "/products");
            }
        } else {
            req.setAttribute("error", "Invalid email or password.");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}
