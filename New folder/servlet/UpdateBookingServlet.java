package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dataBase.dbconnection;

@WebServlet("/UpdateBookingServlet")
public class UpdateBookingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Ensure driver is logged in
        if (session == null || session.getAttribute("driver_id") == null) {
            response.sendRedirect("driverlogin.jsp");
            return;
        }

        int driverId = (int) session.getAttribute("driver_id"); // Get driver_id from session
        String bookingId = request.getParameter("booking_id");
        String newStatus = request.getParameter("status");

        // Validate ENUM values
        if (!newStatus.equals("Pending") && !newStatus.equals("Confirmed") && !newStatus.equals("Completed")) {
            response.getWriter().println("Error: Invalid status value!");
            return;
        }

        try (Connection conn = dbconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("UPDATE booking SET status = ?, driver_id = ? WHERE booking_id = ?")) {

            stmt.setString(1, newStatus);
            stmt.setInt(2, driverId);  // Store driver_id who updated the status
            stmt.setInt(3, Integer.parseInt(bookingId));

            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                response.sendRedirect("driverdashboard.jsp");
            } else {
                response.getWriter().println("Error: No rows updated.");
            }
        } catch (SQLException e) {
            response.getWriter().println("Database error occurred! Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
