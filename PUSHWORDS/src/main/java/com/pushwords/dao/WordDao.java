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

    public long findWordCount(Integer userId) {

        String sql = "SELECT COUNT(1) FROM tb_word n INNER JOIN tb_group t on n.groupId = t.groupId where groupUserId = ?";

        List<Object> params = new ArrayList<>();
        params.add(userId);
        return (long)  BaseDao.findSingleValue(sql,params);

    }

    public List<Word> findWordListByPage(Integer userId, Integer index, Integer pageSize) {

        String sql = "SELECT groupUserId,title,pubtime FROM tb_word n INNER JOIN tb_group t on n.groupId = t.groupId where groupUserId = ?";

        List<Object> params = new ArrayList<>();
        params.add(userId);

        return (List<Word>) BaseDao.queryRows(sql,params, Word.class);

    }
}
