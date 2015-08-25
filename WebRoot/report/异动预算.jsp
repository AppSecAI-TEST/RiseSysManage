<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/js/easyui/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/js/easyui/themes/icon.css">
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/js/demo.css">
		<script type="text/javascript" src="<%=path %>/pub/js/jquery.min.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/easyui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json2.js"></script>
  	</head>
  
  	<body>
  		<div style="padding:5px 10px;">
  			<form id="qryFm1">
	  			<table>
	  				<tr>
	  					<td>校区：</td>
	  					<td>
	  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>时间：</td>
	  					<td>
	  						<input class="easyui-datebox" id="startTime" name="startTime" style="width:150px;">至
	  					</td>
	  					<td>
	  						<input class="easyui-datebox" id="endTime" name="endTime" style="width:150px;">
	  					</td>
	  					<td>	
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qryBtn" onclick="qryData()">查询</a>
	  					</td>
	  					<td>
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" style="width:150px" id="qryBtn" onclick="exportData()">导出</a>
	  					</td>
	  				</tr>
	  			</table>
  			</form>
			<div style="padding:5px 0;">
				<table class="easyui-datagrid" title="查询结果" style="width:100%;height:250px" id="list_data" fitColumns="true">
					<thead>
						<tr>
							<th field="date" align="center" width="10%" rowspan="2">日期</th>
							<th field="schoolId" align="center" width="10%" rowspan="2">校区</th>
							<th field="nowNum" align="center" width="10%" rowspan="2">在校人数</th>
							<th field="readNum" align="center" width="10%" rowspan="2">在读人数</th>
							<th field="excTotal" align="center" width="10%" rowspan="2">异动总人数</th>
							<th field="excRate" align="center" width="10%" rowspan="2">异动总占比</th>
							<th field="excNum" align="center" width="10%" rowspan="2">异动进班人数</th>
							<th field="endClass" align="center" width="10%" colspan="2">本周结课</th>
							<th field="newPlan" align="center" width="10%" rowspan="2">新招计划</th>
						</tr>
						<tr>
							<th field="now" align="center" width="5%">在读</th>
							<th field="used" align="center" width="5%">已升</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
