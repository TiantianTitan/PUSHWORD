package com.pushwords.service;

import com.pushwords.dao.TestResultDao;
import com.pushwords.dao.WordDao;
import com.pushwords.po.TestResult;
import com.pushwords.po.Word;
import com.pushwords.util.Page;
import com.pushwords.vo.ResultInfo;
import cn.hutool.core.util.StrUtil;

import java.util.List;

/**
 * WordService handles operations related to words and test results.
 */
public class WordService {

    private final WordDao wordDao = new WordDao();
    private final TestResultDao testResultDao = new TestResultDao();

    /**
     * Adds or updates a word with the given group ID, title, and content.
     *
     * @param groupId  the ID of the group the word belongs to
     * @param title    the title of the word
     * @param content  the content or description of the word
     * @return a ResultInfo object containing the result of the add or update operation
     */
    public ResultInfo<Word> addOrUpdate(String groupId, String title, String content) {
        ResultInfo<Word> resultInfo = new ResultInfo<>();

        if (StrUtil.isBlank(groupId)) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Backend: choose the Group!");
            return resultInfo;
        }
        if (StrUtil.isBlank(title)) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Backend: enter a word!");
            return resultInfo;
        }
        if (StrUtil.isBlank(content)) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Backend: enter the description of the word!");
            return resultInfo;
        }

        Word word = new Word();
        word.setTitle(title);
        word.setContent(content);
        word.setGroupId(Integer.parseInt(groupId));
        resultInfo.setResult(word);

        int row = wordDao.addOrUpdate(word);
        if (row > 0) {
            resultInfo.setCode(1);
        } else {
            resultInfo.setCode(0);
            resultInfo.setResult(word);
        }

        return resultInfo;
    }

    /**
     * Finds a paginated list of words for a specific group.
     *
     * @param pageNumStr   the page number as a string
     * @param pageSizeStr  the page size as a string
     * @param groupIdStr   the group ID as a string
     * @return a Page object containing a list of words
     */
    public Page<Word> findWordListByPage(String pageNumStr, String pageSizeStr, String groupIdStr) {
        Integer pageNum = 1;
        Integer pageSize = 10;

        if (StrUtil.isBlank(groupIdStr)) {
            return null;
        }
        Integer groupId = Integer.parseInt(groupIdStr);
        if (!StrUtil.isBlank(pageNumStr)) {
            pageNum = Integer.parseInt(pageNumStr);
        }
        if (!StrUtil.isBlank(pageSizeStr)) {
            pageSize = Integer.parseInt(pageSizeStr);
        }

        long count = wordDao.findWordCount(groupId);
        if (count < 1) {
            return null;
        }

        Page<Word> page = new Page<>(pageNum, pageSize, count);
        Integer index = (pageNum - 1) * pageSize;
        List<Word> wordList = wordDao.findWordListByPage(groupId, index, pageSize);
        page.setDataList(wordList);
        return page;
    }

    /**
     * Deletes a word by its ID.
     *
     * @param wordId the ID of the word to be deleted
     */
    public void deleteWord(String wordId) {
        wordDao.deleteWord(Integer.parseInt(wordId));
    }

    /**
     * Updates the details of a word.
     *
     * @param word the Word object containing updated information
     */
    public void updateWord(Word word) {
        wordDao.updateWord(word);
    }

    /**
     * Retrieves a list of words for a specific group ID.
     *
     * @param groupId the ID of the group
     * @return a list of Word objects
     */
    public List<Word> getWordsByGroupId(int groupId) {
        return wordDao.findWordsByGroupId(groupId);
    }

    /**
     * Saves a test result.
     *
     * @param testResult the TestResult object to be saved
     */
    public void saveTestResult(TestResult testResult) {
        testResultDao.saveTestResult(testResult);
    }

    /**
     * Finds test results for a given user ID.
     *
     * @param userId the ID of the user whose test results are to be found
     * @return a list of TestResult objects
     */
    public List<TestResult> findTestResultsByUserId(int userId) {
        return testResultDao.findTestResultsByUserId(userId);
    }
}
