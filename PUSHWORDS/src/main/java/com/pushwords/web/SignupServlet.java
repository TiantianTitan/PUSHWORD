package com.pushwords.web;

import com.pushwords.po.User;
import com.pushwords.service.SignupService;
import com.pushwords.vo.ResultInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    private final SignupService signupService = new SignupService();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String actionName = request.getParameter("actionName");
        if ("register".equals(actionName)) {
            registerUser(request, response);
        }
    }

    private void registerUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = request.getParameter("userName");
        String userPwd = request.getParameter("userPwd");

        ResultInfo<User> resultInfo = signupService.registerUser(userName, userPwd);

        if (resultInfo.getCode() == 1) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("resultInfo", resultInfo);
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }
}
