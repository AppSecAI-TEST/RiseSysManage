<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
  		<div style ="margin-right:5px;">
  			<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="list_data" 
		  		pagination="false" rownumbers="false" fitColumns="true" singleSelect="true"
		  		url="<%=path %>/pubData/qryDataListByPage.do?param={'funcNodeId':'1087'}">
		  		<thead>
		  			<tr>
		  				<th data-options="field:'timerId',width:50,align:'center'">任务编码</th>
		  				<th data-options="field:'timeName',width:150,align:'center'">任务描述</th>
		  				<th data-options="field:'interval',width:100,align:'center'">任务运行间隔</th>
		  				<th data-options="field:'lastDate',width:120,align:'center'">上次运行时间</th>
		  				<th data-options="field:'thisDate',width:120,align:'center'">本次运行时间</th>
		  				<th data-options="field:'nextDate',width:120,align:'center'">下次运行时间</th>
		  				<th data-options="field:'failures',width:120,align:'center'">错误日志</th>
		  				<th data-options="field:'controlText',width:120,align:'center'">是否运行</th>
		  			</tr>
		  		</thead>
		  	</table>
  		</div>
  	</body>
</html>
