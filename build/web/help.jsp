<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help - Mega Cab Booking System</title>
    <link rel="stylesheet" type="text/css" href="styles/help.css">
</head>

<body>
    <!-- Help Section -->
    <section id="help">
        <h1>Welcome to the Mega Cab Booking System!</h1>
        <p>Thank you for choosing our service. Whether you're a customer or a driver, we've made the booking process simple and easy to use. Here's how you can get started:</p>

        <!-- New Customer Guide -->
        <h2>For New Customers:</h2>
        <p>As a new customer, you'll need to sign up first. Follow these steps:</p>
        <ul>
            <li>Go to the <a href="signup.jsp">Sign Up</a> page.</li>
            <li>Provide your details: Name, Username, Password, Address, NIC, and Phone Number.</li>
            <li>Make sure to enter the details correctly.</li>
            <li>Once signed up, you'll be automatically redirected to the <a href="login.jsp">Login</a> page.</li>
            <li>Log in with the username and password you provided during sign-up.</li>
            <li>If the login is successful, you'll be redirected to your personal <strong>Dashboard</strong>.</li>
            <li>From the dashboard, you can:</li>
            <ul>
                <li>Book a ride.</li>
                <li>View details of your booked rides.</li>
                <li>Log out anytime by clicking the <strong>Logout</strong> button on the dashboard. This will log you out and redirect you to the <a href="index.html">Home page</a>.</li>
            </ul>
        </ul>

        <!-- New Driver Guide -->
        <h2>For New Drivers:</h2>
        <p>If you're a new driver, follow these steps to sign up:</p>
        <ul>
            <li>Click the <a href="driversignup.jsp">Driver Sign Up</a> button.</li>
            <li>Fill out your details: Full Name, Username, Password, Phone Number, and Vehicle Number.</li>
            <li>Ensure that all your details are entered correctly.</li>
            <li>Once submitted, you'll be redirected to the <a href="driverlogin.jsp">Login</a> page.</li>
            <li>Log in using the username and password you provided during sign-up.</li>
            <li>If the login is successful, you will be directed to your <strong>Driver Dashboard</strong>.</li>
            <li>As a driver, you can:</li>
            <ul>
                <li>Update the status of your rides (from Pending to Confirmed or Completed).</li>
                <li>View the list of assigned bookings and manage them.</li>
                <li>If you wish to log out, click the <strong>Logout</strong> button on the dashboard. This will log you out and redirect you to the <a href="index.html">Home page</a>.</li>
            </ul>
        </ul>

        <!-- Staff Members Information -->
        <h2>For Staff Members:</h2>
        <p>Staff members have special access to manage customer and driver details. Only staff members know the username and password for the staff section.</p>
        <ul>
            <li>Staff members can access their section after logging in with their credentials.</li>
            <li>Note that the <strong>Staff section</strong> is only available to authorized staff, and both customers and drivers cannot access this part of the system.</li>
        </ul>

        <!-- General Information -->
        <h2>General Information:</h2>
        <ul>
            <li>Once you sign up and log in, you will have access to your dashboard, which differs for customers and drivers.</li>
            <li>Remember that once logged in, you can log out at any time by clicking the <strong>Logout</strong> button on your respective dashboard.</li>
            <li>If you have any questions, feel free to contact us!</li>
        </ul>

        <!-- Button to Go Back to Home -->
        <h3>Ready to get started? Click the button below to go back to the homepage:</h3>
        <a href="index.html" class="help-button">Go Home</a>

        <footer>
            <p>&copy; 2025 Mega Cab Booking System. All rights reserved.</p>
        </footer>
    </section>

</body>

</html>
