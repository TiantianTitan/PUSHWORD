package com.pushwords.po;

import java.sql.Timestamp;

/**
 * TestResult represents the result of a test taken by a user.
 */
public class TestResult {
    private int resultId;
    private int userId;
    private int groupId;
    private int totalWords;
    private int correctAnswers;
    private float accuracy;
    private int timeTaken;
    private Timestamp testDate;
    private String groupName;  // Add this field to match the join result
    private String originalTestDate;  // Field to store the original date string

    /**
     * Gets the result ID.
     *
     * @return the result ID
     */
    public int getResultId() {
        return resultId;
    }

    /**
     * Sets the result ID.
     *
     * @param resultId the result ID
     */
    public void setResultId(int resultId) {
        this.resultId = resultId;
    }

    /**
     * Gets the user ID.
     *
     * @return the user ID
     */
    public int getUserId() {
        return userId;
    }

    /**
     * Sets the user ID.
     *
     * @param userId the user ID
     */
    public void setUserId(int userId) {
        this.userId = userId;
    }

    /**
     * Gets the group ID.
     *
     * @return the group ID
     */
    public int getGroupId() {
        return groupId;
    }

    /**
     * Sets the group ID.
     *
     * @param groupId the group ID
     */
    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    /**
     * Gets the total number of words.
     *
     * @return the total number of words
     */
    public int getTotalWords() {
        return totalWords;
    }

    /**
     * Sets the total number of words.
     *
     * @param totalWords the total number of words
     */
    public void setTotalWords(int totalWords) {
        this.totalWords = totalWords;
    }

    /**
     * Gets the number of correct answers.
     *
     * @return the number of correct answers
     */
    public int getCorrectAnswers() {
        return correctAnswers;
    }

    /**
     * Sets the number of correct answers.
     *
     * @param correctAnswers the number of correct answers
     */
    public void setCorrectAnswers(int correctAnswers) {
        this.correctAnswers = correctAnswers;
    }

    /**
     * Gets the accuracy percentage.
     *
     * @return the accuracy percentage
     */
    public float getAccuracy() {
        return accuracy;
    }

    /**
     * Sets the accuracy percentage.
     *
     * @param accuracy the accuracy percentage
     */
    public void setAccuracy(float accuracy) {
        this.accuracy = accuracy;
    }

    /**
     * Gets the time taken for the test.
     *
     * @return the time taken for the test
     */
    public int getTimeTaken() {
        return timeTaken;
    }

    /**
     * Sets the time taken for the test.
     *
     * @param timeTaken the time taken for the test
     */
    public void setTimeTaken(int timeTaken) {
        this.timeTaken = timeTaken;
    }

    /**
     * Gets the date of the test.
     *
     * @return the date of the test
     */
    public Timestamp getTestDate() {
        return testDate;
    }

    /**
     * Sets the date of the test.
     *
     * @param testDate the date of the test
     */
    public void setTestDate(Timestamp testDate) {
        this.testDate = testDate;
    }

    /**
     * Gets the name of the group.
     *
     * @return the name of the group
     */
    public String getGroupName() {
        return groupName;
    }

    /**
     * Sets the name of the group.
     *
     * @param groupName the name of the group
     */
    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    /**
     * Gets the original test date as a string.
     *
     * @return the original test date as a string
     */
    public String getOriginalTestDate() {
        return originalTestDate;
    }

    /**
     * Sets the original test date as a string.
     *
     * @param originalTestDate the original test date as a string
     */
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
