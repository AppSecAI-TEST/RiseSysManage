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
	  					<td>班级：</td>
	  					<td>
	  						<select class="easyui-combobox" name="classId" id="classId" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>老师：</td>
	  					<td>
	  						<select class="easyui-combobox" name="teacherId" id="teacherId" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>姓名：</td>
	  					<td>
	  						<input class="easyui-textbox" name="name" id="name" style="width:150px;">
	  					</td>
	  				</tr>
	  				<tr>
	  					<td>联系电话：</td>
	  					<td>
	  						<input class="easyui-textbox" name="contactNbr" id="contactNbr" style="width:150px;">
	  					</td>	
	  					<td>教质时间：</td>
	  					<td>
	  						<select class="easyui-combobox" name="month" id="month" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>数据类型：</td>
	  					<td>
	  						<select class="easyui-combobox"  name="dataType" id="dataType" style="width:150px;">
	  							
	  						</select>
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
							<th field="schoolId" align="center" width="11%">校区</th>
							<th field="event" align="center" width="11%" >教质事件</th>
							<th field="dateType" align="center" width="11%" >数据类型</th>
							<th field="name" align="center" width="11%" >姓名</th>
							<th field="enName" align="center" width="11%" >英文名</th>
							<th field="class" align="center" width="11%" >班级</th>
							<th field="contactNbr" align="center" width="11%" >联系电话</th>
							<th field="teacherA" align="center" width="11%" >老师A</th>
							<th field="teacherB" align="center" width="11%" >老师B</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
