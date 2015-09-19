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
		<script type="text/javascript" src="<%=path %>/js/leaveManage.js"></script>
		<script type="text/javascript">
		   	$(document).ready(function(){
		   		 $("#delayDate").datebox("setValue","${obj.leaveInfo.leaveDate}")
		   	});
	   </script>
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/css/style.css">
		<style type="text/css">
			.datagrid{
				margin:0 auto;
				min-width:1100px;
				margin-top:20px;
				width:97%;
			}
			.datagrid .panel-header{width:99% !important;}
			/*.datagrid .panel-header .panel-title{width:100% !important;}*/
			.datagrid .datagrid-wrap{width:100% !important;}
			.datagrid .datagrid-wrap .datagrid-toolbar{width:99.5% !important;border-right-width:1px;}
			.datagrid .datagrid-wrap .datagrid-view{width:100% !important;}
			.datagrid .datagrid-wrap .datagrid-view .datagrid-view1{width:0% !important;}
			.datagrid .datagrid-wrap .datagrid-view .datagrid-view2{width:100% !important;}
			.datagrid .datagrid-wrap .datagrid-view .datagrid-view2 .datagrid-header{width:99.9% !important;border-left-width:0px;border-right-width:1px;}
			.datagrid .datagrid-wrap .datagrid-view .datagrid-view2 .datagrid-body{width:99.9% !important;border-left-width:0px;border-right:1px solid #95B8E7;}
			.datagrid .datagrid-wrap .datagrid-pager{width:99.9% !important;border-left-width:0px;border-right:1px solid #95B8E7;}
		</style>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="学员基础信息">
  			<table width="100%" cellpadding="5px" class="maintable" id="studentTd">
  				<tr>
  					<td align="right">学员姓名：</td>
  					<td align="left">${obj.studentInfo.name}</td>
  					<td align="right">出生日期：</td>
  					<td align="left">${obj.studentInfo.birthday}</td>
  					<td align="right">性别：</td>
  					<td align="left">${obj.studentInfo.sexVal}</td>
  				</tr>
  				<tr>
  					<td align="right">证件号码：</td>
  					<td align="left">${obj.studentInfo.identityId}</td>
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
  				<tr>
  					<td align="right">休学开始时间：</td>
  					<td align="left">${obj.leaveInfo.createDate}</td>
  					<td align="right">计划休学时长：</td>
  					<td align="left">${obj.leaveInfo.leaveTime}个月</td>
  					<td align="right">操作人员：</td>
  					<td align="left">${obj.leaveInfo.handerName}</td>
  				</tr>
  				<tr>
  					<td align="right">休学剩余时间：</td>
  					<td align="left">${obj.leaveInfo.leftTime}天</td>
  					<td align="right">休学状态：</td>
  					<td align="left">${obj.leaveInfo.leaveState}</td>
  					<td align="right">查看休学申请：</td>
  					<td align="left">${obj.leaveInfo.imgUrl}</td>
  				</tr>
  			</table>
  		</div>
		<div style="height: 10px;"></div>
   		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="学员课程信息">
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
 						<td></td>
 						<td align="center">${courseInfo.adviser}</td>
 						<td align="center">${courseInfo.dutyAdvister}</td>
 						<td align="center">${courseInfo.carer}</td>
 					</tr>
 				</c:forEach>
 			</tr>
 			<tr>
 				<td colspan="2" align="right">延长至：</td>
 				<td colspan="10"><input class="easyui-datebox" name="delayDate" id="delayDate" style="width:150px;"  /></td>
 			</tr>
 			<tr>
 				<td colspan="2" align="right">备注：</td>
 				<td colspan="10"><textarea rows="7" cols="100" id="updateRemark" name="updateRemark" class="easyui-validatebox textbox" required="true"></textarea></td>
 			</tr>
 		</table>
 		</div>
 		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
 		<input id="studentId" type="hidden" value="${obj.studentInfo.studentId}" />
 		<input id="leaveId" type="hidden" value="${obj.leaveInfo.leaveId}" />
 		<input id="studentCourseId" type="hidden" value="${obj.leaveInfo.studentCourseId}" />
 		<input id="leaveDate" type="hidden" value="${obj.leaveInfo.leaveDate}" />
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: right;">
	      		<a href="javascript:void(0)" id="restartClassSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;" onclick="updateSubmit()">提交</a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
  	</body>
</html>
