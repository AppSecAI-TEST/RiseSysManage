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
	  						<input class="easyui-datebox" id="startTime" name="startTime" style="width:150px;">
	  					</td>
	  					<td>至</td>
	  					<td>
	  						<input class="easyui-datebox" id="pastTime" name="pastTime" style="width:150px;">
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
							<th field="schoolId" align="center" width="10%" rowspan="2">校区</th>
							<th field="finish" align="center" width="40%" colspan="5">2015各校月度</th>
							<th field="classStep" align="center" width="40%" colspan="5">2016各校月度</th>
						</tr>
						<tr>
							<th field="month" align="center" width="4%">月份</th>
							<th field="graduateBase" align="center" width="9%">升学基数</th>
							<th field="graduatedNum" align="center" width="9%">已升人数</th>
							<th field="monthRate" align="center" width="9%">月度升学率</th>
							<th field="seasonRate" align="center" width="9%">季度升学率</th>
							<th field="month1" align="center" width="4%">月份</th>
							<th field="graduateBase1" align="center" width="9%">升学基数</th>
							<th field="graduatedNum1" align="center" width="9%">已升人数</th>
							<th field="monthRate1" align="center" width="9%">月度升学率</th>
							<th field="seasonRate1" align="center" width="9%">季度升学率</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
