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
	  					<td>已结课班级：</td>
	  					<td>
	  						<select class="easyui-combobox" name="classId" id="classId" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>教师：</td>
	  					<td>
	  						<select class="easyui-combobox" name="teacherId" id="teacherId" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td>结课时间：</td>
	  					<td>
	  						<input class="easyui-datebox" id="endTime" name="endTime" style="width:150px;">
	  					</td>
	  					<td>阶段</td>
	  					<td>
	  						<select class="easyui-combobox" name="step" id="step" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>升学率：</td>
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
							<th field="step" align="center" width="5%">阶段</th>
							<th field="classId" align="center" width="5%">班级</th>
							<th field="endTime" align="center" width="5%">结课时间</th>
							<th field="isSecond" align="center" width="5%">是否二手班</th>
							<th field="teacherA" align="center" width="5%">老师A</th>
							<th field="teacherB" align="center" width="5%">老师B</th>
							<th field="stuNum" align="center" width="5%">开班人数</th>
							<th field="graduateBase" align="center" width="5%">升学基数</th>
							<th field="graduateNum" align="center" width="5%">已升学人数</th>
							<th field="graduateRate" align="center" width="5%">升学率</th>
							<th field="changeInfo" align="center" width="24%">中途更换老师情况</th>
							<th field="lessonScale" align="center" width="8%">授课课时比例</th>
							<th field="applyBonus" align="center" width="8%">是否已申请奖金</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  		<div id="dlg" class="easyui-dialog" style="width: 800px; height: 250px; padding: 10px 20px" closed="true" data-options="modal:true">
  			<table class="easyui-datagrid" title="结课班级学员升学明细" style="width:100%;height:250px" id="list_datas">
					<thead>
						<tr>
							<th field="seq" align="center" width="10%">序号</th>
							<th field="chName" align="center" width="10%">中文名</th>
							<th field="enName" align="center" width="10%">英文名</th>
							<th field="isGraduated" align="center" width="10%">是否升学</th>
							<th field="currentClass" align="center" width="10%">现在读班级</th>
							<th field="lessonProgress" align="center" width="10%">学员课时进度</th>
							<th field="payDate" align="center" width="10%">缴费日期</th>
							<th field="graduateBase" align="center" width="10%">升学基数</th>
						</tr>
					</thead>
				</table>
  		</div>
  	</body>
</html>
