<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Expense Tracker</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #7B61FF, #9879FF);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #fff;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            text-align: center;
            width: 360px;
        }

        h2 {
            color: #333;
            font-size: 28px;
            margin-bottom: 10px;
        }

        h3 {
            color: #555;
            font-weight: 400;
            margin-bottom: 30px;
        }

        .menu-btn {
            background: linear-gradient(135deg, #7B61FF, #9879FF);
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            margin: 10px;
            width: 140px;
            transition: 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .menu-btn:hover {
            opacity: 0.95;
            transform: scale(1.05);
        }

        .button-container {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
    </style>

</head>
<body>
<div class="container">
    <h2>Welcome to Expense Tracker</h2>
    <h3>Please choose an option:</h3>

    <div class="button-container">

        <a href="login.jsp" class="menu-btn">Login</a>


        <a href="register.jsp" class="menu-btn">Register</a>
    </div>
</div>
</body>
</html>