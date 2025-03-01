<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%
    String username = (String) session.getAttribute("username");
    Integer customerId = (Integer) session.getAttribute("customer_id");

    if (username == null || customerId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome User</title>
    <link rel="stylesheet" href="styles/userCss.css"> 
</head>
<body>
    <header>
        <nav>
            <ul>
                <li><a href="afterLoggedBooking.jsp">Book a Ride</a></li>
                <li><a href="bookinglist.jsp">View Bookings</a></li>
                <li>
                    <form action="logoutservlet" method="POST">
                        <button type="submit" class="logout-btn">Logout</button>
                    </form>
                </li>
            </ul>
        </nav>
    </header>

        <main>
            <div class="content-box">
                <h2>Welcome, <%= username %>!</h2>
                <p>Your customer ID is: <%= customerId %></p>
                <p>Enjoy your ride booking experience.</p>
            </div>
        </main>

</body>
</html>
