<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="zh">
<head>
	<%
		pageContext.setAttribute("APP_PATH", request.getContextPath());
	%>
	<meta charset="UTF-8">
	<title>登录页面</title>
	<link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.css" rel="stylesheet">
	<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/layer/3.1.0/layer.js"></script>
	<link rel="stylesheet" type="text/css" href="${APP_PATH}/WEB-INF/classes/static/css/common.css">
    <link rel="stylesheet" type="text/css" href="../css/common.css">
</head>
<body>
	<!-- 导航栏-->
	<%@include file="include/navigator.jsp" %>

	<div class="container container-small">
		<h1>登陆
			<small>没有账号?
				<a href="${pageContext.request.contextPath}/signup2">赶紧注册</a>
			</small>
		</h1>
		<form action="${pageContext.request.contextPath}/login" method="post">
			<div class="form-group">
				<label>用户名</label>
				<input type="text" name="username" class="form-control">
			</div>
			<div class="form-group">
				<label>密码</label>
				<input type="password" name ="password" class="form-control">
			</div>
			<button type="submit" class="btn btn-primary btn-block">登陆</button>
		</form>
	</div>
</body>
</html>
<script type="text/javascript">
	$(function () {
       var authError = window.location.href.indexOf('authError');
        if (authError>0){
            layer.msg("用户名或密码不正确",{time:1000,shade: [0.3, '#000']});
		}
    })


</script>