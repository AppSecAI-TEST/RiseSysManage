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
	  					<td>阶段：</td>
	  					<td>
	  						<select class="easyui-combobox" name="step" id="step" style="width:150px;">
	  							
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
	  				</tr>
	  				<tr>
	  					<td>出勤率：</td>
	  					<td>
	  						<input class="easyui-text" id="attLowLimit" style="width:58px;">%至
	  						<input class="easyui-text" id="attLimit" style="width:58px;">%
	  					</td>
	  					<td>校服穿着率：</td>
	  					<td>
	  						<input class="easyui-text" id="dreLowLimit" style="width:58px;">%至
	  						<input class="easyui-text" id="dreLimit" style="width:58px;">%
	  					</td>	
	  					<td>上课日期：</td>
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
				<table class="easyui-datagrid" title="查询结果" style="width:100%;height:250px" id="list_data" fitColumns="true" rowsnumber="true">
					<thead>
						<tr>
							<th field="schoolId" align="center" width="10%">校区</th>
							<th field="lessonDate" align="center" width="10%">上课日期</th>
							<th field="week" align="center" width="5%">星期</th>
							<th field="classId" align="center" width="5%">班级</th>
							<th field="teacher" align="center" width="10%">上课教师</th>
							<th field="leassonTime" align="center" width="10%">上课时间</th>
							<th field="lessonCount" align="center" width="10%">实际课时</th>
							<th field="nowNum" align="center" width="10%">在读人数</th>
							<th field="stuNum" align="center" width="10%">出勤人数</th>
							<th field="dreNum" align="center" width="10%">校服穿着人数</th>
							<th field="dreRate" align="center" width="10%">校服穿着率</th>
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
							<th field="schoolId1" align="center" width="10%">校区</th>
							<th field="shouldNum" align="center" width="10%">应到人数</th>
							<th field="currentNum" align="center" width="10%">实到人数</th>
							<th field="attRate" align="center" width="10%">出勤率</th>
							<th field="dressNum" align="center" width="10%">实穿校服人数</th>
							<th field="dressRate" align="center" width="10%">校服穿着人数</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
