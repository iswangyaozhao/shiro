<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="org.${projectName}.dao.${pojoName}Dao">
	<insert id="add" parameterType="org.${projectName}.pojo.${pojoName}"
		useGeneratedKeys="true" keyColumn="id" keyProperty="id">
		insert into ${table_name}(<#list columnNames as c>${c}<#if c_has_next>,</#if></#list>)
			values(<#list columnNames as c>${jing}{${c}}<#if c_has_next>,</#if></#list>)
	</insert>
	
	<update id="update" parameterType="org.${projectName}.pojo.${pojoName}">
		update ${table_name} set <#list columnNames as c>${c} = ${jing}{${c}}<#if c_has_next>,</#if></#list>
			where id = ${jing}{id}
	</update>
	
	<delete id="deleteByIds" parameterType="java.lang.reflect.Array">
		delete from ${table_name} where id in
		<foreach collection="array" item="item" open="(" close=")" separator=",">
			${jing}{item}
		</foreach>
	</delete>

	<sql id="conditionSql">
		<if test="condition != null">
			<where>
			</where>
		</if>
	</sql>
	
	<select id="getAll" resultType="org.${projectName}.pojo.${pojoName}">
		select * from ${table_name}
	</select>
	
	<select id="getById" parameterType="int" resultType="org.${projectName}.pojo.${pojoName}">
		select * from ${table_name} where id = ${jing}{id}
	</select>
	
	<select id="getListByCondition" resultType="org.${projectName}.pojo.${pojoName}">
		select * from ${table_name}
			<include refid="conditionSql"></include>
		order by ${dao}{column} ${dao}{orderBy}
			limit ${jing}{start},${jing}{limit}
	</select>
	<select id="getCountByCondition" resultType="int">
		select count(1) from ${table_name}
			<include refid="conditionSql"></include>
	</select>
</mapper>