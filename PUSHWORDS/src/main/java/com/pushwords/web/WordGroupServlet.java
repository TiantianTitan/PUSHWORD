package com.pushwords.web;

import com.pushwords.po.User;
import com.pushwords.po.WordGroup;
import com.pushwords.service.WordGroupService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/group")
public class WordGroupServlet extends HttpServlet {
    private WordGroupService groupService = new WordGroupService();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String actionName = request.getParameter("actionName");
        if("list".equals(actionName)){
            groupList(request,response);
        }
    }

    private void groupList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user =  (User) request.getSession().getAttribute("user");

        List<WordGroup> groupList = groupService.findGroupList(user.getUserId());
        request.setAttribute("groupList",groupList);
//        request.setAttribute("changePage","group/list.jsp");
        request.getRequestDispatcher("index.jsp").forward(request,response);

    }
}
