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
  			<form id="qryFm">
	  			<table>
	  				<tr>
	  					<td>校区：</td>
	  					<td>
	  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>姓名：</td>
	  					<td>
	  						<input class="easyui-textbox" id="LowLimit" style="width:150px;">
	  					</td>
	  					<td>入职时间：</td>
	  					<td>
	  						<input class="easyui-datebox" id="startTime" name="startTime" style="width:150px;">
	  					</td>
	  					<td>
	  						<input class="easyui-datebox" id="endTime" name="endTime" style="width:150px;">
	  					</td>
	  				</tr>
	  				<tr>	
	  					<td>升学个数：</td>
	  					<td>
	  						<input class="easyui-textbox" id="graduateNum" style="width:150px;">
	  					</td>
	  					<td>升学年数：</td>
	  					<td>
	  						<input class="easyui-textbox" id="graduateYear" style="width:150px;">
	  					</td>
	  					<td>时间：</td>
	  					<td>
	  						<input class="easyui-datebox" id="startTime1" name="startTime1" style="width:150px;">
	  					</td>
	  					<td>
	  						<input class="easyui-datebox" id="endTime1" name="endTime1" style="width:150px;">
	  					</td>
	  				</tr>
	  				<tr>
	  					<td>退费个数：</td>
	  					<td>
	  						<input class="easyui-textbox" id="graduateYear" style="width:150px;">
	  					</td>
	  					<td>退费年数：</td>
	  					<td>
	  						<input class="easyui-textbox" id="graduateYear" style="width:150px;">
	  					</td>
	  					<td>口碑个数：</td>
	  					<td>
	  						<input class="easyui-textbox" id="graduateYear" style="width:150px;">
	  					</td>	
	  				</tr>
	  				<tr>
	  					<td>游学业绩：</td>
	  					<td>
	  						<input class="easyui-textbox" id="graduateYear" style="width:150px;">
	  					</td>	
	  					<td>国际班业绩：</td>
	  					<td>
	  						<input class="easyui-textbox" id="graduateYear" style="width:150px;">
	  					</td>
	  					<td></td>
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
							<th field="seq" align="center" width="6%" rowspan="2">序号</th>
							<th field="schoolId" align="center" width="6%" rowspan="2">校区</th>
							<th field="chName" align="center" width="6%" rowspan="2">中文名</th>
							<th field="enName" align="center" width="6%" rowspan="2">英文名</th>
							<th field="entryDate" align="center" width="6%" rowspan="2">入职时间</th>
							<th field="entryDuration" align="center" width="6%" rowspan="2">入职时长</th>
							<th field="graAchieve" align="center" width="12%" colspan="2">升学业绩</th>
							<th field="graReturn" align="center" width="12%" colspan="2">升学退费情况</th>
							<th field="certNum" align="center" width="6" rowspan="2">口碑业绩</th>
							<th field="dutyStep" align="center" width="6%" rowspan="2">口碑退费</th>
							<th field="entryDuration" align="center" width="6%" rowspan="2">游学业绩</th>
							<th field="certStep" align="center" width="6%" rowspan="2">游学退费</th>
							<th field="certNum" align="center" width="6%" rowspan="2">国际班业绩</th>
							<th field="dutyStep" align="center" width="6%" rowspan="2">国际版退费</th>
						</tr>
						<tr>
							<th field="num1" align="center" width="6%">个数</th>
							<th field="year1" align="center" width="6%">年数</th>
							<th field="num2" align="center" width="6%">个数</th>
							<th field="year2" align="center" width="6%">年数</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
