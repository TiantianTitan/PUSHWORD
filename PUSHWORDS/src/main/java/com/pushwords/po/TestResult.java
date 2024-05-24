package com.pushwords.po;

import java.sql.Timestamp;

public class TestResult {
    // 现有字段
    private int resultId;
    private int userId;
    private int groupId;
    private int totalWords;
    private int correctAnswers;
    private float accuracy;
    private int timeTaken;
    private Timestamp testDate;
    private String groupName;  // Add this field to match the join result

    // 新增字段，用于存储原始时间字符串
    private String originalTestDate;

    // Getters and setters for all fields
    public int getResultId() {
        return resultId;
    }

    public void setResultId(int resultId) {
        this.resultId = resultId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public int getTotalWords() {
        return totalWords;
    }

    public void setTotalWords(int totalWords) {
        this.totalWords = totalWords;
    }

    public int getCorrectAnswers() {
        return correctAnswers;
    }

    public void setCorrectAnswers(int correctAnswers) {
        this.correctAnswers = correctAnswers;
    }

    public float getAccuracy() {
        return accuracy;
    }

    public void setAccuracy(float accuracy) {
        this.accuracy = accuracy;
    }

    public int getTimeTaken() {
        return timeTaken;
    }

    public void setTimeTaken(int timeTaken) {
        this.timeTaken = timeTaken;
    }

    public Timestamp getTestDate() {
        return testDate;
    }

    public void setTestDate(Timestamp testDate) {
        this.testDate = testDate;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    // 新增 getter 和 setter 方法
    public String getOriginalTestDate() {
        return originalTestDate;
    }

    public void setOriginalTestDate(String originalTestDate) {
        this.originalTestDate = originalTestDate;
    }

    @Override
    public String toString() {
        return "TestResult{" +
                "resultId=" + resultId +
                ", userId=" + userId +
                ", groupId=" + groupId +
                ", totalWords=" + totalWords +
                ", correctAnswers=" + correctAnswers +
                ", accuracy=" + accuracy +
                ", timeTaken=" + timeTaken +
                ", testDate=" + testDate +
                ", groupName='" + groupName + '\'' +
                ", originalTestDate='" + originalTestDate + '\'' +
                '}';
    }
}
