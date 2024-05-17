package com.pushwords.service;

import cn.hutool.core.util.StrUtil;
import com.pushwords.dao.WordDao;
import com.pushwords.po.Word;
import com.pushwords.vo.ResultInfo;

public class WordService {

    private WordDao wordDao = new WordDao();


    public ResultInfo<Word> addOrUpdate(String groupId, String title, String content) {
        ResultInfo<Word> resultInfo = new ResultInfo<>();

        if(StrUtil.isBlank(groupId)){
            resultInfo.setCode(0);
            resultInfo.setMsg("Backend: choose the Group!");
            return resultInfo;
        }

        if(StrUtil.isBlank(title)){
            resultInfo.setCode(0);
            resultInfo.setMsg("Backend: enter a word!");
            return resultInfo;
        }

        if(StrUtil.isBlank(content)){
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
        if(row > 0){
            resultInfo.setCode(1);
        }else{
            resultInfo.setCode(0);
            resultInfo.setResult(word);
        }

        return  resultInfo;
    }
}
