<%--
  Created by IntelliJ IDEA.
  User: 39346
  Date: 2018/2/21
  Time: 17:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
            <!-- <div class="navbar-brand">人气美食推荐系统</div> -->
            <a href="${pageContext.request.contextPath}/newCooling" class="navbar-brand"></a>
        </div>
        <ul class="nav navbar-nav ">
            <li><a class="navwordsize glyphicon glyphicon-home" href="${pageContext.request.contextPath}/newCooling">首页</a></li>
            <li><a class="navwordsize glyphicon glyphicon-thumbs-up" href="${pageContext.request.contextPath}/recommend">上榜次数排序</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <input type="hidden" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}">
            <c:if test="${sessionScope==null || sessionScope.SPRING_SECURITY_CONTEXT==null}">
                <li><a class="glyphicon glyphicon-ok" href="${pageContext.request.contextPath}/user/login">登陆</a></li>
            </c:if>
            <c:if test="${sessionScope!=null && sessionScope.SPRING_SECURITY_CONTEXT!=null}">
                <li><a  href="#">${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}</a></li>
                <li><a class="glyphicon glyphicon-remove" href="${pageContext.request.contextPath}/logout">注销</a></li>
            </c:if>

            <li><a class="glyphicon glyphicon-list-alt" href="${pageContext.request.contextPath}/signup2">注册</a></li>
            <li><a class="glyphicon glyphicon-heart-empty" href="${pageContext.request.contextPath}/user/collection">我的收藏</a></li>
        </ul>
    </div>
</div>
