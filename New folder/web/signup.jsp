<%@ page import="java.sql.*" %>
<%
    String msg = request.getParameter("msg");
%>

<html>
    <head>
        <link rel="stylesheet" type="text/css" href="styles/jspStyles.css">
        <script>
            function validateForm() {
                var password = document.forms["signupForm"]["password"].value;
                var nic = document.forms["signupForm"]["nic"].value;
                var phone = document.forms["signupForm"]["phone"].value;

                // Validate password (at least 8 characters, one uppercase, one digit)
                var passwordRegex = /^(?=.*[A-Z])(?=.*\d).{8,}$/;
                if (!password.match(passwordRegex)) {
                    alert("Password must be at least 8 characters long, with at least one uppercase letter and one number.");
                    return false;
                }

                // Validate NIC format (e.g., 123456789V or 123456789)
                var nicRegex = /^[0-9]{9}[Vv]?$|^[0-9]{12}$/;
                if (!nic.match(nicRegex)) {
                    alert("Please enter a valid NIC number.");
                    return false;
                }

                // Validate phone number (e.g., starting with a digit, 10 digits)
                var phoneRegex = /^[0-9]{10}$/;
                if (!phone.match(phoneRegex)) {
                    alert("Phone number must be exactly 10 digits.");
                    return false;
                }

                return true;
            }
        </script>
    </head>
    <body>
        <form name="signupForm" action="signupservlet" method="POST" onsubmit="return validateForm()" class="form-container">
            <h2>Sign Up</h2>
            <% if (msg != null) { %>
                <p class="success"><%= msg %></p>
            <% } %>
            <label>Full Name</label>
            <input type="text" name="name" required>
            <label>Username</label>
            <input type="text" name="username" required>
            <label>Password</label>
            <input type="password" name="password" required>
            <label>Address</label>
            <input type="text" name="address" required>
            <label>NIC</label>
            <input type="text" name="nic" required>
            <label>Phone</label>
            <input type="text" name="phone" required>
            
            <button type="submit">Sign Up</button>
            <br>
            <button type="button" onclick="window.location.href='index.html'">Home</button>

            <!-- Already have an account link -->
            <p>Already have an account? <a href="login.jsp">Login</a></p>
        </form>
    </body>
</html>
