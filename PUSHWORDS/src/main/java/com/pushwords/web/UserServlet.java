package com.pushwords.web;

import cn.hutool.core.io.FileUtil;
import com.pushwords.po.User;
import com.pushwords.service.UserService;
import com.pushwords.vo.ResultInfo;
import org.apache.commons.io.FileUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/user")
public class UserServlet extends HttpServlet {

    private final UserService userService = new UserService();
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String actionName = request.getParameter("actionName");
        if("login".equals(actionName)) {
            userLogin(request, response);
        }else if ("logout".equals(actionName)){
            userLogOut(request,response);
        }else if("userHead".equals(actionName)){
            // Load the image of head
            userHead(request,response);
        }
    }



    private void userLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String userName = request.getParameter("userName");
        String userPwd = request.getParameter("userPwd");

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

            response.sendRedirect("index.jsp");
        }else{
            request.setAttribute("resultInfo",resultInfo);

            request.getRequestDispatcher("login.jsp").forward(request,response);
        }


    }
    private void userLogOut(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.getSession().invalidate();
        Cookie cookie = new Cookie("user",null);
        cookie.setMaxAge(0);
        response.addCookie(cookie);
        response.sendRedirect("login.jsp");
    }

    private void userHead(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String head = request.getParameter("imageName");
        // Get the path of image
        String realPath = request.getServletContext().getRealPath("/WEB-INF/upload/");
        File file = new File(realPath + "/" +head);
        String pic = head.substring(head.lastIndexOf(".")+1);
        System.out.println(pic);

        if("PNG".equalsIgnoreCase(pic)){
            response.setContentType("image/png");
        }else if("JPG".equalsIgnoreCase(pic)||"JPEG".equalsIgnoreCase(pic)){
            response.setContentType("image/jpeg");
        }else if("GIF".equalsIgnoreCase(pic)){
            response.setContentType("image/gif");
        }

        FileUtils.copyFile(file,response.getOutputStream());

    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String actionName = request.getParameter("actionName");
        if ("login".equals(actionName)) {
            try {
                userLogin(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                if (!response.isCommitted()) {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
            }
        } else {
            // Handle other POST requests or send an error if it's not supported.
            response.sendError(HttpServletResponse.SC_NOT_IMPLEMENTED, "POST not supported for this action");
        }
    }


}
