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
      	<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="VIP维护信息添加">
      		<form id="vipRemarkFm">
      			<input type="hidden" id="studentId" name="studentId" value="<%=studentId %>"/>
      			<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
      			<table width="100%" cellpadding="5px" class="maintable" id="addActivityTd">
      				<tr>
      					<td>
			      			<textarea rows="9" cols="120" id="vipRemark" name="vipRemark" class="easyui-validatebox textbox" required="true"></textarea>
      					</td>
      				</tr>
      			</table>
      		</form>
      	</div>
      		
      	<div style="margin-top: 20px;min-width:1100px; width:99%;">
		    <div style="float: left; margin-left: 800px;">
		      	<a href="javascript:void(0)" id="vipRemarkSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
		      	&nbsp;<a href="javascript:void(0)" id="vipRemarkReset" class="easyui-linkbutton" iconCls="icon-reload" style="width: 80px; height: 28px;" onclick="javascript:$('#vipRemarkFm').form('clear');">重置</a>
		      	&nbsp;<a href="javascript:void(0)" id="vipRemarkBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
			</div>
      	</div>
  	</body>
</html>
