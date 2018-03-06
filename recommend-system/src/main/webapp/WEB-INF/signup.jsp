<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="zh">
<head>
	<%
		pageContext.setAttribute("APP_PATH", request.getContextPath());
	%>
	<meta charset="UTF-8">
	<title>注册页面</title>
	<link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.css" rel="stylesheet">
	<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/layer/3.1.0/layer.js"></script>
	<link rel="stylesheet" type="text/css" href="${APP_PATH}/WEB-INF/classes/static/css/common.css">
	<link rel="stylesheet" type="text/css" href="${APP_PATH}/WEB-INF/classes/static/css/login.css">
    <link rel="stylesheet" type="text/css" href="css/common.css">
	<link rel="stylesheet" type="text/css" href="css/login.css">

</head>
<body style="background-color:#f5f5f5;">
<!-- 导航栏-->
	<%@include file="include/navigator.jsp" %>

	<div class="container">
		<div class="row">
			<div class="col-md-offset-3 col-md-6">

		<form method="post" class="form-horizontal" action="${pageContext.request.contextPath}/signup">
			<span class="tittlesize">用户注册</span>
			<div class="form-group">
				<label>用户名</label>
				<input type="text" name="username" id = 'username'class="form-control"placeholder="请输入用户名或电子邮箱">
				<span class="error-message" style="color: red;"/>
				<i class="fa fa-user"></i>
			</div>
			<span style="color:red;display: none;" class="tips"></span>
			<span style="display: none;" class=" glyphicon glyphicon-remove"></span>
			<span style="display: none;" class="glyphicon glyphicon-ok "></span>
			<div class="form-group">
				<label>密码</label>
				<input type="password" id='password'name="password" class="form-control" placeholder="请输入密码">
			</div>
			<span style="color:red;display: none;" class="tips"></span>
			<span style="display: none;" class=" glyphicon glyphicon-remove"></span>
			<span style="display: none;" class="glyphicon glyphicon-ok "></span>
			<div class="form-group">
				<label>确认密码</label>
				<input type="password"  id='password2' class="form-control" placeholder="请再次输入密码">
			</div>
			<span style="color:red;display: none;" class="tips"></span>
			<span style="display: none;" class=" glyphicon glyphicon-remove"></span>
			<span style="display: none;" class="glyphicon glyphicon-ok "></span>
			<div class="form-group">
				<button type="submit" id='submit' class="btn btn-primary btn-block">注册</button>
			</div>
			<div class="form-group">
				<input value="重置" id="reset" class="btn btn-danger btn-block" style="background-color: orangered" type="reset">
			</div>

		</form>
	</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript" src="${APP_PATH}/WEB-INF/classes/static/js/sign.js"></script>
<script type="text/javascript" src="js/sign.js"></script>

<script type="text/javascript">
	console.log("我进来拉");
	$('#submit').click(function (){
	    if($("#password").val()!=$("#password2").val()){
            layer.msg('两次输入的密码不一致',{time:1000,shade: [0.3, '#000']});
            return false;
		}
	});

	$("#username").blur(function(){
        var username =  $("#username").val();
        $.ajax({
			url: 'validate?username='+username,
			type:'GET',
			success:function(data){
				if(data.code!=200){
                    layer.msg('该用户已被注册',{time:1000,shade: [0.3, '#000']});
                    $("#submit").attr('disabled','disabled');
                    $(".error-message").text("该用户已被注册");
				}else{
                    $("#submit").removeAttr('disabled','disabled');
                    $(".error-message").text("");
				}
			}

		}
		)
	})


</script>