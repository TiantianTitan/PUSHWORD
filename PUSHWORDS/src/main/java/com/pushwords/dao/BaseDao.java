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

public class BaseDao {

    // Update add/delete/modify
    public static  int executeUpdate(String sql, List<Object> params){
        int row = 0;
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DBUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);

            if(!params.isEmpty()){
                for(int i = 0; i < params.size(); i++ ){
                    preparedStatement.setObject(i+1,params.get(i));
                }
            }
            row = preparedStatement.executeUpdate();

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DBUtil.close(null,preparedStatement,connection);
        }
        return  row;
    }

    public static Object findSingleValue(String sql,List<Object> params){
        Object object = null;
        Connection  connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DBUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            if(!params.isEmpty()){
                for(int i = 0; i < params.size(); i++ ){
                    preparedStatement.setObject(i+1,params.get(i));
                }
            }
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                object = resultSet.getObject(1);
            }


        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DBUtil.close(resultSet,preparedStatement,connection);
        }


        return  object;
    }

    public static List queryRows(String sql,List<Object> params,Class cls){
        List list = new ArrayList();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DBUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);

            if(!params.isEmpty()){
                for(int i = 0; i < params.size(); i++ ){
                    preparedStatement.setObject(i+1,params.get(i));
                }
            }
            resultSet = preparedStatement.executeQuery();

            ResultSetMetaData resultSetMetaData = resultSet.getMetaData();

            int fieldNum = resultSetMetaData.getColumnCount();
            while(resultSet.next()){
                Object object = cls.newInstance();
                for(int i = 1; i <= fieldNum; i++){
                    String columnName = resultSetMetaData.getColumnLabel(i);

                    Field field = cls.getDeclaredField(columnName);

                    String setMethod = "set" + columnName.substring(0,1).toUpperCase() + columnName.substring(1);

                    Method method = cls.getDeclaredMethod(setMethod,field.getType());

                    Object value = resultSet.getObject(columnName);

                    method.invoke(object,value);
                }
                list.add(object);
            }

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DBUtil.close(resultSet,preparedStatement,connection);
        }

        return  list;
    }

    public static Object queryRow(String sql,List<Object> params,Class cls){
        List list = queryRows(sql,params,cls);
        Object object = null;
        if(!list.isEmpty()){
            object = list.get(0);
        }
        return  object;
    }


}
