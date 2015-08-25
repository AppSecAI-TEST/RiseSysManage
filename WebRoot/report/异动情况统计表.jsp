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
							<th field="schoolId" align="center" width="10%" rowspan="2">校区</th>
							<th field="nowNum" align="center" width="10%" rowspan="2">在校生人数</th>
							<th field="waitReturn" align="center" width="10%" colspan="2">待退费</th>
							<th field="changeClass" align="center" width="5%" rowspan="2">转班</th>
							<th field="changeSchool" align="center" width="5%" rowspan="2">转校</th>
							<th field="exception" align="center" width="10%" colspan="2">异常</th>
							<th field="quit" align="center" width="10%" colspan="2">休学</th>
							<th field="noclassNum" align="center" width="10%" rowspan="2">升学未进班总数</th>
							<th field="newNum" align="center" width="10%" rowspan="2">新生未进班总数</th>
							<th field="excNum" align="center" width="10%" rowspan="2">异动人数</th>
							<th field="sciChange" align="center" width="10%" rowspan="2">学术异动</th>
							<th field="newChange" align="center" width="10%" rowspan="2">新招异动</th>
						</tr>
						<tr>
							<th field="nonSci" align="center" width="5%">非学术</th>
							<th field="Sci" align="center" width="5%">学术</th>
							<th field="inThrMon" align="center" width="5%">3个月内</th>
							<th field="aftThrMon" align="center" width="5%">3个月以上</th>
							<th field="inThrMon1" align="center" width="5%">3个月内</th>
							<th field="aftThrMon1" align="center" width="5%">3个月以上</th>
						</tr>
					</thead>
				</table>
				<div id="dlg" class="easyui-dialog" closed="true" modal="true">
					<table class="easyui-datagrid" title="升学未进班阶段明细" style="width:100%;height:250px" id="list_data1" fitColumns="true">
						<thead>
							<tr>
								<th field="step1" align="center" width="30%">阶段</th>
								<th field="inTwoWeeks" align="center" width="35%">2周内结课人数</th>
								<th field="aftTwoWeeks" align="center" width="35%">2周以上结课人数</th>
							</tr>
						</thead>
					</table>
				</div>
				<div id="dlg1" class="easyui-dialog" closed="true" modal="true">
					<table class="easyui-datagrid" title="新生未进班阶段明细" style="width:100%;height:250px" id="list_data2" fitColumns="true">
						<thead>
							<tr>
								<th field="step2" align="center" width="30%">阶段</th>
								<th field="inMonth" align="center" width="35%">1个月以内新招未进</th>
								<th field="aftMonth" align="center" width="35%">1个月以上新招未进班</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
  		</div>
  	</body>
</html>
