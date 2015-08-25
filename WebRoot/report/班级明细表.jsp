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
	  					<td>时间：</td>
	  					<td>
	  						<input class="easyui-datebox" id="startTime" name="startTime" style="width:150px;">
	  					</td>
	  				</tr>
	  				<tr>
	  					<td>阶段：</td>
	  					<td>
							<select class="easyui-combobox" name="teacherId" id="teacherId" style="width:150px;">
	  						</select>
	  					</td>
	  					<td>开班人数：</td>
	  					<td>
	  						<input class="easyui-textbox" name="stuName" id="stuName" style="width:150px;" />
	  					</td>
	  					<td>在读人数：</td>
	  					<td>
	  						<input class="easyui-textbox" name="stuName" id="stuName" style="width:150px;" />
	  					</td>
	  					<td>升学率：</td>
	  					<td>
	  						<select class="easyui-combobox" name="teacherId" id="teacherId" style="width:150px;">
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
				<table class="easyui-datagrid" title="查询结果" style="width:100%;height:250px" id="list_data">
					<thead>
						<tr>
							<th field="schoolId" align="center" width="5%">季度</th>
							<th field="seq" align="center" width="5%">序号</th>
							<th field="classId" align="center" width="5%">结课班级</th>
							<th field="certRate" align="center" width="5%">班级持证率</th>
							<th field="teacherA" align="center" width="5%">老师A</th>
							<th field="certA" align="center" width="5%">是否持证</th>
							<th field="teacherB" align="center" width="5%">老师B</th>
							<th field="certB" align="center" width="5%">是否持证</th>
							<th field="month" align="center" width="10%">结课月</th>
							<th field="classNum" align="center" width="5%">开班人数</th>
							<th field="classStep" align="center" width="10%">课时进度</th>
							<th field="enter" align="center" width="10%">转校转入</th>
							<th field="exit" align="center" width="10%">转校转出</th>
							<th field="enterClass" align="center" width="10%">转入转班</th>
							<th field="exitClass" align="center" width="10%">转出转班</th>
							<th field="exception" align="center" width="10%">异常</th>
							<th field="quit" align="center" width="10%">休学</th>
							<th field="inTwelve" align="center" width="10%">12课时内退学</th>
							<th field="afterTwelve" align="center" width="10%">12课时后退学</th>
							<th field="nowNum" align="center" width="10%">在读人数</th>
							<th field="graduateRate" align="center" width="10%">升学率基数</th>
							<th field="graduatedRate" align="center" width="10%">已升学基数</th>
							<th field="currentRate" align="center" width="10%">当前升学率</th>
							<th field="ninetyPerDistance" align="center" width="10%">距90%升学缺口</th>
							<th field="classNature" align="center" width="10%">班级性质</th>
							<th field="teacherChange" align="center" width="10%">更换老师情况</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
