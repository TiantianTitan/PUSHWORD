package com.pushwords.dao;

import com.pushwords.util.DBUtil;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.List;

/**
 * BaseDao provides basic database operations including update, delete, find single value, and query rows.
 */
public class BaseDao {

    /**
     * Executes an update, delete, or insert operation on the database.
     *
     * @param sql the SQL query to be executed
     * @param params the list of parameters for the SQL query
     * @return the number of rows affected by the query
     */
    public static int executeUpdate(String sql, List<Object> params) {
        int row = 0;
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DBUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);

            if (!params.isEmpty()) {
                for (int i = 0; i < params.size(); i++) {
                    preparedStatement.setObject(i + 1, params.get(i));
                }
            }
            row = preparedStatement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(null, preparedStatement, connection);
        }
        return row;
    }

    /**
     * Finds a single value from the database.
     *
     * @param sql the SQL query to be executed
     * @param params the list of parameters for the SQL query
     * @return the single value found from the query
     */
    public static Object findSingleValue(String sql, List<Object> params) {
        Object object = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DBUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            if (!params.isEmpty()) {
                for (int i = 0; i < params.size(); i++) {
                    preparedStatement.setObject(i + 1, params.get(i));
                }
            }
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                object = resultSet.getObject(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(resultSet, preparedStatement, connection);
        }

        return object;
    }

    /**
     * Queries multiple rows from the database and maps them to a list of objects of the specified class.
     *
     * @param sql the SQL query to be executed
     * @param params the list of parameters for the SQL query
     * @param cls the class of the objects to be mapped
     * @return a list of objects mapped from the query results
     */
    public static List queryRows(String sql, List<Object> params, Class<?> cls) {
        List<Object> list = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DBUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);

            if (!params.isEmpty()) {
                for (int i = 0; i < params.size(); i++) {
                    preparedStatement.setObject(i + 1, params.get(i));
                }
            }
            resultSet = preparedStatement.executeQuery();

            ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
            int fieldNum = resultSetMetaData.getColumnCount();
            while (resultSet.next()) {
                Object object = cls.newInstance();
                for (int i = 1; i <= fieldNum; i++) {
                    String columnName = resultSetMetaData.getColumnLabel(i);
                    Field field = cls.getDeclaredField(columnName);

                    String setMethod = "set" + columnName.substring(0, 1).toUpperCase() + columnName.substring(1);
                    Method method = cls.getDeclaredMethod(setMethod, field.getType());

                    Object value = resultSet.getObject(columnName);
                    method.invoke(object, value);
                }
                list.add(object);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(resultSet, preparedStatement, connection);
        }

        return list;
    }

    /**
     * Queries a single row from the database and maps it to an object of the specified class.
     *
     * @param sql the SQL query to be executed
     * @param params the list of parameters for the SQL query
     * @param cls the class of the object to be mapped
     * @return the object mapped from the query result
     */
    public static Object queryRow(String sql, List<Object> params, Class<?> cls) {
        List<Object> list = queryRows(sql, params, cls);
        if (!list.isEmpty()) {
            return list.get(0);
        }
        return null;
    }
}
