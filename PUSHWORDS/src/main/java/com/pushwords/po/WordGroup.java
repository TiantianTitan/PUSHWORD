package com.pushwords.po;

import lombok.Getter;
import lombok.Setter;

/**
 * WordGroup represents a group of words in the system.
 */
@Setter
@Getter
public class WordGroup {

    private Integer groupId;
    private String groupName;
    private String groupDescription;
    private Integer groupUserId;

    /**
     * Gets the group ID.
     *
     * @return the group ID
     */
    public Integer getGroupId() {
        return groupId;
    }

    /**
     * Sets the group ID.
     *
     * @param groupId the group ID
     */
    public void setGroupId(Integer groupId) {
        this.groupId = groupId;
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
     * Gets the description of the group.
     *
     * @return the description of the group
     */
    public String getGroupDescription() {
        return groupDescription;
    }

    /**
     * Sets the description of the group.
     *
     * @param groupDescription the description of the group
     */
    public void setGroupDescription(String groupDescription) {
        this.groupDescription = groupDescription;
    }

    /**
     * Gets the user ID associated with the group.
     *
     * @return the user ID associated with the group
     */
    public Integer getGroupUserId() {
        return groupUserId;
    }

    /**
     * Sets the user ID associated with the group.
     *
     * @param groupUserId the user ID associated with the group
     */
    public void setGroupUserId(Integer groupUserId) {
        this.groupUserId = groupUserId;
    }
}
