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
	  					<td>班级：</td>
	  					<td>
	  						<select class="easyui-combobox" name="classId" id="classId" style="width:150px;">
	  						</select>
	  					</td>
	  					<td>教师：</td>
	  					<td>
	  						<select class="easyui-combobox" name="teacherId" id="teacherId" style="width:150px;">
	  						</select>
	  					</td>
	  					<td>阶段：</td>
	  					<td>
							<select class="easyui-combobox" name="teacherId" id="teacherId" style="width:150px;">
	  						</select>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td>课时进度：</td>
	  					<td>
	  						<input class="easyui-textbox" name="stuName" id="stuName" style="width:150px;" />
	  					</td>
	  					<td>时间：</td>
	  					<td>
	  						<input class="easyui-datebox" id="startTime" name="startTime" style="width:150px;">
	  					</td>
	  					<td>至</td>
	  					<td>
	  						<input class="easyui-datebox" id="endTime" name="endTime" style="width:150px;">
	  					</td>
	  					<td></td>
	  					<td>
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qryBtn" onclick="qryData()">查询</a>
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
							<th field="seq" align="center" width="5%">序号</th>
							<th field="classId" align="center" width="10%">班级</th>
							<th field="teacherA" align="center" width="10%">老师A</th>
							<th field="teacherB" align="center" width="10%">老师B</th>
							<th field="schoolId" align="center" width="10%">上课时间一</th>
							<th field="schoolId" align="center" width="10%">上课时间二</th>
							<th field="schoolId" align="center" width="10%">开课时间</th>
							<th field="schoolId" align="center" width="10%">结课时间</th>
							<th field="schoolId" align="center" width="10%">课时进度目标</th>
							<th field="schoolId" align="center" width="10%">课时进度</th>
							<th field="schoolId" align="center" width="10%">剩余课时数</th>
							<th field="schoolId" align="center" width="10%">计划课时</th>
							<th field="schoolId" align="center" width="10%">实际课时</th>
							<th field="schoolId" align="center" width="10%">课时差异</th>
							<th field="schoolId" align="center" width="10%">差异原因说明</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
