<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String studentId = request.getParameter("studentId");
	String studentCourseId = request.getParameter("studentCourseId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  
  	<body>
  		<div style="padding:5px 0;min-width:1100px; width:100%;">
		  	<table class="easyui-datagrid" title="选班历史信息" style="height:auto;" id="list_data" pagination="false" rownumbers="true" fitColumns="true" singleSelect="true"
		  		url="<%=path %>/pubData/qryDataListByPage.do?param={studentId:'<%=studentId %>',studentCourseId:'<%=studentCourseId %>',funcNodeId:'1027'}">
				<thead>
					<tr>
						<th data-options="field:'schoolName',width:100,align:'center'">发生校区</th>
						<th data-options="field:'createDate',width:200,align:'center'">选班时间</th>
						<th data-options="field:'className',width:100,align:'center'">班级</th>
						<th data-options="field:'schooltimeName',width:200,align:'center'">上课时段</th>
						<th data-options="field:'handlerName',width:100,align:'center'">操作人</th>
					</tr>
				</thead>
			</table>
	  	</div>
  	</body>
</html>
