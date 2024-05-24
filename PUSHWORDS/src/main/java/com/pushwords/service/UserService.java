package com.pushwords.service;

import cn.hutool.core.util.StrUtil;
import com.pushwords.dao.UserDao;
import com.pushwords.po.User;
import com.pushwords.vo.ResultInfo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

/**
 * UserService handles operations related to user management, such as login, registration, and profile updates.
 */
public class UserService {

    private final UserDao userDao = new UserDao();

    /**
     * Logs in a user with the provided username and password.
     *
     * @param userName the username of the user
     * @param userPwd  the password of the user
     * @return a ResultInfo object containing the login result and user information
     */
    public ResultInfo<User> userLogin(String userName, String userPwd) {
        ResultInfo<User> resultInfo = new ResultInfo<>();

        User u = new User();
        u.setUname(userName);
        u.setUpwd(userPwd);
        resultInfo.setResult(u);

        // Validate input parameters
        if (StrUtil.isBlank(userName) || StrUtil.isBlank(userPwd)) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Username or password should not be empty");
            return resultInfo;
        }

        // Check if the user exists
        User user = userDao.queryUserByName(userName);
        if (user == null) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Username not found!");
            return resultInfo;
        }

        // Validate password
        if (!userPwd.equals(user.getUpwd())) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Password incorrect!");
            return resultInfo;
        }

        resultInfo.setCode(1);
        resultInfo.setResult(user);
        return resultInfo;
    }

    /**
     * Checks if a nickname is already taken by another user.
     *
     * @param nick   the nickname to check
     * @param userId the ID of the user
     * @return 1 if the nickname is available, 0 otherwise
     */
    public Integer checkNick(String nick, Integer userId) {
        if (StrUtil.isBlank(nick)) {
            return 0;
        }
        User user = userDao.queryUserByNickAndUserId(nick, userId);
        if (user != null) {
            return 0;
        }
        return 1;
    }

    /**
     * Updates the user's profile with new information.
     *
     * @param request the HttpServletRequest containing the user's profile data
     * @return a ResultInfo object containing the update result and user information
     */
    public ResultInfo<User> updateUser(HttpServletRequest request) {
        ResultInfo<User> resultInfo = new ResultInfo<>();

        String nick = request.getParameter("nick");
        String mood = request.getParameter("mood").trim();

        // Validate input parameters
        if (StrUtil.isBlank(nick)) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Nick can't be empty!");
            return resultInfo;
        }

        User user = (User) request.getSession().getAttribute("user");
        user.setNick(nick);
        user.setMood(mood);

        try {
            Part part = request.getPart("img");
            String header = part.getHeader("Content-Disposition");
            String str = header.substring(header.lastIndexOf("=") + 2);
            String fileName = str.substring(0, str.length() - 1);
            if (!StrUtil.isBlank(fileName)) {
                user.setHead(fileName);
                String filePath = request.getServletContext().getRealPath("/WEB-INF/upload/");
                part.write(filePath + "/" + fileName);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        int row = userDao.updateUser(user);

        if (row > 0) {
            resultInfo.setCode(1);
            request.getSession().setAttribute("user", user);
        } else {
            resultInfo.setCode(0);
            resultInfo.setMsg("Update failed");
        }

        return resultInfo;
    }

    /**
     * Registers a new user with the provided username and password.
     *
     * @param userName the username of the new user
     * @param userPwd  the password of the new user
     * @return a ResultInfo object containing the registration result and user information
     */
    public ResultInfo<User> userRegister(String userName, String userPwd) {
        ResultInfo<User> resultInfo = new ResultInfo<>();

        // Validate input parameters
        if (StrUtil.isBlank(userName) || StrUtil.isBlank(userPwd)) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Username and password should not be empty");
            return resultInfo;
        }

        // Check if the username already exists
        User existingUser = userDao.queryUserByName(userName);
        if (existingUser != null) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Username already exists!");
            return resultInfo;
        }

        // Create a new User object and save it to the database
        User user = new User();
        user.setUname(userName);
        user.setUpwd(userPwd);
        int row = userDao.saveUser(user);

        // Set the result information based on the database operation result
        if (row > 0) {
            resultInfo.setCode(1);
        } else {
            resultInfo.setCode(0);
            resultInfo.setMsg("Registration failed");
        }

        return resultInfo;
    }
}
