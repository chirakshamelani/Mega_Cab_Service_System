<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Driver Login</title>
    <link rel="stylesheet" type="text/css" href="styles/driver.css">
</head>
<body>

<div class="form-container">
    <h2>Driver Login</h2>

    <% if (request.getParameter("error") != null) { %>
        <p class="error-message"><%= request.getParameter("error") %></p>
    <% } %>

    <form action="driverLoginServlet" method="post">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
        <a href="index.html" class="home-button">Home</a>

    <p>Don't have an account? <a href="driversignup.jsp">Sign up</a></p>
    </form>
    

    
    
</div>

</body>
</html>
