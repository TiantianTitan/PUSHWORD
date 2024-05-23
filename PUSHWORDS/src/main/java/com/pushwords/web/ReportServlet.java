package com.pushwords.web;

import com.pushwords.po.TestResult;
import com.pushwords.service.TestResultService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/report")
public class ReportServlet extends HttpServlet {
    private final TestResultService testResultService = new TestResultService();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String actionName = request.getParameter("actionName");
        if ("showReports".equals(actionName)) {
            showReports(request, response);
        }
    }

    private void showReports(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            System.out.println("User ID is not set in the session.");
            response.getWriter().println("User ID is not set in the session.");
            return;
        }

        System.out.println("Fetching test results for userId: " + userId);
        List<TestResult> testResults = testResultService.findTestResultsByUserId(userId);

        if (testResults == null || testResults.isEmpty()) {
            System.out.println("No test results found for userId: " + userId);
        } else {
            for (TestResult result : testResults) {
                System.out.println("Test result: " + result);
            }
        }

        request.setAttribute("testResults", testResults);
        request.getRequestDispatcher("reports.jsp").forward(request, response);
    }
}
