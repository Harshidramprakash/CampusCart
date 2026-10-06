package com.campuscart.servlet;

import com.campuscart.dao.ProductDAO;
import com.campuscart.model.Product;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Handles AJAX requests for live product search.
 * Demonstrates: Experiment 6 (AJAX).
 */
public class ProductSearchServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword = req.getParameter("query");
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        JsonObject jsonResponse = new JsonObject();
        
        if (keyword == null || keyword.trim().isEmpty()) {
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", "Search query is empty");
        } else {
            List<Product> products = productDAO.searchProducts(keyword.trim());
            jsonResponse.addProperty("status", "success");
            jsonResponse.add("data", gson.toJsonTree(products));
        }

        try (PrintWriter out = resp.getWriter()) {
            out.print(jsonResponse.toString());
            out.flush();
        }
    }
}
