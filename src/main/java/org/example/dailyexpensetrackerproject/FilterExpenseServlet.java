package org.example.dailyexpensetrackerproject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.util.HashMap;

public class FilterExpenseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Step 1: Check user is logged in
        String userEmail = (String) request.getSession().getAttribute("userEmail");
        if (userEmail == null) {
            response.sendRedirect("login.jsp?msg=Please login first");
            return;
        }

        // Step 2: Get parameters
        String category = request.getParameter("category");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        // Step 3: Get user ID from email
        UserDAO dao = new UserDAO();
        int userId = dao.getUserId(userEmail);
        if (userId == -1) {
            response.sendRedirect("login.jsp?msg=User not found");
            return;
        }

        // Step 4: Prepare clean inputs
        category = (category != null && !category.equals("all")) ? category.trim() : "";
        startDate = (startDate != null && !startDate.trim().isEmpty()) ? startDate.trim() : null;
        endDate = (endDate != null && !endDate.trim().isEmpty()) ? endDate.trim() : null;

        HashMap<String, HashMap<Date, HashMap<String, int[]>>> filteredExpenses = null;

        // Step 5: Only if filters applied → call DB
        boolean isAnyFilterApplied = (category != null && !category.isEmpty())
                || (startDate != null)
                || (endDate != null);

        if (isAnyFilterApplied) {
            // Default endDate to today if missing
            if (endDate == null) {
                endDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
            }

            filteredExpenses = dao.filteredExpenses(userId, category, startDate, endDate);
            request.setAttribute("filteredExpenses", filteredExpenses);
        }

        // Step 6: Forward to JSP
        request.setAttribute("selectedCategory", category);
        request.setAttribute("selectedStartDate", startDate);
        request.setAttribute("selectedEndDate", endDate);
        request.setAttribute("filterApplied", isAnyFilterApplied); // important for JSP condition

        request.getRequestDispatcher("filterExpense.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
