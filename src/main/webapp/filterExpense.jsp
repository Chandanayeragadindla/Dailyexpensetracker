<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.Date" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.jsp?msg=Please login first");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Filter Expenses</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #7B61FF;
            padding: 40px;
        }
        .container {
            max-width: 750px;
            margin: auto;
            background: #ffffff;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06);
        }
        h2 {
            text-align: center;
            background-color: #7B61FF;
            color: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
            font-weight: bold;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        form {
            display: grid;
            gap: 20px;
        }
        .row {
            display: flex;
            gap: 20px;
        }
        input, select {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            font-size: 16px;
            border: 1px solid #ccc;
            font-weight: bold;
        }
        button {
            background-color: #7B61FF;
            color: white;
            padding: 10px 25px; /* Width based on content */
            border: none;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            display: block;
            margin: 0 auto; /* This centers the button */
            width: fit-content; /* Key part: only as wide as text */
        }


        button:hover {
            background-color: #5c47d3;
        }
        .result-box {
            margin-top: 40px;
            background-color: #fafafa;
            padding: 25px;
            border-radius: 12px;
            border: 1px solid #e3e3e3;
        }
        .expense-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 16px;
            border-left: 5px solid #7B61FF;
            background-color: #ffffff;
            border-radius: 10px;
            margin: 10px 0;
            box-shadow: 0px 1px 4px rgba(0, 0, 0, 0.05);
            font-size: 15px;
            font-weight: bold;
        }
        .expense-row span:first-child {
            color: #17252a;
        }
        .expense-row span:last-child {
            color: #0e6251;
        }
        .total {
            text-align: right;
            font-weight: bold;
            font-size: 17px;
            margin-top: 15px;
            color: #0e6251;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 30px;
            color: #ffffff;
            text-decoration: none;
            font-weight: bold;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Search by Date or Category</h2>

    <form action="filterExpense" method="post">
        <div class="row">
            <input type="date" name="startDate" placeholder="From Date 🗓" required />
            <input type="date" name="endDate" placeholder="To Date 🗓" />
        </div>
        <select name="category">
            <option value="">All Categories</option>
            <option value="Food">Food</option>
            <option value="Transportation">Transportation</option>
            <option value="Stationary">Stationary</option>
            <option value="Shopping">Shopping</option>
            <option value="Bills">Bills</option>
            <option value="Healthcare">Healthcare</option>
            <option value="Entertainment">Entertainment</option>
        </select>
        <button type="submit">Filter</button>
    </form>

    <%
        Boolean filterApplied = (Boolean) request.getAttribute("filterApplied");
        HashMap<String, HashMap<Date, HashMap<String, int[]>>> filteredExpenses =
                (HashMap<String, HashMap<Date, HashMap<String, int[]>>>) request.getAttribute("filteredExpenses");

        if (filterApplied != null && filterApplied) {
            if (filteredExpenses == null || filteredExpenses.isEmpty()) {
    %>
    <p style="text-align:center; margin-top:20px; font-weight:bold;">No matching expenses found.</p>
    <%
    } else {
    %>
    <div class="result-box">
        <%
            double grandTotal = 0;
            for (String cat : filteredExpenses.keySet()) {
                HashMap<Date, HashMap<String, int[]>> dateMap = filteredExpenses.get(cat);
                for (Date dt : dateMap.keySet()) {
                    HashMap<String, int[]> subMap = dateMap.get(dt);
                    for (String sub : subMap.keySet()) {
                        int[] val = subMap.get(sub);
                        grandTotal += val[1];
        %>
        <div class="expense-row">
            <span><%= cat %> - <%= sub %></span>
            <span>₹<%= val[1] %></span>
        </div>
        <%           }
        }
        }
        %>

        <div class="expense-row" style="font-weight: bold; font-size: 16px; border-top: 1px solid #ccc; margin-top: 30px; padding-top: 10px;">
            <span>Overall Total:</span>
            <span>₹<%= grandTotal %></span>
        </div>
    </div>
    <%   }
    }
    %>

    <a href="dashboard.jsp" class="back-link">← Back to Dashboard</a>
</div>
</body>
</html>
