package org.shiro.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.shiro.crypto.hash.Md5Hash;
import org.shiro.dao.SysPermissionDao;
import org.shiro.dao.SysUserDao;
import org.shiro.pojo.SysPermission;
import org.shiro.pojo.SysUser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/user")
public class SysUserController {

	@Resource
	private SysUserDao sysUserDao;
	
	@Resource
	private SysPermissionDao sysPermissionDao;
	
	public void setSysPermissionDao(SysPermissionDao sysPermissionDao) {
		this.sysPermissionDao = sysPermissionDao;
	}

	public void setSysUserDao(SysUserDao sysUserDao) {
		this.sysUserDao = sysUserDao;
	}
	
	@RequestMapping("/index")
	public String index() throws Exception{
		return "user/index";
	}
	@RequestMapping("/main")
	public String main() throws Exception{
		return "main";
	}
	@RequestMapping("/form")
	public String form() throws Exception{
		return "user/sysuser_form";
	}
	@RequestMapping(value="login",method=RequestMethod.GET)
	public String login() throws Exception{
		return "login";
	}
	@RequestMapping(value="login",method=RequestMethod.POST)
	public String login(String username, String password, ModelMap modelMap, HttpSession session) throws Exception{
		
		SysUser sysUser = sysUserDao.getByUsername(username);
		if (sysUser != null) {
			Md5Hash md5Hash = new Md5Hash(password,sysUser.getSalt());
			if (md5Hash.toString().equals(sysUser.getPassword())) {
				//查询登录用户拥有的所有权限菜单
				List<SysPermission> permissionList = sysPermissionDao.getPermissionsByUserId(sysUser.getId(), "menu");
				//查询用户所拥有的所有的功能编码.getPermissionCodeByUserId(sysUser.getId());
				List<SysPermission> percodes = sysPermissionDao.getPermissionCodeByUserId(sysUser.getId());
				session.setAttribute("percodes", percodes.toString());
				session.setAttribute("permissions", permissionList);
				session.setAttribute("login_user", sysUser);
				return "redirect:/user/main";
			}
		}
		modelMap.put("error", "用户名或者密码错误！");
		return "login";
	}
	
	@RequestMapping("/logout")
	public String Logout(HttpSession session) throws Exception {
		session.removeAttribute("login_user");
		session.removeAttribute("permissions");
		return "redirect:/user/login";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Map<String, Object> list(@RequestParam(defaultValue="1")Integer page, @RequestParam(defaultValue="10")Integer rows,@RequestParam(defaultValue="id") String sort,@RequestParam(defaultValue="asc") String order,SysUser condition) throws Exception{
		Map<String, Object> map = new HashMap<>();
		int start = (page - 1) * rows;
		List<SysUser> list = sysUserDao.getListByCondition(start, rows, condition, sort, order);
		int total = sysUserDao.getCountByCondition(condition);
		map.put("rows", list);
		map.put("total", total);
		return map;
	}
	
	@RequestMapping(value="batchDelete",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> batchDelete(Integer [] ids) throws Exception{
		Map<String, Object> map = new HashMap<>();
		sysUserDao.deleteByIds(ids);
		map.put("result", true);
		return map;
	}
	@RequestMapping(value="add",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> add(SysUser user,Integer[] roleIds) throws Exception{
		Map<String, Object> map = new HashMap<>();
		//对密码进行加密存储
		Md5Hash md5Hash = new Md5Hash(user.getPassword(), user.getSalt());
		user.setPassword(md5Hash.toString());
		sysUserDao.add(user);
		sysUserDao.addUserRole(user.getId(), roleIds);
		map.put("result", true);
		return map;
	}
	@RequestMapping(value="edit",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> edit(SysUser user,Integer[] roleIds) throws Exception{
		Map<String, Object> map = new HashMap<>();
		//对密码进行加密存储
		Md5Hash md5Hash = new Md5Hash(user.getPassword(), user.getSalt());
		user.setPassword(md5Hash.toString());
		sysUserDao.update(user);
		sysUserDao.addUserRole(user.getId(), roleIds);
		map.put("result", true);
		return map;
	}
	
	@RequestMapping("/view")
	@ResponseBody
	public SysUser view(Integer id) throws Exception {
		return sysUserDao.getById(id);
	}
	
	
}
