package org.shiro.test;

import org.freemarker.utils.ProjectUtils;
import org.shiro.pojo.SysPermission;

public class addDaoAndMapper {

	public static void main(String[] args) throws Exception {
		ProjectUtils.setClasses(new Class[] {SysPermission.class});
		ProjectUtils.setProjectName("shiro");
		ProjectUtils.setProjectNamee("shiro");
		//ProjectUtils.generateDaoInterface();
		//ProjectUtils.generateMappers();
		
	}

}
