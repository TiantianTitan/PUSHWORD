package com.pushwords.po;

import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;

@Getter
@Setter
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

    // Getters and setters for all fields

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
                '}';
    }
}
