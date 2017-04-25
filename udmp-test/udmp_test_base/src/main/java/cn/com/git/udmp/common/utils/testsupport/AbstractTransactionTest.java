package cn.com.git.udmp.common.utils.testsupport;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.subject.Subject;
import org.junit.Before;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.support.TransactionTemplate;

import cn.com.git.udmp.common.utils.SpringContextHolder;
import cn.com.git.udmp.modules.sys.security.UsernamePasswordToken;

/**
 * @description junit的测试基类（带事务回滚）
 * @author liuliang 
 * @date 2014年9月11日 下午2:27:39
 */
@ContextConfiguration(locations = { "classpath*:META-INF/spring*.xml" })
public abstract class AbstractTransactionTest extends AbstractTransactionalJUnit4SpringContextTests{
    /**
     * @Fields UNIT_TEST_USER : 用户代码
     */
    public static final String UNIT_TEST_USER = "DEMO";
    /**
     * @Fields transactionTemplate : TransactionTemplate
     */
    protected TransactionTemplate transactionTemplate;
    /**
     * @Fields jdbcTemplate : JdbcTemplate
     */
    protected JdbcTemplate jdbcTemplate;
    /**
     * @Fields dataSource : DataSource
     */
    protected DataSource dataSource;
    /**
     * @Fields threadPoolTaskExecutor : ThreadPoolTaskExecutor
     */
    protected ThreadPoolTaskExecutor taskExecutor;
    /**
     * @Fields context : ApplicationContext
     */
    private ApplicationContext context;
    
    
    @Autowired
    private SecurityManager securityManager;

    /**
     * @description 获取Spring Bean
     * @version 1.0
     * @title 获取Spring Bean
     * @author liuliang liuliang_wb@newchinalife.com
     * @param name
     *            bean名称
     * @return spring配置中对应的bean实例
     */
    public Object getBean(String name) {
        if (context == null) {
            context = SpringContextHolder.getApplicationContext();
        }
        System.out.println("context:"+context==null);
        return context.getBean(name);
    }

    /**
     * @description 设置数据源
     * @version 1.0
     * @title 设置数据源
     * @author tanzhiliang tanzl_wb@newchinalife.com
     * @param dataSource
     *            数据源
     */
    @Resource(name = "dataSource")
    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    /**
     * @description 设置异步线程池
     * @version 1.0
     * @title 设置异步线程池
     * @author bihb bihb_wb@newchinalife.com
     * @param threadPoolTaskExecutor1
     *            ThreadPoolTaskExecutor
     */
//    @Resource(name = "threadPoolTaskExecutor")
//    public void setTaskExecutor(ThreadPoolTaskExecutor threadPoolTaskExecutor1) {
//        this.taskExecutor = threadPoolTaskExecutor1;
//    }

    /**
     * @description 设置PlatformTransactionManager
     * @version 1.0
     * @title 设置PlatformTransactionManager
     * @author bihb bihb_wb@newchinalife.com
     * @param transactionManager
     *            PlatformTransactionManager
     */
    @Autowired
    public void setTransactionManager(PlatformTransactionManager transactionManager) { // 注入TransactionManager
        // 以注入的TransactionManager作为参数，获取一个TransactionTemplate实例，该实例封装了Hibernate的行为
        this.transactionTemplate = new TransactionTemplate(transactionManager);

    }

    /**
     * 重载这个方法，设置不同的测试用户
     * 
     * @description 重载这个方法，设置不同的测试用户
     * @version 1.0
     * @title 重载这个方法，设置不同的测试用户
     * @author liuliang liuliang_wb@newchinalife.com
     * @return 测试用户名
     */
    protected String getTestUserName() {
        return UNIT_TEST_USER;
    }

    /**
     * @description 初始化方法
     * @version 1.0
     * @title 初始化方法
     * @author liuliang liuliang_wb@newchinalife.com
     */
    @Before
    public void setupAbstractTest() {
        bindAppUser();
    }

    /**
     * @description Bind current user to current thread
     * @version 1.0
     * @title Bind current user to current thread
     * @author liuliang liuliang_wb@newchinalife.com
     */
    private void bindAppUser() {
//        User user = userSvc.getByUsername(String.valueOf(principal));
//        String password = user.getPassword();
//        UsernamePasswordToken token = new UsernamePasswordToken(user.getUsername(), password);
//        token.setRememberMe(true);
        SecurityUtils.setSecurityManager(securityManager);
        Subject subject= SecurityUtils.getSubject();
        String username = "thinkgem";
        String password =  "admin";
        UsernamePasswordToken token  = new UsernamePasswordToken(username, password.toCharArray(), true, "", "", false);
        subject.login(token);//登录
        logger.info("=============登录完成==============");
    }

    public void setTransactionTemplate(TransactionTemplate transactionTemplate) {
        this.transactionTemplate = transactionTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public void setTaskExecutor(ThreadPoolTaskExecutor taskExecutor) {
        this.taskExecutor = taskExecutor;
    }

    public void setContext(ApplicationContext context) {
        this.context = context;
    }


    public void setSecurityManager(SecurityManager securityManager) {
        this.securityManager = securityManager;
    }

}
