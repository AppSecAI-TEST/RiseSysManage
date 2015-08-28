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
	  					<td>姓名：</td>
	  					<td>
	  						<input class="easyui-textbox" name="name" id="name" style="width:150px;">
	  					</td>
	  					<td>联系电话：</td>
	  					<td>
	  						<input class="easyui-textbox" name="contactNbr" id="contactNbr" style="width:150px;">
	  					</td>
	  					<td>持证阶段：</td>
	  					<td>
	  						<select class="easyui-combobox" multiple="multiple" name="certStep" id="certStep" style="width:150px;">
	  							
	  						</select>
	  					</td>	
	  				</tr>
	  				<tr>
	  					<td>持证数量：</td>
	  					<td>
	  						<input class="easyui-textbox" id="certNum" name="certNum" style="width:150px;">
	  					</td>
	  					<td>带班阶段：</td>
	  					<td>
	  						<select class="easyui-combobox" multiple="multiple" name="teachStep" id="teachStep" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>待培训阶段：</td>
	  					<td>
	  						<select class="easyui-combobox" multiple="multiple" name="waitTrainStep" id="waitTrainStep" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>入职时间：</td>
	  					<td>
	  						<input class="easyui-datebox" id="startTime" name="startTime" style="width:150px;">
	  					</td>
	  					<td>
	  						<input class="easyui-datebox" id="endTime" name="endTime" style="width:150px;">
	  					</td>
	  				</tr>
	  				<tr>	
	  					<td>(在读)带班持证率：</td>
	  					<td>
	  						<input class="easyui-textbox" id="LowLimit" style="width:58px;">%至
	  						<input class="easyui-textbox" id="Limit" style="width:58px;">%
	  					</td>
	  					<td>带班信息：</td>
	  					<td>
	  						<select class="easyui-combobox"  name="dutyInfo" id="dutyInfo" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>状态：</td>
	  					<td>
	  						<select class="easyui-combobox"  name="state" id="state" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>职务：</td>
	  					<td>
	  						<select class="easyui-combobox"  name="title" id="title" style="width:150px;">
	  							
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
				<table class="easyui-datagrid" title="查询结果" style="width:100%;height:250px" id="list_data" fitColumns="true" rownumbers="true">
					<thead>
						<tr>
							<th field="schoolId" align="center" width="10%" >校区</th>
							<th field="chName" align="center" width="10%" >中文名</th>
							<th field="enName" align="center" width="10%" >英文名</th>
							<th field="contactNbr" align="center" width="10%" >联系电话</th>
							<th field="title" align="center" width="10%" >职务</th>
							<th field="entryDate" align="center" width="10%" >入职时间</th>
							<th field="entryDuration" align="center" width="10%" >入职时常(月)</th>
							<th field="certStep" align="center" width="10%" >持证阶段</th>
							<th field="certNum" align="center" width="10%" >持证数量</th>
							<th field="dutyStep" align="center" width="10%" >带班阶段</th>
							<th field="certRate" align="center" width="10%" >(在读)带班持证率</th>
							<th field="trainStep" align="center" width="10%" >待培训阶段</th>
							<th field="finishedClass" align="center" width="10%" >已结课班级</th>
							<th field="currentClass" align="center" width="10%" >所带在读班级明细</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
