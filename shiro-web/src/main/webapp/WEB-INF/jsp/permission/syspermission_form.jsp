<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
$(function(){
	$("#parent").hide();
		$("#level").combobox({
			onChange: function (n,o) {
				if(n == 1){
					$("#parent").hide();
				}
				if(n == 2){
					$("#parent").show();
				}
			}
		})
})

</script>

	<form action="" id="permissionForm" method="post">
		<input type="hidden" name="id" />
		<p>
			PerMissionName : <input type="text" name="text" class="easyui-validatebox"  />
		</p>
		<p>
			Type : <input class="easyui-combobox" name="type" style="width: auto;min-width: 100px;" 
			 data-options="hasDownArrow:true,valueField:'type',textField:'type',url:'permission/type',panelHeight:'auto',panelMaxHeight:250,panelMinWidth:150">
		</p>
		<p>
			Url: <input type="text" name="url"  />
		</p>
		<p>
			level:<input id="level" class="easyui-combobox" name="level" style="width: auto;min-width: 100px;" 
			 data-options="hasDownArrow:true,valueField:'level',textField:'level',url:'permission/level',panelHeight:'auto',editable:false,panelMaxHeight:250,panelMinWidth:150">
		</p>
		<p id="parent">
			parent:<input id="parentid" class="easyui-combobox" name="parentid" style="width: auto;min-width: 100px;" 
			 data-options="hasDownArrow:true,valueField:'id',textField:'text',url:'permission/list',panelHeight:'auto',editable:false,panelMaxHeight:250,panelMinWidth:150">
		</p>
		<p>
			Available : <input name="available" value="1" class="easyui-switchbutton" data-options="onText:'Yes',offText:'No'">
		</p>
		<!--  
		<p>
		Roles : <input id="roles_form" class="easyui-tagbox" name="roleIds"
    		data-options="hasDownArrow:true,valueField:'id',textField:'name',url:'role/all',panelHeight:'auto',panelMaxHeight:250,multiple:true,editable:false,panelMinWidth:150">
		</p>
		-->
	</form>
</body>

</html>






