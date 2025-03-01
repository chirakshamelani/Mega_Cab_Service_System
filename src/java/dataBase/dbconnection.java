/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dataBase;
import java.sql.*;

/**
 *
 * @author rajah
 */
public class dbconnection {
  private static final String URL = "jdbc:mysql://localhost:3306/icbt";
    private static final String USER = "root"; 
    private static final String PASSWORD = ""; 

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Database driver not found!", e);
        }
    }
    
}
