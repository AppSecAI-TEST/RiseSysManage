<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/pub/js/json.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json2.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/css/style.css">
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="浏览反馈维护">
	 		<table width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td width="3%" align="center">序号</td>
  					<td width="7%" align="center">姓名</td>
  					<td width="7%" align="center">英文名</td>
  					<td width="8%" align="center">课程状态</td>
  					<td width="15%" align="center">电教次数</td>
  					<td width="20%" align="center">家长会</td>
  					<td width="20%" align="center">公开课</td>
  					<td width="20%" align="center">毕业典礼</td>
  				</tr>
  				<c:forEach items="${obj.feedback}" var="feedback" varStatus="status">
					<tr>
						<td align="center">${status.count}</td>
						<td align="center">${feedback.studentName}</td>
						<td align="center">${feedback.byname}</td>
						<td align="center">${feedback.courseStateVal}</td>
						<td align="center">${feedback.teachingNum}</td>
						<td align="center">
							<c:if test="${feedback.meetingIsAttend == 'Y'}">
								<span>已到</span>&nbsp;&nbsp;&nbsp;<span>满意度：${feedback.meetingCsi}</span>
							</c:if>
							<c:if test="${feedback.meetingIsAttend == 'N'}">
								<span>未到</span>&nbsp;&nbsp;&nbsp;
							</c:if>
						</td>
						<td align="center">
							<c:if test="${feedback.openIsAttend == 'Y'}">
								<span>已到</span>&nbsp;&nbsp;&nbsp;<span>满意度：${feedback.openCsi}</span>
							</c:if>
							<c:if test="${feedback.openIsAttend == 'N'}">
								<span>未到</span>&nbsp;&nbsp;&nbsp;
							</c:if>
						</td>
						<td align="center">
							<c:if test="${feedback.gradIsAttend == 'Y'}">
								<span>已到</span>&nbsp;&nbsp;&nbsp;<span>满意度：${feedback.gradCsi}</span>
							</c:if>
							<c:if test="${feedback.gradIsAttend == 'N'}">
								<span>未到</span>&nbsp;&nbsp;&nbsp;
							</c:if>
						</td>
					</tr>
			   </c:forEach>
	 		</table>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: right;">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
  	</body>
</html>
