package servlet;

import dataBase.dbconnection;
import org.mindrot.jbcrypt.BCrypt;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/loginservlet")
public class loginservlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve login credentials from the form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Log the login attempt for debugging purposes
        System.out.println("Attempting to log in user: " + username);

        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            response.sendRedirect("login.jsp?error=Please enter both username and password.");
            return;
        }

        try (Connection conn = dbconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM customers WHERE username=?")) {

            // Set the username parameter in the query
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Retrieve the stored hashed password from the database
                String storedHashedPassword = rs.getString("password");

                // Compare the stored hash with the input password using BCrypt
                if (BCrypt.checkpw(password, storedHashedPassword)) {
                    // Successful login, set session attributes
                    int customerId = rs.getInt("id");  // Retrieve the customer ID
                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);  // Store username in session
                    session.setAttribute("customer_id", customerId);  // Store customer ID in session

                    // Redirect to the user dashboard or home page
                    response.sendRedirect("user.jsp?success=Login successful");
                } else {
                    // Invalid password, redirect with error
                    response.sendRedirect("login.jsp?error=Invalid username or password.");
                }
            } else {
                // Invalid username, redirect with error
                response.sendRedirect("login.jsp?error=Invalid username or password.");
            }
        } catch (Exception e) {
            e.printStackTrace();  // Log the full stack trace for debugging
            // Redirect to login page with database error message
            response.sendRedirect("login.jsp?error=Database error: " + e.getMessage());
        }
    }
}
