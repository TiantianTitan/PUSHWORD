package pushwords;

import com.pushwords.dao.BaseDao;
import com.pushwords.dao.UserDao;
import com.pushwords.dao.WordGroupDao;
import com.pushwords.po.User;
import com.pushwords.po.WordGroup;
import org.junit.Test;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TestUser {

    @Test
    public void testQueryUserByName() throws SQLException {
        UserDao userDao = new UserDao();
        User user = userDao.queryUserByName("admin");
        System.out.println(user.getHead());
    }

    @Test
    public void testQueryGroupByName() throws SQLException {
        WordGroupDao wordGroupDao = new WordGroupDao();
        List<WordGroup> wordGroups = wordGroupDao.findGroupListByUserId(1);
        for(WordGroup wordGroup: wordGroups){
            System.out.println(wordGroup.getGroupId());
            System.out.println(wordGroup.getGroupName());
            System.out.println(wordGroup.getGroupDescription());
            System.out.println(wordGroup.getGroupUserId());
        }
    }

    @Test
    public void testAdd(){
        String sql = "insert into tb_user (uname,upwd,nick,head,mood) values (?,?,?,?,?)";
        List<Object> params = new ArrayList<>();
        params.add("Zoe");
        params.add("abcd");
        params.add("LittleStar");
        params.add("404.jpg");
        params.add("Hello world!");
        int row = BaseDao.executeUpdate(sql,params);
        System.out.println(row);
    }



}
