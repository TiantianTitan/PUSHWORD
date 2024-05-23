package com.pushwords.dao;

import com.pushwords.po.TestResult;
import com.pushwords.util.DBUtil;
import java.util.ArrayList;
import java.util.List;

public class TestResultDao {

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

    private boolean existsInTable(String tableName, String columnName, int value) {
        String sql = "SELECT 1 FROM " + tableName + " WHERE " + columnName + " = ?";
        List<Object> params = new ArrayList<>();
        params.add(value);
        Object result = BaseDao.findSingleValue(sql, params);
        return result != null;
    }

    public List<TestResult> findTestResultsByUserId(int userId) {
        String sql = "SELECT tr.*, g.groupName FROM tb_test_result tr JOIN tb_group g ON tr.groupId = g.groupId WHERE tr.userId = ? ORDER BY tr.testDate DESC";
        List<Object> params = new ArrayList<>();
        params.add(userId);

        // Debug output
        System.out.println("Executing SQL: " + sql);
        System.out.println("With userId: " + userId);

        List<TestResult> results = (List<TestResult>) BaseDao.queryRows(sql, params, TestResult.class);
        return results;
    }
}
