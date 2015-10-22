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
  			<form id="disbandClassFm">
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
	  					<td align="right" width="10%"><span>解散原因：</span></td>
	  					<td>
	  						<textarea rows="6" cols="122" id="remark" name="remark" required="true" class="easyui-validatebox textbox"></textarea>
	  					</td>
	  				</tr>
	  			</table>
  			</form>
  		</div>
  	</body>
</html>
