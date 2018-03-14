<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<base href="<%=basePath%>">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" type="text/css" href="easyui/themes/material/easyui.css"/>
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css"/>
<script type="text/javascript">
	$(function(){
		$("#userTable").datagrid({
			pagination : true
		});
	})
	
	function roleFormatter(value,row,index){
		if(value.length == 0){
			return "-";
		}
		var str = "";
		for(var i = 0; i < value.length; i++){
			str += value[i].name;
			if(i < value.length -1){
				str += ", ";
			}
		}
		console.log(value)
		return str;
	}

	function setCondition(){
		var postData = {username : $("#username").val()};
		var ids = $("#roles").combobox("getValues");
		for(var i = 0; i < ids.length ; i++){
			postData["sysRoles["+i+"].id"] = ids[i];
		}
		
		$("#userTable").datagrid("reload",postData);
	}
</script>
</head>
<body>
<div class="easyui-panel" title="设置查询条件" style="padding:15px 10px;">
	username : <input type="text" name="" id="username" />
	roles : 
	<input id="roles" class="easyui-combobox" name="dept"
    		data-options="valueField:'id',textField:'name',url:'role/all',panelHeight:'auto',panelMaxHeight:250,multiple:true">
	<a id="btn" href="javascript:void(0)" onclick="setCondition();" class="easyui-linkbutton" data-options="iconCls:'icon-search'">Search</a>
	<a id="btn" href="javascript:void(0)" onclick="resetCondition()" class="easyui-linkbutton" data-options="iconCls:'icon-undo'">Reset</a>
</div>
<table id="userTable"  title="User List"
        data-options="url:'users/list',fitColumns:true,striped:true,rownumbers:true,iconCls:'icon-search'">
    <thead>
        <tr>
        		<th data-options="field:'tyu',checkbox:true"></th>
        		<th data-options="field:'id',width:30,sortable:true,order:'desc'">Id</th>
            <th data-options="field:'username',width:100,sortable:true">Username</th>
            <th data-options="field:'password',width:200">Password</th>
            <th data-options="field:'salt',width:100">Salt</th>
            <th data-options="field:'sysRoles',width:120,formatter:roleFormatter">Roles</th>
        </tr>
    </thead>
</table>
</body>
</html>




