<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Driver Signup</title>
    <link rel="stylesheet" type="text/css" href="styles/driver.css">
</head>
<body>

<div class="form-container">
    <h2>Driver Signup</h2>

    <% if (request.getAttribute("error") != null) { %>
        <p class="error-message"><%= request.getAttribute("error") %></p>
    <% } %>

    <form action="driverSinupServlet" method="POST">
        <label>Full Name</label>
        <input type="text" name="name" value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>">

        <label>Username</label>
        <input type="text" name="username" value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>">

        <label>Password</label>
        <input type="password" name="password">

        <label>Phone</label>
        <input type="text" name="phone" value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>">

        <label>Vehicle Number</label>
        <input type="text" name="vehicle_number" value="<%= request.getAttribute("vehicle_number") != null ? request.getAttribute("vehicle_number") : "" %>">

        <button type="submit">Sign Up</button>
                <a href="index.html" class="home-button">Home</a>

    <p>Already have an account? <a href="driverlogin.jsp">Login</a></p>
    </form>


    
    
</div>

</body>
</html>
