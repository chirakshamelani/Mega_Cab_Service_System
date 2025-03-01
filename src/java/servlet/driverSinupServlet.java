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

@WebServlet("/driverSinupServlet")
public class driverSinupServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String vehicleNumber = request.getParameter("vehicle_number");

        String errorMessage = null;

        // Password validation
        if (!password.matches("^(?=.*[A-Z])(?=.*\\d).{8,}$")) {
            errorMessage = "Password must be at least 8 characters long, with at least one uppercase letter and one digit.";
        }
        // Phone number validation
        else if (!phone.matches("^[0-9]{10}$")) {
            errorMessage = "Phone number must be exactly 10 digits.";
        }
        // Vehicle number validation (2 or 3 letters followed by 4 digits)
        else if (!vehicleNumber.matches("^[A-Za-z]{2,3}[0-9]{4}$")) {
            errorMessage = "Vehicle number must have 2 or 3 letters followed by 4 digits (e.g., AB1234).";
        }

        if (errorMessage != null) {
            // Set attributes to be displayed on the JSP page
            request.setAttribute("error", errorMessage);
            request.setAttribute("name", name);
            request.setAttribute("username", username);
            request.setAttribute("phone", phone);
            request.setAttribute("vehicle_number", vehicleNumber);

            // Forward the request to the signup page
            request.getRequestDispatcher("driversignup.jsp").forward(request, response);
        } else {
            // If validation passed, hash the password and save to database
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            // Save driver details to the database (insert into drivers table)
            try (Connection connection = dbconnection.getConnection()) {
                String sql = "INSERT INTO drivers (name, username, password, phone, vehicle_number) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement ps = connection.prepareStatement(sql)) {
                    ps.setString(1, name);
                    ps.setString(2, username);
                    ps.setString(3, hashedPassword);
                    ps.setString(4, phone);
                    ps.setString(5, vehicleNumber);

                    int rowsInserted = ps.executeUpdate();
                    if (rowsInserted > 0) {
                        response.sendRedirect("driverlogin.jsp"); // Redirect to login if successful
                    } else {
                        request.setAttribute("error", "An error occurred while saving your data. Please try again.");
                        request.getRequestDispatcher("driversignup.jsp").forward(request, response);
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Database error. Please try again later.");
                request.getRequestDispatcher("driversignup.jsp").forward(request, response);
            }
        }
    }
}
