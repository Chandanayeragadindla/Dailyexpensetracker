<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <meta charset="UTF-8">
    <title>Dashboard - Expense Tracker</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <style>
        .menu-btn {
            padding: 14px 28px;
            background-color: #ffffff;
            color: #7B61FF;
            border: 2px solid #7B61FF;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            font-size: 15px;
            transition: 0.3s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }

        .menu-btn:hover {
            background-color: #f4f0ff;
            transform: scale(1.05);
        }

        footer {
            margin-top: auto;
            background-color: #ffffff;
            color: #7B61FF;
            text-align: center;
            padding: 15px;
            font-size: 14px;
            border-top: 1px solid #ddd;
            box-shadow: 0 -2px 8px rgba(0, 0, 0, 0.05);
        }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #7B61FF, #9879FF);
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .header {
            background-color:#7B61FF;
            color: white;
            padding: 25px;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .header h1 {
            margin: 0;
            font-size: 28px;
        }

        .welcome {
            margin: 40px auto 20px;
            text-align: center;
            color: white;
        }

        .welcome h2 {
            margin-bottom: 10px;
            font-size: 22px;
        }

        .menu {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 20px;
            margin: 30px auto;
        }



        img {
            max-width: 90%;
            border-radius: 16px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            margin-bottom: 40px;
        }


    </style>
</head>
<body>
<div class="header">
    <h1>Expense Tracker </h1>
</div>

<div class="welcome">
    <h2>Welcome, <%= userEmail %>!</h2>
    <p>Manage your daily expenses efficiently</p>
</div>

<div class="menu">
    <a href="addExpense" class="menu-btn">Add Expense</a>
    <a href="viewExpense" class="menu-btn">View Expenses</a>
    <a href="filterExpense" class="menu-btn">Filter Expenses</a>
</div>

<div style="text-align: center;">
    <img src="expensesimage.jpg" alt="Dashboard Illustration" />
</div>

<footer>
    &copy; 2025 Daily Expense Tracker | Designed by Chandu
</footer>
</body>
</html>
