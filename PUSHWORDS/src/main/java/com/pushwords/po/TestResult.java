package com.pushwords.po;

import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;


@Setter
@Getter
public class TestResult {
    private int resultId;
    private int userId;
    private int groupId;
    private int totalWords;
    private int correctAnswers;
    private float accuracy;
    private int timeTaken;
    private Timestamp testDate;

    // Getters and setters...
}
