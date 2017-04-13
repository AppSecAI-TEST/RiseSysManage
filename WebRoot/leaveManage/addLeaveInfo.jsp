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
  	</head>
  	<body>
  		<input type="hidden" id="channel" value="${obj.studentInfo.channelSourse }"/>
  		<input type="hidden" id="funcNodeId" value="${obj.studentInfo.funcNodeId }"/>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="学员基础信息">
  			<table width="100%" cellpadding="5px" class="maintable" id="studentTd">
  				<tr>
  					<td align="right"><span>学员姓名：</span></td>
  					<td align="left"><span>${obj.studentInfo.name}</span></td>
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
  			</table>
  		</div>
		<div style="height: 5px;"></div>
   		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="学员课程信息">
 		<form id="addLeaveForm" method="post" enctype="multipart/form-data">
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
 				<td align="right"><span>休学时长：</span></td>
 				<td colspan="2"><input class="easyui-numberbox" name="planLeaveTime" id="planLeaveTime" style="width:120px;height: 25px;" data-options="min:1" required="true"/></td>
 				<td colspan="11"><span>休学申请单与缴费凭证：</span>
 					<input type="hidden" name="imgUrl" id="imgUrl"/>
                    <input style="width: 500px; height: 28px;" class="easyui-filebox" name="fileName" id="fileName" data-options="prompt:'', buttonText: '文件选择', accept: 'image/*'"/>
                    <a href="javascript:void(0)" class="easyui-linkbutton" id="uploadBtn" iconCls="icon-save" iconCls="icon-save" style="width: 100px; height: 25px;"><span>上传</span></a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" id="cancelUploadBtn" iconCls="icon-cancel" iconCls="icon-cancel" style="width: 100px; height: 25px;"><span>取消</span></a>
				</td>
 			</tr>
 			<tr>
 				<td align="right"><span>备注：</span></td>
 				<td colspan="13"><textarea rows="7" cols="100" id="addRemark" name="addRemark" class="textarea easyui-validatebox" validType="length[0,120]"></textarea></td>
 			</tr>
 		</table>
 		</form>
 		</div>
 		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
 		<input id="studentId" type="hidden" value="${obj.studentInfo.studentId}" />
 		<input id="schoolId" type="hidden" value="${schoolId}" />
 		<input id="courseState" type="hidden" value="${courseState}" />
 		<input id="stageLevel" type="hidden" value="${stageLevel}" />
 		<input id="classInstId" type="hidden" value="${classInstId}" />
 		<input id="className" type="hidden" value="${className}" />
 		<input id="teacherName" type="hidden" value="${teacherName}" />
 		<input id="studentCourseId" type="hidden" value="${studentCourseId}" />
 		<input id="currentHours" type="hidden" value="${currentHours}" />
      	<table style="margin-top: 20px;min-width:1100px; width:99%;">
      		<tr>
      			<td align="right">
		      		<a href="javascript:void(0)" id="addLeaveSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 100px;" onclick="addLeaveSubmit()"><span>提交</span></a>
		      		&nbsp;
		      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
      			</td>
      		</tr>
      	</table>
  	</body>
</html>
