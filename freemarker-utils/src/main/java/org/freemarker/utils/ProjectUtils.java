package org.freemarker.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import freemarker.template.Configuration;
import freemarker.template.Template;

public class ProjectUtils {

	private static Class[] classes; //要生成相应模块的实体类
	private static String projectName ;
	private static String projectNamee;
	private static Configuration configuration = new Configuration(Configuration.VERSION_2_3_23);
	private static Map<String, Object> model = new HashMap<>(); //模型数据
	
	public static void setClasses(Class[] clazzes) {
		ProjectUtils.classes = clazzes;
	}
	
	
	public static void setProjectName(String projectName) {
		ProjectUtils.projectName = projectName;
	}

	public static void setProjectNamee(String projectName) {
		
		ProjectUtils.projectNamee = projectName.replace(".", "/");;
	}


	/**
	 * FreeMarker框架的配置
	 */
	static {
		try {
			configuration.setDirectoryForTemplateLoading(new File("src/main/resources"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		configuration.setDefaultEncoding("utf-8");
		
		//准备模型数据
		model.put("projectName", projectName+"");
		model.put("jing", "#");
		model.put("dao", "$");
		
	}
	
	/**
	 * 生成dao接口
	 */
	public static void generateDaoInterface() throws Exception{
		Template template = configuration.getTemplate("dao.ftl");
		System.out.println(projectName);
		//根据传入的 classes 来批量生成dao接口
		if (classes == null) {
			return;
		}
		for (Class clazz : classes) {
			model.put("pojoName", clazz.getSimpleName());
			Field[] fields = clazz.getDeclaredFields();
			String pkType = "Integer";
			for (Field field : fields) {
				if (field.getAnnotations().length > 0) {
					if(field.getAnnotations()[0].annotationType() == Resource.class) {
						pkType = field.getType().getSimpleName();
					}
				}
			}
			model.put("pkType", pkType);
			
			//输出到对应的目录
			File file = new File("src/main/java/org/"+projectNamee+"/dao/"+clazz.getSimpleName()+"Dao.java");
			if (file.exists() == false) {
				file.createNewFile();
			}
			Writer out = new OutputStreamWriter(new FileOutputStream(file));
			template.process(model, out);
			
			System.out.println("generate" + clazz.getSimpleName() + "Dao.java success!") ;
		}
	}
	
	/**
	 * 生成 sql mapper files
	 */
	public static void generateMappers() throws Exception{
		Template template = configuration.getTemplate("mapper.ftl");
		
		//根据传入的 classes 来批量生成dao接口
		if (classes == null) {
			return;
		}
		for (Class clazz : classes) {
			model.put("pojoName", clazz.getSimpleName());
			//根据类名自动计算出表名 SysUser --> sys_user
			StringBuffer sb = new StringBuffer(clazz.getSimpleName());
			
			char[] array = clazz.getSimpleName().toCharArray();
			for (int i = 1; i < array.length; i++) {
				char c = array[i];
				boolean isUpper = Character.isUpperCase(c);
				if (isUpper) {
					sb.insert(i, "_");
				}
			}
			model.put("table_name", sb.toString());
			
			List<String> columnNames = new ArrayList<>();
			Field[] fields = clazz.getDeclaredFields();
			String pkType = "Integer";
			for (Field field : fields) {
					if(field.getAnnotations().length > 0 && field.getAnnotations()[0].annotationType() == Resource.class) {
						pkType = field.getType().getSimpleName();
					}else {
						columnNames.add(field.getName());
					}
			}
			model.put("columnNames", columnNames);
			
			//输出到对应的目录
			File file = new File("src/main/java/org/"+projectNamee+"/mappers/"+clazz.getSimpleName()+"Mapper.xml");
			if (file.exists() == false) {
				file.createNewFile();
			}
			Writer out = new OutputStreamWriter(new FileOutputStream(file));
			template.process(model, out);
			
			System.out.println("generate" + clazz.getSimpleName() + "Mapper.xml success!") ;
		}
	}
}
