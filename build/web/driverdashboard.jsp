<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.sql.*, jakarta.servlet.http.*, jakarta.servlet.*, dataBase.dbconnection" %>

<html>
<head>
    <title>Driver Dashboard</title>
    <link rel="stylesheet" type="text/css" href="styles/driverdashboard.css">
</head>
<body>

<%
    HttpSession sessionObj = request.getSession(false);
    Integer driverId = (Integer) sessionObj.getAttribute("driver_id");
    String driverUsername = (String) sessionObj.getAttribute("driver_username");

    if (driverId == null) {
        response.sendRedirect("driverlogin.jsp");
        return;
    }
%>

<div class="form-container">
    <h2>Welcome, <%= driverUsername %>!</h2>
    <h3>Customer Bookings</h3>

    <%
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = dbconnection.getConnection();
            stmt = conn.prepareStatement("SELECT * FROM booking");
            rs = stmt.executeQuery();

            if (rs.next()) {
    %>
                <div class="table-container">
                    <table>
                        <tr>
                            <th>Booking ID</th>
                            <th>Pickup</th>
                            <th>Destination</th>
                            <th>Fare</th>
                            <th>Status</th>
                            <th>Update Status</th>
                        </tr>

                        <%
                            do {
                                int bookingId = rs.getInt("booking_id");
                                String pickupLocation = rs.getString("pickup_location");
                                String destination = rs.getString("destination");
                                double fare = rs.getDouble("fare");
                                String status = rs.getString("status");
                        %>
                                <tr>
                                    <td><%= bookingId %></td>
                                    <td><%= pickupLocation %></td>
                                    <td><%= destination %></td>
                                    <td><%= fare %></td>
                                    <td><%= status %></td>
                                    <td>
                                        <form action="UpdateBookingServlet" method="post">
                                            <input type="hidden" name="booking_id" value="<%= bookingId %>">
                                            <select name="status">
                                                <option value="Pending" <%= status.equals("Pending") ? "selected" : "" %>>Pending</option>
                                                <option value="Confirmed" <%= status.equals("Confirmed") ? "selected" : "" %>>Confirmed</option>
                                                <option value="Completed" <%= status.equals("Completed") ? "selected" : "" %>>Completed</option>
                                            </select>
                                            <button type="submit" class="update-btn">Update</button>
                                        </form>
                                    </td>
                                </tr>
                        <%
                            } while (rs.next());
                        %>
                    </table>
                </div>
    <%
            } else {
                out.println("<p>No bookings available.</p>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>Error fetching bookings.</p>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>

    <a href="index.html"><button class="logout-btn">Logout</button></a>
</div>

</body>
</html>
