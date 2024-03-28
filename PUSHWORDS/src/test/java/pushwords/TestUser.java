package pushwords;

import com.pushwords.dao.UserDao;
import com.pushwords.po.User;
import org.junit.Test;

import java.sql.SQLException;

public class TestUser {

    @Test
    public void testQueryUserByName() throws SQLException {
        UserDao userDao = new UserDao();
        User user = userDao.queryUserByName("admin");
        System.out.println(user.getUpwd());
    }


}
