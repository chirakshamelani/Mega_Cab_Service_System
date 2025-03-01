<%-- 
    Document   : login
    Created on : Feb 18, 2025, 3:58:16 PM
    Author     : rajah
--%>

<%@ page import="java.sql.*" %>
<%
    String error = request.getParameter("error");
%>

<html>
    <head>
        <link rel="stylesheet" type="text/css" href="styles/jspStyles.css">
    </head>
    <body>
        <form action="loginservlet" method="POST" class="form-container">
            <h2>Login</h2>
            <% if (error != null) { %>
                <p class="error"><%= error %></p>
            <% } %>
            <label>Username</label>
            <input type="text" name="username" required>
            <label>Password</label>
            <input type="password" name="password" required>
            <button type="submit">Login</button>
            
            
            <br><br>
            
            
            <button type="button" onclick="window.location.href='index.html'">Home</button>

            <p>New user? <a href="signup.jsp">Create an account</a></p>
        </form>
    </body>
</html>
