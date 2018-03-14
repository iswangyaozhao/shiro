package org.shiro.dao;

import org.shiro.pojo.SysRole;
import org.shiro.dao.CommonDao;

public interface SysRoleDao extends CommonDao<SysRole, Integer> {

	public void delSysUserRoleByRoleId(Integer [] ids);
}
