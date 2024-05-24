package com.pushwords.util;

import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

/**
 * DBUtil provides utility methods for managing database connections and resources.
 */
public class DBUtil {

    private static final Properties properties = new Properties();

    static {
        // Load properties from the configuration file
        try (InputStream in = DBUtil.class.getClassLoader().getResourceAsStream("db.properties")) {
            properties.load(in);
            Class.forName(properties.getProperty("jdbcName"));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Gets a connection to the database.
     *
     * @return a Connection object to the database
     */
    public static Connection getConnection() {
        Connection connection = null;

        // Retrieve database connection information from properties
        try {
            String dbUrl = properties.getProperty("dbUrl");
            String dbName = properties.getProperty("dbName");
            String dbPwd = properties.getProperty("dbPwd");
            connection = DriverManager.getConnection(dbUrl, dbName, dbPwd);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }

    /**
     * Closes the provided database resources.
     *
     * @param resultSet the ResultSet to be closed
     * @param preparedStatement the PreparedStatement to be closed
     * @param connection the Connection to be closed
     */
    public static void close(ResultSet resultSet,
                             PreparedStatement preparedStatement,
                             Connection connection) {
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
