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
	  						<select class="easyui-combobox" name="Step" id="Step" style="width:150px;">
	  							
	  						</select>
	  					</td>	
	  					<td>持证率：</td>
	  					<td>
	  						<input class="easyui-textbox" id="LowLimit" style="width:58px;">%至
	  						<input class="easyui-textbox" id="Limit" style="width:58px;">%
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
							<th field="schoolId" align="center" width="8%" >校区</th>
							<th field="chName" align="center" width="8%" >阶段</th>
							<th field="enName" align="center" width="5%" >班级数</th>
							<th field="contactNbr" align="center" width="5%" >教师数</th>
							<th field="title" align="center" width="5%" >持证数</th>
							<th field="entryDate" align="center" width="5%" >持证率</th>
							<th field="entryDuration" align="center" width="10%" >目标持证数</th>
							<th field="certStep" align="center" width="10%" >缺口持证数</th>
							<th field="certNum" align="center" width="22%" >带班未持证教师名单</th>
							<th field="dutyStep" align="center" width="22%" >已持证教师</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
