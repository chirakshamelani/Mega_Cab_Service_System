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

@WebServlet("/UpdateCustomerServlet")
public class UpdateCustomerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        
        int customerId;
        try {
            customerId = Integer.parseInt(request.getParameter("customer_id"));
        } catch (NumberFormatException e) {
            response.getWriter().write("error");
            return;
        }

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (name == null || phone == null || address == null || name.isEmpty() || phone.isEmpty() || address.isEmpty()) {
            response.getWriter().write("error");
            return;
        }

        try (Connection connection = dbconnection.getConnection()) {
            String query = "UPDATE customers SET name = ?, phone = ?, address = ? WHERE id = ?";
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, name);
            pstmt.setString(2, phone);
            pstmt.setString(3, address);
            pstmt.setInt(4, customerId);

            int result = pstmt.executeUpdate();
            response.getWriter().write(result > 0 ? "success" : "error");

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("error");
        }
    }
}
