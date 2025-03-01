<%@ page import="java.sql.*, dataBase.dbconnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Manage Customer Details</title>
    <link rel="stylesheet" type="text/css" href="styles/managecustomer.css">
    
    <script>
        // Function to show the update popup with the selected customer’s details
        function showUpdatePopup(customerId, name, phone, address) {
    document.getElementById("customer_id").value = customerId;
    document.getElementById("update_name").value = name;
    document.getElementById("update_phone").value = phone;
    document.getElementById("update_address").value = address;

    // Show the popup and overlay
    document.getElementById("updatePopup").style.display = "block";
    document.getElementById("popupOverlay").style.display = "block";
}

// Close popup function
function closePopup() {
    document.getElementById("updatePopup").style.display = "none";
    document.getElementById("popupOverlay").style.display = "none";
}

        // Function to send update request via AJAX
        function updateCustomer() {
    var customerId = document.getElementById("customer_id").value; // Correct ID
    var name = document.getElementById("update_name").value;
    var phone = document.getElementById("update_phone").value;
    var address = document.getElementById("update_address").value;

    var xhr = new XMLHttpRequest();
    xhr.open("POST", "UpdateCustomerServlet", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4) {
            if (xhr.status == 200) {
                var response = xhr.responseText.trim();
                if (response === "success") {
                    alert("Customer updated successfully!");
                    location.reload(); // Refresh the page
                } else {
                    alert("Error updating customer.");
                }
            } else {
                console.log("HTTP Error: " + xhr.status); // Debugging
            }
        }
    };

    xhr.send("customer_id=" + encodeURIComponent(customerId) + 
             "&name=" + encodeURIComponent(name) + 
             "&phone=" + encodeURIComponent(phone) + 
             "&address=" + encodeURIComponent(address));
}

        function deleteCustomer(customerId) {
    if (confirm("Are you sure you want to delete this customer?")) {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "DeleteCustomerServlet", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && xhr.status == 200) {
                var response = xhr.responseText.trim();
                if (response === "success") {
                    alert("Customer deleted successfully!");
                    location.reload(); // Refresh the page to update the table
                } else {
                    alert("Error deleting customer.");
                }
            }
        };

        xhr.send("customer_id=" + customerId);
    }
}

    </script>
</head>
<body>
    <h2>Manage Customer Details</h2>
    <a href="staff.jsp">Back to Staff Page</a>
    <table border="1">
        <tr>
            <th>Customer ID</th>
            <th>Name</th>
            <th>Phone</th>
            <th>Address</th>
            <th>Actions</th>
        </tr>
        
        <%
            Connection connection = dbconnection.getConnection();
            String query = "SELECT * FROM customers";
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("phone") %></td>
            <td><%= rs.getString("address") %></td>
            <td>
                <button onclick="showUpdatePopup('<%= rs.getInt("id") %>', '<%= rs.getString("name") %>', '<%= rs.getString("phone") %>', '<%= rs.getString("address") %>')">Update</button>
                <button onclick="deleteCustomer(<%= rs.getInt("id") %>)">Delete</button>
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
    <!-- Overlay -->
<div id="popupOverlay" onclick="closePopup()"></div>

<!-- Update Popup Box -->
<div id="updatePopup">
    <span class="close-btn" onclick="closePopup()">&times;</span>
    <h2>Update Customer</h2>
    <form id="updateForm">
        <input type="hidden" id="customer_id" name="customer_id"> <!-- Correct ID -->
        <label>Name:</label>
        <input type="text" id="update_name" name="name"><br>
        <label>Phone:</label>
        <input type="text" id="update_phone" name="phone"><br>
        <label>Address:</label>
        <input type="text" id="update_address" name="address"><br>
        <button type="button" onclick="updateCustomer()">Save</button>
        <button type="button" onclick="closePopup()">Cancel</button>
    </form>
</div>

</body>
</html>
