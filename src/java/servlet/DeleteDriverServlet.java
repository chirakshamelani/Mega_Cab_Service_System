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

@WebServlet("/DeleteDriverServlet")
public class DeleteDriverServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int driverId = Integer.parseInt(request.getParameter("driver_id"));

        try (Connection connection = dbconnection.getConnection()) {
            String query = "DELETE FROM drivers WHERE driver_id = ?";
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, driverId);

            int result = pstmt.executeUpdate();
            
            if (result > 0) {
                response.sendRedirect("manageDriverDetails.jsp?success=Driver deleted successfully");
            } else {
                response.sendRedirect("manageDriverDetails.jsp?error=Failed to delete driver");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("manageDriverDetails.jsp?error=Database error occurred");
        }
    }
}
