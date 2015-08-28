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
	  					<td>热身课次数：</td>
	  					<td><input class="easyui-textbox" id="lessonNum" name="lessonNum" style="width:150px;"></td>
	  					<td>热身课计划课时：</td>
	  					<td><input class="easyui-textbox" id="planNum" name="planNum" style="width:150px;"></td>
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
							<th field="schoolId" align="center" width="20%">校区</th>
							<th field="lessonNum" align="center" width="30%">热身课次数</th>
							<th field="planNum" align="center" width="30%">热身课计划课时</th>
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
	  						<select class="easyui-combobox" name="schoolId" id="schoolId1" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>热身课计划课时：</td>
	  					<td>
	  						<input class="easyui-datebox" id="startTime" name="startTime" style="width:150px;">
	  					</td>
	  					<td>	
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qryBtn" onclick="qryDatas()">查询</a>
	  					</td>
	  					<td>
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" style="width:150px" id="qryBtn" onclick="exportDatas()">导出</a>
	  					</td>
	  				</tr>
	  			</table>
  			</form>
			<div style="padding:5px 0;">
				<table class="easyui-datagrid" title="查询结果" style="width:100%;height:250px" id="list_datas" fitColumns="true">
					<thead>
						<tr>
							<th field="schoolId1" align="center" width="10%">校区</th>
							<th field="classNbr" align="center" width="15%">热身课班级编号</th>
							<th field="startTime" align="center" width="15%">热身课开始时间</th>
							<th field="endTime" align="center" width="15%">热身课结束时间</th>
							<th field="planNum" align="center" width="10%">计划总课时</th>
							<th field="realNum" align="center" width="10%">实际反馈课时</th>
							<th field="applyNum" align="center" width="10%">申请热身课人数</th>
							<th field="actNum" align="center" width="10%">实际上课人数</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
