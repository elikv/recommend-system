<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta http-equiv="Content-language" content="zh-CN"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="applicable-device" content="pc">

    <title>寻店地图</title>
    <meta name="description" content="方便快捷寻店"/>
    <meta name="keywords" content="寻店"/>
    <link href="/static/css/main.css" rel='stylesheet' type='text/css'/>
    <link href="/static/lib/layui/layui.css" rel="stylesheet" type="text/css"/>
    <link href="/static/css/rent-map.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
</head>
<body>
<header th:replace="common :: header"></header>
<div>
    <div class="left-region">
        <input id="cityEnName" th:value="${city.enName}" type="hidden">
        <input id="cityCnName" th:value="${city.cnName}" hidden="hidden">
        <div class="r-hd2">
            <ol class="order-select">
                <li class="s-default on" data-bind="lastUpdateTime" data-direction="desc">默认</li>
                <li class="s-price s-asc" data-bind="price" data-direction="asc">租金低
                    <i class="asc">↑</i>
                </li>
                <li class="s-area s-asc" data-bind="area" data-direction="desc">面积大
                    <i class="asc">↓</i></li>
                <li class="s-new" data-bind="createTime" data-direction="desc">最新</li>
            </ol>
        </div>
        <div class="r-hd3" style="display: block;">
            <div class="r-hd3-content">
                <ol class="i-card i-card-1">
                    <li class="i-card-name" th:text="${city.CnName}">北京市</li>
                    <li class=""><span th:text="${total}">0</span>套正在出租</li>
                    <li>共<span th:text="${#lists.size(regions)}"></span>个区域</li>
                </ol>
            </div>
            <div class="r-hd3-bg">
                <div class="r-hd3-cycle">
                    <div></div>
                </div>
                <div class="r-hd3-triangle"></div>
            </div>
        </div>
        <div class="r-container" style="position: relative; overflow: auto;">
            <ul id="house-flow" class="flow-default r-content">
                <!--<tr th:each="house: ${houses}">-->
                    <!--<li class="list-item">-->
                        <!--<a th:href="@{/rent/house/show(id=${house.id})}" target="_blank" th:title="${house.title}"-->
                           <!--data-community="1111027382235">-->
                            <!--<div class="item-aside">-->
                                <!--<img th:src="${house.cover} + '?imageView2/1/w/116/h/116'">-->
                                <!--<div class="item-btm">-->
                <!--<span class="item-img-icon">-->
                <!--<i class="i-icon-arrow"></i><i class="i-icon-dot"></i></span>&nbsp;&nbsp;-->
                                <!--</div>-->
                            <!--</div>-->
                            <!--<div class="item-main"><p class="item-tle" th:text="${house.title}">大标题</p>-->
                                <!--<p class="item-des">-->
                                    <!--<span th:text="${house.room} + '室' + ${house.parlour} + '厅'"></span>-->
                                    <!--<span th:text="${house.area} + '平米'"></span>-->
                                    <!--<span>南 北</span>-->
                                    <!--<span class="item-side" th:text="${house.price}">0<span>元/月</span></span>-->
                                <!--</p>-->
                                <!--<p class="item-community">-->
                                    <!--<span class="item-replace-com" th:text="${house.district}">小区</span><span-->
                                        <!--class="item-exact-com" th:text="${house.district}">小区</span>-->
                                <!--</p>-->
                                <!--<p class="item-tag-wrap">-->
                <!--<span th:each="tag: ${house.tags}">-->
                <!--<span class="item-tag-color_2 item-extra" title="" th:text="${tag}">标签</span>-->
                <!--</span>-->
                                <!--</p>-->
                            <!--</div>-->
                        <!--</a>-->
                    <!--</li>-->
                <!--</tr>-->
            </ul>
        </div>
    </div>
    <div id="allmap" class="wrapper">
    </div>
</div>
<!--<div th:include="common :: footer"></div>-->
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=Oi2uijgpb8tILz7Ys9Q48KbmmfHDSpjK"></script>
<script type="text/javascript" src="/static/js/baidu-map/TextIconOverlay.js"></script>
<script type="text/javascript" src="/static/js/baidu-map/MarkerClusterer.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
<script type="text/javascript" src="/static/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="/static/lib/layui/layui.js"></script>
<script type="text/javascript" src="/static/js/rent-map.js"></script>
<script type="text/javascript" th:inline="javascript">
    // 初始化加载地图数据
    var city = [[${city}]],
        regions = [[${regions}]],
        aggData = [[${aggData}]];

    load(city, regions, aggData);
</script>
</body>
</html>

