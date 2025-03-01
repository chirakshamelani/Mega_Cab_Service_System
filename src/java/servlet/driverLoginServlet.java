package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.mindrot.jbcrypt.BCrypt; // Import BCrypt for password hashing
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dataBase.dbconnection;

@WebServlet("/driverLoginServlet")
public class driverLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = dbconnection.getConnection();
            if (conn != null) {
                System.out.println("Database connection successful.");
            } else {
                System.out.println("Database connection failed.");
            }

            stmt = conn.prepareStatement("SELECT driver_id, password FROM drivers WHERE username = ?");
            stmt.setString(1, username);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String storedPasswordHash = rs.getString("password"); // Get the hashed password from the database

                // Verify the entered password with the stored hash using BCrypt
                if (BCrypt.checkpw(password, storedPasswordHash)) {
                    // Login successful - Store driver ID in session
                    int driverId = rs.getInt("driver_id");
                    HttpSession session = request.getSession();
                    session.setAttribute("driver_id", driverId);
                    session.setAttribute("driver_username", username);

                    // Redirect to driver dashboard
                    response.sendRedirect("driverdashboard.jsp");
                } else {
                    // Login failed - Incorrect password
                    response.sendRedirect("driverlogin.jsp?error=Incorrect username or password.");
                }
            } else {
                // Login failed - No such user
                response.sendRedirect("driverlogin.jsp?error=Incorrect username or password.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("driverlogin.jsp?error=" + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
