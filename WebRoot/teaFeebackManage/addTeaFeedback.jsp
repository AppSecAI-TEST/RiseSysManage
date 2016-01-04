<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
		<script type="text/javascript" src="<%=path %>/js/teaFeebackManage/teaFeebackManage.js"></script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="新增反馈维护">
  			<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<input id="qualityId" type="hidden" value="${qualityId}"/>
  			<input id="classInstId" type="hidden" value="${classInstId}"/>
  			<input id="className" type="hidden" value="${className}"/>
  			<input id="schoolId" type="hidden" value="${schoolId}"/>
  			<input id="month" type="hidden" value="${month}"/>
	 		<table id="feedbackTab" width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
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
  				<c:forEach items="${obj.studentInfo}" var="studentInfo" varStatus="status">
     	        <input type="hidden" name="studentId" id="studentId${status.index}" value="${studentInfo.studentId}"/>
     	        <input type="hidden" id="courseState${status.index}" value="${studentInfo.courseState}"/>
					<tr>
						<td align="center">${status.count}</td>
						<td id="studentName${status.index}" align="center">${studentInfo.name}</td>
						<td id="byname${status.index}" align="center">${studentInfo.byName}</td>
						<td align="center">${studentInfo.courseStateVal}</td>
						<td align="center"><input id="teachingNum${status.index}" class="easyui-numberbox" min="0" max="2"  style='width:120px;' /></td>
						<td align="center">
							<input type="radio" class="meeting" value="Y" name="meetingIsAttend${status.index}" checked="checked"/><span>已到</span>&nbsp;<input type="radio" class="meeting" value="N" name="meetingIsAttend${status.index}"/><span>未到</span>
							&nbsp;<span class="meetingCsi">满意度：<input id="meetingCsi${status.index}" class="easyui-numberbox" min="0" max="100" style='width:40px;' />%</span>
						</td>
						<td align="center">
							<input type="radio" class="open" value="Y" name="openIsAttend${status.index}" checked="checked"/><span>已到</span>&nbsp;<input type="radio" class="open" value="N" name="openIsAttend${status.index}"/><span>未到</span>
							&nbsp;<span class="openCsi">满意度：<input id="openCsi${status.index}" class="easyui-numberbox" min="0" max="100" style='width:40px;' />%</span>
						</td>
						<td align="center">
							<input type="radio" class="grad" value="Y" name="gradIsAttend${status.index}" checked="checked"/><span>已到</span>&nbsp;<input type="radio" class="grad" value="N" name="gradIsAttend${status.index}"/><span>未到</span>
							&nbsp;<span class="gradCsi">满意度：<input id="gradCsi${status.index}" class="easyui-numberbox" min="0" max="100" style='width:40px;' />%</span>
						</td>
					</tr>
			   </c:forEach>
	 		</table>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: right;">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;" onclick="addTeaFeedbackSubmit()">提交</a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
  	</body>
</html>
