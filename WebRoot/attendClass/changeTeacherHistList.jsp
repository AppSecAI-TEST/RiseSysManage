<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String classInstId = request.getParameter("classInstId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  
  	<body>
  		<div style="padding:5px 0;min-width:920px; width:80%; margin-left: 8px;">
  			<table class="easyui-datagrid" title="老师变更历史信息" style="height:auto;" id="list_data" pagination="false" rownumbers="true" fitColumns="true" singleSelect="true"
  				url="<%=path %>/pubData/qryDataListByPage.do?param={'classInstId':'<%=classInstId %>','queryCode':'qryChangeTeacherHistList'}" >
  				<thead>
					<tr>
						<th data-options="field:'className',width:100,align:'center'">班级名称</th>
						<th data-options="field:'changeDate',width:100,align:'center'">变更时间</th>
						<th data-options="field:'classProgress',width:120,align:'center'">变更时课时进度</th>
						<th data-options="field:'handlerName',width:100,align:'center'">变更操作人</th>
						<th data-options="field:'oldTeacherName',width:150,align:'center'">原带班老师</th>
						<th data-options="field:'newTeacherName',width:150,align:'center'">变更带班老师</th>
						<th data-options="field:'changeRemark',width:200,align:'center'">变更备注</th>
					</tr>
				</thead>
  			</table>
  		</div>
  	</body>
</html>
