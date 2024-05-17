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

@WebServlet("/word")
public class WordServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String actionName = request.getParameter("actionName");

        if("view".equals(actionName)){
            wordView(request,response);
        }


    }

    private void wordView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");

        List<WordGroup> groupList = new WordGroupService().findGroupList(user.getUserId());

        request.setAttribute("groupList",groupList);

        request.getRequestDispatcher("word/publish.jsp").forward(request,response);
    }


}
