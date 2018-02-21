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
    <link rel="stylesheet" type="text/css" href="css/common.css">
</head>
<body>
<!-- 导航栏-->
	<%@include file="include/navigator.jsp" %>

	<div class="container container-small">
		<form method="post" action="${pageContext.request.contextPath}/signup">
			<div class="form-group">
				<label>用户名</label>
				<input type="text" name="username" id = 'username'class="form-control">
				<span class="error-message" style="color: red;"/>
			</div>
			<div class="form-group">
				<label>密码</label>
				<input type="password" id='password'name="password" class="form-control">
			</div>
						<div class="form-group">
				<label>确认密码</label>
				<input type="password"  id='password2' class="form-control">
			</div>
			<button type="submit" id='submit' class="btn btn-primary btn-block">注册</button>
		</form>
	</div>
</body>
</html>

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