package org.shiro.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.shiro.dao.SysPermissionDao;
import org.shiro.pojo.SysPermission;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/permission")
public class SysPermissionController {

	@Resource
	private SysPermissionDao sysPermissionDao;

	public void setSysPermissionDao(SysPermissionDao sysPermissionDao) {
		this.sysPermissionDao = sysPermissionDao;
	}
	
	@RequestMapping("/index")
	public String index() throws Exception{
		return "permission/permission";
	}
	@RequestMapping("/form")
	public String form() throws Exception{
		return "permission/syspermission_form";
	}
	
	
	@RequestMapping("/list")
	@ResponseBody
	public List<SysPermission> list() throws Exception{
		return sysPermissionDao.getAll();
	}
	
	@RequestMapping(value="batchDelete",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> batchDelete(Integer [] ids) throws Exception{
		Map<String, Object> map = new HashMap<>();
		sysPermissionDao.deleteByIds(ids);
		map.put("result", true);
		return map;
	}
	@RequestMapping(value="add",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> add(SysPermission permission,Integer[] roleIds) throws Exception{
		Map<String, Object> map = new HashMap<>();
		sysPermissionDao.add(permission);
		map.put("result", true);
		return map;
	}
	@RequestMapping(value="edit",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> edit(SysPermission permission,Integer[] roleIds) throws Exception{
		Map<String, Object> map = new HashMap<>();
		sysPermissionDao.update(permission);
		map.put("result", true);
		return map;
	}
	@RequestMapping("/view")
	@ResponseBody
	public SysPermission view(Integer id) throws Exception {
		return sysPermissionDao.getById(id);
	}
	
	@RequestMapping(value="/type",method=RequestMethod.POST)
	@ResponseBody
	public List<SysPermission> type() throws Exception{
		return sysPermissionDao.getPermissionType();
	}
	@RequestMapping(value="/level",method=RequestMethod.POST)
	@ResponseBody
	public List<SysPermission> level() throws Exception{
		return sysPermissionDao.getPermissionLevel();
	}
}
