package com.pushwords.web;

import com.pushwords.po.User;
import com.pushwords.po.Word;
import com.pushwords.po.WordGroup;
import com.pushwords.service.WordGroupService;
import com.pushwords.service.WordService;
import com.pushwords.service.WordsApiService;
import com.pushwords.util.Page;
import com.pushwords.vo.ResultInfo;
import org.json.JSONArray;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * WordServlet handles requests related to words such as viewing, adding, updating, deleting, and translating words.
 */
@WebServlet("/word")
public class WordServlet extends HttpServlet {

    private final WordService wordService = new WordService();
    private final WordsApiService wordsApiService = new WordsApiService();

    /**
     * Handles HTTP requests to the /word URL.
     *
     * @param request  the HttpServletRequest object that contains the request the client made to the servlet
     * @param response the HttpServletResponse object that contains the response the servlet returns to the client
     * @throws ServletException if the request could not be handled
     * @throws IOException      if an input or output error is detected when the servlet handles the request
     */
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String actionName = request.getParameter("actionName");

        if ("view".equals(actionName)) {
            wordView(request, response);
        } else if ("addOrUpdate".equals(actionName)) {
            addOrUpdate(request, response);
        } else if ("showWords".equals(actionName)) {
            showWords(request, response);
        } else if ("deleteWord".equals(actionName)) {
            deleteWord(request, response);
        } else if ("updateWord".equals(actionName)) {
            updateWord(request, response);
        } else if ("translate".equals(actionName)) {
            translateWord(request, response);
        }
    }

    /**
     * Shows a paginated list of words for a specific group.
     *
     * @param request  the HttpServletRequest object that contains the request the client made to the servlet
     * @param response the HttpServletResponse object that contains the response the servlet returns to the client
     * @throws ServletException if the request could not be handled
     * @throws IOException      if an input or output error is detected when the servlet handles the request
     */
    private void showWords(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String groupId = request.getParameter("groupId");
        String pageNumStr = request.getParameter("pageNum");
        String pageSizeStr = request.getParameter("pageSize");

        Page<Word> wordPage = wordService.findWordListByPage(pageNumStr, pageSizeStr, groupId);
        request.setAttribute("page", wordPage);
        request.getRequestDispatcher("/word/memory.jsp").forward(request, response);
    }

    /**
     * Adds or updates a word.
     *
     * @param request  the HttpServletRequest object that contains the request the client made to the servlet
     * @param response the HttpServletResponse object that contains the response the servlet returns to the client
     * @throws ServletException if the request could not be handled
     * @throws IOException      if an input or output error is detected when the servlet handles the request
     */
    private void addOrUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String groupId = request.getParameter("groupId");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        ResultInfo<Word> resultInfo = wordService.addOrUpdate(groupId, title, content);
        if (resultInfo.getCode() == 1) {
            response.sendRedirect("word?actionName=showWords&groupId=" + groupId);
        } else {
            request.setAttribute("resultInfo", resultInfo);
            request.getRequestDispatcher("word?actionName=showWords&groupId=" + groupId).forward(request, response);
        }
    }

    /**
     * Deletes a word.
     *
     * @param request  the HttpServletRequest object that contains the request the client made to the servlet
     * @param response the HttpServletResponse object that contains the response the servlet returns to the client
     * @throws IOException if an input or output error is detected when the servlet handles the request
     */
    private void deleteWord(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String wordId = request.getParameter("wordId");
        String groupId = request.getParameter("groupId");
        wordService.deleteWord(wordId);
        response.sendRedirect("word?actionName=showWords&groupId=" + groupId);
    }

    /**
     * Updates a word.
     *
     * @param request  the HttpServletRequest object that contains the request the client made to the servlet
     * @param response the HttpServletResponse object that contains the response the servlet returns to the client
     * @throws ServletException if the request could not be handled
     * @throws IOException      if an input or output error is detected when the servlet handles the request
     */
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

    /**
     * Displays the word view page.
     *
     * @param request  the HttpServletRequest object that contains the request the client made to the servlet
     * @param response the HttpServletResponse object that contains the response the servlet returns to the client
     * @throws ServletException if the request could not be handled
     * @throws IOException      if an input or output error is detected when the servlet handles the request
     */
    private void wordView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        List<WordGroup> groupList = new WordGroupService().findGroupList(user.getUserId());
        request.setAttribute("groupList", groupList);
        request.getRequestDispatcher("word/publish.jsp").forward(request, response);
    }

    /**
     * Translates a word using the WordsAPI and returns the definitions as a JSON response.
     *
     * @param request  the HttpServletRequest object that contains the request the client made to the servlet
     * @param response the HttpServletResponse object that contains the response the servlet returns to the client
     * @throws IOException if an input or output error is detected when the servlet handles the request
     */
    private void translateWord(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String word = request.getParameter("word");

        try {
            List<Map<String, String>> definitions = wordsApiService.translateWord(word);
            JSONArray jsonArray = new JSONArray(definitions);
            response.setContentType("application/json");
            response.getWriter().write(jsonArray.toString());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Translation failed.");
        }
    }
}
