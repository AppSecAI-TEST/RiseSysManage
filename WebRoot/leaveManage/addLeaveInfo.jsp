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
		<script type="text/javascript" src="<%=path %>/js/leaveManage/leaveManage.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/css/style.css">
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="学员基础信息">
  			<table width="100%" cellpadding="5px" class="maintable" id="studentTd">
  				<tr>
  					<td align="right">学员姓名：</td>
  					<td align="left">${obj.studentInfo.name}</td>
  					<td align="right">英文名：</td>
  					<td align="left">${obj.studentInfo.byName}</td>
  					<td align="right">联系电话：</td>
  					<td align="left">${obj.studentInfo.phone}</td>
  				</tr>
  				<tr>
  					<td align="right">所属校区：</td>
  					<td align="left">${obj.studentInfo.schoolName}</td>
  					<td align="right">责任顾问：</td>
  					<td align="left">${obj.studentInfo.dutyAdvisterName}</td>
  					<td align="right">客户关怀：</td>
  					<td align="left">${obj.studentInfo.carerName}</td>
  				</tr>
  			</table>
  		</div>
		<div style="height: 10px;"></div>
   		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="学员课程信息">
 		<form id="addLeaveForm" method="post" enctype="multipart/form-data">
 		<table width="100%" cellpadding="5px" class="maintable" id="courseTd">
 			<tr>
 				<td align="center">课程名称</td>
 				<td align="center">课程状态</td>
 				<td align="center">校区</td>
 				<td align="center">缴费时间</td>
 				<td align="center">业绩类型</td>
 				<td align="center">班级</td>
 				<td align="center">开课日期</td>
 				<td align="center">结课日期</td>
 				<td align="center">课程进度</td>
 				<td align="center">业绩顾问</td>
 				<td align="center">责任顾问</td>
 				<td align="center">客户关怀</td>
 				<c:forEach items="${obj.courseInfo}" var="courseInfo">
 					<tr>
 						<td align="center">${courseInfo.courseName}</td>
 						<td align="center">${courseInfo.courseState}</td>
 						<td align="center">${courseInfo.schoolName}</td>
 						<td align="center">${courseInfo.payDate}</td>
 						<td align="center">${courseInfo.feeType}</td>
 						<td align="center">${courseInfo.className}</td>
 						<td align="center">${courseInfo.startTime}</td>
 						<td align="center">${courseInfo.finishTime}</td>
 						<td align="center">${courseInfo.classProgress}</td>
 						<td align="center">${courseInfo.adviser}</td>
 						<td align="center">${courseInfo.dutyAdvister}</td>
 						<td align="center">${courseInfo.carer}</td>
 					</tr>
 				</c:forEach>
 			</tr>
 			<tr>
 				<td align="right">休学时长：</td>
 				<td colspan="2"><input class="easyui-numberbox" name="planLeaveTime" id="planLeaveTime" style="width:120px;" data-options="min:1,max:24" required="true"/></td>
 				<td colspan="9">休学申请单与缴费凭证：
 					<input type="hidden" name="imgUrl" id="imgUrl"/>
                    <input style="width: 500px; height: 28px;" class="easyui-filebox" name="fileName" id="fileName" data-options="prompt:''"/>
                    <a href="javascript:void(0)" class="easyui-linkbutton" id="uploadBtn" iconCls="icon-save" iconCls="icon-save" style="width: 100px; height: 25px;">上传</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" id="cancelUploadBtn" iconCls="icon-cancel" iconCls="icon-cancel" style="width: 100px; height: 25px;">取消</a>
				</td>
 			</tr>
 			<tr>
 				<td align="right">备注：</td>
 				<td colspan="11"><textarea rows="7" cols="100" id="addRemark" name="addRemark" class="easyui-validatebox textbox"></textarea></td>
 			</tr>
 		</table>
 		</form>
 		</div>
 		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
 		<input id="studentId" type="hidden" value="${obj.studentInfo.studentId}" />
 		<input id="schoolId" type="hidden" value="${schoolId}" />
 		<input id="courseState" type="hidden" value="${courseState}" />
 		<input id="studentCourseId" type="hidden" value="${studentCourseId}" />
 		<input id="currentHours" type="hidden" value="${currentHours}" />
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: right;">
	      		<a href="javascript:void(0)" id="addLeaveSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;" onclick="addLeaveSubmit()">提交</a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
  	</body>
</html>
