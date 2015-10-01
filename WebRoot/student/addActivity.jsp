<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String studentId = request.getParameter("studentId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/student/student.js"></script>
  	</head>
  
  	<body>
      	<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="活动信息">
      		<form id="activityFm">
      			<input type="hidden" id="studentId" name="studentId" value="<%=studentId %>"/>
      			<table width="100%" cellpadding="5px" class="maintable" id="addActivityTd">
      				<tr>
      					<td align="right"><span style="color: red;">*</span><span>活动标题：</span></td>
	      				<td>
	      					<select name="title" id="title" class="easyui-combobox" style="width: 400px; height: 28px;"
	      					data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      					onLoadSuccess:function(data){$('#title').combobox('setValue',data[0].codeFlag);}" 
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=ACTIVITY_T&codeType=TITLE" required="true">
        					</select>
	      				</td>
      				</tr>
      				<tr>
      					<td align="right"><span style="color: red;">*</span><span>活动时间：</span></td>
	      				<td>
	      					<input name="activityDate" id="activityDate" type="text" class="easyui-datebox" required="true" style="width: 200px; height: 28px;"/>
	      				</td>
      				</tr>
      				<tr>
      					<td align="right"><span>获奖情况：</span></td>
	      				<td>
	      					<select name="award" id="award" class="easyui-combobox" style="width: 400px; height: 28px;"
	      					data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      					onLoadSuccess:function(data){$('#award').combobox('setValue',data[0].codeFlag);}" 
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=ACTIVITY_T&codeType=AWARD">
        					</select>
	      				</td>
      				</tr>
      				<tr>
      					<td align="right"><span>活动详细：</span></td>
	      				<td>
	      					<textarea rows="9" cols="54" id="remark" name="remark" class="easyui-validatebox textbox"></textarea>
	      				</td>
      				</tr>
      			</table>
      		</form>
      	</div>
      		
      	<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: left;margin-left: 900px;">
	      		<a href="javascript:void(0)" id="activitySubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      		&nbsp;<a href="javascript:void(0)" id="activityBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	    </div>
  	</body>
</html>
