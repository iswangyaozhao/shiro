package org.shiro.test;


import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.shiro.dao.SysRoleDao;
import org.shiro.pojo.SysRole;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:web-dao.xml"})
public class test {

	@Resource
	private SysRoleDao sysRoleDao;
	
	public void setSysUserDao(SysRoleDao sysRoleDao) {
		this.sysRoleDao = sysRoleDao;
	}



	@Test
	public void testGetAll() {
		List<SysRole> list = sysRoleDao.getAll();
		for (SysRole sysRole : list) {
			System.out.println(sysRole.getName());
		}
	}
	
	@Test
	public void translate(){
		String str ="王亚zhao";
		
		String tstr = "";
		try {
			tstr = new String(str.getBytes("gbk"), "gbk");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		System.out.println(tstr);
		}

	
	
}
