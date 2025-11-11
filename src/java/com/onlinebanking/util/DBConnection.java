package com.onlinebanking.util;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    // This method returns a Connection object to the database
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to the database
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3307/online_banking", // database URL
                "root",    // MySQL username
                ""     // MySQL password
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn; // Return the Connection object
    }
}
