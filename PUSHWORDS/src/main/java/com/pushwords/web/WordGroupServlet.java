package com.pushwords.web;

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
import java.io.IOException;
import java.util.List;

/**
 * WordGroupServlet handles requests related to word groups such as listing, adding, updating, and deleting groups.
 */
@WebServlet("/group")
public class WordGroupServlet extends HttpServlet {
    private final WordGroupService groupService = new WordGroupService();

    /**
     * Handles HTTP requests to the /group URL.
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
        if ("list".equals(actionName)) {
            groupList(request, response);
        } else if ("delete".equals(actionName)) {
            deleteGroup(request, response);
        } else if ("addOrUpdate".equals(actionName)) {
            addOrUpdateGroup(request, response);
        }
    }

    /**
     * Adds or updates a word group.
     *
     * @param request  the HttpServletRequest object that contains the request the client made to the servlet
     * @param response the HttpServletResponse object that contains the response the servlet returns to the client
     */
    private void addOrUpdateGroup(HttpServletRequest request, HttpServletResponse response) {
        String groupName = request.getParameter("groupName");
        String groupId = request.getParameter("groupId");
        String groupDescription = request.getParameter("groupDescription");

        User user = (User) request.getSession().getAttribute("user");

        ResultInfo<Integer> resultInfo = groupService.addOrUpdateGroup(groupName, user.getUserId(), groupId, groupDescription);
        JsonUtil.toJson(response, resultInfo);
    }

    /**
     * Deletes a word group.
     *
     * @param request  the HttpServletRequest object that contains the request the client made to the servlet
     * @param response the HttpServletResponse object that contains the response the servlet returns to the client
     */
    private void deleteGroup(HttpServletRequest request, HttpServletResponse response) {
        String groupId = request.getParameter("groupId");
        ResultInfo<WordGroup> resultInfo = groupService.deleteGroup(groupId);
        JsonUtil.toJson(response, resultInfo);
    }

    /**
     * Lists all word groups for the current user.
     *
     * @param request  the HttpServletRequest object that contains the request the client made to the servlet
     * @param response the HttpServletResponse object that contains the response the servlet returns to the client
     * @throws ServletException if the request could not be handled
     * @throws IOException      if an input or output error is detected when the servlet handles the request
     */
    private void groupList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        List<WordGroup> groupList = groupService.findGroupList(user.getUserId());
        request.setAttribute("groupList", groupList);
        request.getRequestDispatcher("/group/group.jsp").forward(request, response);
    }
}
