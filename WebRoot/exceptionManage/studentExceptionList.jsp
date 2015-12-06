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
  	</head>
  
  	<body>
  		<table class="easyui-datagrid" title="学员异动维护信息" style="height:auto;"
			url="<%=path %>/pubData/qryDataListByPage.do?param={funcNodeId:'1031',studentId:'<%=studentId %>'}" 
			pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th data-options="field:'exceptionTypeText',width:200,align:'center'">异动类型</th>
					<th data-options="field:'stageId',width:100,align:'center'">异动课程阶段</th>
					<th data-options="field:'payDate',width:100,align:'center'">缴费日期</th>
					<th data-options="field:'dutyAdvisterName',width:80,align:'center'">责任顾问</th>
					<th data-options="field:'carerName',width:80,align:'center'">客户关怀</th>
					<th data-options="field:'teacherName',width:150,align:'center'">带班老师</th>
					<th data-options="field:'className',width:150,align:'center'">班级</th>
					<th data-options="field:'num',width:100,align:'center'">跟进次数</th>
					<th data-options="field:'num',width:100,align:'center'">异动开始时间</th>
					<th data-options="field:'exceptionDays',width:100,align:'center'">异动时长（天）</th>
					<th data-options="field:'num',width:100,align:'center'">异动结束时间</th>
				</tr>
			</thead>
		</table>
  	</body>
</html>
