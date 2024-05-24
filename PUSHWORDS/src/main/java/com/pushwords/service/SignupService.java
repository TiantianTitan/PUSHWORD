package com.pushwords.service;

import cn.hutool.core.util.StrUtil;
import com.pushwords.dao.UserDao;
import com.pushwords.po.User;
import com.pushwords.vo.ResultInfo;

/**
 * SignupService handles the registration of new users.
 */
public class SignupService {

    private final UserDao userDao = new UserDao();

    /**
     * Registers a new user with the provided username and password.
     *
     * @param userName the username of the new user
     * @param userPwd  the password of the new user
     * @return a ResultInfo object containing the registration result and user information
     */
    public ResultInfo<User> registerUser(String userName, String userPwd) {
        ResultInfo<User> resultInfo = new ResultInfo<>();

        // Validate input parameters
        if (StrUtil.isBlank(userName) || StrUtil.isBlank(userPwd)) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Username or password should not be empty");
            return resultInfo;
        }

        // Check if the username already exists
        User existingUser = userDao.queryUserByName(userName);
        if (existingUser != null) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Username already exists");
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
            resultInfo.setResult(user);
        } else {
            resultInfo.setCode(0);
            resultInfo.setMsg("Registration failed");
        }

        return resultInfo;
    }
}
