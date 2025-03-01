<%@ page import="java.sql.*, dataBase.dbconnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Manage Driver Details</title>
    <link rel="stylesheet" type="text/css" href="styles/managedriver.css">

    <script>
        function showUpdatePopup(driverId, name, phone, vehicleNumber) {
            document.getElementById("update_driver_id").value = driverId;
            document.getElementById("update_name").value = name;
            document.getElementById("update_phone").value = phone;
            document.getElementById("update_vehicle_number").value = vehicleNumber;
            document.getElementById("updatePopup").style.display = "block";
        }

        function closePopup() {
            document.getElementById("updatePopup").style.display = "none";
        }

        // Function to display alert messages from URL parameters
        function showAlertMessages() {
            const params = new URLSearchParams(window.location.search);
            if (params.has("success")) {
                alert(params.get("success"));
            }
            if (params.has("error")) {
                alert(params.get("error"));
            }
        }

        // Run the alert function when the page loads
        window.onload = showAlertMessages;
    </script>

    <style>
        /* Centering the popup */
        #updatePopup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: #f4f4f4;
            padding: 20px;
            box-shadow: 0px 0px 10px gray;
            border-radius: 8px;
            z-index: 1000;
        }
    </style>
</head>
<body>
    <h2>Manage Driver Details</h2>
    <a href="staff.jsp">Back to Staff Page</a>
    <table border="1">
        <tr>
            <th>Driver ID</th>
            <th>Name</th>
            <th>Phone</th>
            <th>Vehicle Number</th>
            <th>Actions</th>
        </tr>
        
        <%
            Connection connection = dbconnection.getConnection();
            String query = "SELECT * FROM drivers";
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("driver_id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("phone") %></td>
            <td><%= rs.getString("vehicle_number") %></td>
            <td>
                <button onclick="showUpdatePopup('<%= rs.getInt("driver_id") %>', '<%= rs.getString("name") %>', '<%= rs.getString("phone") %>', '<%= rs.getString("vehicle_number") %>')">Update</button>
                
                <form action="DeleteDriverServlet" method="post" style="display:inline;">
                    <input type="hidden" name="driver_id" value="<%= rs.getInt("driver_id") %>">
                    <input type="submit" value="Delete">
                </form>
            </td>
        </tr>
        <%
            }
            rs.close();
            pstmt.close();
            connection.close();
        %>
    </table>

    <!-- Update Popup -->
    <div id="updatePopup">
        <h3>Update Driver Details</h3>
        <form action="UpdateDriverServlet" method="post">
            <input type="hidden" id="update_driver_id" name="driver_id">
            Name: <input type="text" id="update_name" name="name"><br>
            Phone: <input type="text" id="update_phone" name="phone"><br>
            Vehicle Number: <input type="text" id="update_vehicle_number" name="vehicle_number"><br>
            <input type="submit" value="Save">
            <button type="button" onclick="closePopup()">Close</button>
        </form>
    </div>
</body>
</html>
