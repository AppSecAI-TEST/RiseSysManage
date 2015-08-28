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
	  					<td>Demo课时间：</td>
	  					<td>
	  						<select class="easyui-combobox" name="classId" id="classId" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>Demo：</td>
	  					<td>
	  						<select class="easyui-combobox" name="teacherId" id="teacherId" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td>DemoTA：</td>
	  					<td>
	  						<input class="easyui-datebox" id="endTime" name="endTime" style="width:150px;">
	  					</td>
	  					<td>Demo转化率：</td>
	  					<td>
	  						<input class="easyui-textbox" id="lowLimit" style="width:58px;">%至
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
				<table class="easyui-datagrid" title="查询结果" style="width:100%;height:250px" id="list_data">
					<thead>
						<tr>
							<th field="schoolId" align="center" width="10%">校区</th>
							<th field="time" align="center" width="10%">时间</th>
							<th field="demoNum" align="center" width="10%">参加Demo人数</th>
							<th field="payNum" align="center" width="10%">定金个数</th>
							<th field="allPay" align="center" width="10%">全费个数</th>
							<th field="sToAll" align="center" width="10%">定金转全费</th>
							<th field="pay" align="center" width="10%">补缴全费</th>
							<th field="tansRate" align="center" width="10%">Demo转化率</th>
							<th field="demoT" align="center" width="10%">Demo T</th>
							<th field="demoTa" align="center" width="10%">Demo TA</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  		<div id="dlg" class="easyui-dialog" style="width: 800px; height: 250px; padding: 10px 20px" closed="true" data-options="modal:true">
  			<table class="easyui-datagrid" title="结课班级学员升学明细" style="width:100%;height:250px" id="list_datas">
					<thead>
						<tr>
							<th field="name" align="center" width="10%">姓名</th>
							<th field="demoTime" align="center" width="10%">Demo课时间</th>
							<th field="isPay" align="center" width="10%">是否缴定金</th>
							<th field="isAll" align="center" width="10%">是否缴全费</th>
							<th field="isPayToAll" align="center" width="15%">是否定金转全费</th>
							<th field="payToAllDate" align="center" width="15%">定金转全费日期</th>
							<th field="isPayLast" align="center" width="15%">是否补缴全费</th>
							<th field="payLastDate" align="center" width="15%">补缴全费日期</th>
						</tr>
					</thead>
				</table>
  		</div>
  	</body>
</html>
