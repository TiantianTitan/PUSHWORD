package com.pushwords.dao;

import com.pushwords.po.TestResult;
import com.pushwords.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * TestResultDao handles database operations related to the TestResult entity.
 */
public class TestResultDao {

    /**
     * Saves a TestResult object to the database.
     *
     * @param testResult the TestResult object to be saved
     * @throws IllegalArgumentException if the groupId or userId does not exist in the referenced tables
     */
    public void saveTestResult(TestResult testResult) {
        if (!existsInTable("tb_group", "groupId", testResult.getGroupId()) ||
                !existsInTable("tb_user", "userId", testResult.getUserId())) {
            throw new IllegalArgumentException("Foreign key constraint violation: groupId or userId does not exist.");
        }

        String sql = "INSERT INTO tb_test_result (userId, groupId, totalWords, correctAnswers, accuracy, timeTaken, testDate) VALUES (?, ?, ?, ?, ?, ?, NOW())";
        List<Object> params = new ArrayList<>();
        params.add(testResult.getUserId());
        params.add(testResult.getGroupId());
        params.add(testResult.getTotalWords());
        params.add(testResult.getCorrectAnswers());
        params.add(testResult.getAccuracy());
        params.add(testResult.getTimeTaken());
        BaseDao.executeUpdate(sql, params);
    }

    /**
     * Checks if a value exists in a specified table and column.
     *
     * @param tableName the name of the table to check
     * @param columnName the name of the column to check
     * @param value the value to check for existence
     * @return true if the value exists, false otherwise
     */
    private boolean existsInTable(String tableName, String columnName, int value) {
        String sql = "SELECT 1 FROM " + tableName + " WHERE " + columnName + " = ?";
        List<Object> params = new ArrayList<>();
        params.add(value);
        Object result = BaseDao.findSingleValue(sql, params);
        return result != null;
    }

    /**
     * Finds test results by user ID.
     *
     * @param userId the ID of the user whose test results are to be found
     * @return a list of TestResult objects associated with the user ID
     */
    public List<TestResult> findTestResultsByUserId(int userId) {
        String sql = "SELECT tr.*, g.groupName FROM tb_test_result tr JOIN tb_group g ON tr.groupId = g.groupId WHERE tr.userId = ? ORDER BY tr.testDate DESC";
        List<Object> params = new ArrayList<>();
        params.add(userId);

        List<TestResult> results = (List<TestResult>) BaseDao.queryRows(sql, params, TestResult.class);

        // Format testDate
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for (TestResult result : results) {
            result.setOriginalTestDate(sdf.format(result.getTestDate()));
        }

        return results;
    }

    /**
     * Deletes test results by group ID.
     *
     * @param groupId the ID of the group whose test results are to be deleted
     * @return the number of rows affected by the delete operation
     */
    public int deleteResultsByGroupId(String groupId) {
        String sql = "DELETE FROM tb_test_result WHERE groupId = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, groupId);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return -1; // Indicate failure
        }
    }
}
