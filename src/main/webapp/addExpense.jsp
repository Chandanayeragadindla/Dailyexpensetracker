<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Add Expense</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      margin: 0;
      padding: 0;
      background: linear-gradient(135deg, #7B61FF, #9879FF);
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }

    .container {
      background-color: white;
      padding: 40px;
      border-radius: 16px;
      box-shadow: 0 8px 20px rgba(0,0,0,0.15);
      width: 500px;
      animation: slideUp 0.5s ease;
    }

    @keyframes slideUp {
      from { transform: translateY(30px); opacity: 0; }
      to { transform: translateY(0); opacity: 1; }
    }

    h2 {
      color: #7B61FF;
      text-align: center;
      margin-bottom: 25px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    label {
      font-weight: 600;
      margin-bottom: 6px;
      display: block;
      color: #333;
    }

    input[type="text"],
    input[type="number"],
    input[type="date"],
    select,
    textarea {
      width: 100%;
      padding: 12px;
      border-radius: 6px;
      border: 1px solid #ccc;
      font-size: 14px;
      box-sizing: border-box;
      transition: 0.3s;
    }

    input:focus, select:focus, textarea:focus {
      border-color: #9879FF;
      outline: none;
    }

    button {
      background: linear-gradient(135deg, #7B61FF, #9879FF);
      color: white;
      font-weight: 600;
      padding: 12px;
      border: none;
      border-radius: 8px;
      width: 100%;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s ease, transform 0.2s ease;
    }

    button:hover {
      opacity: 0.95;
      transform: scale(1.02);
    }

    .back-link {
      text-align: center;
      margin-top: 20px;
      display: block;
      color: #5F36B5;
      text-decoration: none;
      font-weight: 500;
    }

    .back-link:hover {
      text-decoration: underline;
    }

    .message {
      padding: 10px;
      margin-bottom: 20px;
      text-align: center;
      border-radius: 6px;
      font-size: 14px;
    }

    .error {
      background-color: #fdecea;
      color: #b71c1c;
      border: 1px solid #f5c6cb;
    }
  </style>
</head>
<body>
<div class="container">
  <h2>Add New Expense</h2>

  <%
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage != null) {
  %>
  <div class="message error"><%= errorMessage %></div>
  <%
    }
  %>

  <form action="addExpense" method="post">
    <div class="form-group">
      <label for="category">Category:</label>
      <select id="category" name="category" required>
        <option value="">-- Select Category --</option>
        <option value="Food">Food</option>
        <option value="Transportation">Transportation</option>
        <option value="Entertainment">Entertainment</option>
        <option value="Shopping">Shopping</option>
        <option value="Bills">Bills</option>
        <option value="Healthcare">Healthcare</option>
        <option value="Education">Education</option>
        <option value="Other">Other</option>
      </select>
    </div>

    <div class="form-group">
      <label for="subcategory">Subcategory:</label>
      <input type="text" id="subcategory" name="subcategory" required placeholder="Enter Your Expense Name">
    </div>

    <div class="form-group">
      <label for="price">Price:</label>
      <input type="number" id="price" name="price" min="1" required placeholder="Enter amount">
    </div>

    <div class="form-group">
      <label for="quantity">Quantity:</label>
      <input type="number" id="quantity" name="quantity" min="1" required placeholder="Enter Quantity">
    </div>

    <div class="form-group">
      <label for="date">Date:</label>
      <input type="date" id="date" name="date" required>
    </div>

    <div class="form-group">
      <label for="description">Description:</label>
      <textarea id="description" name="description" required placeholder="Any notes about this expense..."></textarea>
    </div>

    <button type="submit">Add Expense</button>
  </form>

  <a href="dashboard.jsp" class="back-link">← Back to Dashboard</a>
</div>
</body>
</html>
