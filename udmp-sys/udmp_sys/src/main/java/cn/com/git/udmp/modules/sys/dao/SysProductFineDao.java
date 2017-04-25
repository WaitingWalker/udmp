

package cn.com.git.udmp.modules.sys.dao;

import cn.com.git.udmp.common.persistence.CrudDao;
import cn.com.git.udmp.common.persistence.annotation.MyBatisDao;
import cn.com.git.udmp.modules.sys.entity.SysProductFine;

/**
 * 罚息管理DAO接口
 * @author 赵明辉
 * @version 2015-11-18
 */
@MyBatisDao
public interface SysProductFineDao extends CrudDao<SysProductFine> {
	
}