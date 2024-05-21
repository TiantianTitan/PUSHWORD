package com.pushwords.web;

import com.pushwords.po.User;
import com.pushwords.po.Word;
import com.pushwords.service.WordService;
import com.pushwords.util.Page;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/index")
public class IndexServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("menu_page","index");
//
//        wordList(request,response);

        request.setAttribute("changePage","word/publish.jsp"); // TO CHANGE
        request.getRequestDispatcher("index.jsp").forward(request,response);
    }

}
