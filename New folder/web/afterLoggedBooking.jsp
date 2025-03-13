<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>

<%
    // Retrieve customer_id from session
    Integer customerId = (Integer) session.getAttribute("customer_id");

    // If customer_id is not found, redirect to login page
    if (customerId == null) {
        response.sendRedirect("login.jsp?error=Please login first.");
        return;
    }
%>

<html>
<head>
    <title>Book a Ride</title>
    <link rel="stylesheet" href="styles/afterlogged.css">
</head>
<body>

    <h2>Book a Ride</h2>

    <!-- Booking form -->
    <form action="afterloggedbooking" method="POST">
        <!-- Hidden customer ID -->
        <input type="hidden" name="customer_id" value="<%= customerId %>">
        <label for="vehicle_type">Vehicle Type: <select id="vehicle_type" name="vehicle_type" required>
    <option value="Car">Car</option>
    <option value="Three Wheeler">Three Wheeler</option>
</select></label>



        <label for="pickup_location">Pickup Location:</label>
        <input type="text" id="pickup_location" name="pickup_location" required>

        <label for="destination">Destination:</label>
        <input type="text" id="destination" name="destination" required>

        <label for="distance">Distance (in km):</label>
        <input type="number" id="distance" name="distance" required>

        <label for="fare">Fare (Calculated):</label>
        <input type="text" id="fare" name="fare" readonly>

        <button type="submit">Confirm Booking</button>
    </form>

    <script>
        // Calculate fare on distance input change
        document.getElementById("distance").addEventListener("input", function() {
            let distance = parseFloat(this.value);
            let fare = distance * 40;  // Example fare calculation (40 rupees per km)
            document.getElementById("fare").value = fare.toFixed(2);
        });
    </script>

</body>
</html>