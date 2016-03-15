<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String actionId =request.getParameter("actionId");
	String operate =request.getParameter("operate");
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/action/replyAction.js"></script>
	</head>
	<body>
		<div id ="baseInfo" class="easyui-panel" title="基本信息" style="width:1100px;">
		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
		<input id="actionId" type="hidden" value="<%=actionId%>"/>
		<input id="operate" type="hidden" value="<%=operate%>"/>
  			<table id ="infoTab" width="100%;" class="maintable">
  				<tr>
  					<td width="15%" align="right"><span>校区：</span></td>
  					<td align="left" colspan="2">
  					</td>
  				</tr>
  				<tr>
  					<td width="15%" align="right"><span>活动时间：</span></td>
  					<td align="left" colspan="2" >
  					</td>
  				</tr>
  				<tr>
  					<td align="right" ><span>活动名称：</span></td>
  					<td align="left" colspan="2">
  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>课时：</span></td>
  					<td align="left" colspan="2">
  						  <input type="text" class="easyui-numberbox" id="realHours" name="realHours" data-options="min:1,max:24,precision:0"  style="width:100px;height: 25px;">
  					</td>
  				</tr>
  				<tr id="addInfo">
  					<td align="right"><span>老师：</span></td>
  					<td align="left">
  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:100px;height: 25px;" editable="false"
  							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
  						</select>
  						&nbsp;&nbsp;
  						<select class="easyui-combobox" name="teacherId" id="teacherId" style="width:100px;height: 25px;" editable="false"
  							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'">
  						</select>
  						&nbsp;&nbsp;
  						<select class="easyui-combobox" name="teacherType" id="teacherType" style="width:100px;height: 25px;" editable="false"
  							 data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      				 url="<%=path %>/pubData/qryCodeNameList.do?tableName=ACTION_T&codeType=TEACHER_TYPE">
  						</select>
  						&nbsp;&nbsp;
  						<input type="text" class="easyui-numberbox" id="hours" name="hours" data-options="min:1,max:24,precision:0"  style="width:100px;height: 25px;">
  					</td>
  					<td width="20%" align="center">
  						<a href="javascript:void(0)" id="addBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px"><span>添加</span></a>
  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>反馈备注：</span></td>
  					<td align="left" colspan="2">
  						<textarea rows="8" cols="100" id="replyRemark" name="replyRemark" class="easyui-validatebox textbox"></textarea>
  					</td>
  				</tr>
  			</table>
  		</div>
  		<div style="width:1100px;text-align:center;margin-top:25px;">
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:150px" id="submitBtn">提交</a>
  				&nbsp;&nbsp;&nbsp;&nbsp;
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:150px" id="backBtn" >返回</a>	
  		</div>	
	</body>
</html>		