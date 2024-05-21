package com.pushwords.dao;

import com.pushwords.po.User;
import com.pushwords.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDao {

    public User queryUserByName(String userName) {

        String sql = "select * from tb_user where uname = ?";
        List<Object> params = new ArrayList<>();
        params.add(userName);

        User user =(User) BaseDao.queryRow(sql,params,User.class);

        return  user;
    }

    public User queryUserByName02(String userName) {
        User user = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DBUtil.getConnection();

            String sql = "select * from tb_user where uname = ?";

            preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setString(1,userName);

            resultSet = preparedStatement.executeQuery();

            if(resultSet.next()){
                user = new User();
                user.setUserId(resultSet.getInt("userId"));
                user.setUname(userName);
                user.setHead(resultSet.getString("head"));
                user.setMood(resultSet.getString("mood").trim());
                user.setNick(resultSet.getString("nick"));
                user.setUpwd(resultSet.getString("upwd"));
            }

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DBUtil.close(resultSet,preparedStatement,connection);
        }
        return  user;
    }

    public User queryUserByNickAndUserId(String nick, Integer userId) {
        String sql = "select * from tb_user where nick = ? and userId != ?";
        List<Object> params = new ArrayList<>();
        params.add(nick);
        params.add(userId);
        return (User) BaseDao.queryRow(sql,params,User.class);
    }

    public int updateUser(User user) {
        String sql = "update tb_user set nick = ?, mood = ?, head = ? where userId = ?";

        List<Object> params = new ArrayList<>();
        params.add(user.getNick());
        params.add(user.getMood().trim());
        params.add(user.getHead());
        params.add(user.getUserId());

        return BaseDao.executeUpdate(sql,params);
    }
}
