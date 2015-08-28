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
  		<div style="padding:5px 0;">
  			<form id="qryFm">
	  			<table>
	  				<tr>
	  					<td>校区：</td>
	  					<td>
	  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>服务人数：</td>
	  					<td>
	  						<input class="easyui-textbox" id="serviceNum" name="serviceNum" style="width:150px;">
	  					</td>
	  					<td>时间：</td>
	  					<td>
	  						<input class="easyui-datebox" id="startTime" name="startTime" style="width:150px;">
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
							<th field="entryDate" align="center" width="10%">教师</th>
							<th field="coClaNum1" align="center" width="5%">合带班量</th>
							<th field="coSerNum1" align="center" width="5%">服务人数</th>
							<th field="siClaNum1" align="center" width="5%">单独带班</th>
							<th field="siSerNum1" align="center" width="5%">服务人数</th>
							<th field="week1" align="center" width="5%">第一周</th>
							<th field="coClaNum2" align="center" width="5%">合带班量</th>
							<th field="coSerNum2" align="center" width="5%">服务人数</th>
							<th field="siClaNum2" align="center" width="5%">单独带班</th>
							<th field="siSerNum2" align="center" width="5%">服务人数</th>
							<th field="week2" align="center" width="5%">第二周</th>
							<th field="coClaNum" align="center" width="5%">合带班量</th>
							<th field="coSerNum" align="center" width="5%">服务人数</th>
							<th field="siClaNum" align="center" width="5%">单独带班</th>
							<th field="siSerNum" align="center" width="5%">服务人数</th>
							<th field="total" align="center" width="5%">总计</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  		<div style="padding:5px 0;">
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
	  						<input class="easyui-datebox" id="startTime1" name="startTime1" style="width:150px;">
	  					</td>
	  					<td>	
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qryBtn1" onclick="qryDatas()">查询</a>
	  					</td>
	  					<td>
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" style="width:150px" id="expBtn1" onclick="exportDatas()">导出</a>
	  					</td>
	  				</tr>
	  			</table>
  			</form>
			<div style="padding:5px 0;">
				<table class="easyui-datagrid" title="查询结果" style="width:100%;height:250px" id="list_datas" fitColumns="true">
					<thead>
						<tr>
							<th field="schoolId" align="center" width="15%">校区</th>
							<th field="entryDate" align="center" width="15%">入职时间</th>
							<th field="teacherNum" align="center" width="15%">教师人数</th>
							<th field="classNum" align="center" width="15%">带班数量总计</th>
							<th field="stuNum" align="center" width="15%">带班学员总计</th>
							<th field="serviceNum" align="center" width="15%">教师服务人数</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
