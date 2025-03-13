package servlet;

import dataBase.dbconnection;
import org.mindrot.jbcrypt.BCrypt;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.regex.*;

@WebServlet("/signupservlet")
public class signupservlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");
        String phone = request.getParameter("phone");

        // Validate the input fields
        String message = null;

        // Password validation (at least 8 characters, one uppercase, one digit)
        if (!password.matches("^(?=.*[A-Z])(?=.*\\d).{8,}$")) {
            message = "Password must be at least 8 characters long, with at least one uppercase letter and one number.";
            response.sendRedirect("signup.jsp?msg=" + message);
            return;
        }

        // NIC validation (12 digits or 9 digits followed by 'V'/'v')
        if (!nic.matches("^[0-9]{9}[Vv]?$|^[0-9]{12}$")) {
            message = "Please enter a valid NIC number.";
            response.sendRedirect("signup.jsp?msg=" + message);
            return;
        }

        // Phone validation (exactly 10 digits)
        if (!phone.matches("^[0-9]{10}$")) {
            message = "Phone number must be exactly 10 digits.";
            response.sendRedirect("signup.jsp?msg=" + message);
            return;
        }

        // Database connection variables
        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Establish DB connection (replace with your DB credentials)
            con = dbconnection.getConnection();

            // Check if the username already exists
            String checkQuery = "SELECT * FROM customers WHERE username = ?";
            ps = con.prepareStatement(checkQuery);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // If username already exists, send error message
                message = "Username already exists! Please choose a different username.";
                response.sendRedirect("signup.jsp?msg=" + message);
                return;
            }

            // Hash the password using BCrypt before storing it
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            // SQL query to insert new user into the database
            String insertQuery = "INSERT INTO customers (name, username, password, address, nic, phone) VALUES (?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(insertQuery);
            ps.setString(1, name);
            ps.setString(2, username);
            ps.setString(3, hashedPassword);  // Store the hashed password
            ps.setString(4, address);
            ps.setString(5, nic);
            ps.setString(6, phone);

            // Execute the insert statement
            int result = ps.executeUpdate();

            // Check if the insertion was successful
            if (result > 0) {
                message = "Sign up successful! You can now log in.";
                response.sendRedirect("login.jsp?msg=" + message);
            } else {
                message = "Something went wrong. Please try again.";
                response.sendRedirect("signup.jsp?msg=" + message);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            message = "An error occurred. Please try again later.";
            response.sendRedirect("signup.jsp?msg=" + message);
        } finally {
            // Close database resources
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
