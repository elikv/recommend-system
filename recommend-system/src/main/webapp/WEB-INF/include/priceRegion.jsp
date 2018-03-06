<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
<div class="search-bar">
    <input type="search" class="form-control" placeholder="想吃啥点我">
</div>
<div class="side-bar-card">
    <center>
        <a href="" class="poor-0">我是穷神</a>
        <br>
        <br>
        <a href="" class="poor-1">我是学生</a>
        <br>
        <br>
        <a href="" class="poor-2">我是小资</a>
        <br>
        <br>
        <a href="" class="poor-3">我是大款</a>
        <br>
        <br>
        <a href="" class="poor-4">我是王思聪</a>
        <br>
        <br>
        <span style="color: #337ab7;">动感地带我的价格我做主</span>
        <br>
        <input type="text"  class="startPrice priceSort" value="${param.start}" style="width:40px;">~
        <input type="text"  class="endPrice priceSort" value="${param.end}" style="width:40px;">
        <br>
        <a href="#" type="submit" role="botton" class="btn btn-primary sortSubmit"  style="margin:10px;" >确定</a>
    </center>
</div>
<div class="signword">标签</div>