package com.pushwords.dao;

import com.pushwords.po.User;
import com.pushwords.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * UserDao handles database operations related to the User entity.
 */
public class UserDao {

    /**
     * Queries a user by their username.
     *
     * @param userName the username to query by
     * @return the User object corresponding to the username
     */
    public User queryUserByName(String userName) {
        String sql = "select * from tb_user where uname = ?";
        List<Object> params = new ArrayList<>();
        params.add(userName);

        User user = (User) BaseDao.queryRow(sql, params, User.class);

        return user;
    }

    /**
     * Queries a user by their username using direct database operations.
     *
     * @param userName the username to query by
     * @return the User object corresponding to the username
     */
    public User queryUserByName02(String userName) {
        User user = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DBUtil.getConnection();

            String sql = "select * from tb_user where uname = ?";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, userName);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                user = new User();
                user.setUserId(resultSet.getInt("userId"));
                user.setUname(userName);
                user.setHead(resultSet.getString("head"));
                user.setMood(resultSet.getString("mood").trim());
                user.setNick(resultSet.getString("nick"));
                user.setUpwd(resultSet.getString("upwd"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(resultSet, preparedStatement, connection);
        }
        return user;
    }

    /**
     * Queries a user by their nickname and user ID.
     *
     * @param nick the nickname to query by
     * @param userId the user ID to exclude from the results
     * @return the User object corresponding to the nickname and user ID
     */
    public User queryUserByNickAndUserId(String nick, Integer userId) {
        String sql = "select * from tb_user where nick = ? and userId != ?";
        List<Object> params = new ArrayList<>();
        params.add(nick);
        params.add(userId);
        return (User) BaseDao.queryRow(sql, params, User.class);
    }

    /**
     * Updates the user's information in the database.
     *
     * @param user the User object containing updated information
     * @return the number of rows affected by the update
     */
    public int updateUser(User user) {
        String sql = "update tb_user set nick = ?, mood = ?, head = ? where userId = ?";

        List<Object> params = new ArrayList<>();
        params.add(user.getNick());
        params.add(user.getMood().trim());
        params.add(user.getHead());
        params.add(user.getUserId());

        return BaseDao.executeUpdate(sql, params);
    }

    /**
     * Saves a new user to the database.
     *
     * @param user the User object to be saved
     * @return the number of rows affected by the insert
     */
    public int saveUser(User user) {
        String sql = "insert into tb_user (uname, upwd) values (?, ?)";
        List<Object> params = new ArrayList<>();
        params.add(user.getUname());
        params.add(user.getUpwd());
        return BaseDao.executeUpdate(sql, params);
    }

}
