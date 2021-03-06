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
		.datagrid {
			min-width:500px;
		}
	</style>
	</head>
	<body>
		<table class="easyui-datagrid" align="center" title="异动跟进历史信息" style="width:100%;height:421px;" id="followHis_data" 
			url="<%=path %>/pubData/qryDataListByPage.do?param={'queryCode':'qryExpFollowHisInfo','studentId':'<%=studentId%>','expType':'<%=expType%>','studentCourseId':'<%=studentCourseId%>'}" 
			border="true" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true" data-options="onLoadSuccess:function(data){$('#followHis_data').datagrid('clearSelections');}">
			<thead>
				<tr>
					<th field="handlerName" align="center" width="20%"><span>维护人</span></th>
					<th field="createDate" align="center" width="20%"><span>跟进时间</span></th>
					<th field="exceptionTypeVal" align="center" width="20%"><span>异动类型</span></th>
					<th field="remark" align="center" width="40%"><span>跟进记录</span></th>
				</tr>
			</thead>
		</table>
	</body>
</html>