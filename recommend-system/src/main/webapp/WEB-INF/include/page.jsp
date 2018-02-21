<%--
  Created by IntelliJ IDEA.
  User: 39346
  Date: 2018/2/21
  Time: 17:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--显示分页信息-->
<div class="row">
    <!--文字信息-->
    <div class="col-md-6">
        当前第 ${pageInfo.pageNum} 页.总共 ${pageInfo.pages} 页.一共 ${pageInfo.total} 条记录
    </div>

    <!--点击分页-->
    <div class="col-md-6">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <li><a href="${pageContext.request.contextPath}/newCooling?pageNum=1&${param.category}&start=${param.start}&end=${param.end}">第一页</a></li>
                <!--上一页-->
                <li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <a href="${pageContext.request.contextPath}/newCooling?pageNum=${pageInfo.pageNum-1}&category=${param.category}&start=${param.start}&end=${param.end}" aria-label="Previous">
                            <span aria-hidden="true">«</span>
                        </a>
                    </c:if>
                </li>
                <!--循环遍历连续显示的页面，若是当前页就高亮显示，并且没有链接-->
                <c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
                    <c:if test="${page_num == pageInfo.pageNum}">
                        <li class="active"><a href="#">${page_num}</a></li>
                    </c:if>
                    <c:if test="${page_num != pageInfo.pageNum}">
                        <li><a href="${pageContext.request.contextPath}/newCooling?pageNum=${page_num}&category=${param.category}&start=${param.start}&end=${param.end}">${page_num}</a></li>
                    </c:if>
                </c:forEach>
                <!--下一页-->
                <li>
                    <c:if test="${pageInfo.hasNextPage}">
                        <a href="${pageContext.request.contextPath}/newCooling?pageNum=${pageInfo.pageNum+1}&category=${param.category}&start=${param.start}&end=${param.end}"
                           aria-label="Next">
                            <span aria-hidden="true">»</span>
                        </a>
                    </c:if>
                </li>
                <li><a href="${pageContext.request.contextPath}/newCooling?pageNum=${pageInfo.pages}&category=${param.category}&start=${param.start}&end=${param.end}">最后一页</a></li>
            </ul>
        </nav>
    </div>

</div>
