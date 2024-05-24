package com.pushwords.web;

import com.pushwords.po.User;
import com.pushwords.service.UserService;
import com.pushwords.vo.ResultInfo;
import org.apache.commons.io.FileUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;

@WebServlet("/user")
@MultipartConfig
public class UserServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String actionName = request.getParameter("actionName");
        if ("login".equals(actionName)) {
            userLogin(request, response);
        } else if ("logout".equals(actionName)) {
            userLogOut(request, response);
        } else if ("userHead".equals(actionName)) {
            // Load the image of head
            userHead(request, response);
        } else if ("checkNick".equals(actionName)) {
            checkNick(request, response);
        } else if ("updateUser".equals(actionName)) {
            // Modify the information of user
            updateUser(request, response);
        } else if ("register".equals(actionName)) {
            userRegister(request, response);
        }
    }

    private void userLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String userName = request.getParameter("userName");
        String userPwd = request.getParameter("userPwd");

        ResultInfo<User> resultInfo = userService.userLogin(userName, userPwd);

        if (resultInfo.getCode() == 1) {
            User user = resultInfo.getResult();
            request.getSession().setAttribute("user", user);
            request.getSession().setAttribute("userId", user.getUserId());  // 将 userId 设置到 session 中

            String rem = request.getParameter("rem");
            Cookie cookie;
            if ("1".equals(rem)) {
                cookie = new Cookie("user", userName + "-" + userPwd);
                cookie.setMaxAge(3 * 24 * 60 * 60);
                response.addCookie(cookie);
            } else {
                cookie = new Cookie("user", null);
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }

            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("resultInfo", resultInfo);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void userLogOut(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.getSession().invalidate();
        Cookie cookie = new Cookie("user", null);
        cookie.setMaxAge(0);
        response.addCookie(cookie);
        response.sendRedirect("login.jsp");
    }

    private void userHead(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String head = request.getParameter("imageName");
        // Get the path of image
        String realPath = request.getServletContext().getRealPath("/WEB-INF/upload/");
        File file = new File(realPath + "/" + head);
        String pic = head.substring(head.lastIndexOf(".") + 1);

        if ("PNG".equalsIgnoreCase(pic)) {
            response.setContentType("image/png");
        } else if ("JPG".equalsIgnoreCase(pic) || "JPEG".equalsIgnoreCase(pic)) {
            response.setContentType("image/jpeg");
        } else if ("GIF".equalsIgnoreCase(pic)) {
            response.setContentType("image/gif");
        }

        FileUtils.copyFile(file, response.getOutputStream());
    }

    private void checkNick(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String nick = request.getParameter("nick");
        User user = (User) request.getSession().getAttribute("user");
        Integer code = userService.checkNick(nick, user.getUserId());
        response.getWriter().write(code + "");
        response.getWriter().close();
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ResultInfo<User> resultInfo = userService.updateUser(request);

        request.setAttribute("resultInfo", resultInfo);
        request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
    }

    private void userRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String userName = request.getParameter("userName");
        String userPwd = request.getParameter("userPwd");

        ResultInfo<User> resultInfo = userService.userRegister(userName, userPwd);

        if (resultInfo.getCode() == 1) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("resultInfo", resultInfo);
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
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
        } else if ("register".equals(actionName)) {
            try {
                userRegister(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                if (!response.isCommitted()) {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_IMPLEMENTED, "POST not supported for this action");
        }
    }
}
