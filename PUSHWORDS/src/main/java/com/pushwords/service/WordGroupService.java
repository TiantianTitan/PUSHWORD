package com.pushwords.service;

import cn.hutool.core.util.StrUtil;
import com.pushwords.dao.WordGroupDao;
import com.pushwords.dao.TestResultDao;
import com.pushwords.po.WordGroup;
import com.pushwords.vo.ResultInfo;

import java.util.List;

public class WordGroupService {

    private final WordGroupDao groupDao = new WordGroupDao();
    private final TestResultDao testResultDao = new TestResultDao();

    public List<WordGroup> findGroupList(Integer userId){
        return groupDao.findGroupListByUserId(userId);
    }

    public ResultInfo<WordGroup> deleteGroup(String groupId) {
        ResultInfo<WordGroup> resultInfo = new ResultInfo<>();

        if (StrUtil.isBlank(groupId)) {
            resultInfo.setCode(0);
            resultInfo.setMsg("System error, try again");
            return resultInfo;
        }

        // Delete related results first
        int resultRow = testResultDao.deleteResultsByGroupId(groupId);
        if (resultRow < 0) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Failed to delete related results");
            return resultInfo;
        }

        // Delete the group
        int row = groupDao.deleteGroupById(groupId);
        if (row > 0) {
            resultInfo.setCode(1);
        } else {
            resultInfo.setCode(0);
            resultInfo.setMsg("Delete group failed!");
        }

        return resultInfo;
    }

    public ResultInfo<Integer> addOrUpdateGroup(String groupName, Integer userId, String groupId, String groupDescription) {
        ResultInfo<Integer> resultInfo = new ResultInfo<>();
        if (StrUtil.isBlank(groupName)) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Name could not be empty");
            return resultInfo;
        }

        Integer code = groupDao.checkGroupName(groupName, userId, groupId, groupDescription);
        if (code == 0) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Group exists");
            return resultInfo;
        }

        Integer key = null;
        if (StrUtil.isBlank(groupId)) {
            // add
            key = groupDao.addGroup(groupName, userId, groupDescription);
        } else {
            // modify
            key = groupDao.updateGroup(groupName, groupId, groupDescription);
        }

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
