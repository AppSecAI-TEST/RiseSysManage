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
  
  	<body class="manage">
		<table class="tab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" width="10%">上课时间：</td>
				<td><fmt:formatDate value="${shortClassAttendT.schooltime}" pattern="yyyy-MM-dd" /> ${shortClassAttendT.hourRangeObj.paramDesc}</td>
			</tr>
			<tr>
				<td align="right">教室：</td>
				<td>${shortClassAttendT.roomT.roomName}</td>
			</tr>
			<tr>
				<td align="right">课时：</td>
				<td>${shortClassAttendT.hours}</td>
			</tr>
		</table>
		<table class="tab" id="teacherTab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr class="headTr">
				<td>&nbsp;</td>
				<td>校区</td>
				<td>姓名</td>
				<td>课时类型</td>
				<td>课时量</td>
				<td>是否持证</td>
			</tr>
			<c:forEach items="${shortClassAttendT.teacherAttendList}" var="node">
				<tr>
					<td align="right">老师：</td>
					<td align="center">${node.teacherT.schoolT.schoolName}</td>
					<td align="center">${node.teacherT.teacherName}</td>
					<td align="center">${node.teacherType}</td>
					<td align="center">${node.lessionHours}</td>
					<td align="center">
						<c:choose>
							<c:when test="${fn:length(node.teacherT.teacherLicenseList) == 0}">
								未持证
							</c:when>
							<c:otherwise>
								已持证
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</table>
		<table class="tab" id="studentTab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr class="headTr">
				<td width="4%">序号</td>
				<td width="10%">学员姓名</td>
				<td width="10%">英文名</td>
				<td width="50%">考勤操作</td>
				<td width="16%">校服着装情况</td>
			</tr>
			<c:forEach items="${shortClassAttendT.studentAttendList}" var="node" varStatus="i">
				<tr id="studentId${node.studentId}">
					<td align="center">${i.count}</td>
					<td align="center">${node.studentT.name}</td>
					<td align="center">${node.studentT.byName}</td>
					<td align="center">
						<c:choose>
							<c:when test="${node.attendType == 'N'}">
								正常上课
							</c:when>
							<c:when test="${node.attendType == 'B'}">
								迟到
							</c:when>
							<c:when test="${node.attendType == 'L'}">
								请假
							</c:when>
							<c:when test="${node.attendType == 'T'}">
								旷课
							</c:when>
						</c:choose>
					</td>
					<td align="center">
						<c:choose>
							<c:when test="${node.dress == 'N'}">
								未穿校服
							</c:when>
							<c:when test="${node.dress == 'Y'}">
								已穿校服
							</c:when>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</table>
		<div style="margin:0 auto;padding:0 0;text-align:right;padding-right:2px;width:99%;margin-top:10px">
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
		</div>
		<script type="text/javascript">
			ajaxLoadEnd();
			function backFunc()
			{
				ajaxLoading("返回中...");
				window.location.href = "/sys/shortBus/shortAttenceDetailPage.do?funcNodeId=${funcNodeId}&shortClassInstId=${shortClassAttendT.shortClassInstId}&pageName=${pageName}";
			}
		</script>
 	</body>
</html>