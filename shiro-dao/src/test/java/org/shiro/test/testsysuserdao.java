package org.shiro.test;


import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.shiro.dao.SysRoleDao;
import org.shiro.dao.SysUserDao;
import org.shiro.pojo.SysUser;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:web-dao.xml")
public class testsysuserdao {

	@Resource
	private SysUserDao sysUserDao;
	
	
	public void setSysUserDao(SysUserDao sysUserDao) {
		this.sysUserDao = sysUserDao;
	}
	@Resource
	private SysRoleDao sysRoleDao;
	
	

	public void setSysRoleDao(SysRoleDao sysRoleDao) {
		this.sysRoleDao = sysRoleDao;
	}



	@Test
	public void test() {
		List<SysUser> list = sysUserDao.getAll();
		for (SysUser sysPermission : list) {
			System.out.println(sysPermission.getUsername());
		}
	}

}
