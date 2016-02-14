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
		<script type="text/javascript">
			ajaxLoadEnd();
			function backFunc()
			{
				ajaxLoading("返回中...");
				window.location.href = "/sys/shortBus/accessShortAttenceDetail.do?funcNodeId=${funcNodeId}&pageName=attenceTourismDetail&shortClassInstId=${shortClassInstT.shortClassInstId}";
			}
		</script>
  	</head>
  	<body class="manage">
		<table class="tab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" width="15%">游学开始日期：</td>
				<td width="15%"><fmt:formatDate value="${shortClassInstT.openDate}" pattern="yyyy-MM-dd" /></td>
				<td align="right" width="15%">游学结束日期：</td>
				<td><fmt:formatDate value="${shortClassInstT.finishDate}" pattern="yyyy-MM-dd" /></td>
			</tr>
		</table>
		<table class="tab" id="teacherTab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<c:forEach items="${shortClassAttendT.teacherAttendList}" var="node">
				<tr>
					<td align="right" width="15%">老师：</td>
					<td align="center" width="15%">${node.teacherT.schoolT.schoolName}</td>
					<td align="center" width="15%">${node.teacherT.byName}</td>
					<td>&nbsp;</td>
				</tr>
			</c:forEach>
		</table>
		<table class="tab" id="studentTab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr class="headTr">
				<td width="5%">序号</td>
				<td width="15%">所属校区</td>
				<td width="15%">姓名</td>
				<td width="15%">英文名</td>
				<td width="50%">考勤</td>
			</tr>
			<c:forEach items="${shortClassAttendT.studentAttendList}" var="node" varStatus="i">
				<tr id="studentId${node.studentId}">
					<td align="center">${i.count}</td>
					<td align="center">${node.studentT.schoolT.schoolName}</td>
					<td align="center">${node.studentT.name}</td>
					<td align="center">${node.studentT.byName}</td>
					<td align="center">
						<c:choose>
							<c:when test="${node.attendType == 'Y'}">
								参加
							</c:when>
							<c:when test="${node.attendType == 'N'}">
								未参加
							</c:when>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</table>
		<div style="margin:0 auto;padding:0 0;text-align:right;padding-right:2px;width:99%;margin-top:10px">
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
		</div>
 	</body>
</html>