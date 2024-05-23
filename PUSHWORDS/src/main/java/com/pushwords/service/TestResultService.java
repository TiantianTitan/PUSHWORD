package com.pushwords.service;

import com.pushwords.dao.TestResultDao;
import com.pushwords.po.TestResult;
import java.util.List;

public class TestResultService {
    private final TestResultDao testResultDao = new TestResultDao();

    public List<TestResult> findTestResultsByUserId(int userId) {
        return testResultDao.findTestResultsByUserId(userId);
    }


}
