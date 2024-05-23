package com.pushwords.web;

import com.pushwords.po.Word;
import com.pushwords.service.WordService;
import com.alibaba.fastjson.JSON;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

@WebServlet("/study")
public class StudyServlet extends HttpServlet {
    private final WordService wordService = new WordService();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String actionName = request.getParameter("actionName");
        if ("startStudy".equals(actionName)) {
            startStudy(request, response);
        }
    }

    private void startStudy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String groupId = request.getParameter("groupId");
        List<Word> words = wordService.getWordsByGroupId(Integer.parseInt(groupId));
        Collections.shuffle(words);  // Shuffle the word list
        request.setAttribute("words", words);
        request.getRequestDispatcher("/study.jsp").forward(request, response);
    }
}
