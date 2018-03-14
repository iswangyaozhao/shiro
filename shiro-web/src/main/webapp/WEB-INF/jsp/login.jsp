<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>大驼队cTMS协同运输管理系统登录</title>
<link rel="stylesheet" href="css/login.css">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<script src="easyui/jquery.min.js"></script>

<style type="text/css">
/*media all*/
.full-compatable {
	margin: 20px 0;
	text-align: center;
	height: 40px;
	line-height: 40px;
	color: #444444;
	font-size: 16px;
	background-color: yellow;
}
</style>
</head>
<body>
	<div class="login-box">
		<div class="big-logo"></div>
		<div class="box-content">
			<form id="form1" name="form1" action="user/login" method="post">
				<div class="row">
					<div class="input-group">
						<div class="input-group-addon">
							<i class="fa fa-user"></i>
						</div>
						<input id="userName" name="username" tabindex="1" value="" class="form-control" autocomplete="off" placeholder="请输入账号">
							<input type="hidden">
					</div>
				</div>
				<div class="row">
					<div class="input-group">
						<div class="input-group-addon">
							<i class="fa fa-unlock-alt"></i>
						</div>
						<input id="userPass" name="password" tabindex="2" type="password" value="" class="form-control" placeholder="请输入密码">
					</div>
				</div>
				<div class="row flex-row">
					<div class="left-block">
						<div class="input-group">
							<div class="input-group-addon">
								<i class="fa fa-pencil"></i>
							</div>
							<input id="veriCode" value="" name="veriCode" tabindex="3" class="form-control" placeholder="请输入右侧验证码">
						</div>
					</div>
					<div class="right-block">
						<img align="bottom" id="imgVeriCodePic" src="./大驼队cTMS协同运输管理系统登录_files/veriCodePic.action.下载" onclick="this.src=&#39;/veriCodePic.action?dt=&#39;+new Date().getSeconds()">
					</div>
				</div>

				<div class="row flex-row btn-row">
					<div class="left-block">
						<button class="btn btn-info" type="submit" id="BtnSave">登录</button>
					</div>
				</div>
				<div class="row alert-row">
					<p class="text-danger" id="error">
						${error }
					</p>
				</div>
			</form>
		</div>
	</div>

</body></html>