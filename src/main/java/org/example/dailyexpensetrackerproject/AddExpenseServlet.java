package org.example.dailyexpensetrackerproject;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class AddExpenseServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userEmail = (String) request.getSession().getAttribute("userEmail");
        if (userEmail == null) {
            response.sendRedirect("login.jsp?msg=Please login first");
            return;
        }
        request.getRequestDispatcher("addExpense.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String userEmail = (String) request.getSession().getAttribute("userEmail");
        if (userEmail == null) {
            response.sendRedirect("login.jsp?msg=Please login first");
            return;
        }

        String category = request.getParameter("category");
        String subcategory = request.getParameter("subcategory");
        String priceStr = request.getParameter("price");
        String quantityStr = request.getParameter("quantity");
        String description = request.getParameter("description");
        String date = request.getParameter("date");

        if (category == null || category.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Category is required");
            request.getRequestDispatcher("addExpense.jsp").forward(request, response);
            return;
        }

        if (subcategory == null || subcategory.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Subcategory is required");
            request.getRequestDispatcher("addExpense.jsp").forward(request, response);
            return;
        }

        if (priceStr == null || priceStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Price is required");
            request.getRequestDispatcher("addExpense.jsp").forward(request, response);
            return;
        }

        if (date == null || date.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Date is required");
            request.getRequestDispatcher("addExpense.jsp").forward(request, response);
            return;
        }

        double price;
        int quantity = 1;

        try {
            price = Double.parseDouble(priceStr);
            if (price <= 0) {
                request.setAttribute("errorMessage", "Price must be greater than 0");
                request.getRequestDispatcher("addExpense.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid price format");
            request.getRequestDispatcher("addExpense.jsp").forward(request, response);
            return;
        }

        if (quantityStr != null && !quantityStr.trim().isEmpty()) {
            try {
                quantity = Integer.parseInt(quantityStr);
                if (quantity <= 0) {
                    request.setAttribute("errorMessage", "Quantity must be greater than 0");
                    request.getRequestDispatcher("addExpense.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid quantity format");
                request.getRequestDispatcher("addExpense.jsp").forward(request, response);
                return;
            }
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        sdf.setLenient(false);
        try {
            sdf.parse(date);
        } catch (ParseException e) {
            request.setAttribute("errorMessage", "Invalid date format");
            request.getRequestDispatcher("addExpense.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO expenses (user_email, category, subcategory, price, quantity, description, date) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, userEmail);
            ps.setString(2, category.trim());
            ps.setString(3, subcategory.trim());
            ps.setDouble(4, price);
            ps.setInt(5, quantity);
            ps.setString(6, description != null ? description.trim() : "");
            ps.setString(7, date);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("dashboard.jsp?msg=Expense added successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to add expense");
                request.getRequestDispatcher("addExpense.jsp").forward(request, response);
            }

        } catch (Exception e) {
            System.err.println("Error adding expense: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("addExpense.jsp").forward(request, response);
        }
    }
}