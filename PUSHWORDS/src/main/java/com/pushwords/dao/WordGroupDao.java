package com.pushwords.dao;


import com.pushwords.po.WordGroup;

import java.util.ArrayList;
import java.util.List;

public class WordGroupDao {

    public List<WordGroup> findGroupListByUserId(Integer userId){
        String sql = "select groupId,groupName,userId from tb_word_group where userId = ?";

        List<Object> params = new ArrayList<>();
        params.add(userId);

        List<WordGroup> list = BaseDao.queryRows(sql,params, WordGroup.class);

        return  list;
    }




}
