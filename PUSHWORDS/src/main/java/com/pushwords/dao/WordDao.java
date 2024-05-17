package com.pushwords.dao;

import com.pushwords.po.Word;

import java.util.ArrayList;
import java.util.List;

public class WordDao {
    public int addOrUpdate(Word word) {

        String sql = "insert into tb_word (groupId,title,content,pubTime) values (?,?,?,now())";
        List<Object> params = new ArrayList<>();
        params.add(word.getGroupId());
        params.add(word.getTitle());
        params.add(word.getContent());

        return BaseDao.executeUpdate(sql,params);
    }
}
