<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form action="" id="userForm" method="post">
		<input type="hidden" name="id" />
		<p>
			Username : <input type="text" name="username" class="easyui-validatebox"  />
		</p>
		<p>
			Password : <input type="text" name="password" class="easyui-validatebox"  />
		</p>
		<p>
			Salt: <input type="text" name="salt" id="" />
		</p>
		<p>
			Locked : <input name="locked" value="1" class="easyui-switchbutton" data-options="onText:'Yes',offText:'No'">
		</p>
		<p>
		Roles : <input id="roles_form" class="easyui-tagbox" name="roleIds"
    		data-options="hasDownArrow:true,valueField:'id',textField:'name',url:'role/all',panelHeight:'auto',panelMaxHeight:250,multiple:true,editable:false,panelMinWidth:150">
		</p>
	</form>
</body>
</html>






