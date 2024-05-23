package com.pushwords.web;
import com.pushwords.po.TestResult;
import com.pushwords.util.DatabaseConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.getWriter().println("User ID is not set in the session.");
            return;
        }

        List<TestResult> testResults = new ArrayList<>();
        try {
            Connection conn = DatabaseConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM tb_test_result WHERE userId = ?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                TestResult result = new TestResult();
                result.setTestDate(rs.getTimestamp("testDate"));
                result.setGroupId(rs.getInt("groupId"));
                result.setTotalWords(rs.getInt("totalWords"));
                result.setCorrectAnswers(rs.getInt("correctAnswers"));
                result.setAccuracy(rs.getInt("accuracy"));
                result.setTimeTaken(rs.getInt("timeTaken"));
                testResults.add(result);
            }

            request.setAttribute("testResults", testResults);
            request.getRequestDispatcher("reports.jsp").forward(request, response);

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            Connection conn = DatabaseConnection.getConnection();
            System.out.println("Database connection established.");

            PreparedStatement ps = conn.prepareStatement("SELECT * FROM tb_test_result WHERE userId = ?");
            ps.setInt(1, userId);
            System.out.println("Executing query for userId: " + userId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TestResult result = new TestResult();
                result.setTestDate(rs.getTimestamp("testDate"));
                result.setGroupId(rs.getInt("groupId"));
                result.setTotalWords(rs.getInt("totalWords"));
                result.setCorrectAnswers(rs.getInt("correctAnswers"));
                result.setAccuracy(rs.getInt("accuracy"));
                result.setTimeTaken(rs.getInt("timeTaken"));
                testResults.add(result);
            }

            System.out.println("Number of results found: " + testResults.size());

            request.setAttribute("testResults", testResults);
            request.getRequestDispatcher("reports.jsp").forward(request, response);

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
