package com.pushwords.dao;


import com.mysql.cj.protocol.Resultset;
import com.pushwords.po.WordGroup;
import com.pushwords.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class WordGroupDao {

    public List<WordGroup> findGroupListByUserId(Integer userId){
        String sql = "select * from tb_group where groupUserId = ?";

        List<Object> params = new ArrayList<>();
        params.add(userId);

        return (List<WordGroup>) BaseDao.queryRows(sql,params, WordGroup.class);
    }

    public long findWordCountByGroupId(String groupId) {
        String sql = "select count(1) from tb_word where groupId = ?";
        List<Object> params = new ArrayList<>();
        params.add(groupId);
        return (long) BaseDao.findSingleValue(sql,params);

    }

    public int deleteGroupById(String groupId) {
        String sql = "delete from tb_group where groupId = ?";
        List<Object> params = new ArrayList<>();
        params.add(groupId);
        return  BaseDao.executeUpdate(sql,params);
    }

    /**
     *  Return 1 success, return 0 fail
     * @param groupName
     * @param userId
     * @param groupId
     * @param groupDescription
     * @return
     */
    public Integer checkGroupName(String groupName, Integer userId, String groupId, String groupDescription) {
        String sql = "select * from tb_group where groupUserId = ? and groupName = ?";
        List<Object> params = new ArrayList<>();
        params.add(userId);
        params.add(groupName);
        WordGroup wordGroup = (WordGroup) BaseDao.queryRow(sql, params, WordGroup.class);
        if (wordGroup == null) {
            return 1;
        } else {
            if (groupId.equals(wordGroup.getGroupId().toString())) {
                return 1;
            }

        }
        return 0;
    }

    public Integer addGroup(String groupName, Integer userId, String groupDescription) {
        Integer key = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet generatedKeys = null;

        try {
            connection = DBUtil.getConnection();

            // INSERT without manually assigning groupId since it should be auto-increment
            String sql = "INSERT INTO tb_group (groupName, groupDescription, groupUserId) VALUES (?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, groupName);
            preparedStatement.setString(2, groupDescription);
            preparedStatement.setInt(3, userId);

            // Execute the INSERT operation
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                // Retrieve the generated key
                generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    key = generatedKeys.getInt(1); // Fetch the auto-generated key
                } else {
                    System.out.println("No generated keys returned.");
                }
            } else {
                System.out.println("No rows affected by the insert operation.");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log any SQL exceptions that occur
        } finally {
            DBUtil.close(generatedKeys, preparedStatement, connection); // Close resources
        }
        return key;
    }


    public Integer updateGroup(String groupName, String groupId, String groupDescription) {
        String sql = "update tb_group set groupName=? , groupDescription = ? where groupId = ?";
        List<Object> params = new ArrayList<>();
        params.add(groupName);
        params.add(groupDescription);
        params.add(groupId);

        return BaseDao.executeUpdate(sql,params);
    }
}
