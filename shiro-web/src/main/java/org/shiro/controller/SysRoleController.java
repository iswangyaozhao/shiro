package org.shiro.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.shiro.dao.SysPermissionDao;
import org.shiro.dao.SysRoleDao;
import org.shiro.pojo.SysRole;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/role")
public class SysRoleController {

	@Resource
	private SysRoleDao sysRoleDao;

	@Resource
	private SysPermissionDao sysPermissionDao;

	public void setSysPermissionDao(SysPermissionDao sysPermissionDao) {
		this.sysPermissionDao = sysPermissionDao;
	}

	public void setSysRoleDao(SysRoleDao sysRoleDao) {
		this.sysRoleDao = sysRoleDao;
	}
	
	@RequestMapping("/toAssign")
	public String toAssign(Integer rid,ModelMap modelMap) throws Exception {
		modelMap.put("roleId", rid);
		return "role/assign";
	}
	
	@RequestMapping("/takePermissions")
	@ResponseBody
	public List<Integer> selPermission(Integer roleId) throws Exception{
		return sysPermissionDao.getPermissionIdsByRoleId(roleId);
	}
	
	//授权
	@RequestMapping("/assign")
	@ResponseBody
	public Map<String, Object> assign(Integer roleId,Integer[] ids) throws Exception {
		Map<String, Object> map = new HashMap<>();
		
		sysPermissionDao.deletePermissionsByRoleId(roleId);
		sysPermissionDao.addRolePermissions(roleId, Arrays.asList(ids));
		map.put("result", true);
		return map;
	}
	
	//查询所有角色
	@RequestMapping(value="/all",method=RequestMethod.POST)
	@ResponseBody
	public List<SysRole> all() throws Exception{
		return sysRoleDao.getAll();
	}
	
	//跳转页面roles
	@RequestMapping("/roles")
	public String index() throws Exception{
		return "role/roles";
	}
	
	//role的添加和修改界面
	@RequestMapping("/form")
	public String form() throws Exception{
		return "role/sysrole_form";
	}
	
	//分页查询角色
	@RequestMapping("/list")
	@ResponseBody
	public Map<String, Object> list(@RequestParam(defaultValue="1")Integer page, @RequestParam(defaultValue="10")Integer rows,@RequestParam(defaultValue="id") String sort,@RequestParam(defaultValue="asc") String order,SysRole condition) throws Exception{
		Map<String, Object> map = new HashMap<>();
		int start = (page - 1) * rows;
		List<SysRole> list = sysRoleDao.getListByCondition(start, rows, condition, sort, order);
		int total = sysRoleDao.getCountByCondition(condition);
		map.put("rows", list);
		map.put("total", total);
		return map;
	}
	
	//批量删除角色
	@RequestMapping(value="batchDelete",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> batchDelete(Integer [] ids) throws Exception{
		Map<String, Object> map = new HashMap<>();
		sysRoleDao.delSysUserRoleByRoleId(ids);
		sysRoleDao.deleteByIds(ids);
		map.put("result", true);
		return map;
	}
	
	@RequestMapping(value="add",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> add(SysRole role) throws Exception{
		Map<String, Object> map = new HashMap<>();
		sysRoleDao.add(role);
		map.put("result", true);
		return map;
	}
	@RequestMapping(value="edit",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> edit(SysRole role) throws Exception{
		Map<String, Object> map = new HashMap<>();
		sysRoleDao.update(role);
		map.put("result", true);
		return map;
	}
	@RequestMapping("/view")
	@ResponseBody
	public SysRole view(Integer id) throws Exception {
		return sysRoleDao.getById(id);
	}
}
