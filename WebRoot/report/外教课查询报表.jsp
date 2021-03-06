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
	  					<td>姓名：</td>
	  					<td>
	  						<input class="easyui-textbox" id="name" name="name" style="width:150px;">
	  					</td>
	  					<td>联系电话：</td>
	  					<td>
	  						<input class="easyui-textbox" id="contactNbr" name="contactNbr" style="width:150px;">
	  					</td>
	  					<td>缴费时间：</td>
	  					<td>
	  						<input class="easyui-datebox" id="payTime" name="payTime" style="width:150px;">
	  					</td>
	  				</tr>
	  				<tr>	
	  					<td>消耗次数：</td>
	  					<td>
	  						<input class="easyui-textbox" id="lowLimit" style="width:62px;">至
	  						<input class="easyui-textbox" id="Limit" style="width:62px;">
	  					</td>
	  					<td>是否已消耗完：</td>
	  					<td>
	  						<select class="easyui-combobox" name="isFinish" id="isFinish" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>是否过期：</td>
	  					<td>
	  						<select class="easyui-combobox" name="isExp" id="isExp" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td></td>
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
							<th field="schoolId" align="center" width="10%">校区</th>
							<th field="name" align="center" width="5%">姓名</th>
							<th field="contactNbr" align="center" width="10%">联系电话</th>
							<th field="payClass" align="center" width="10%">缴费课程 </th>
							<th field="payTime" align="center" width="10%">缴费时间</th>
							<th field="foreignFee" align="center" width="10%">赠外教课金额</th>
							<th field="foreignNum" align="center" width="10%">赠外教课次数</th>
							<th field="expendNum" align="center" width="10%">已消耗次数</th>
							<th field="isExp" align="center" width="10%">是否过期</th>
							<th field="expTime" align="center" width="15%">有效期截止时间</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
