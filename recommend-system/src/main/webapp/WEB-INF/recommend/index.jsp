<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
<%
 pageContext.setAttribute("APP_PATH", request.getContextPath());
 %>
	<meta charset="UTF-8">
	<title>魔都美食推荐</title>
	<link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.css" rel="stylesheet">
	<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${APP_PATH}/WEB-INF/classes/static/css/common.css">
    <link rel="stylesheet" type="text/css" href="css/common.css">
</head>
<body style="background-color:#f5f5f5;">
	<!-- 导航栏-->
	<%@include file="../include/navigator.jsp" %>
	<div class="container">
		<div class="row">


	<div class="col-sm-2">
	<div class="list-group side-bar">
		<a href="${pageContext.request.contextPath}/recommend" class="list-group-item active">全部</a>
		<a href="${pageContext.request.contextPath}/recommend?pageNum=1&category=508" class="list-group-item">烧烤</a>
		<a href="${pageContext.request.contextPath}/recommend?pageNum=1&category=110" class="list-group-item">火锅</a>
		<a href="${pageContext.request.contextPath}/recommend?pageNum=1&category=116" class="list-group-item">西餐</a>
		<a href="${pageContext.request.contextPath}/recommend?pageNum=1&category=113" class="list-group-item">日料</a>
		<a href="${pageContext.request.contextPath}/recommend?pageNum=1&category=111" class="list-group-item">自助</a>
		<a href="${pageContext.request.contextPath}/recommend?pageNum=1&category=103" class="list-group-item">粤菜</a>
		<a href="${pageContext.request.contextPath}/recommend?pageNum=1&category=102" class="list-group-item">川菜</a>
		<a href="${pageContext.request.contextPath}/recommend?pageNum=1&category=101" class="list-group-item">江浙菜</a>
		<a href="${pageContext.request.contextPath}/recommend?pageNum=1&category=118" class="list-group-item">其他</a>
	</div>
	</div>
	<div class="col-sm-8">

	<div class="foodlist">
	<c:forEach items="${data}" var="list">
		<div class="foodlist-item clearfix">
			<div class="col-sm-4">
				<img src="${list.defaultPic}" alt="img"></div>
			<div class="col-sm-8">
				<a href="${list.url}" class="tittle">${list.shopName}</a>
				<span class='pull-right'>${list.categoryId}</span>
			<ul class="food-info">
           	<li class="grade">
           		口味:<span>${list.refinedScore1}</span>
           		环境:<span>${list.refinedScore2}</span>
           		服务:<span>${list.refinedScore3}</span>
            </li>
        	<br>
       	 	<li><span>人均：</span>${list.avgPrice}元</li>
       		 <br>
       	 	<li><span>地址 :</span>${list.address}</li>
        	<br>
        	<button type="button" class="btn btn-info btn-sm">加入收藏</button>
    		</ul>
		</div>
		</div>
	</c:forEach>

	</div>
	</div>
	<div class="col-sm-2">
			<!--显示价格区间-->
			<%@include file="../include/priceRegion.jsp" %>
	</div>
	</div>

	<!--显示分页信息-->
 <%@include file="../include/page.jsp" %>

	</div>



</body>
</html>
<script type="text/javascript">
console.log("我进来辣！")
//切换 sidebar active
$(function(){
	$('.list-group-item').removeClass("active");
	$('.list-group-item').each(function(){
		var context = location.href.split('recommend');
		if(context.length==1){
			$(this).addClass("active");
			return false;
		}else{
			if($(this).attr("href").split('recommend')[1].split('&')[1]===location.href.split('recommend')[1].split('&')[1]){
				$(this).addClass("active");
				return false;
			}
		}
	});
});

//给botton 添加动态地址
$(".priceSort").blur(function(){
	console.log(location.href);
	var baseUrl =location.href;
	//http://localhost:8080/spider-dianping2/recommend?pageNum=1&category=116&start=200&end=300
	if(baseUrl.indexOf('start')>=0){
		var index = baseUrl.indexOf('start');
		console.log(baseUrl.substring(0,index-1));
		//http://localhost:8080/spider-dianping2/recommend?pageNum=1&category=116
		baseUrl = baseUrl.substring(0,index-1);
	}
	var start = $(".startPrice").val();
	var end = $(".endPrice").val();
	if(baseUrl.indexOf("?")<0){
		baseUrl = baseUrl + "?";
	}
	//http://localhost:8080/spider-dianping2/recommend?pageNum=1&category=116#
	if(baseUrl.indexOf("#")>=0){
		baseUrl = baseUrl.replace("#","");
	}
	console.log(baseUrl+'\&start='+start+'\&end='+end);
	$(".sortSubmit").attr('href',baseUrl+'\&start='+start+'\&end='+end)
})

//动态地址
$(".poor-0").click(function(){
    var url = parseUrl(0,50);
    $(this).attr('href',url);
});
$(".poor-1").click(function(){
    var url = parseUrl(50,150);
    $(this).attr('href',url);
});
$(".poor-2").click(function(){
    var url = parseUrl(150,350);
    $(this).attr('href',url);
});
$(".poor-3").click(function(){
    var url = parseUrl(300,500);
    $(this).attr('href',url);
});
$(".poor-4").click(function(){
    var url = parseUrl(500,9999);
    $(this).attr('href',url);
});




function parseUrl(start,end){
    console.log(location.href);
    var baseUrl =location.href;
    //http://localhost:8080/spider-dianping2/newCooling?pageNum=1&category=116&start=200&end=300
    if(baseUrl.indexOf('start')>=0){
        var index = baseUrl.indexOf('start');
        console.log(baseUrl.substring(0,index-1));
        //http://localhost:8080/spider-dianping2/newCooling?pageNum=1&category=116
        baseUrl = baseUrl.substring(0,index-1);
    }
    if(baseUrl.indexOf("?")<0){
        baseUrl = baseUrl + "?";
    }
    if(baseUrl.indexOf("#")>=0){
        baseUrl = baseUrl.replace("#","");
    }
    console.log(baseUrl+'\&start='+start+'\&end='+end);
    return baseUrl+'\&start='+start+'\&end='+end;
}
</script>
<script type="text/javascript" color="0,0,0" zindex="-1" opacity="0.5" count="99" src="https://cdn.bootcss.com/canvas-nest.js/1.0.0/canvas-nest.min.js"></script>