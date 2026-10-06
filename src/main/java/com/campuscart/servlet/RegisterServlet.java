package com.campuscart.servlet;

import com.campuscart.dao.UserDAO;
import com.campuscart.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Handles user registration.
 * GET  → display registration form
 * POST → validate & register user
 *
 * Demonstrates: Experiment 2 (Servlet), Experiment 5 (JDBC).
 */
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String fullName = req.getParameter("fullName");
        String email    = req.getParameter("email");
        String password = req.getParameter("password");
        String confirm  = req.getParameter("confirmPassword");
        String phone    = req.getParameter("phone");
        String address  = req.getParameter("address");

        // Server-side validation
        StringBuilder errors = new StringBuilder();
        if (fullName == null || fullName.trim().length() < 2) errors.append("Name must be at least 2 characters. ");
        if (email == null || !email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) errors.append("Invalid email. ");
        if (password == null || password.length() < 6) errors.append("Password must be at least 6 characters. ");
        if (!password.equals(confirm)) errors.append("Passwords do not match. ");
        if (phone != null && !phone.isEmpty() && !phone.matches("^\\d{10}$")) errors.append("Phone must be 10 digits. ");

        if (errors.length() > 0) {
            req.setAttribute("error", errors.toString().trim());
            req.setAttribute("fullName", fullName);
            req.setAttribute("email", email);
            req.setAttribute("phone", phone);
            req.setAttribute("address", address);
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        // Check duplicate email
        if (userDAO.emailExists(email.trim())) {
            req.setAttribute("error", "Email is already registered.");
            req.setAttribute("fullName", fullName);
            req.setAttribute("phone", phone);
            req.setAttribute("address", address);
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        // Create user
        User user = new User(fullName.trim(), email.trim(), password, phone, address);
        boolean success = userDAO.registerUser(user);

        if (success) {
            req.setAttribute("success", "Registration successful! Please login.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "Registration failed. Please try again.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}
