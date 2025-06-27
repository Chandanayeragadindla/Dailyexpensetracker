<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Expense Tracker</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #7B61FF, #9879FF);
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }


        .container {
            background-color: #FFFFFF;
            padding: 40px 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            width: 360px;
            text-align: center;
        }

        h2 {
            color: #7B61FF;
            margin-bottom: 20px;
            font-size: 26px;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        input[type="email"],
        input[type="password"] {
            padding: 12px;
            width: 90%;
            margin: 10px 0;
            border: 1px solid #d9d9d9;
            border-radius: 10px;
            font-size: 15px;
            background-color: #F6EFFF;
            color: #44475B;
        }

        input[type="submit"] {
            background-color: #7B61FF;
            color: #fff;
            padding: 12px 25px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: bold;
            margin-top: 20px;
            cursor: pointer;
            transition: 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #6346E8;
        }

        .message {
            padding: 12px;
            margin-bottom: 15px;
            border-radius: 10px;
            font-size: 14px;
        }

        .success {
            background-color: #eafaf1;
            color: #2e7d32;
            border: 1px solid #c8e6c9;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        a {
            display: block;
            margin-top: 15px;
            color: #7B61FF;
            text-decoration: none;
            font-size: 14px;
        }

        a:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>
<div class="container">
    <h2>Login</h2>

    <%
        String msg = request.getParameter("msg");
        String error = request.getParameter("error");
        if (msg != null) {
    %>
    <div class="message success"><%= msg %></div>
    <%
        }
        if (error != null) {
    %>
    <div class="message error"><%= error %></div>
    <%
        }
    %>

    <form action="login" method="post">
        <input type="email" name="email" placeholder="Email" required />
        <input type="password" name="password" placeholder="Password" required />
        <input type="submit" value="Login" />
    </form>

    <a href="index.jsp">&larr; Back to Home</a>
    <a href="register.jsp">Don't have an account? Register</a>
</div>
</body>
</html>
