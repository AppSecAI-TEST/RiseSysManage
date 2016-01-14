<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String applyId = request.getParameter("applyId");
	String schoolId = request.getParameter("schoolId");
	System.err.println(schoolId)
	String studentId = request.getParameter("studentId");
	String studentCourseId = request.getParameter("studentCourseId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/changeClass/changeIn.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="转班转入">
  			<form id="changeInClassFm">
  				<input type="hidden" id="stageId"/>
  				<input type="hidden" id="classType"/>
  				<input type="hidden" id="inClassId"/>
  				<input type="hidden" id="courseType"/>
  				<input type="hidden" id="outClassId"/>
  				<input type="hidden" id="inClassIsBegin"/>
  				<input type="hidden" id="applyId" name="applyId" value="<%=applyId %>"/>
  				<input type="hidden" id="studentChannelType" name="studentChannelType"/>
  				<input type="hidden" id="schoolId" name="schoolId" value="<%=schoolId %>"/>
  				<input type="hidden" id="studentId" name="studentId" value="<%=studentId %>"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  				<input type="hidden" id="studentCourseId" name="studentCourseId" value="<%=studentCourseId %>"/>
  				<table width="100%" cellpadding="5px" class="maintable" id="changeInClassTd">
  					<tr>
  						<td align="right" width="15%"><span>学员姓名：</span></td>
  						<td width="15%"><span id="nameText"></span></td>
  						<td align="right" width="15%"><span>出生日期：</span></td>
  						<td width="20%"><span id="birthdayText"></span></td>
  						<td align="right" width="15%"><span>业绩类型：</span></td>
  						<td width="20%"><span id="feeTypeText"></span></td>
  					</tr>
  					<tr>
  						<td align="right" width="15%"><span>性别：</span></td>
  						<td width="15%"><span id="sexText"></span></td>
  						<td align="right" width="15%"><span>证件号码：</span></td>
  						<td width="20%"><span id="identityIdText"></span></td>
  						<td align="right" width="15%"><span>联系电话：</span></td>
  						<td width="20%"><span id="phoneText"></span></td>
  					</tr>
  					<tr>
  						<td align="right" width="15%"><span>英文名：</span></td>
  						<td width="15%"><span id="byNameText"></span></td>
  						<td align="right" width="15%"><span>责任顾问：</span></td>
  						<td width="20%"><span id="dutyAdvisterNameText"></span></td>
  						<td align="right" width="15%"><span>业绩老师：</span></td>
  						<td width="20%"><span id="adviserTeacherNameText"></span></td>
  					</tr>
  					<tr>
  						<td align="right" width="15%"><span>缴费日期：</span></td>
  						<td width="15%"><span id="payDateText"></span></td>
  						<td align="right" width="15%"><span>班级类型：</span></td>
  						<td width="20%"><span id="classTypeText"></span></td>
  						<td align="right" width="15%"><span>计划转入班级：</span></td>
  						<td width="20%"><span id="planInClassNameText"></span></td>
  					</tr>
  					<tr>
  						<td align="right" width="15%"><span>转出班级：</span></td>
  						<td width="15%"><span id="outClassNameText"></span></td>
  						<td align="right" width="15%"><span>原班课时进度：</span></td>
  						<td width="20%"><span id="outClassProgressText"></span></td>
  						<td align="right" width="15%"><span>转出时间：</span></td>
  						<td width="20%"><span id="outDateText"></span></td>
  					</tr>
  					<tr>
  						<td align="right" width="15%"><span>转入班级：</span></td>
  						<td width="85%" colspan="5">
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
  		<div style="display: none;" id="changeDiv">
	  		<div class="easyui-panel" style="min-width:1100px; width:100%;height:auto;" title="选择班级情况">
	  			<form id="">
	  				<table width="99.99%" cellpadding="5px" class="maintable">
	  					<tr>
	  						<td align="right" width="10%"><span>班级名称：</span></td>
		  					<td width="15%"><span id="classNameText"></span></td>
		  					<td align="right" width="10%"><span>放班时间：</span></td>
		  					<td width="15%"><span id="applyDate"></span></td>
		  					<td align="right" width="10%"><span>开班时间：</span></td>
		  					<td width="10%"><span id="startDate"></span></td>
		  					<td align="right" width="10%"><span>带班老师：</span></td>
		  					<td width="20%"><span id="teacherName"></span></td>
	  					</tr>
	  					<tr>
	  						<td align="right" width="10%"><span>定班人数：</span></td>
		  					<td width="20%"><span id="classStudentNum"></span></td>
		  					<td align="right" width="10%"><span>课程进度：</span></td>
		  					<td width="20%"><span id="classProgress"></span></td>
		  					<td align="right" width="10%"><span>上课时段：</span></td>
		  					<td width="30%" colspan="3"><span id="schooltimeName"></span></td>
	  					</tr>
	  				</table>
	  			</form>
	  		</div>
  		</div>
  		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: left;margin-left: 800px;">
	      		<a href="javascript:void(0)" id="changeInSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      		&nbsp;<a href="javascript:void(0)" id="activityBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	    </div>
  	</body>
</html>
