<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String studentCourseId = request.getParameter("studentCourseId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/selectClass/selectClass.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="选班基础信息">
  			<form id="selectClassFm">
  				<input type="hidden" id="schoolId"/>
  				<input type="hidden" id="courseType"/>
  				<input type="hidden" id="stageId"/>
  				<input type="hidden" id="classType"/>
  				<input type="hidden" id="studentId"/>
  				<input type="hidden" id="oldClassName"/>
  				<input type="hidden" id="oldClassInstId"/>
  				<input type="hidden" id="outSchoolName"/>
  				<input type="hidden" id="feeType"/>
  				<input type="hidden" id="oldCourseState"/>
  				<input type="hidden" id="studentCourseId" name="studentCourseId" value="<%=studentCourseId %>"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  				<table width="100%" cellpadding="5px" class="maintable" id="selectClassTd">
  					<tr>
  						<td align="right" width="15%"><span>学员姓名：</span></td>
  						<td width="15%"><span id="nameText"></span></td>
  						<td align="right" width="12%"><span>出生日期：</span></td>
  						<td width="20%"><span id="birthdayText"></span></td>
  						<td align="right" width="12%"><span>业绩类型：</span></td>
  						<td width="26%"><span id="feeTypeText"></span></td>
  					</tr>
  					<tr>
  						<td align="right"><span>性别：</span></td>
  						<td><span id="sexText"></span></td>
  						<td align="right"><span>证件号码：</span></td>
  						<td><span id="identityIdText"></span></td>
  						<td align="right"><span>联系电话：</span></td>
  						<td><span id="phoneText"></span></td>
  					</tr>
  					<tr>
  						<td align="right"><span>英文名：</span></td>
  						<td><span id="byNameText"></span></td>
  						<td align="right"><span>缴费日期：</span></td>
  						<td><span id="payDateText"></span></td>
  						<td align="right"><span>责任顾问：</span></td>
  						<td><span id="dutyAdvisterNameText"></span></td>
  					</tr>
  					<tr>
  						<td align="right"><span id="adviserTeacher">业绩老师：</span></td>
  						<td><span id="adviserTeacherNameText"></span></td>
  						<td align="right"><span>班级类型：</span></td>
  						<td colspan="3"><span id="classTypeText"></span></td>
  					</tr>
  					<tr>
  						<td align="right"><span>当前选班班级：</span></td>
  						<td><span id="currentClassNameText"></span></td>
  						<td align="right"><span>选班时间：</span></td>
  						<td><span id="selectClassDateText"></span></td>
  						<td align="right"><span>选班次数：</span></td>
  						<td><span id="selectClassNumText"></span></td>
  					</tr>
  					<tr>
  						<td align="right"><span>是否定班：</span></td>
  						<td><span id="courseStateText"></span></td>
  						<td colspan="4" style="vertical-align:middle;">
  							<input type="radio" name="isBegin" value="N"/>
  							<span style="display: inline-block; text-align: center;">未开课班级</span>
  							<select id="notBeginClassInstId" name="notBeginClassInstId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"></select>
  							<input type="radio" name="isBegin" value="Y"/>
  							<span style="display: inline-block; text-align: center;">已开课班级</span>
  							<select id="beginClassInstId" name="beginClassInstId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"></select>
  						</td>
  					</tr>
  				</table>
  			</form>
  		</div>
  		<div style="height: 10px;"></div>
  		<div style="display: none;min-width:1100px; width:100%;height:auto;" id="changeDiv">
	  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="选择班级情况">
	  			<form id="">
	  				<table width="99.99%" cellpadding="5px" class="maintable">
			  			<tr>
			  				<td align="right" width="10%"><span>班级名称：</span></td>
				  			<td width="15%"><span id="classNameText"></span></td>
				  			<td align="right" width="10%"><span>放班日期：</span></td>
				  			<td width="15%"><span id="applyDate"></span></td>
				  			<td align="right" width="10%"><span>开课日期：</span></td>
				  			<td width="10%"><span id="startDate"></span></td>
				  			<td align="right" width="10%"><span>带班老师：</span></td>
				  			<td width="20%" style="border-right: 0px;"><span id="teacherName"></span></td>
			  			</tr>
			  			<tr>
			  				<td align="right" width="10%" style="border-bottom: 0px;"><span>定班人数：</span></td>
				  			<td width="20%" style="border-bottom: 0px;"><span id="classStudentNum"></span></td>
				  			<td align="right" width="10%" style="border-bottom: 0px;"><span>课程进度：</span></td>
				  			<td width="20%" style="border-bottom: 0px;"><span id="classProgress"></span></td>
				  			<td align="right" width="10%" style="border-bottom: 0px;"><span>上课时段：</span></td>
				  			<td width="30%" colspan="3" style="border-right: 0px; border-bottom: 0px;"><span id="schooltimeName"></span></td>
			  			</tr>
			  		</table>
	  			</form>
	  		</div>
  		</div>
  		<div style="margin-top: 25px;min-width:1100px; width:99%;text-align: right;">
	    	<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      	&nbsp;<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	   	</div>
  	</body>
</html>
