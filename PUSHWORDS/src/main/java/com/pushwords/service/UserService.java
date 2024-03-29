package com.pushwords.service;

import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.digest.DigestUtil;
import com.pushwords.dao.UserDao;
import com.pushwords.po.User;
import com.pushwords.vo.ResultInfo;

import java.sql.SQLException;

public class UserService {

    private final UserDao userDao = new UserDao();

    public ResultInfo<User> userLogin(String userName, String userPwd)  {
        ResultInfo<User> resultInfo = new  ResultInfo<>();


        User u = new User();
        u.setUname(userName);
        u.setUpwd(userPwd);
        resultInfo.setResult(u);

        // Judge the userName or userPwd
        if(StrUtil.isBlank(userName) || StrUtil.isBlank(userPwd)){
            resultInfo.setCode(0);

            resultInfo.setMsg("Username or password should not be empty");
            return resultInfo;
        }

        User user = userDao.queryUserByName(userName);


        if(user == null){

            resultInfo.setCode(0);
            resultInfo.setMsg("userName not found!");
            return resultInfo;
        }

        //userPwd = DigestUtil.md5Hex(userPwd);
        if(!userPwd.equals(user.getUpwd())){

            resultInfo.setCode(0);
            resultInfo.setMsg("password incorrect!");
            return resultInfo;
        }


        resultInfo.setCode(1);
        resultInfo.setResult(user);
        return  resultInfo;

    }

    public Integer checkNick(String nick, Integer userId) {
        if(StrUtil.isBlank(nick)){
            return 0;
        }
        User user = userDao.queryUserByNickAndUserId(nick,userId);

        if(user != null){
            return 0;
        }
        return 1;
   }
}
