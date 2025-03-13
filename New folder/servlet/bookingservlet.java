package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import dataBase.dbconnection;

@WebServlet("/bookingservlet")
public class bookingservlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get customer ID, pickup, destination, and distance from the request
        String customerId = request.getParameter("customer_id");
        String pickup = request.getParameter("pickup");
        String destination = request.getParameter("destination");
        String distanceStr = request.getParameter("distance");

        // Calculate the fare (40 rupees per km)
        double fare = 0;
        if (distanceStr != null && !distanceStr.trim().isEmpty()) {
            try {
                double distance = Double.parseDouble(distanceStr);
                fare = distance * 40;
            } catch (NumberFormatException e) {
                response.sendRedirect("afterLoggedBooking.jsp?error=Invalid distance input.");
                return;
            }
        }

        // Insert the booking details into the database
        try (Connection conn = dbconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "INSERT INTO booking (customer_id, pickup_location, destination, fare, status) VALUES (?, ?, ?, ?, 'pending')")) {

            stmt.setInt(1, Integer.parseInt(customerId));
            stmt.setString(2, pickup);
            stmt.setString(3, destination);
            stmt.setDouble(4, fare);

            stmt.executeUpdate();
            response.sendRedirect("afterLoggedBooking.jsp?msg=Booking confirmed. Your fare is " + fare + " LKR.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("afterLoggedBooking.jsp?error=Booking failed.");
        }
    }
}
