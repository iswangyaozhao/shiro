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
	$.post("role/takePermissions",{roleId: ${roleId } },function(d){
		$("#assignTree").tree({
			lines : true,
			loadFilter : function(data){
				$.each(data,function(){
					//遍历子节点
					$.each(this.children,function(){
						if($.inArray(this.id,d) != -1){
							this.checked = true;
						}
					});
				});
				return data;
			}
		});
	});
});
</script>

<ul id="assignTree" data-options="url:'permission/list',checkbox:true"></ul>
</body>
</html>



