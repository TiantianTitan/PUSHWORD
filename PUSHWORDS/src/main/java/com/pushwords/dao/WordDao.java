package com.pushwords.dao;

import com.pushwords.po.Word;
import com.pushwords.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * WordDao handles database operations related to the Word entity.
 */
public class WordDao {

    /**
     * Adds a new word or updates an existing word in the database.
     *
     * @param word the Word object to be added or updated
     * @return the number of rows affected by the operation
     */
    public int addOrUpdate(Word word) {
        String sql = "INSERT INTO tb_word (groupId, title, content, pubTime) VALUES (?, ?, ?, NOW())";
        List<Object> params = new ArrayList<>();
        params.add(word.getGroupId());
        params.add(word.getTitle());
        params.add(word.getContent());
        return BaseDao.executeUpdate(sql, params);
    }

    /**
     * Finds the count of words in a specific group.
     *
     * @param groupId the ID of the group
     * @return the count of words in the specified group
     */
    public long findWordCount(Integer groupId) {
        String sql = "SELECT COUNT(1) FROM tb_word WHERE groupId = ?";
        List<Object> params = new ArrayList<>();
        params.add(groupId);
        return (long) BaseDao.findSingleValue(sql, params);
    }

    /**
     * Finds a list of words in a specific group by page.
     *
     * @param groupId the ID of the group
     * @param index the starting index for the page
     * @param pageSize the size of the page
     * @return a list of Word objects corresponding to the specified page
     */
    public List<Word> findWordListByPage(Integer groupId, Integer index, Integer pageSize) {
        String sql = "SELECT wordId, title, content, pubTime FROM tb_word WHERE groupId = ? LIMIT ?, ?";
        List<Object> params = new ArrayList<>();
        params.add(groupId);
        params.add(index);
        params.add(pageSize);
        return (List<Word>) BaseDao.queryRows(sql, params, Word.class);
    }

    /**
     * Deletes a word from the database by its ID.
     *
     * @param wordId the ID of the word to be deleted
     * @return the number of rows affected by the delete operation
     */
    public int deleteWord(Integer wordId) {
        String sql = "DELETE FROM tb_word WHERE wordId = ?";
        List<Object> params = new ArrayList<>();
        params.add(wordId);
        return BaseDao.executeUpdate(sql, params);
    }

    /**
     * Updates an existing word in the database.
     *
     * @param word the Word object containing updated information
     * @return the number of rows affected by the update
     */
    public int updateWord(Word word) {
        String sql = "UPDATE tb_word SET title = ?, content = ? WHERE wordId = ?";
        List<Object> params = new ArrayList<>();
        params.add(word.getTitle());
        params.add(word.getContent());
        params.add(word.getWordId());
        return BaseDao.executeUpdate(sql, params);
    }

    /**
     * Finds a list of words by group ID.
     *
     * @param groupId the ID of the group
     * @return a list of Word objects corresponding to the specified group ID
     */
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
