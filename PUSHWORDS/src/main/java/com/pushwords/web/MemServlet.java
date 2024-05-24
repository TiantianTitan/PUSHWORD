package com.pushwords.web;

import com.pushwords.po.User;
import com.pushwords.po.WordGroup;
import com.pushwords.service.WordGroupService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * MemServlet handles requests related to word groups for the current user.
 */
@WebServlet("/mem")
public class MemServlet extends HttpServlet {

    private final WordGroupService groupService = new WordGroupService();

    /**
     * Handles HTTP requests to the /mem URL.
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
        }
    }

    /**
     * Retrieves the list of word groups for the current user and forwards to the appropriate JSP page.
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

        // Forward to the mem.jsp page
        request.getRequestDispatcher("/mem/mem.jsp").forward(request, response);
    }
}
