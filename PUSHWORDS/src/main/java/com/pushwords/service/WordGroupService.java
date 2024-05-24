package com.pushwords.service;

import cn.hutool.core.util.StrUtil;
import com.pushwords.dao.WordGroupDao;
import com.pushwords.po.WordGroup;
import com.pushwords.vo.ResultInfo;

import java.util.List;

/**
 * WordGroupService handles operations related to word groups.
 */
public class WordGroupService {

    private final WordGroupDao groupDao = new WordGroupDao();

    /**
     * Finds the list of word groups for a given user ID.
     *
     * @param userId the ID of the user whose word groups are to be found
     * @return a list of WordGroup objects corresponding to the user ID
     */
    public List<WordGroup> findGroupList(Integer userId) {
        return groupDao.findGroupListByUserId(userId);
    }

    /**
     * Deletes a word group by its ID.
     *
     * @param groupId the ID of the group to be deleted
     * @return a ResultInfo object containing the result of the delete operation
     */
    public ResultInfo<WordGroup> deleteGroup(String groupId) {
        ResultInfo<WordGroup> resultInfo = new ResultInfo<>();

        // Validate input parameter
        if (StrUtil.isBlank(groupId)) {
            resultInfo.setCode(0);
            resultInfo.setMsg("System error, try again");
            return resultInfo;
        }

        // Perform delete operation
        int row = groupDao.deleteGroupById(groupId);
        if (row > 0) {
            resultInfo.setCode(1);
        } else {
            resultInfo.setCode(0);
            resultInfo.setMsg("Delete group failed!");
        }

        return resultInfo;
    }

    /**
     * Adds or updates a word group.
     *
     * @param groupName        the name of the group
     * @param userId           the ID of the user
     * @param groupId          the ID of the group to be updated, or null for a new group
     * @param groupDescription the description of the group
     * @return a ResultInfo object containing the result of the add or update operation
     */
    public ResultInfo<Integer> addOrUpdateGroup(String groupName, Integer userId, String groupId, String groupDescription) {
        ResultInfo<Integer> resultInfo = new ResultInfo<>();

        // Validate input parameter
        if (StrUtil.isBlank(groupName)) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Name could not be empty");
            return resultInfo;
        }

        // Check if the group name already exists
        Integer code = groupDao.checkGroupName(groupName, userId, groupId, groupDescription);
        if (code == 0) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Group exists");
            return resultInfo;
        }

        // Add or update group
        Integer key = null;
        if (StrUtil.isBlank(groupId)) {
            // Add new group
            key = groupDao.addGroup(groupName, userId, groupDescription);
        } else {
            // Update existing group
            key = groupDao.updateGroup(groupName, groupId, groupDescription);
        }

        // Set the result information based on the database operation result
        if (key > 0) {
            resultInfo.setCode(1);
            resultInfo.setResult(key);
        } else {
            resultInfo.setCode(0);
            resultInfo.setMsg("Update error");
        }
        return resultInfo;
    }
}
