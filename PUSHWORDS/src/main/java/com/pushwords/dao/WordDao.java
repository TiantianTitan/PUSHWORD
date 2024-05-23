package com.pushwords.dao;

import com.pushwords.po.Word;
import com.pushwords.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class WordDao {

    public int addOrUpdate(Word word) {
        String sql = "INSERT INTO tb_word (groupId, title, content, pubTime) VALUES (?, ?, ?, NOW())";
        List<Object> params = new ArrayList<>();
        params.add(word.getGroupId());
        params.add(word.getTitle());
        params.add(word.getContent());
        return BaseDao.executeUpdate(sql, params);
    }

    public long findWordCount(Integer groupId) {
        String sql = "SELECT COUNT(1) FROM tb_word WHERE groupId = ?";
        List<Object> params = new ArrayList<>();
        params.add(groupId);
        return (long) BaseDao.findSingleValue(sql, params);
    }

    public List<Word> findWordListByPage(Integer groupId, Integer index, Integer pageSize) {
        String sql = "SELECT wordId, title, content, pubTime FROM tb_word WHERE groupId = ? LIMIT ?, ?";
        List<Object> params = new ArrayList<>();
        params.add(groupId);
        params.add(index);
        params.add(pageSize);
        return (List<Word>) BaseDao.queryRows(sql, params, Word.class);
    }

    public int deleteWord(Integer wordId) {
        String sql = "DELETE FROM tb_word WHERE wordId = ?";
        List<Object> params = new ArrayList<>();
        params.add(wordId);
        return BaseDao.executeUpdate(sql, params);
    }

    public int updateWord(Word word) {
        String sql = "UPDATE tb_word SET title = ?, content = ? WHERE wordId = ?";
        List<Object> params = new ArrayList<>();
        params.add(word.getTitle());
        params.add(word.getContent());
        params.add(word.getWordId());
        return BaseDao.executeUpdate(sql, params);
    }

    public List<Word> findWordsByGroupId(int groupId) {
        List<Word> words = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection()) {
            String sql = "SELECT * FROM tb_word WHERE groupId = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, groupId);
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        Word word = new Word();
                        word.setWordId(resultSet.getInt("wordId"));
                        word.setGroupId(resultSet.getInt("groupId"));
                        word.setTitle(resultSet.getString("title"));
                        word.setContent(resultSet.getString("content"));
                        word.setPubTime(resultSet.getTimestamp("pubTime"));
                        words.add(word);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return words;
    }
}
