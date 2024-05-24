package com.pushwords.po;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

/**
 * Word represents a word entity in the system.
 */
@Getter
@Setter
public class Word {

    private Integer wordId;
    private String title;
    private String content;
    private Integer groupId;
    private Date pubTime;

    /**
     * Gets the word ID.
     *
     * @return the word ID
     */
    public Integer getWordId() {
        return wordId;
    }

    /**
     * Sets the word ID.
     *
     * @param wordId the word ID
     */
    public void setWordId(Integer wordId) {
        this.wordId = wordId;
    }

    /**
     * Gets the title of the word.
     *
     * @return the title of the word
     */
    public String getTitle() {
        return title;
    }

    /**
     * Sets the title of the word.
     *
     * @param title the title of the word
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * Gets the content of the word.
     *
     * @return the content of the word
     */
    public String getContent() {
        return content;
    }

    /**
     * Sets the content of the word.
     *
     * @param content the content of the word
     */
    public void setContent(String content) {
        this.content = content;
    }

    /**
     * Gets the group ID associated with the word.
     *
     * @return the group ID
     */
    public Integer getGroupId() {
        return groupId;
    }

    /**
     * Sets the group ID associated with the word.
     *
     * @param groupId the group ID
     */
    public void setGroupId(Integer groupId) {
        this.groupId = groupId;
    }

    /**
     * Gets the publication time of the word.
     *
     * @return the publication time of the word
     */
    public Date getPubTime() {
        return pubTime;
    }

    /**
     * Sets the publication time of the word.
     *
     * @param pubTime the publication time of the word
     */
    public void setPubTime(Date pubTime) {
        this.pubTime = pubTime;
    }
}
