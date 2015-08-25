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
	  					<td>年级组：</td>
	  					<td>
	  						<select class="easyui-combobox" name="teacherId" id="teacherId" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>课时进度：</td>
	  					<td>
	  						<select class="easyui-combobox" name="rate" id="rate" style="width:150px;">
	  							
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
							<th field="schoolId" align="center" width="10%" rowspan="2">校区</th>
							<th field="finish" align="center" width="40%" colspan="5">已结课</th>
							<th field="classStep" align="center" width="40%" colspan="5">课时进度</th>
						</tr>
						<tr>
							<th field="grade" align="center" width="8%">年级组</th>
							<th field="classNum" align="center" width="8%">班级数</th>
							<th field="gradeBase" align="center" width="8%">年级组总基数</th>
							<th field="gradeGraduate" align="center" width="8%">年级组总升学</th>
							<th field="avgRate" align="center" width="8%">平均升学率</th>
							<th field="classNum1" align="center" width="8%">班级数</th>
							<th field="nowNum" align="center" width="8%">在读人数</th>
							<th field="gradeBase1" align="center" width="8%">年级组总基数</th>
							<th field="gradeGraduate1" align="center" width="8%">年级组总升学</th>
							<th field="avgRate1" align="center" width="8%">平均升学率</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
