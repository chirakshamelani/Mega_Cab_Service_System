package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dataBase.dbconnection;

@WebServlet("/UpdateDriverServlet")
public class UpdateDriverServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int driverId = Integer.parseInt(request.getParameter("driver_id"));
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String vehicleNumber = request.getParameter("vehicle_number");

        try (Connection connection = dbconnection.getConnection()) {
            String query = "UPDATE drivers SET name = ?, phone = ?, vehicle_number = ? WHERE driver_id = ?";
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, name);
            pstmt.setString(2, phone);
            pstmt.setString(3, vehicleNumber);
            pstmt.setInt(4, driverId);

            int result = pstmt.executeUpdate();
            
            if (result > 0) {
                response.sendRedirect("manageDriverDetails.jsp?success=Driver updated successfully");
            } else {
                response.sendRedirect("manageDriverDetails.jsp?error=Failed to update driver");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("manageDriverDetails.jsp?error=Database error occurred");
        }
    }
}
