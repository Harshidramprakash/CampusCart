package com.campuscart.dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Database connection utility.
 * Reads credentials from db.properties on the classpath so that
 * passwords are never hard-coded in Java source files.
 *
 * Demonstrates: Experiment 5 — JDBC Database Connectivity.
 */
public class DBConnection {

    private static String URL;
    private static String USER;
    private static String PASSWORD;

    static {
        try {
            String driver = "com.mysql.cj.jdbc.Driver";
            Properties props = new Properties();
            
            try (InputStream in = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
                if (in != null) {
                    props.load(in);
                    if (props.getProperty("db.driver") != null) {
                        driver = props.getProperty("db.driver");
                    }
                }
            }

            URL = System.getenv("DB_URL") != null ? System.getenv("DB_URL") : props.getProperty("db.url");
            USER = System.getenv("DB_USERNAME") != null ? System.getenv("DB_USERNAME") : props.getProperty("db.username");
            PASSWORD = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : props.getProperty("db.password");

            Class.forName(driver);
        } catch (Exception e) {
            throw new RuntimeException("Failed to load database configuration", e);
        }
    }

    /**
     * Returns a new JDBC connection.
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    /**
     * Quietly closes a connection (null-safe).
     */
    public static void close(Connection conn) {
        if (conn != null) {
            try { conn.close(); } catch (SQLException ignored) {}
        }
    }
}
