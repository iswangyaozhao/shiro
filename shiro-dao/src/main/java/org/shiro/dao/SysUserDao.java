package org.shiro.dao;

import org.apache.ibatis.annotations.Param;
import org.shiro.pojo.SysUser;
import org.shiro.dao.CommonDao;

public interface SysUserDao extends CommonDao<SysUser, Integer>{

	/**
	 * 根据用户名查询用户信息
	 * @param username
	 * @return
	 */
	public SysUser getByUsername(@Param("username") String username);
	
	public void addUserRole(@Param("userId") Integer userId,@Param("roleIds") Integer[] roleIds);
	
	public void deleteRelationByUserId(Integer userId);
}
