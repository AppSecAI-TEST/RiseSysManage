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
	  					<td>老师：</td>
	  					<td>
	  						<input class="easyui-textbox" id="name" style="width:150px;">
	  					</td>
	  					<td>月份：</td>
	  					<td>
	  						<select class="easyui-combobox" name="month" id="month" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>项目：</td>
	  					<td>
	  						<select class="easyui-combobox" name="month" id="month" style="width:150px;">
	  							
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
							<th field="schoolId" align="center" width="9%" rowspan="2">校区</th>
							<th field="chName" align="center" width="9%" rowspan="2">中文名</th>
							<th field="enName" align="center" width="9%" rowspan="2">英文名</th>
							<th field="project" align="center" width="9%" rowspan="2">项目</th>
							<th field="date" align="center" width="62%" colspan="31">日期</th>
							<th field="total" align="center" width="2%" rowspan="2">总计</th>
						</tr>
						<tr>
							<th field="1" align="center" width="2%">1</th>
							<th field="2" align="center" width="2%">2</th>
							<th field="3" align="center" width="2%">3</th>
							<th field="4" align="center" width="2%">4</th>
							<th field="5" align="center" width="2%">5</th>
							<th field="6" align="center" width="2%">6</th>
							<th field="7" align="center" width="2%">7</th>
							<th field="8" align="center" width="2%">8</th>
							<th field="9" align="center" width="2%">9</th>
							<th field="10" align="center" width="2%">10</th>
							<th field="11" align="center" width="2%">11</th>
							<th field="12" align="center" width="2%">12</th>
							<th field="13" align="center" width="2%">13</th>
							<th field="14" align="center" width="2%">14</th>
							<th field="15" align="center" width="2%">15</th>
							<th field="16" align="center" width="2%">16</th>
							<th field="17" align="center" width="2%">17</th>
							<th field="18" align="center" width="2%">18</th>
							<th field="19" align="center" width="2%">19</th>
							<th field="20" align="center" width="2%">20</th>
							<th field="21" align="center" width="2%">21</th>
							<th field="22" align="center" width="2%">22</th>
							<th field="23" align="center" width="2%">23</th>
							<th field="24" align="center" width="2%">24</th>
							<th field="25" align="center" width="2%">25</th>
							<th field="26" align="center" width="2%">26</th>
							<th field="27" align="center" width="2%">27</th>
							<th field="28" align="center" width="2%">28</th>
							<th field="29" align="center" width="2%">29</th>
							<th field="30" align="center" width="2%">30</th>
							<th field="31" align="center" width="2%">31</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
