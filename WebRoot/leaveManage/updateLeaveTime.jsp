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
		<script type="text/javascript" src="<%=path %>/js/leaveManage/leaveManage.js"></script>
		<script type="text/javascript">
		   	$(document).ready(function(){
		   		 $("#delayDate").datebox("setValue","${obj.leaveInfo.leaveDate}")
		   		 $("#leaveImgUrl").lightBox();
		   	});
	   </script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="学员基础信息">
  			<table width="100%" cellpadding="5px" class="maintable" id="studentTd">
  				<tr>
  					<td align="right"><span>学员姓名：</span></td>
  					<td align="left"><span>${obj.studentInfo.name}</span></td>
  					<td align="right"><span>出生日期：</td>
  					<td align="left"><span>${obj.studentInfo.birthday}</span></td>
  					<td align="right"><span>性别：</span></td>
  					<td align="left"><span>${obj.studentInfo.sexVal}</span></td>
  				</tr>
  				<tr>
  					<td align="right"><span>证件号码：</span></td>
  					<td align="left"><span>${obj.studentInfo.identityId}</span></td>
  					<td align="right"><span>英文名：</span></td>
  					<td align="left"><span>${obj.studentInfo.byName}</span></td>
  					<td align="right"><span>联系电话：</span></td>
  					<td align="left"><span>${obj.studentInfo.phone}</span></td>
  				</tr>
  				<tr>
  					<td align="right"><span>所属校区：</span></td>
  					<td align="left"><span>${obj.studentInfo.schoolName}</span></td>
  					<td align="right"><span>责任顾问：</span></td>
  					<td align="left"><span>${obj.studentInfo.dutyAdvisterName}</span></td>
  					<td align="right"><span>客户关怀：</span></td>
  					<td align="left"><span>${obj.studentInfo.carerName}</span></td>
  				</tr>
  				<tr>
  					<td align="right"><span>休学开始时间：</span></td>
  					<td align="left"><span id="leaveStartDate">${obj.leaveInfo.createDate}</span></td>
  					<td align="right"><span>计划休学时长：</span></td>
  					<td align="left"><span>${obj.leaveInfo.leaveTime}个月</span></td>
  					<td align="right"><span>操作人员：</span></td>
  					<td align="left"><span>${obj.leaveInfo.handerName}</span></td>
  				</tr>
  				<tr>
  					<td align="right"><span>休学剩余时间：</span></td>
  					<c:if test="${obj.leaveInfo.leftTime >= 0}">
  						<td align="left"><span>${obj.leaveInfo.leftTime}天</span></td>
  					</c:if>
  					<c:if test="${obj.leaveInfo.leftTime < 0}">
  						<td align="left"><span>0天</span></td>
  					</c:if>
  					<td align="right"><span>休学状态：</span></td>
  					<td align="left"><span>${obj.leaveInfo.leaveState}</span></td>
  					<td align="right"><span>查看休学申请：</span></td>
  					<td align="left">
						<c:if test="${!empty obj.leaveInfo.imgUrl }">
  							<span style="margin-right: 200px"><a href="${obj.leaveInfo.imgUrl }" id="leaveImgUrl" class="linkmore">查看休学申请单</a></span>
  						</c:if>
					</td>
  				</tr>
  			</table>
  		</div>
		<div style="height: 5px;"></div>
   		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="学员课程信息">
 		<table width="100%" cellpadding="5px" class="maintable" id="courseTd">
 			<tr>
 				<td align="center"><span>课程阶段</span></td>
 				<td align="center"><span>课程状态</span></td>
 				<td align="center"><span>校区</span></td>
 				<td align="center"><span>缴费时间</span></td>
 				<td align="center"><span>业绩类型</span></td>
 				<td align="center"><span>班级</span></td>
 				<td align="center"><span>开课日期</span></td>
 				<td align="center"><span>结课日期</span></td>
 				<td align="center"><span>课程进度</span></td>
 				<td align="center"><span>带班老师</span></td>
 				<td align="center"><span>业绩顾问</span></td>
 				<td align="center"><span>业绩老师</span></td>
 				<td align="center"><span>责任顾问</span></td>
 				<td align="center"><span>客户关怀</span></td>
 				<c:forEach items="${obj.courseInfo}" var="courseInfo">
 					<tr>
 						<td align="center"><span>${courseInfo.stageId}</span></td>
 						<td align="center"><span>${courseInfo.courseStateText}</span></td>
 						<td align="center"><span>${courseInfo.paySchoolName}</span></td>
 						<td align="center"><span>${courseInfo.payDate}</span></td>
 						<td align="center"><span>${courseInfo.feeTypeText}</span></td>
 						<td align="center"><span>${courseInfo.className}</span></td>
 						<td align="center"><span>${courseInfo.startDate}</span></td>
 						<td align="center"><span>${courseInfo.finishDate}</span></td>
 						<td align="center"><span>${courseInfo.classProgress}</span></td>
 						<td align="center"><span>${courseInfo.classTeacherName}</span></td>
 						<td align="center"><span>${courseInfo.adviserName}</span></td>
 						<td align="center"><span>${courseInfo.adviserTeacherName}</span></td>
 						<td align="center"><span>${courseInfo.dutyAdvisterName}</span></td>
 						<td align="center"><span>${courseInfo.carerName}</span></td>
 					</tr>
 				</c:forEach>
 			</tr>
 			<tr>
 				<td colspan="2" align="right"><span>延长至：</span></td>
 				<td colspan="10"><input class="easyui-datebox" name="delayDate" id="delayDate" style="width:100px;height:25px;" editable="false"/></td>
 			</tr>
 			<tr>
 				<td colspan="2" align="right"><span>备注：</span></td>
 				<td colspan="10"><textarea rows="7" cols="100" id="updateRemark" name="updateRemark" class="easyui-validatebox textbox"></textarea></td>
 			</tr>
 		</table>
 		</div>
 		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
 		<input id="studentId" type="hidden" value="${obj.studentInfo.studentId}" />
 		<input id="leaveId" type="hidden" value="${obj.leaveInfo.leaveId}" />
 		<input id="studentCourseId" type="hidden" value="${obj.leaveInfo.studentCourseId}" />
 		<input id="leaveDate" type="hidden" value="${obj.leaveInfo.leaveDate}" />
 		<table style="margin-top: 20px;min-width:1100px; width:99%;">
			<tr>
				<td align="center">
					<a href="javascript:void(0)" id="updateSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 100px;" onclick="updateSubmit()"><span>提交</span></a>
		      		&nbsp;
		      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
				</td>
			</tr>
		</table>
  	</body>
</html>
