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
	  					<td>时间：</td>
	  					<td>
	  						<input class="easyui-datebox" id="startTime" name="startTime" style="width:150px;">至
	  					</td>
	  					<td>
	  						<input class="easyui-datebox" id="endTime" name="endTime" style="width:150px;">
	  					</td>
	  					<td>退费类型：</td>
	  					<td>
	  						<select class="easyui-combobox" name="returnType" id="returnType" style="width:150px;">
	  							
	  						</select>
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
							<th field="schoolId" align="center" width="10%">校区</th>
							<th field="returnTotal" align="center" width="10%">退费总数</th>
							<th field="returnType" align="center" width="10%">退费类型</th>
							<th field="returnNum" align="center" width="10%">退费个数</th>
							<th field="returnRate" align="center" width="10%">退费占比</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  		<div style="padding:5px 10px;">
  			<form id="qryFm1">
	  			<table>
	  				<tr>
	  					<td>校区：</td>
	  					<td>
	  						<select class="easyui-combobox" name="schoolId1" id="schoolId1" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>时间：</td>
	  					<td>
	  						<input class="easyui-datebox" id="startTime1" name="startTime1" style="width:150px;">至
	  					</td>
	  					<td>
	  						<input class="easyui-datebox" id="endTime1" name="endTime1" style="width:150px;">
	  					</td>
	  					<td>退费阶段：</td>
	  					<td>
	  						<select class="easyui-combobox" name="returnStep" id="returnStep" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>	
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qryBtn1" onclick="qryData1()">查询</a>
	  					</td>
	  					<td>
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" style="width:150px" id="expBtn1" onclick="exportData1()">导出</a>
	  					</td>
	  				</tr>
	  			</table>
  			</form>
			<div style="padding:5px 0;">
				<table class="easyui-datagrid" title="查询结果" style="width:100%;height:250px" id="list_datas" fitColumns="true">
					<thead>
						<tr>
							<th field="schoolId" align="center" width="10%">校区</th>
							<th field="returnTotal" align="center" width="10%">退费总数</th>
							<th field="returnStep" align="center" width="10%">退费阶段</th>
							<th field="returnNum" align="center" width="10%">退费个数</th>
							<th field="returnRate" align="center" width="10%">退费占比</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  		<div style="padding:5px 10px;">
  			<form id="qryFm2">
	  			<table>
	  				<tr>
	  					<td>校区：</td>
	  					<td>
	  						<select class="easyui-combobox" name="schoolId2" id="schoolId2" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>时间：</td>
	  					<td>
	  						<input class="easyui-datebox" id="startTime2" name="startTime2" style="width:150px;">至
	  					</td>
	  					<td>
	  						<input class="easyui-datebox" id="endTime2" name="endTime2" style="width:150px;">
	  					</td>
	  					<td>退费原因：</td>
	  					<td>
	  						<select class="easyui-combobox" name="returnReason" id="returnReason" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>	
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qryBtn2" onclick="qryData2()">查询</a>
	  					</td>
	  					<td>
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" style="width:150px" id="expBtn2" onclick="exportData2()">导出</a>
	  					</td>
	  				</tr>
	  			</table>
  			</form>
			<div style="padding:5px 0;">
				<table class="easyui-datagrid" title="查询结果" style="width:100%;height:250px" id="list_datass" fitColumns="true">
					<thead>
						<tr>
							<th field="schoolId2" align="center" width="10%">校区</th>
							<th field="returnTotal2" align="center" width="10%">退费总数</th>
							<th field="type" align="center" width="10%">大类</th>
							<th field="detailType" align="center" width="10%">细分</th>
							<th field="returnNum2" align="center" width="10%">退费个数</th>
							<th field="returnRate2" align="center" width="10%">退费占比</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
