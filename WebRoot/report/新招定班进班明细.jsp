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
	  					<td>学员姓名：</td>
	  					<td>
	  						<input class="easyui-textbox" style="width: 150px;" name="stuName" id="stuName">
	  					</td>
	  					<td>学员状态：</td>
	  					<td>
	  						<select class="easyui-combobox" name="stuState" id="stuState" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>缴费时间：</td>
	  					<td>
	  						<input class="easyui-datebox" id="pstartTime" name="pstartTime" style="width:150px;">
	  					</td>
	  					<td>至</td>
	  					<td>
	  						<input class="easyui-datebox" id="pendTime" name="pendTime" style="width:150px;">
	  					</td>
	  				</tr>
	  				<tr>
	  					<td>客户关怀：</td>
	  					<td>
	  						<input class="easyui-textbox" style="width: 150px;" name="custCare" id="custCare">
	  					</td>
	  					<td>报名阶段：</td>
	  					<td>
	  						<select class="easyui-combobox" name="enrollState" id="enrollState" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>联系电话：</td>
	  					<td>
	  						<input class="easyui-textbox" style="width: 150px;" name="contactPhone" id="contactPhone">
	  					</td>
	  					<td>进班时间：</td>
	  					<td>
	  						<input class="easyui-datebox"  id="estartTime" name="estartTime" style="width:150px;">
	  					</td>
	  					<td>至</td>
	  					<td>
	  						<input class="easyui-datebox"  id="eendTime" name="eendTime" style="width:150px;">
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
				<table class="easyui-datagrid" title="查询结果" style="width:100%;height:250px" id="list_data" fitColumns="true" rownumbers="true">
					<thead>
						<tr>
							<th field="schoolId" align="center" width="10%">校区</th>
							<th field="payTime" align="center" width="10%">缴费时间</th>
							<th field="stuName" align="center" width="10%">学员姓名</th>
							<th field="enName" align="center" width="10%">英文名</th>
							<th field="gander" align="center" width="5%">性别</th>
							<th field="holderName" align="center" width="10%">家长姓名</th>
							<th field="contactNbr" align="center" width="10%">联系电话</th>
							<th field="adviser" align="center" width="10%">招生顾问</th>
							<th field="custCare" align="center" width="10%">客户关怀</th>
							<th field="enrollStep" align="center" width="10%">报名阶段</th>
							<th field="classCount" align="center" width="10%">定班次数</th>
							<th field="classId" align="center" width="10%">当前定班班级</th>
							<th field="learnClass" align="center" width="10%">开课班级</th>
							<th field="learnTime" align="center" width="10%">学员开课时间</th>
							<th field="waitTime" align="center" width="10%">等班时间</th>
							<th field="stuNature" align="center" width="10%">学员性质</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
