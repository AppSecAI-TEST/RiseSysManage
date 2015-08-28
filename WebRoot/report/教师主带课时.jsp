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
	  					<td>姓名：</td>
	  					<td>
	  						<input class="easyui-textbox" name="name" id="name" style="width:150px;">
	  					</td>
	  					<td>英文名</td>
	  					<td>
	  						<input class="easyui-textbox" name="enName" id="enName" style="width:150px;">
	  					</td>
	  					<td>带班段主T课时</td>
	  					<td>
	  						<input class="easyui-textbox" name="mainT" id="mainT" style="width:150px;">
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
							<th field="seq" align="center" width="5%" rowspan="2">序号</th>
							<th field="schoolId" align="center" width="10%" rowspan="2">校区</th>
							<th field="name" align="center" width="10%" rowspan="2">姓名</th>
							<th field="enName" align="center" width="10%" rowspan="2">英文名</th>
							<th field="grade" align="center" width="10%" rowspan="2">年级组</th>
							<th field="dutyInfo" align="center" width="55%" colspan="11">带班情况</th>
						</tr>
						<tr>
							<th field="Dpre_K" align="center" width="5%">Dpre-K</th>
							<th field="Pre_K" align="center" width="5%">Pre-K</th>
							<th field="DK" align="center" width="5%">DK</th>
							<th field="K" align="center" width="5%">K</th>
							<th field="Pre_Rise" align="center" width="5%">Pre-Rise</th>
							<th field="S1" align="center" width="5%">S1</th>
							<th field="S2" align="center" width="5%">S2</th>
							<th field="S3" align="center" width="5%">S3</th>
							<th field="S4" align="center" width="5%">S4</th>
							<th field="S5" align="center" width="5%">S5</th>
							<th field="weekNum" align="center" width="5%">周课时</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
