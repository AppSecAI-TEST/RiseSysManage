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
	  					<td>阶段：</td>
	  					<td>
	  						<select class="easyui-combobox" name="step" id="step" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>班级人数：</td>
	  					<td>
	  						<input class="easyui-textbox" name="classNum" id="classNum" style="width:150px;" />
	  					</td>
	  					<td>预计开班时间：</td>
	  					<td>
	  						<input class="easyui-datebox" id="startTime" name="startTime" style="width:150px;">
	  					</td>
	  					<td>至</td>
	  					<td>
	  						<input class="easyui-datebox" id="endTime" name="endTime" style="width:150px;">
	  					</td>
	  				</tr>	
	  				<tr>
	  					<td colspan="7"></td>
	  					<td>	
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qryBtn" onclick="qryData()">查询</a>
	  					</td>
	  					<td></td>
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
							<th field="schoolId" align="center" width="20%">校区</th>
							<th field="classId" align="center" width="10%">班级</th>
							<th field="classTime" align="center" width="20%">上课时间</th>
							<th field="classStuNum" align="center" width="10%">班级人数</th>
							<th field="toMinNum" align="center" width="10%">距最低开班人数</th>
							<th field="planTime" align="center" width="10%">预计开班时间</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  		<div id="dlg" class="easyui-dialog" style="width: 800px; height: 600x; padding: 10px 20px" closed="true" modal="true">
			<table class="easyui-datagrid" style="width:760px;height:500px;overflow:auto;" id="list_datas"  rownumbers="true" fitColumns="true" >
				<thead>
					<tr>
						<th field="payTime" align="center" width="11%">缴费时间</th>
						<th field="stuName" align="center" width="11%">学员姓名</th>
						<th field="stuNature" align="center" width="11%">学员性质</th>
						<th field="idCardNum" align="center" width="14%">本人身份证号</th>
						<th field="contactNum" align="center" width="11%">联系方式</th>
						<th field="adviserA" align="center" width="8%">顾问A</th>
						<th field="adviserB" align="center" width="8%">顾问B</th>
						<th field="teacherA" align="center" width="8%">老师A</th>
						<th field="teacherB" align="center" width="8%">老师B</th>
					</tr>
				</thead>
			</table>
		</div>
  	</body>
</html>
