package com.pushwords.service;

import cn.hutool.core.util.StrUtil;
import com.pushwords.dao.WordGroupDao;
import com.pushwords.po.WordGroup;
import com.pushwords.vo.ResultInfo;

import java.util.List;

public class WordGroupService {

    private final WordGroupDao groupDao = new WordGroupDao();

    public List<WordGroup> findGroupList(Integer userId){
        return groupDao.findGroupListByUserId(userId);
    }


    public ResultInfo<WordGroup> deleteGroup(String groupId) {

        ResultInfo<WordGroup> resultInfo = new ResultInfo<>();

        if(StrUtil.isBlank(groupId)){
            resultInfo.setCode(0);
            resultInfo.setMsg("System error, try again");
            return resultInfo;
        }

//        long wordCount = groupDao.findWordCountByGroupId(groupId);
//        if(wordCount > 0){
//            resultInfo.setCode(0);
//            resultInfo.setMsg("words exist, couldn't delete");
//            return  resultInfo;
//        }

        int row = groupDao.deleteGroupById(groupId);

        if(row >0){
            resultInfo.setCode(1);
        }else{
            resultInfo.setCode(0);
            resultInfo.setMsg("delete group fail!");
        }

        return resultInfo;

    }
}
