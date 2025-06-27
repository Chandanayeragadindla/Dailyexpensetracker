package org.example.dailyexpensetrackerproject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.util.HashMap;


public class ViewExpenseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userEmail = (String) request.getSession().getAttribute("userEmail");
        if (userEmail == null) {
            response.sendRedirect("login.jsp?msg=Please login first");
            return;
        }

        UserDAO dao = new UserDAO();
        HashMap<String, HashMap<Date, HashMap<String, int[]>>> allExpenses = dao.getExpenses(userEmail);

        request.setAttribute("filteredExpenses", allExpenses);
        request.getRequestDispatcher("viewExpense.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
