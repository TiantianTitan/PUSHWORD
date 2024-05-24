package com.pushwords.web;


import cn.hutool.json.JSON;
import com.pushwords.po.User;
import com.pushwords.po.WordGroup;
import com.pushwords.service.WordGroupService;
import com.pushwords.util.JsonUtil;
import com.pushwords.vo.ResultInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import static cn.hutool.json.JSON.*;

@WebServlet("/group")
public class WordGroupServlet extends HttpServlet {
    private final WordGroupService groupService = new WordGroupService();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String actionName = request.getParameter("actionName");
        if ("list".equals(actionName)) {
            groupList(request, response);
        } else if ("delete".equals(actionName)) {
            deleteGroup(request, response);
        } else if ("addOrUpdate".equals(actionName)) {
            addOrUpdateGroup(request, response);
        }
    }

    private void addOrUpdateGroup(HttpServletRequest request, HttpServletResponse response) {
        String groupName = request.getParameter("groupName");
        String groupId = request.getParameter("groupId");
        String groupDescription = request.getParameter("groupDescription");

        User user = (User) request.getSession().getAttribute("user");

        ResultInfo<Integer> resultInfo = groupService.addOrUpdateGroup(groupName, user.getUserId(), groupId, groupDescription);
        JsonUtil.toJson(response, resultInfo);
    }

    private void deleteGroup(HttpServletRequest request, HttpServletResponse response) {
        String groupId = request.getParameter("groupId");
        ResultInfo<WordGroup> resultInfo = groupService.deleteGroup(groupId);
        JsonUtil.toJson(response, resultInfo);
    }

    private void groupList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        List<WordGroup> groupList = groupService.findGroupList(user.getUserId());
        request.setAttribute("groupList", groupList);
        request.getRequestDispatcher("/group/group.jsp").forward(request, response);
    }
}
