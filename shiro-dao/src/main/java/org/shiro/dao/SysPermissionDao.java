package org.shiro.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.shiro.pojo.SysPermission;

public interface SysPermissionDao extends CommonDao<SysPermission, Integer>{
	/**
	 * 根据角色id获取权限id
	 * @param roleId
	 * @return
	 */
	public List<Integer> getPermissionIdsByRoleId(Integer roleId);
	
	/**
	 * 根据角色id删除权限
	 * @param roleId
	 */
	public void deletePermissionsByRoleId(Integer roleId);
	
	/**
	 * 根据父级id来查询所拥有的子权限
	 * @param parentid
	 * @return
	 */
	public List<SysPermission> getPermissionByParentId(Integer parentid);
	
	/**
	 * 根据角色id添加权限
	 * @param roleId
	 * @param perIds
	 */
	public void addRolePermissions(@Param("roleId") Integer roleId,@Param("perIds") List<Integer> perIds);
	
	/**
	 * 获取数据库中已有的Type
	 * @return
	 */
	public List<SysPermission> getPermissionType();
	
	/**
	 * 获取数据库中已有的level
	 * @return
	 */
	public List<SysPermission> getPermissionLevel();
	
	public List<SysPermission> getPermissionsByUserId(@Param("userId") Integer userId,@Param("type") String type);
	
	public List<SysPermission> getPermissionCodeByUserId(Integer userId);
}
