<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="班级维护">
  			<form id="maintenanceClassFm">
	  			<table width="99.99%" cellpadding="5px" class="maintable">
	  				<tr>
	  					<td align="right" width="10%"><span>课程阶段：</span></td>
	  					<td width="20%"><span id="stageId">${obj.createClassObj.stageId }</span></td>
	  					<td align="right" width="10%"><span>班级类型：</span></td>
	  					<td width="20%"><span id="classType">${obj.createClassObj.classType }</span></td>
	  					<td align="right" width="10%"><span>班级名称：</span></td>
	  					<td width="30%"><span id="className">${obj.createClassObj.className }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>开课时间：</span></td>
	  					<td width="20%"><span>${obj.createClassObj.startDate }</span></td>
	  					<td align="right" width="10%"><span>学员来源类型：</span></td>
	  					<td width="20%"><span id="studentChannelTypeVal">${obj.createClassObj.studentChannelTypeVal }</span></td>
	  					<td align="right" width="10%"><span>来源班级：</span></td>
	  					<td width="30%"><span id="higherSchoolName">${obj.createClassObj.higherSchoolName }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>开班类型：</span></td>
	  					<td width="20%"><span>${obj.createClassObj.startDate }</span></td>
	  					<td align="right" width="10%"><span>开班人数：</span></td>
	  					<td width="20%"><span id="studentChannelTypeVal">${obj.createClassObj.studentChannelTypeVal }</span></td>
	  					<td align="right" width="10%"><span>在读人数：</span></td>
	  					<td width="30%"><span id="higherSchoolName">${obj.createClassObj.higherSchoolName }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>升学基数：</span></td>
	  					<td width="20%"><span>${obj.createClassObj.startDate }</span></td>
	  					<td align="right" width="10%"><span>已升学人数：</span></td>
	  					<td width="20%"><span id="studentChannelTypeVal">${obj.createClassObj.studentChannelTypeVal }</span></td>
	  					<td align="right" width="10%"><span>升学率：</span></td>
	  					<td width="30%"><span id="higherSchoolName">${obj.createClassObj.higherSchoolName }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>课时进度：</span></td>
	  					<td width="20%"><span>${obj.createClassObj.startDate }</span></td>
	  					<td align="right" width="10%"><span>持证率：</span></td>
	  					<td width="20%"><span id="studentChannelTypeVal">${obj.createClassObj.studentChannelTypeVal }</span></td>
	  					<td align="right" width="10%"><span>班级性质：</span></td>
	  					<td width="30%"><span id="higherSchoolName">${obj.createClassObj.higherSchoolName }</span></td>
	  				</tr>
	  				<tr>
  						<td colspan="6">
  							<table width="100%" cellpadding="5px" id="schooltimeTb" class="maintable">
  								<tr>
  									<td align="center" width='4%'><span>序号</span></td>
  									<td align="center" width='14%'><span>上课时段</span></td>
  									<td align="center" width='4%'><span>教室</span></td>
  									<td align="center" width='4%'><span>课时</span></td>
  									<td align="center" width='64%'><span>带班老师</span></td>
  									<td align="center" width='10%'><span>操作</span></td>
  								</tr>
  								<c:forEach items="${obj.schooltimeObj.rows }" var="schooltime" varStatus="status">
	  								<tr>
					        			<input type='hidden' name='schooltimes' roomId='${schooltime.roomId }' weekTime='${schooltime.weekTime }' hourRange='${schooltime.hourRange }' lessionHours='${schooltime.lessionHours }' addNum='${status.index + 1 }' schooltimeId='${schooltime.schooltimeId }'/>
	  									<td align="center" width='4%' lessionHours='${schooltime.lessionHours }' weekTime='${schooltime.weekTime }' hourRange='${schooltime.hourRange }'><span>${status.index + 1 }</span></td>
	  									<td align="center" width='14%'><span>${schooltime.schooltimeName }</span></td>
	  									<td align="center" width='4%'>
	  										<select name='roomId' id="roomId${status.index + 1 }" class="easyui-combobox" style="width: 80px; height: 28px;" weekTime='${schooltime.weekTime }' hourRange='${schooltime.hourRange }'>
					        				</select>
	  									</td>
	  									<td align="center" width='4%'><span>${schooltime.lessionHours }</span></td>
	  									<td width='64%' lessions='${schooltime.lessionHours }'>
	  										<c:forEach items="${schooltime.classTeacherList }" var="classTeacher">
	  											<span id="teacher${classTeacher.teacherId }${schooltime.weekTime }${schooltime.hourRange }">
	  												${classTeacher.schoolName }&nbsp;${classTeacher.byname }&nbsp;${classTeacher.hours }&nbsp;${classTeacher.isLicense }&nbsp;
	  												<a href='javascript:void(0)' class='linkmore' onclick="deleteTeacher(this, ${classTeacher.teacherId })"><span>删除</span></a>
	  												<input type='hidden' name='teachers' teacherId='${classTeacher.teacherId }' weekTime='${schooltime.weekTime }' hourRange='${schooltime.hourRange }' lessions='${classTeacher.hours }' classTeacherId='${classTeacher.classTeacherId }'/>&nbsp;
	  											</span>
	  										</c:forEach>
	  									</td>
	  									<td align="center" width='10%'>
	  										<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px; height: 28px;" onclick="addTeacher(this)">添加老师</a>
	  									</td>
	  								</tr>
  								</c:forEach>
  							</table>
  						</td>
  					</tr>
  					<tr>
	  					<td align="right" width="10%"><span>老师变更备注：</span></td>
	  					<td>
	  						<textarea rows="6" cols="122" id="remark" name="remark" required="true" class="easyui-validatebox textbox"></textarea>
	  					</td>
	  				</tr>
	  			</table>
  			</form>
  		</div>
  	</body>
</html>
