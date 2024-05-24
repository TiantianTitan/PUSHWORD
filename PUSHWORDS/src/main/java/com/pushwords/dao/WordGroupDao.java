package com.pushwords.dao;

import com.pushwords.po.WordGroup;
import com.pushwords.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * WordGroupDao handles database operations related to the WordGroup entity.
 */
public class WordGroupDao {

    /**
     * Finds a list of word groups by user ID.
     *
     * @param userId the ID of the user whose word groups are to be found
     * @return a list of WordGroup objects corresponding to the user ID
     */
    public List<WordGroup> findGroupListByUserId(Integer userId) {
        String sql = "select * from tb_group where groupUserId = ?";

        List<Object> params = new ArrayList<>();
        params.add(userId);

        return (List<WordGroup>) BaseDao.queryRows(sql, params, WordGroup.class);
    }

    /**
     * Finds the count of words in a specific group by group ID.
     *
     * @param groupId the ID of the group
     * @return the count of words in the specified group
     */
    public long findWordCountByGroupId(String groupId) {
        String sql = "select count(1) from tb_word where groupId = ?";
        List<Object> params = new ArrayList<>();
        params.add(groupId);
        return (long) BaseDao.findSingleValue(sql, params);
    }

    /**
     * Deletes a word group from the database by its ID.
     *
     * @param groupId the ID of the group to be deleted
     * @return the number of rows affected by the delete operation
     */
    public int deleteGroupById(String groupId) {
        String sql = "delete from tb_group where groupId = ?";
        List<Object> params = new ArrayList<>();
        params.add(groupId);
        return BaseDao.executeUpdate(sql, params);
    }

    /**
     * Checks if a group name already exists for a user.
     * Returns 1 if the group name is unique or matches the current group, otherwise returns 0.
     *
     * @param groupName the name of the group
     * @param userId the ID of the user
     * @param groupId the ID of the group to be checked
     * @param groupDescription the description of the group
     * @return 1 if the group name is unique or matches the current group, otherwise 0
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

    /**
     * Adds a new word group to the database.
     *
     * @param groupName the name of the group
     * @param userId the ID of the user
     * @param groupDescription the description of the group
     * @return the generated key for the new group, or null if the operation failed
     */
    public Integer addGroup(String groupName, Integer userId, String groupDescription) {
        Integer key = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet generatedKeys = null;

        try {
            connection = DBUtil.getConnection();

            String sql = "INSERT INTO tb_group (groupName, groupDescription, groupUserId) VALUES (?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, groupName);
            preparedStatement.setString(2, groupDescription);
            preparedStatement.setInt(3, userId);

            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    key = generatedKeys.getInt(1);
                } else {
                    System.out.println("No generated keys returned.");
                }
            } else {
                System.out.println("No rows affected by the insert operation.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(generatedKeys, preparedStatement, connection);
        }
        return key;
    }

    /**
     * Updates an existing word group in the database.
     *
     * @param groupName the name of the group
     * @param groupId the ID of the group
     * @param groupDescription the description of the group
     * @return the number of rows affected by the update
     */
    public Integer updateGroup(String groupName, String groupId, String groupDescription) {
        String sql = "update tb_group set groupName = ?, groupDescription = ? where groupId = ?";
        List<Object> params = new ArrayList<>();
        params.add(groupName);
        params.add(groupDescription);
        params.add(groupId);

        return BaseDao.executeUpdate(sql, params);
    }
}
