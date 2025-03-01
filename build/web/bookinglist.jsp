<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.sql.*, jakarta.servlet.http.*, jakarta.servlet.*, dataBase.dbconnection" %>

<html>
<head>
    <title>Your Bookings</title>
    <link rel="stylesheet" type="text/css" href="styles/booking.css">
</head>
<body>

<h2>Your Bookings</h2>

<%
    Integer customerId = (Integer) session.getAttribute("customer_id");
    
    if (customerId == null) {
        out.println("<p>You need to log in to view your bookings.</p>");
    } else {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = dbconnection.getConnection();
            stmt = conn.prepareStatement(
                "SELECT b.booking_id, b.pickup_location, b.destination, b.fare, b.status, " +
                "d.driver_id, d.name AS driver_name " +
                "FROM booking b LEFT JOIN drivers d ON b.driver_id = d.driver_id " +
                "WHERE b.customer_id = ?");

            stmt.setInt(1, customerId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                out.println("<table border='1'>");
                out.println("<tr><th>Booking ID</th><th>Pickup Location</th><th>Destination</th><th>Fare</th><th>Status</th><th>Driver ID</th><th>Driver Name</th></tr>");
                do {
                    int bookingId = rs.getInt("booking_id");
                    String pickupLocation = rs.getString("pickup_location");
                    String destination = rs.getString("destination");
                    double fare = rs.getDouble("fare");
                    String status = rs.getString("status");
                    int driverId = rs.getInt("driver_id");
                    String driverName = rs.getString("driver_name") != null ? rs.getString("driver_name") : "Not Assigned";

                    out.println("<tr>");
                    out.println("<td>" + bookingId + "</td>");
                    out.println("<td>" + pickupLocation + "</td>");
                    out.println("<td>" + destination + "</td>");
                    out.println("<td>" + fare + "</td>");
                    out.println("<td>" + status + "</td>");
                    out.println("<td>" + driverId + "</td>");
                    out.println("<td>" + driverName + "</td>");
                    out.println("</tr>");
                } while (rs.next());
                out.println("</table>");
            } else {
                out.println("<p>No bookings found for your account.</p>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>Error fetching bookings. Please try again later.</p>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<div style="margin-top: 20px; text-align: center;">
    <button onclick="window.location.href='user.jsp'">User Dashboard</button>
</div>

</body>
</html>
