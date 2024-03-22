package com.pushwords.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

public class DBUtil {


    private  static Properties properties = new Properties();
    static {
        // load properties
        InputStream in = DBUtil.class.getClassLoader().getResourceAsStream("db.properties");
        try {
            properties.load(in);
            Class.forName(properties.getProperty("jdbcName"));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {
        Connection connection = null;

        // get infos from database
            String dbUrl = properties.getProperty("dbUrl");
            String dbName = properties.getProperty("dbName");
            String dbPwd = properties.getProperty("dbPwd");

        try {
            connection = DriverManager.getConnection(dbUrl,dbName,dbPwd);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return  connection;
    }

    public static  void close(ResultSet resultSet,
                              PreparedStatement preparedStatement,
                              Connection connection) throws SQLException {

        if(resultSet != null){
            resultSet.close();
        }

        if(resultSet != null){
            preparedStatement.close();
        }

        if(resultSet != null){
            connection.close();
        }

    }

}
