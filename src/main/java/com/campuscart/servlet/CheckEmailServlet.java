package com.campuscart.servlet;

import com.campuscart.dao.UserDAO;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Handles AJAX requests to check if an email is already registered.
 * Demonstrates: Experiment 6 (AJAX).
 */
public class CheckEmailServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        JsonObject jsonResponse = new JsonObject();

        if (email == null || email.trim().isEmpty()) {
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", "Email parameter is missing");
        } else {
            boolean exists = userDAO.emailExists(email.trim());
            jsonResponse.addProperty("status", "success");
            jsonResponse.addProperty("exists", exists);
            if (exists) {
                jsonResponse.addProperty("message", "Email is already registered");
            } else {
                jsonResponse.addProperty("message", "Email is available");
            }
        }

        try (PrintWriter out = resp.getWriter()) {
            out.print(jsonResponse.toString());
            out.flush();
        }
    }
}
