<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String studentId = request.getParameter("studentId");
	String expType = request.getParameter("expType");
	String studentCourseId = request.getParameter("studentCourseId");
%>
<html>
	<head>
	<%@ include file="../common/head.jsp" %>
	<%@ include file="../common/formvalidator.jsp" %>
	<style>
		.datagrid
		{
			min-width:500px;
		}
	</style>
	</head>
	<body>
		<table class="easyui-datagrid" align="center" title="异动跟进历史信息" style="width:720px;margin:5px auto;height:300px;" id="followHis_data" url="<%=path %>/pubData/qryDataListByPage.do?param={'queryCode':'qryExpFollowHisInfo','studentId':'<%=studentId%>','expType':'<%=expType%>','studentCourseId':'<%=studentCourseId%>'}" 
		border="true" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true" data-options="onLoadSuccess:function(data){$('#followHis_data').datagrid('clearSelections');}">
			<thead>
				<tr>
					<th field="handlerName" align="center" width="20%">维护人</th>
					<th field="createDate" align="center" width="20%">跟进时间</th>
					<th field="exceptionTypeVal" align="center" width="20%">异动类型</th>
					<th field="remark" align="center" width="40%">跟进记录</th>
				</tr>
			</thead>
		</table>
		<div style="margin-top: 10px;margin-right:10px;text-align:right;">
	      	<a href="javascript:void(0)" id="back" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:parent.window.$('#dlg').dialog('close')">返回</a>
	     </div>
	</body>
</html>