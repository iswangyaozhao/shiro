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
<table id="permissionTable"  title="Permission List"
        data-options="url:'permission/list',fitColumns:true,striped:true,rownumbers:true,iconCls:'icon-search'">
    <thead>
        <tr>
       		<th data-options="field:'tyu',checkbox:true"></th>
            <th data-options="field:'text',width:100,sortable:true">PermissionName</th>
            <th data-options="field:'available',width:120">available</th>
            <th data-options="field:'url',width:120">Url</th>
        </tr>
    </thead>
</table>
<div id="tb">
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="add_permission();" data-options="iconCls:'icon-add',plain:true">添加</a>
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="edit_permission();" data-options="iconCls:'icon-edit',plain:true">修改</a>
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="delete_permission();" data-options="iconCls:'icon-remove',plain:true">删除</a>
</div>
<script type="text/javascript">
	$(function(){
		$("#permissionTable").treegrid({
			toolbar:"#tb",
			idField:"id",
			treeField:"text",
			animate:true,
			onLoadSuccess : function(){
				//$(this).treegrid("collapseAll");
			},
			loadFilter : function(data){
				$.each(data,function(){
					this.state = "open";//closed
				});
				return data;
			}
		});
	})
	
	//删除选择的数据行
	function delete_permission(){
		//获取要删除的数据
		var selRows = $("#permissionTable").datagrid("getSelections");
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
				$.post("permission/batchDelete",postData,function(data){
					if(data.result == true){
						//4. 删除成功后，刷新表格 reload
						$("#permissionTable").datagrid("reload");
					}
				})
			}
		})
	}
	
	//添加权限
	function add_permission(){
		var d = $("<div></div>").appendTo("body");
		d.dialog({
			title : "添加权限",
			iconCls : "icon-add",
			width:400,	
			height:300,
			modal:true,//是否是模态框
			href : "permission/form",
			onClose:function(){$(this).dialog("destroy"); },//destroy销毁
			buttons:[{
				iconCls:"icon-ok",
				text:"确定",
				handler:function(){//点击确定按钮的操作
					$("#permissionForm").form("submit",{
						url : "permission/add",
						success : function(data){
							d.dialog("close");
							$("#permissionTable").datagrid("reload");
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
	
	//修改权限
	function edit_permission(){
		var row = $("#permissionTable").datagrid("getSelected");
		if(row == null){
			return;
		}
		var d = $("<div></div>").appendTo("body");
		d.dialog({
			title : "编辑权限",
			iconCls : "icon-edit",
			width:400,
			height:300,
			modal:true,
			href : "permission/form",
			onClose:function(){$(this).dialog("destroy"); },
			onLoad:function(){
				//发送异步请求，查询数据
				$.post("permission/view",{id:row.id},function(data){
					$("#permissionForm").form("load",data);
					$("#permissions_form").combobox("setValues",permissions);
				});
			},
			buttons:[{
				iconCls:"icon-ok",
				text:"确定",
				handler:function(){
					$("#permissionForm").form("submit",{
						url : "permission/edit",
						success : function(data){
							d.dialog("close");
							$("#permissionTable").datagrid("reload");
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




