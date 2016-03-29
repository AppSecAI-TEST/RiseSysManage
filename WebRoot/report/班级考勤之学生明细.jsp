<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  	<body>
		<form id="attFm" style="margin:0 auto;">
			<c:choose>
				<c:when test="${fn:length(attStudentList) == 0}">
					<script type="text/javascript">
						$(document).ready(function(){
							$.messager.alert('提示',"该课程没有学员考勤信息","info",function(){
								 backFunc();
							});
						});
					</script>
				</c:when>
				<c:otherwise>
					<table align="center" class="tab" style="min-width:2000px;margin:0 auto;padding:0 0;border-top:1px solid #ccc;height:auto" cellpadding="0" cellspacing="0">
						<tr class="headTr datagrid-header">
							<td rowspan="2" style="border-left:1px solid #ccc;">序号</td>
							<td rowspan="2">学员姓名</td>
							<td rowspan="2">学员英文名</td>
							<c:forEach begin="1" end="${maxDay}" varStatus="i">
								<td>${i.count}</td>
							</c:forEach>
							<td rowspan="2">总计</td>
						</tr>
						<tr class="headTr datagrid-header">
							<c:forEach begin="1" end="${maxDay}" varStatus="i">
								<td>
									<fmt:parseDate value="${monthDateStr}-${i.count}" var="weekDay" pattern="yyyy-MM-dd" />
									<fmt:formatDate value="${weekDay}" pattern="EE"/>
								</td>
							</c:forEach>
						</tr>
						<c:forEach items="${attStudentList}" var="node" varStatus="i">
							<tr>
								<td align="center" style="border-left:1px solid #ccc;">${i.count}</td>
								<td align="center">${node.name}</td>
								<td align="center">${node.byName}</td>
								<c:forEach begin="1" end="${maxDay}" varStatus="j">
									<fmt:parseDate value="${monthDateStr}-${j.count}" var="weekDay" pattern="yyyy-MM-dd" />
									<c:set var="attendTotalHour" value="" />
									<c:forEach items="${node.attendDates}" var="item">
										<c:if test="${item.attendDate.time-weekDay.time == 8*60*60*1000}">
											<c:set var="attendTotalHour" value="${item.attendTotalHour}" />
										</c:if>
									</c:forEach>
									<td align="center">${attendTotalHour}</td>
								</c:forEach>
								<td align="center">${node.attendCount}</td>
							</tr>
						</c:forEach>
						<tr>
							<td colspan="${maxDay+4}" align="right" style="border:none !important;padding-right:5px;padding-top:5px">
								<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
							</td>
						</tr>
					</table>
				</c:otherwise>
			</c:choose>
		</form>
		<script type="text/javascript">
			$(document).ready(function(){
				ajaxLoadEnd();
			});
			function backFunc()
			{
				window.location.href = "/sys/report/班级考勤表.jsp";
			}
		</script>
 	</body>
</html>