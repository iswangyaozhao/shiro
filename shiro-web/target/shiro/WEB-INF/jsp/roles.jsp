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
	RoleName : <input type="text" name="" id="name" />
	<!--  roles : <div style="min-width:100px; display: inline-block;">
  		<input id="roles" class="easyui-tagbox" name="roleIds" style="width: auto;min-width: 100px;"  data-options="hasDownArrow:true,valueField:'id',textField:'name',url:'role/all',panelHeight:'auto',panelMaxHeight:250,multiple:true,editable:false,panelMinWidth:150">
    		</div>-->
	<a id="btn" href="javascript:void(0)" onclick="setCondition();" class="easyui-linkbutton" data-options="iconCls:'icon-search'">Search</a>
	<a id="btn" href="javascript:void(0)" onclick="resetCondition()" class="easyui-linkbutton" data-options="iconCls:'icon-undo'">Reset</a>
</div>
<table id="roleTable"  title="role List"
        data-options="url:'role/list',fitColumns:true,striped:true,rownumbers:true,iconCls:'icon-search'">
    <thead>
        <tr>
       		<th data-options="field:'tyu',checkbox:true"></th>
       		<th data-options="field:'id',width:30,sortable:true,order:'desc'">Id</th>
            <th data-options="field:'name',width:100,sortable:true">RoleName</th>
            <th data-options="field:'available',width:120,formatter:roleFormatter">available</th>
        </tr>
    </thead>
</table>
<div id="tb">
<a href="user/index" class="easyui-linkbutton"  data-options="iconCls:'icon-back',plain:true">用户管理</a>
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="add_role();" data-options="iconCls:'icon-add',plain:true">添加</a>
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="edit_role();" data-options="iconCls:'icon-edit',plain:true">修改</a>
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="delete_role();" data-options="iconCls:'icon-remove',plain:true">删除</a>
</div>
<script type="text/javascript">
	$(function(){
		$("#roleTable").datagrid({
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
		var postData = {rolename : $("#rolename").val()};
		//var ids = $("#roles").combobox("getValues");
		//for(var i = 0; i < ids.length ; i++){
		//	postData["sysRoles["+i+"].id"] = ids[i];
	//	}
		
		$("#roleTable").datagrid("reload",postData);
	}
	
	//删除选择的数据行
	function delete_role(){
		//获取要删除的数据黄
		var selRows = $("#roleTable").datagrid("getSelections");
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
				$.post("role/batchDelete",postData,function(data){
					if(data.result == true){
						//4. 删除成功后，刷新表格 reload
						$("#roleTable").datagrid("reload");
					}
				})
			}
		})
	}
	
	//添加角色
	function add_role(){
		var d = $("<div></div>").appendTo("body");
		d.dialog({
			title : "添加用户",
			iconCls : "icon-add",
			width:500,	
			height:300,
			modal:true,//是否是模态框
			href : "role/form",
			onClose:function(){$(this).dialog("destroy"); },//destroy销毁
			buttons:[{
				iconCls:"icon-ok",
				text:"确定",
				handler:function(){//点击确定按钮的操作
					$("#roleForm").form("submit",{
						url : "role/add",
						success : function(data){
							d.dialog("close");
							$("#roleTable").datagrid("reload");
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
	
	function edit_role(){
		var row = $("#roleTable").datagrid("getSelected");
		if(row == null){
			return;
		}

		//如果选中了多个，只保留row这个
		$("#roleTable").datagrid("clearSelections");
		$("#roleTable").datagrid("selectRecord",row.id);
		
		var d = $("<div></div>").appendTo("body");
		d.dialog({
			title : "编辑用户",
			iconCls : "icon-edit",
			width:500,
			height:300,
			modal:true,
			href : "role/form",
			onClose:function(){$(this).dialog("destroy"); },
			onLoad:function(){
				//发送异步请求，查询数据
				$.post("role/view",{id:row.id},function(data){
					$("#roleForm").form("load",data);
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
					$("#roleForm").form("submit",{
						url : "role/edit",
						success : function(data){
							d.dialog("close");
							$("#roleTable").datagrid("reload");
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




