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
    <title>我的收藏</title>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.css" rel="stylesheet">
    <!--     <link rel="stylesheet" type="text/css" href="css/jquery.tagbox.css"> -->
    <script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!--     <script type="text/javascript" src="js/bootstrap-tagsinput.js"></script>
        <script type="text/javascript" src="js/jquery.tagbox.js"></script> -->
    <link rel="stylesheet" type="text/css" href="${APP_PATH}/WEB-INF/classes/static/css/common.css">
    <link rel="stylesheet" type="text/css" href="../css/common.css">




    <!--     <script type="text/javascript" src="js/tag.js"></script> -->

    <!--
         <script type="text/javascript">
        jQuery(function() {
          jQuery("#jquery-tagbox-text").tagBox();
            });
        </script> -->
</head>

<body style=" background-color: rgba(90,120,250,0.1);">
<div id="app">
    <!-- 导航栏-->
    <%@include file="../include/navigator.jsp" %>
    <div class="container">
        <div class="row">

            <!-- 左空白 -->
            <div class="sidecolor col-sm-2">

            </div>
            <div class="col-sm-8 collection">
                <!-- <div class="titlecolor clearfix ">
                    <div class="col-sm-4"></div>
                    <div class="col-sm-2">
                        <img src="img/头像.png" class="img-circle">
                    </div>
                    <div class="username col-sm-4">
                    用户名
                    </div>
                </div> -->
                <div class="col-sm-8 leftcolor">
                    <!-- <h4 style="text-align: center;">收藏餐厅</h4> -->
                    <hr>
                    <!--         全部标签  标签1   标签2  标签3  -->
                    <a href="collection" class="btn btn-info btn-sm taglocation">
                        <span class="glyphicon glyphicon-tags "></span>  全部标签
                    </a>
                    <br>


                    <el-tag :key="tag" v-for="tag in dynamicTags" closable :disable-transitions="false" @close="handleClose(tag)">
                        {{tag}}
                    </el-tag>
                    <el-input class="input-new-tag" v-if="inputVisible" v-model="inputValue" ref="saveTagInput" size="small" @keyup.enter.native="handleInputConfirm" @blur="handleInputConfirm">
                    </el-input>
                    <el-button v-else class="button-new-tag" size="small" @click="showInput">+  新增标签</el-button>
                        <hr>
                    <!--         <a href="">+新增标签</a> -->
                    <c:forEach items="${data}" var="list" varStatus="status">
                        <c:if test="${status.index}%2==0">
                            <li  class="odd1">
                        </c:if>
                        <c:if test="${status.index}%2==1">
                            <li class="odd2">
                        </c:if>
                        <div class="txtcolor">

                            <a class="title2">${list.shopName}</a>
                            <div class="tags-box">
                            </div>
                            <div class="txt-c">
                                <!--商户信息-->
                                <div class="info2">
                                    <span>口味:${list.refinedScore1}</span>
                                    <span>环境:${list.refinedScore2}</span>
                                    <span>服务:${list.refinedScore3}</span>
                                    <p>${list.address}</p>
                                    <p>人均:${list.avgPrice}</p>
                                    <a class="label label-primary" data-toggle="modal" data-target="#myModal"  v-on:click="changeTag(${list.shopId})">编辑</a>
                                    <a class="label label-danger notCollection" >删除</a>
                                    <input type="hidden" value="${list.shopId}" class="shopIdHidden">
                                </div>
                            </div>
                        </div>
                        </li>
                        <hr>
                    </c:forEach>


                </div>
                <div class="col-sm-4 rightcolor">
                    <br><br>
                    <H3>收藏一家餐厅</H3>
                    <br>
                    把平时想去的餐厅收藏起来，想起来的时候就能快速找到啦，还可以设置不同的标签，区分不同种类的餐厅
                    <br>
                    <br>
                    <a href="newCooling">查看人气餐厅</a>
                    <br>
                    <br>
                    <br>
                    <br>
                </div>

                <!--显示分页信息-->
                <%@include file="../include/page.jsp"%>
            </div>
            <div class="col-sm-4"></div>


        </div>
        <div class="sidecolor col-sm-2">

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
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                        </button>
                        <button type="button" class="btn btn-primary" data-dismiss="modal" id="submitLabel">
                            提交更改
                        </button>
                        <input type="hidden" value="" id="shopIdModel">
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
    </div>
</div>

<link rel="stylesheet" type="text/css" href="../css/test.css">
<link rel="stylesheet" type="text/css" href="https://cdn.bootcss.com/element-ui/2.2.0/theme-chalk/index.css">
<script src="https://cdn.bootcss.com/vue/2.5.13/vue.js"></script>

<script src="https://cdn.bootcss.com/element-ui/2.2.0/index.js"></script>
<script type="text/javascript" src="../js/test.js"></script>
<script type="text/javascript" src="${APP_PATH}/WEB-INF/classes/static/js/test.js"></script>
<script src="https://cdn.bootcss.com/layer/3.1.0/layer.js"></script>
<script type="text/javascript">


    $(document).on("click",".modal-body .el-tag",function(){
// box-shadow: rgb(245, 108, 1) 1px 1px 10px;
//        if($(this).attr("data-active")=="true"){
//            $(this).css("box-shadow","");
//            $(this).css("background-color","")
//            $(this).attr("data-active","");
//        }else{
//            $(this).css("box-shadow","rgb(245, 108, 1) 1px 1px 10px");
//            $(this).css("background-color","rgb(35,98,152)")
//            $(this).attr("data-active","true");
//        }
        if($(this).attr("data-active")=="true"){
            $(this).css("box-shadow","");
            $(this).css("background-color","rgba(64,158,255,.1)")
            $(this).css("color","#409EFF")
            $(this).attr("data-active","");
        }else{
            $(this).css("box-shadow","rgba(64,158,255,.2)");
            $(this).css("background-color","rgba(64,158,255,1)")
            $(this).css("color","#FFF")
            $(this).attr("data-active","true");
        }
    });


    //点击标签转到对应门店
    $(document).on("click",".leftcolor .el-tag",function(){
        var labelName = $(this).text().trim();
        window.location.href ="collection?labelName="+labelName;
    })

    //编辑按钮-提交
    $('#submitLabel').click(function(){
        var activrLabelName="";
        var allLabel="";
        $('.modal-body').children(".el-tag").each(function(){
            if(allLabel==""){
                allLabel = $(this).text().trim();
            }else{
                allLabel = allLabel +","+$(this).text().trim();
            }

            if($(this).attr("data-active")=="true"){
                if(activrLabelName==""){
                    activrLabelName = $(this).text().trim();
                }else{
                    activrLabelName = activrLabelName + ","+$(this).text().trim();
                }
            }
        });
        if(activrLabelName==""){
            layer.msg("请选择你要收藏的标签",{time:1000,shade: [0.3, '#000']});
            $('#submitLabel').removeAttr("data-dismiss");
        }else {
            $('#submitLabel').attr("data-dismiss","modal");
            var shopId = $("#shopIdModel").val();
            //String allLabel,String activeLabel,int activeShopId
            $.ajax({
                url:"/recommend-system/api/addOrModifyLabel",
                data:{
                    allLabel:allLabel,
                    activeLabel:activrLabelName,
                    activeShopId:shopId
                },
                type:"POST",
                success:function (e) {
                    if(e.code=='200'){
                        layer.msg("修改成功",{time:1000,shade: [0.3, '#000']});
                        hideOrShow(shopId);
                    }else {
                        layer.msg("修改失败，系统",{time:1000,shade: [0.3, '#000']});


                    }
                }
            });
        }

    });


    //根据shopid来控制整家店显示/隐藏=
    function hideOrShow(shopId){
        $(".shopIdHidden").each(function(){
            var that = $(this);
            if(that.val()==shopId){
                that.parent().hide();
            }
        })
    }
</script>

</body>
</html>
