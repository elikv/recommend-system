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
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
     <link rel="stylesheet" type="text/css" href="${APP_PATH}/WEB-INF/classes/static/css/common.css">
    <link rel="stylesheet" type="text/css" href="css/common.css">
</head>
<body style="background-color:#f5f5f5;">
<div id="app">
	<!-- 导航栏-->
	<%@include file="../include/navigator.jsp" %>
	<div class="container">
		<div class="row">
	<div class="col-sm-2">
	<div class="list-group side-bar">
		<a href="${pageContext.request.contextPath}/newCooling" class="list-group-item active">全部</a>
		<a href="${pageContext.request.contextPath}/newCooling?pageNum=1&category=508" class="list-group-item">烧烤</a>
		<a href="${pageContext.request.contextPath}/newCooling?pageNum=1&category=110" class="list-group-item">火锅</a>
		<a href="${pageContext.request.contextPath}/newCooling?pageNum=1&category=116" class="list-group-item">西餐</a>
		<a href="${pageContext.request.contextPath}/newCooling?pageNum=1&category=113" class="list-group-item">日料</a>
		<a href="${pageContext.request.contextPath}/newCooling?pageNum=1&category=111" class="list-group-item">自助</a>
		<a href="${pageContext.request.contextPath}/newCooling?pageNum=1&category=103" class="list-group-item">粤菜</a>
		<a href="${pageContext.request.contextPath}/newCooling?pageNum=1&category=102" class="list-group-item">川菜</a>
		<a href="${pageContext.request.contextPath}/newCooling?pageNum=1&category=101" class="list-group-item">江浙菜</a>
		<a href="${pageContext.request.contextPath}/newCooling?pageNum=1&category=118" class="list-group-item">其他</a>
	</div>
	</div>
	<div class="col-sm-8">
	<div class="foodlist">
	<c:forEach items="${data}" var="list">
		<div class="foodlist-item clearfix">
			<div class="col-sm-4">
				<img src="${list.defaultPic}" alt="img"></div>
			<div class="col-sm-8">
				<a href="http://www.dianping.com/shop/${list.shopId}" class="tittle">${list.shopName}</a>
			<ul class="food-info">
           	<li class="grade">
           		口味:<span>${list.refinedScore1}</span>
           		环境:<span>${list.refinedScore2}</span>
           		服务:<span>${list.refinedScore3}</span>
           		<span class='pull-right'>${list.categoryId}</span>
            </li>
        	<br>
       	 	<li><span>人均：</span>${list.avgPrice}元</li>
       		 <br>
       	 	<li><span>地址 :</span>${list.address}
       	 	<span class='pull-right'>打分:${list.rankNo}</span>
       	 	</li>
       	 	
        	<br>
        	<button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModal" id="collection" v-on:click="changeTag">加入收藏</button>
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
	<%@include file="../include/page.jsp"%>
	</div>

    <!-- 模态框（Modal） -->
    <div class="modal fade " id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h3 class="modal-title "  id="myModalLabel">
                        修改标签
                    </h3>
                </div>
                <div class="modal-body">

                    选择需要加入标签的位置
                    <br><br>

                        <el-tag :key="tag" v-for="tag in dynamicTags" closable :disable-transitions="false" @close="handleClose(tag)">
                            {{tag}}
                        </el-tag>
                        <el-input class="input-new-tag" v-if="inputVisible" v-model="inputValue" ref="saveTagInput" size="small" @keyup.enter.native="handleInputConfirm" @blur="handleInputConfirm">
                        </el-input>
                        <el-button v-else class="button-new-tag" size="small" @click="showInput">+  新增标签</el-button>

                    <br><br>
                    <!-- <label><input name="tags" type="checkbox" value="" />
                     <button class="btn btn-info btn-sm taglocation">
                     <span type="checkbox"class="glyphicon glyphicon-tag">标签2</button>
                     </label>
                    <label><input name="tags" type="checkbox" value="" />
                        <button class="btn btn-info btn-sm taglocation">
                        <span type="checkbox"class="glyphicon glyphicon-tag">标签3</button>
                    </label>
                    <label><input name="tags" type="checkbox" value="" />
                        <button class="btn btn-info btn-sm taglocation">
                        <span type="checkbox"class="glyphicon glyphicon-tag">标签4</button>
                    </label>
                    <label><input name="tags" type="checkbox" value="" />
                        <button class="btn btn-info btn-sm taglocation">
                        <span type="checkbox"class="glyphicon glyphicon-tag">标签5</button>
                     </label> -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="submitLabel">
                        提交更改
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
</div>
</body>
</html>
<link rel="stylesheet" type="text/css" href="css/test.css">
<link rel="stylesheet" type="text/css" href="https://cdn.bootcss.com/element-ui/2.2.0/theme-chalk/index.css">
<script src="https://cdn.bootcss.com/vue/2.5.13/vue.js"></script>
<script src="https://cdn.bootcss.com/element-ui/2.2.0/index.js"></script>
<script type="text/javascript" src="js/test.js"></script>
<script src="https://cdn.bootcss.com/layer/3.1.0/layer.js"></script>
<script type="text/javascript">
console.log("我进来辣！")
console.log(Main.data().dynamicTags);
//切换 sidebar active
$(function(){
	$('.list-group-item').removeClass("active");
	$('.list-group-item').each(function(){
		var context = location.href.split('newCooling');
		if(context.length==1){
			$(this).addClass("active");
			return false;
		}else{
			if($(this).attr("href").split('newCooling')[1].split('&')[1]===location.href.split('newCooling')[1].split('&')[1]){
				$(this).addClass("active");
				return false;
			}
		}
	});

});


$('#submitLabel').click(function(){
    layer.msg("收藏成功",{time:1000,shade: [0.3, '#000']});

})

//选中修改样式
$(document).on("click",".el-tag",function(){
// box-shadow: rgb(245, 108, 1) 1px 1px 10px;
    if($(this).attr("data-active")=="true"){
        $(this).css("box-shadow","");
        $(this).css("background-color","")
        $(this).attr("data-active","");
    }else{
        $(this).css("box-shadow","rgb(245, 108, 1) 1px 1px 10px");
        $(this).css("background-color","rgb(35,98,152)")
        $(this).attr("data-active","true");
    }

})

//给botton 添加动态地址
$(".priceSort").blur(function(){
	console.log(location.href);
	var baseUrl =location.href;
	//http://localhost:8080/spider-dianping2/newCooling?pageNum=1&category=116&start=200&end=300
	if(baseUrl.indexOf('start')>=0){
		var index = baseUrl.indexOf('start');
		console.log(baseUrl.substring(0,index-1));
		//http://localhost:8080/spider-dianping2/newCooling?pageNum=1&category=116
		baseUrl = baseUrl.substring(0,index-1);
	}
	var start = $(".startPrice").val();
	var end = $(".endPrice").val();
	if(baseUrl.indexOf("?")<0){
		baseUrl = baseUrl + "?";
	}
	//http://localhost:8080/spider-dianping2/newCooling?pageNum=1&category=116#
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
