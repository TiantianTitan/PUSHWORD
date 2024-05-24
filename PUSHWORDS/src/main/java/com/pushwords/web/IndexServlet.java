package com.pushwords.web;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * IndexServlet handles requests for the index page.
 */
@WebServlet("/index")
public class IndexServlet extends HttpServlet {

    /**
     * Handles HTTP requests to the /index URL.
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
        request.setAttribute("menu_page", "index");

        // Uncomment the following line if you want to include word list functionality
        // wordList(request, response);

        request.setAttribute("changePage", "word/publish.jsp"); // TO CHANGE
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
