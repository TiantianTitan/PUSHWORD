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

    public long findWordCountByGroupId(String groupId) {
        String sql = "select count(1) from tb_word where groupId = ?";
        List<Object> params = new ArrayList<>();
        params.add(groupId);
        return (long) BaseDao.findSingleValue(sql,params);

    }

    public int deleteGroupById(String groupId) {
        String sql = "delete from tb_group where groupId = ?";
        List<Object> params = new ArrayList<>();
        params.add(groupId);
        return  BaseDao.executeUpdate(sql,params);
    }
}
