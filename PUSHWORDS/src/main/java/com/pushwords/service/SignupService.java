package com.pushwords.service;

import cn.hutool.core.util.StrUtil;
import com.pushwords.dao.UserDao;
import com.pushwords.po.User;
import com.pushwords.vo.ResultInfo;

public class SignupService {

    private final UserDao userDao = new UserDao();

    public ResultInfo<User> registerUser(String userName, String userPwd) {
        ResultInfo<User> resultInfo = new ResultInfo<>();

        if (StrUtil.isBlank(userName) || StrUtil.isBlank(userPwd)) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Username or password should not be empty");
            return resultInfo;
        }

        User existingUser = userDao.queryUserByName(userName);
        if (existingUser != null) {
            resultInfo.setCode(0);
            resultInfo.setMsg("Username already exists");
            return resultInfo;
        }

        User user = new User();
        user.setUname(userName);
        user.setUpwd(userPwd);
        int row = userDao.saveUser(user);

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
