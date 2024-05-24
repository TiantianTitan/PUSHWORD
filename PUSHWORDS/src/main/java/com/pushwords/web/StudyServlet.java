package com.pushwords.web;

import com.pushwords.po.TestResult;
import com.pushwords.po.Word;
import com.pushwords.service.WordService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

/**
 * StudyServlet handles study-related requests, such as starting a study session and saving test results.
 */
@WebServlet("/study")
public class StudyServlet extends HttpServlet {
    private final WordService wordService = new WordService();

    /**
     * Handles HTTP requests to the /study URL.
     *
     * @param request  the HttpServletRequest object that contains the request the client made to the servlet
     * @param response the HttpServletResponse object that contains the response the servlet returns to the client
     * @throws ServletException if the request could not be handled
     * @throws IOException      if an input or output error is detected when the servlet handles the request
     */
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String actionName = request.getParameter("actionName");
        if ("startStudy".equals(actionName)) {
            startStudy(request, response);
        } else if ("saveResult".equals(actionName)) {
            saveResult(request, response);
        }
    }

    /**
     * Starts a study session by shuffling the words of a specified group and forwarding them to the study page.
     *
     * @param request  the HttpServletRequest object that contains the request the client made to the servlet
     * @param response the HttpServletResponse object that contains the response the servlet returns to the client
     * @throws ServletException if the request could not be handled
     * @throws IOException      if an input or output error is detected when the servlet handles the request
     */
    private void startStudy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String groupId = request.getParameter("groupId");
        List<Word> words = wordService.getWordsByGroupId(Integer.parseInt(groupId));
        Collections.shuffle(words);
        request.setAttribute("words", words);
        request.getRequestDispatcher("/study.jsp").forward(request, response);
    }

    /**
     * Saves the test result for the user.
     *
     * @param request  the HttpServletRequest object that contains the request the client made to the servlet
     * @param response the HttpServletResponse object that contains the response the servlet returns to the client
     * @throws IOException if an input or output error is detected when the servlet handles the request
     */
    private void saveResult(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userIdParam = request.getParameter("userId");
        String groupIdParam = request.getParameter("groupId");
        String totalWordsParam = request.getParameter("totalWords");
        String correctAnswersParam = request.getParameter("correctAnswers");
        String accuracyParam = request.getParameter("accuracy");
        String timeTakenParam = request.getParameter("timeTaken");

        System.out.println("Received parameters:");
        System.out.println("userId: " + userIdParam);
        System.out.println("groupId: " + groupIdParam);
        System.out.println("totalWords: " + totalWordsParam);
        System.out.println("correctAnswers: " + correctAnswersParam);
        System.out.println("accuracy: " + accuracyParam);
        System.out.println("timeTaken: " + timeTakenParam);

        // 检查参数是否为空
        if (userIdParam == null || userIdParam.isEmpty() || groupIdParam == null || groupIdParam.isEmpty() ||
                totalWordsParam == null || totalWordsParam.isEmpty() || correctAnswersParam == null || correctAnswersParam.isEmpty() ||
                accuracyParam == null || accuracyParam.isEmpty() || timeTakenParam == null || timeTakenParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdParam);
            int groupId = Integer.parseInt(groupIdParam);
            int totalWords = Integer.parseInt(totalWordsParam);
            int correctAnswers = Integer.parseInt(correctAnswersParam);
            float accuracy = Float.parseFloat(accuracyParam);
            int timeTaken = Integer.parseInt(timeTakenParam);

            TestResult testResult = new TestResult();
            testResult.setUserId(userId);
            testResult.setGroupId(groupId);
            testResult.setTotalWords(totalWords);
            testResult.setCorrectAnswers(correctAnswers);
            testResult.setAccuracy(accuracy);
            testResult.setTimeTaken(timeTaken);

            wordService.saveTestResult(testResult);

            response.sendRedirect("report?actionName=showReports");
        } catch (NumberFormatException e) {
            System.out.println("NumberFormatException: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input format");
        } catch (IllegalArgumentException e) {
            System.out.println("IllegalArgumentException: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Foreign key constraint violation");
        }
    }
}
