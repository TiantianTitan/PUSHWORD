package com.pushwords.dao;


import com.pushwords.po.WordGroup;

import java.util.ArrayList;
import java.util.List;

public class WordGroupDao {

    public List<WordGroup> findGroupListByUserId(Integer userId){
        String sql = "select * from tb_group where groupUserId = ?";

        List<Object> params = new ArrayList<>();
        params.add(userId);

        return (List<WordGroup>) BaseDao.queryRows(sql,params, WordGroup.class);
    }




}
