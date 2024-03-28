package com.pushwords.web;

import com.pushwords.po.User;
import com.pushwords.service.UserService;
import com.pushwords.vo.ResultInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/user")
public class UserServlet extends HttpServlet {

    private UserService userService = new UserService();
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String actionName =  request.getParameter("actionName");
        if("login".equals(actionName)){
            // Login for User
            try {
                userLogin(request,response);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        super.service(request, response);
    }

    private void userLogin(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {

        String userName = request.getParameter("username");
        String userPwd = request.getParameter("password");

        ResultInfo<User> resultInfo = userService.userLogin(userName,userPwd);

        if(resultInfo.getCode() == 1){
            request.getSession().setAttribute("user",resultInfo.getResult());

            String rem = request.getParameter("rem");
            Cookie cookie;
            if("1".equals(rem)){
                cookie = new Cookie("user",userName +"-"+userPwd);
                cookie.setMaxAge(3*24*60*60);
                response.addCookie(cookie);
            }else {
                cookie = new Cookie("user",null);
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
        }else{
            request.setAttribute("resultInfo",resultInfo);
            request.getRequestDispatcher("login.jsp").forward(request,response);
        }


    }
}
