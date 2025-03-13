package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dataBase.dbconnection;
import java.io.IOException;
import java.sql.*;

@WebServlet("/viewbookingdetails")
public class viewbookingdetails extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer customerId = (session != null) ? (Integer) session.getAttribute("customer_id") : null;

        if (customerId == null) {
            response.sendRedirect("login.jsp?error=Please login first.");
            return;
        }

        try (Connection conn = dbconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT b.booking_id, b.pickup_location, b.destination, b.fare, b.status, " +
                     "d.driver_id, d.name AS driver_name " +
                     "FROM booking b LEFT JOIN drivers d ON b.driver_id = d.driver_id " +
                     "WHERE b.customer_id = ?")) {

            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            StringBuilder bookingHtml = new StringBuilder();
            while (rs.next()) {
                bookingHtml.append("<tr>")
                    .append("<td>").append(rs.getInt("booking_id")).append("</td>")
                    .append("<td>").append(rs.getString("pickup_location")).append("</td>")
                    .append("<td>").append(rs.getString("destination")).append("</td>")
                    .append("<td>").append(rs.getDouble("fare") / 40).append("</td>")
                    .append("<td>").append("Rs. ").append(rs.getDouble("fare")).append("</td>")
                    .append("<td>").append(rs.getString("status")).append("</td>")
                    .append("<td>").append(rs.getInt("driver_id")).append("</td>")
                    .append("<td>").append(rs.getString("driver_name") != null ? rs.getString("driver_name") : "Not Assigned").append("</td>")
                    .append("</tr>");
            }

            request.setAttribute("bookingHtml", bookingHtml.toString());
            request.getRequestDispatcher("bookinglist.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("bookinglist.jsp?error=Error fetching booking details.");
        }
    }
}
