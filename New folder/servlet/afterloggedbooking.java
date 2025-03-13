package servlet;

import dataBase.dbconnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/afterloggedbooking")
public class afterloggedbooking extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer customerId = Integer.parseInt(request.getParameter("customer_id"));
        String vehicle_type = request.getParameter("vehicle_type");
        String pickupLocation = request.getParameter("pickup_location");
        String destination = request.getParameter("destination");
        double fare = Double.parseDouble(request.getParameter("fare"));

        try (Connection conn = dbconnection.getConnection()) {
            String query = "INSERT INTO booking (customer_id,vehicle_type, pickup_location, destination, fare, status) VALUES (?, ?, ? , ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);

            stmt.setInt(1, customerId);
            stmt.setString(2, vehicle_type);
            stmt.setString(3, pickupLocation);
            stmt.setString(4, destination);
            stmt.setDouble(5, fare);
            stmt.setString(6, "Pending"); // Set status as "Pending" or as per your requirement

           
            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("bookinglist.jsp?success=Booking confirmed");
            } else {
                response.sendRedirect("afterloggedbooking.jsp?error=Failed to book ride");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("afterloggedbooking.jsp?error=Database error");
        }
    }
}
