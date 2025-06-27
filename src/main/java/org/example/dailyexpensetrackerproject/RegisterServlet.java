package org.example.dailyexpensetrackerproject;
import jakarta.servlet.http.*;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws  IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        User user = new User(email, password);
        UserDAO userDAO = new UserDAO();
        boolean isSuccess = userDAO.insertUser(user);
        if (isSuccess) {
            response.sendRedirect("login.jsp?msg=Registration successful. Please login.");
        } else {
            response.sendRedirect("register.jsp?msg=Email already exists or something went wrong.");
        }
    }
}
