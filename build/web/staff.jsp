<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Dashboard</title>
    <link rel="stylesheet" type="text/css" href="styles/staff.css">
</head>
<body>
    <div class="container">
        <div class="welcome-section">
            <h2>Welcome to the Staff Dashboard</h2>
            <p>Manage Driver and Customer Details, and Log Out</p>
        </div>
        <div class="button-container">
            <button onclick="location.href='manageDriverDetails.jsp'">Manage Driver Details</button>
            <button onclick="location.href='manageCustomerDetails.jsp'">Manage Customer Details</button>
            <button onclick="location.href='index.html'">Logout</button>
        </div>
    </div>
</body>
</html>
