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

@WebServlet("/DeleteCustomerServlet")
public class DeleteCustomerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customer_id"));

        try (Connection connection = dbconnection.getConnection()) {
            String query = "DELETE FROM customers WHERE id = ?";
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, customerId);

            int result = pstmt.executeUpdate();
            response.getWriter().write(result > 0 ? "success" : "error");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("error");
        }
    }
}
