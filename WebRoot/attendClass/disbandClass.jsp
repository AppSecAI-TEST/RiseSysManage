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
		<script type="text/javascript" src="<%=path %>/js/attendClass/disbandClass.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="班级解散">
  			<form id="disbandClassFm">
  				<input type="hidden" id="applyId" name="applyId" value="${obj.attendClassObj.applyId }"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  				<input type="hidden" id="classInstId" name="classInstId" value="${obj.attendClassObj.classInstId }"/>
  				<input type="hidden" id="classStudentNum" value="${obj.attendClassObj.classStudentNum }"/>
	  			<table width="99.99%" cellpadding="5px" class="maintable">
	  				<tr>
	  					<td align="right" width="10%"><span>课程阶段：</span></td>
	  					<td width="20%"><span id="stageId">${obj.attendClassObj.stageId }</span></td>
	  					<td align="right" width="10%"><span>班级类型：</span></td>
	  					<td width="20%"><span id="classType">${obj.attendClassObj.classType }</span></td>
	  					<td align="right" width="10%"><span>班级名称：</span></td>
	  					<td width="30%"><span id="className">${obj.attendClassObj.className }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>结课时间：</span></td>
	  					<td width="20%"><span>${obj.attendClassObj.finishDate }</span></td>
	  					<td align="right" width="10%"><span>学员来源类型：</span></td>
	  					<td width="20%"><span id="studentChannelTypeVal">${obj.attendClassObj.studentChannelTypeText }</span></td>
	  					<td align="right" width="10%"><span>来源班级：</span></td>
	  					<td width="30%"><span id="higherSchoolName">${obj.attendClassObj.higherSchoolName }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>开课时间：</span></td>
	  					<td width="20%"><span>${obj.attendClassObj.startDate }</span></td>
	  					<td align="right" width="10%"><span>开班类型：</span></td>
	  					<td width="20%"><span>${obj.attendClassObj.openClassTypeText }</span></td>
	  					<td align="right" width="10%"><span>开班人数：</span></td>
	  					<td width="30%"><span id="studentChannelTypeVal">${obj.attendClassObj.openClassNum }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>在读人数：</span></td>
	  					<td width="20%"><span id="higherSchoolName">${obj.attendClassObj.classStudentNum }</span></td>
	  					<td align="right" width="10%"><span>已升学人数：</span></td>
	  					<td width="20%"><span id="studentChannelTypeVal">${obj.attendClassObj.higherStudentNum }</span></td>
	  					<td align="right" width="10%"><span>升学率：</span></td>
	  					<td width="30%"><span id="higherSchoolName">${obj.attendClassObj.higherRateText }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>课时进度：</span></td>
	  					<td width="20%"><span>${obj.attendClassObj.classProgress }</span></td>
	  					<td align="right" width="10%"><span>持证率：</span></td>
	  					<td width="20%"><span id="studentChannelTypeVal">${obj.attendClassObj.licenseRateText }</span></td>
	  					<td align="right" width="10%"><span>班级性质：</span></td>
	  					<td width="30%"><span id="higherSchoolName">${obj.attendClassObj.handTypeText }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>解散原因：</span></td>
	  					<td colspan="5">
	  						<textarea rows="6" cols="122" id="remark" name="remark" class="textarea easyui-validatebox" validType="length[0,120]"></textarea>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td colspan="6" align="right">
	  						<a href="javascript:void(0)" id="disbandClassSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
		      				&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.location.href='/sys/attendClass/attendClassList.jsp?funcNodeId=${funcNodeId}'">返回</a>
		      				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  					</td>
	  				</tr>
	  			</table>
  			</form>
  		</div>
  	</body>
</html>
