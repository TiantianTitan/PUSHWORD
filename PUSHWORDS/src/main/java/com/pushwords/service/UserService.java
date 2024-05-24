package com.pushwords.service;

import cn.hutool.core.util.StrUtil;
import com.pushwords.dao.UserDao;
import com.pushwords.po.User;
import com.pushwords.vo.ResultInfo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

public class UserService {

    private final UserDao userDao = new UserDao();

    public ResultInfo<User> userLogin(String userName, String userPwd) {
        ResultInfo<User> resultInfo = new ResultInfo<>();

        User u = new User();
        u.setUname(userName);
        u.setUpwd(userPwd);
        resultInfo.setResult(u);

        // Judge the userName or userPwd
        if (StrUtil.isBlank(userName) || StrUtil.isBlank(userPwd)) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Username or password should not be empty");
            return resultInfo;
        }

        User user = userDao.queryUserByName(userName);

        if (user == null) {
            resultInfo.setCode(0);
            resultInfo.setMsg("userName not found!");
            return resultInfo;
        }

        if (!userPwd.equals(user.getUpwd())) {
            resultInfo.setCode(0);
            resultInfo.setMsg("password incorrect!");
            return resultInfo;
        }

        resultInfo.setCode(1);
        resultInfo.setResult(user);
        return resultInfo;
    }

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

    public ResultInfo<User> updateUser(HttpServletRequest request) {
        ResultInfo<User> resultInfo = new ResultInfo<>();

        String nick = request.getParameter("nick");
        String mood = request.getParameter("mood").trim();

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
            resultInfo.setMsg("Update Fail");
        }

        return resultInfo;
    }

    public ResultInfo<User> userRegister(String userName, String userPwd) {
        ResultInfo<User> resultInfo = new ResultInfo<>();

        if (StrUtil.isBlank(userName) || StrUtil.isBlank(userPwd)) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Username and password should not be empty");
            return resultInfo;
        }

        User existingUser = userDao.queryUserByName(userName);
        if (existingUser != null) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Username already exists!");
            return resultInfo;
        }

        User user = new User();
        user.setUname(userName);
        user.setUpwd(userPwd);

        int row = userDao.saveUser(user);

        if (row > 0) {
            resultInfo.setCode(1);
        } else {
            resultInfo.setCode(0);
            resultInfo.setMsg("Registration failed");
        }

        return resultInfo;
    }
}
