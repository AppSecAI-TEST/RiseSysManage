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
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="浏览反馈维护">
	 		<table width="98%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td width="3%" align="center"><span>序号</span></td>
  					<td width="7%" align="center"><span>姓名</span></td>
  					<td width="6%" align="center"><span>英文名</span></td>
  					<td width="8%" align="center"><span>课程状态</span></td>
  					<td width="10%" align="center"><span>电教次数</span></td>
  					<td width="15%" align="center"><span>开班典礼</span></td>
  					<td width="15%" align="center"><span>家长会</span></td>
  					<td width="15%" align="center"><span>公开课</span></td>
  					<td width="15%" align="center"><span>毕业典礼</span></td>
  					<td width="8%" align="center"><span>行政满意度</span></td>
  				</tr>
  				<c:forEach items="${obj.feedback}" var="feedback" varStatus="status">
					<tr>
						<td align="center"><span>${status.count}</span></td>
						<td align="center"><span>${feedback.studentName}</span></td>
						<td align="center"><span>${feedback.byname}</span></td>
						<td align="center"><span>${feedback.courseStateVal}</span></td>
						<td align="center"><span>${feedback.teachingNum}</span></td>
						<td align="center">
							<c:if test="${feedback.startIsAttend == 'Y'}">
								<span>已到</span>&nbsp;&nbsp;&nbsp;<span>满意度：${feedback.startCsi}%</span>
							</c:if>
							<c:if test="${feedback.startIsAttend == 'N'}">
								<span>未到</span>&nbsp;&nbsp;&nbsp;
							</c:if>
						</td>
						<td align="center">
							<c:if test="${feedback.meetingIsAttend == 'Y'}">
								<span>已到</span>&nbsp;&nbsp;&nbsp;<span>满意度：${feedback.meetingCsi}%</span>
							</c:if>
							<c:if test="${feedback.meetingIsAttend == 'N'}">
								<span>未到</span>&nbsp;&nbsp;&nbsp;
							</c:if>
						</td>
						<td align="center">
							<c:if test="${feedback.openIsAttend == 'Y'}">
								<span>已到</span>&nbsp;&nbsp;&nbsp;<span>满意度：${feedback.openCsi}%</span>
							</c:if>
							<c:if test="${feedback.openIsAttend == 'N'}">
								<span>未到</span>&nbsp;&nbsp;&nbsp;
							</c:if>
						</td>
						<td align="center">
							<c:if test="${feedback.gradIsAttend == 'Y'}">
								<span>已到</span>&nbsp;&nbsp;&nbsp;<span>满意度：${feedback.gradCsi}%</span>
							</c:if>
							<c:if test="${feedback.gradIsAttend == 'N'}">
								<span>未到</span>&nbsp;&nbsp;&nbsp;
							</c:if>
						</td>
						<td align="center">
								<span>${feedback.strativeCsi}%</span>&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
			   </c:forEach>
	 		</table>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:right">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
  	</body>
</html>
