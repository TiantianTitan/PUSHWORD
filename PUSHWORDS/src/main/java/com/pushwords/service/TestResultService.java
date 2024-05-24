package com.pushwords.service;

import com.pushwords.dao.TestResultDao;
import com.pushwords.po.TestResult;
import java.util.List;

/**
 * TestResultService handles operations related to test results.
 */
public class TestResultService {
    private final TestResultDao testResultDao = new TestResultDao();

    /**
     * Finds test results for a given user ID.
     *
     * @param userId the ID of the user whose test results are to be found
     * @return a list of TestResult objects corresponding to the user ID
     */
    public List<TestResult> findTestResultsByUserId(int userId) {
        return testResultDao.findTestResultsByUserId(userId);
    }
}
