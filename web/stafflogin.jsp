<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Login</title>
    <link rel="stylesheet" type="text/css" href="styles/stafflogin.css">

</head>
<body>

    <div class="login-container">
        <h2>Staff Login</h2>
        <p>Only staff can login</p>
        
        <form action="StaffLoginServlet" method="POST">
            <div class="textbox">
                <input type="text" name="username" placeholder="Username" required>
            </div>
            <div class="textbox">
                <input type="password" name="password" placeholder="Password" required>
            </div>
            <input type="submit" value="Login">
        </form>

        <div class="message">
            <%= request.getParameter("error") != null ? request.getParameter("error") : "" %>
        </div>

        <a href="index.html">Go to Home</a>
    </div>

</body>
</html>
