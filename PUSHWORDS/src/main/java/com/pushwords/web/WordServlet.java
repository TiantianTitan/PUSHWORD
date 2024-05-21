package com.pushwords.web;

import com.mysql.cj.protocol.Resultset;
import com.pushwords.po.User;
import com.pushwords.po.Word;
import com.pushwords.po.WordGroup;
import com.pushwords.service.WordGroupService;
import com.pushwords.service.WordService;
import com.pushwords.util.Page;
import com.pushwords.vo.ResultInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
@WebServlet("/word")
public class WordServlet extends HttpServlet {

    private WordService wordService = new WordService();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String actionName = request.getParameter("actionName");

        if("view".equals(actionName)){
            wordView(request, response);
        } else if ("addOrUpdate".equals(actionName)){
            addOrUpdate(request, response);
        } else if("showWords".equals(actionName)){
            showWords(request, response);
        } else if("deleteWord".equals(actionName)){
            deleteWord(request, response);
        } else if("updateWord".equals(actionName)){
            updateWord(request, response);
        }
    }

    private void showWords(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String groupId = request.getParameter("groupId");
        String pageNumStr = request.getParameter("pageNum");
        String pageSizeStr = request.getParameter("pageSize");

        Page<Word> wordPage = wordService.findWordListByPage(pageNumStr, pageSizeStr, groupId);
        request.setAttribute("page", wordPage);
        request.getRequestDispatcher("/word/memory.jsp").forward(request, response);
    }

    private void addOrUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String groupId = request.getParameter("groupId");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        ResultInfo<Word> resultInfo = wordService.addOrUpdate(groupId, title, content);
        if(resultInfo.getCode() == 1){
            response.sendRedirect("word?actionName=showWords&groupId=" + groupId);
        } else {
            request.setAttribute("resultInfo", resultInfo);
            request.getRequestDispatcher("word?actionName=showWords&groupId=" + groupId).forward(request, response);
        }
    }

    private void deleteWord(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String wordId = request.getParameter("wordId");
        String groupId = request.getParameter("groupId");
        wordService.deleteWord(wordId);
        response.sendRedirect("word?actionName=showWords&groupId=" + groupId);
    }

    private void updateWord(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String wordId = request.getParameter("wordId");
        String groupId = request.getParameter("groupId");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        Word word = new Word();
        word.setWordId(Integer.parseInt(wordId));
        word.setTitle(title);
        word.setContent(content);
        wordService.updateWord(word);
        response.sendRedirect("word?actionName=showWords&groupId=" + groupId);
    }

    private void wordView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        List<WordGroup> groupList = new WordGroupService().findGroupList(user.getUserId());
        request.setAttribute("groupList", groupList);
        request.getRequestDispatcher("word/publish.jsp").forward(request, response);
    }
}

