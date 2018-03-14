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

</head>
<body>
<div class="easyui-panel" title="设置查询条件" style="padding:15px 10px;">
	username : <input type="text" name="" id="username" />
	roles : <div style="min-width:100px; display: inline-block;">
  		<input id="roles" class="easyui-tagbox" name="roleIds" style="width: auto;min-width: 100px;"  data-options="hasDownArrow:true,valueField:'id',textField:'name',url:'role/all',panelHeight:'auto',panelMaxHeight:250,multiple:true,editable:false,panelMinWidth:150">
    		</div>
	<a id="btn" href="javascript:void(0)" onclick="setCondition();" class="easyui-linkbutton" data-options="iconCls:'icon-search'">Search</a>
	<a id="btn" href="javascript:void(0)" onclick="resetCondition()" class="easyui-linkbutton" data-options="iconCls:'icon-undo'">Reset</a>
</div>
<table id="userTable"  title="User List"
        data-options="url:'user/list',fitColumns:true,striped:true,rownumbers:true,iconCls:'icon-search'">
    <thead>
        <tr>
        		<th data-options="field:'tyu',checkbox:true"></th>
        		<th data-options="field:'id',width:30,sortable:true,order:'desc'">Id</th>
            <th data-options="field:'username',width:100,sortable:true">Username</th>
           <!-- <th data-options="field:'password',width:200">Password</th> -->
            <th data-options="field:'salt',width:100">Salt</th>
            <th data-options="field:'sysRoles',width:120,formatter:roleFormatter">Roles</th>
        </tr>
    </thead>
</table>
<div id="tb">
<a href="role/roles" class="easyui-linkbutton"  data-options="iconCls:'icon-back',plain:true">角色管理</a>
<a href="permission/index" class="easyui-linkbutton"  data-options="iconCls:'icon-back',plain:true">权限管理</a>
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="add_user();" data-options="iconCls:'icon-add',plain:true">添加</a>
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="edit_user();" data-options="iconCls:'icon-edit',plain:true">修改</a>
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="delete_user();" data-options="iconCls:'icon-remove',plain:true">删除</a>
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true">导出</a>
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-sum',plain:true">批量导入</a>
</div>
<script type="text/javascript">
	$(function(){
		$("#userTable").datagrid({
			pagination : true,
			toolbar : "#tb",
			idField : "id"
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
	
	//删除选择的数据行
	function delete_user(){
		//获取要删除的数据黄
		var selRows = $("#userTable").datagrid("getSelections");
		if(selRows.length == 0){
			$.messager.alert("提示","请选择要删除的数据行！","warning");
			return;
		}
		$.messager.confirm("提示","确定要删除选中的数据吗？",function(d){
			if(d){
				var postData = "";
				$.each(selRows,function(i){
					postData += "ids="+this.id;
					if(i < selRows.length - 1){
						postData += "&";
					}
				});
				$.post("user/batchDelete",postData,function(data){
					if(data.result == true){
						//4. 删除成功后，刷新表格 reload
						$("#userTable").datagrid("reload");
					}
				})
			}
		})
	}
	
	//添加用户
	function add_user(){
		var d = $("<div></div>").appendTo("body");
		d.dialog({
			title : "添加用户",
			iconCls : "icon-add",
			width:500,	
			height:300,
			modal:true,//是否是模态框
			href : "user/form",
			onClose:function(){$(this).dialog("destroy"); },//destroy销毁
			buttons:[{
				iconCls:"icon-ok",
				text:"确定",
				handler:function(){//点击确定按钮的操作
					$("#userForm").form("submit",{
						url : "user/add",
						success : function(data){
							d.dialog("close");
							$("#userTable").datagrid("reload");
						}
					});
				}
			},{
				iconCls:"icon-cancel",
				text:"取消",
				handler:function(){
					d.dialog("close");
				}
			}]
		});
	}
	
	function edit_user(){
		var row = $("#userTable").datagrid("getSelected");
		if(row == null){
			return;
		}

		//如果选中了多个，只保留row这个
		$("#userTable").datagrid("clearSelections");
		$("#userTable").datagrid("selectRecord",row.id);
		
		var d = $("<div></div>").appendTo("body");
		d.dialog({
			title : "编辑用户",
			iconCls : "icon-edit",
			width:500,
			height:300,
			modal:true,
			href : "user/form",
			onClose:function(){$(this).dialog("destroy"); },
			onLoad:function(){
				//发送异步请求，查询数据
				$.post("user/view",{id:row.id},function(data){
					$("#userForm").form("load",data);
					var roles = new Array();
					$.each(data.sysRoles,function(){
						roles.push(this.id);
					});
					$("#roles_form").combobox("setValues",roles);
				});
			},
			buttons:[{
				iconCls:"icon-ok",
				text:"确定",
				handler:function(){
					$("#userForm").form("submit",{
						url : "user/edit",
						success : function(data){
							d.dialog("close");
							$("#userTable").datagrid("reload");
						}
					});
				}
			},{
				iconCls:"icon-cancel",
				text:"取消",
				handler:function(){
					d.dialog("close");
				}
			}]
		});
	}
</script>
</body>
</html>




