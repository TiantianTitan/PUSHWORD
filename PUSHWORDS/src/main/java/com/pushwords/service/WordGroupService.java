package com.pushwords.service;

import com.pushwords.dao.WordGroupDao;
import com.pushwords.po.WordGroup;

import java.util.List;

public class WordGroupService {

    private final WordGroupDao groupDao = new WordGroupDao();

    public List<WordGroup> findGroupList(Integer userId){
        return groupDao.findGroupListByUserId(userId);
    }



}
