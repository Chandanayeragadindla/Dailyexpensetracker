<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.Date, org.example.dailyexpensetrackerproject.Expense" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.jsp?msg=Please login first");
        return;
    }

    HashMap<String, HashMap<Date, HashMap<String, int[]>>> filteredExpenses =
            (HashMap<String, HashMap<Date, HashMap<String, int[]>>>) request.getAttribute("filteredExpenses");
    Integer totalAmount = (Integer) request.getAttribute("totalAmount");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Expenses</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #7B61FF;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 1000px;
            margin: auto;
            background: #ffffff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        }

        h1 {
            text-align: center;
            font-size: 30px;
            color: #7B61FF;
            margin-bottom: 20px;
        }

        .header-info {
            text-align: center;
            margin-bottom: 30px;
        }

        .header-info p {
            margin: 6px 0;
            font-size: 16px;
            color: #555;
        }

        .total-amount {
            font-size: 20px;
            font-weight: bold;
            color: #7B61FF;
        }

        .expense-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }

        .expense-table thead {
            background-color: #f0edff;
        }

        .expense-table th, .expense-table td {
            padding: 14px 18px;
            border-bottom: 1px solid #eee;
            text-align: left;
        }

        .expense-table td.amount {
            color: #7B61FF;
            font-weight: 600;
        }

        .expense-table tr:nth-child(even) {
            background-color: #f9f7ff;
        }

        .expense-table tr:hover {
            background-color: #f0ebff;
        }

        .no-expenses {
            text-align: center;
            color: #555;
            padding: 50px 20px;
            background: #ffffff;
            border-radius: 12px;
            border: 1px dashed #c2b9ff;
            margin-top: 30px;
        }

        .back-btn {
            background-color: #ffffff;
            color: #7B61FF;
            padding: 12px 22px;
            border: 2px solid #7B61FF;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            margin: 20px 10px 0;
            text-decoration: none;
            display: inline-block;
            transition: 0.3s ease;
            text-align: center;
        }

        .back-btn:hover {
            background-color: #7B61FF;
            color: white;
            transform: scale(1.05);
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            h1 {
                font-size: 24px;
            }

            .expense-table th, .expense-table td {
                font-size: 14px;
                padding: 10px;
            }
        }
    </style>
</head>

<body>
<div class="container">
    <h1>Where Your Money Went</h1>

    <div class="header-info">
        <p>User: <strong><%= userEmail %></strong></p>
        <% if (totalAmount != null) { %>
        <p class="total-amount">Total Amount Spent: ₹<%= totalAmount %></p>
        <% } %>
    </div>

    <% if (filteredExpenses != null && !filteredExpenses.isEmpty()) { %>
    <table class="expense-table">
        <thead>
        <tr>
            <th>Category</th>
            <th>Date</th>
            <th>Subcategory</th>
            <th>Count</th>
            <th>Amount</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Map.Entry<String, HashMap<Date, HashMap<String, int[]>>> categoryEntry : filteredExpenses.entrySet()) {
                String category = categoryEntry.getKey();
                HashMap<Date, HashMap<String, int[]>> dateMap = categoryEntry.getValue();
                for (Map.Entry<Date, HashMap<String, int[]>> dateEntry : dateMap.entrySet()) {
                    Date date = dateEntry.getKey();
                    HashMap<String, int[]> subcategoryMap = dateEntry.getValue();
                    for (Map.Entry<String, int[]> subcategoryEntry : subcategoryMap.entrySet()) {
                        String subcategory = subcategoryEntry.getKey();
                        int[] data = subcategoryEntry.getValue();
                        int count = data[0];
                        int amount = data[1];
        %>
        <tr>
            <td><%= category %></td>
            <td><%= date %></td>
            <td><%= subcategory %></td>
            <td><%= count %></td>
            <td class="amount">₹<%= amount %></td>
        </tr>
        <%
                    }
                }
            }
        %>
        </tbody>
    </table>
    <% } else { %>
    <div class="no-expenses">
        <h3>No expenses found</h3>
        <p>Start by adding your first expense.</p>
        <a href="addExpense.jsp" class="back-btn">Add Expense</a>
    </div>
    <% } %>

    <div style="text-align: center;">
        <a href="dashboard.jsp" class="back-btn">Back to Dashboard</a>
    </div>
</div>
</body>
</html>
