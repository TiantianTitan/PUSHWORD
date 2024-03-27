package pushwords;

import com.pushwords.util.DBUtil;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class TestDB {

    // user the class factory for the log
    private static Logger logger = LoggerFactory.getLogger(TestDB.class);


    // mysql -u root -p --socket=/var/run/mysqld/mysqld.sock    La commande pour démarrer le sql
    @Test
    public void testDB() {
        System.out.println(DBUtil.getConnection());
        // use log
        logger.info("Get the connection of database: " + DBUtil.getConnection());
        logger.info("Get the connection of database {} " , DBUtil.getConnection());
    }




}
