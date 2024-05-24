package com.pushwords.po;

import lombok.Getter;
import lombok.Setter;

/**
 * User represents a user in the system.
 */
@Getter
@Setter
public class User {

    private Integer userId;
    private String uname;
    private String upwd;
    private String nick;
    private String head;
    private String mood;

    /**
     * Gets the user ID.
     *
     * @return the user ID
     */
    public Integer getUserId() {
        return userId;
    }

    /**
     * Sets the user ID.
     *
     * @param userId the user ID
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /**
     * Gets the username.
     *
     * @return the username
     */
    public String getUname() {
        return uname;
    }

    /**
     * Sets the username.
     *
     * @param uname the username
     */
    public void setUname(String uname) {
        this.uname = uname;
    }

    /**
     * Gets the user password.
     *
     * @return the user password
     */
    public String getUpwd() {
        return upwd;
    }

    /**
     * Sets the user password.
     *
     * @param upwd the user password
     */
    public void setUpwd(String upwd) {
        this.upwd = upwd;
    }

    /**
     * Gets the user nickname.
     *
     * @return the user nickname
     */
    public String getNick() {
        return nick;
    }

    /**
     * Sets the user nickname.
     *
     * @param nick the user nickname
     */
    public void setNick(String nick) {
        this.nick = nick;
    }

    /**
     * Gets the user head.
     *
     * @return the user head
     */
    public String getHead() {
        return head;
    }

    /**
     * Sets the user head.
     *
     * @param head the user head
     */
    public void setHead(String head) {
        this.head = head;
    }

    /**
     * Gets the user mood.
     *
     * @return the user mood
     */
    public String getMood() {
        return mood;
    }

    /**
     * Sets the user mood.
     *
     * @param mood the user mood
     */
    public void setMood(String mood) {
        this.mood = mood;
    }
}
