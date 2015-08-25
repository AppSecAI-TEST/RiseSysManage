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
	  						<select class="easyui-combobox" name="step" id="step" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>时间：</td>
	  					<td>
	  						<select class="easyui-combobox" name="month" id="month" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>班级：</td>
	  					<td>
	  						<select class="easyui-combobox" name="classId" id="classId" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td>公开课满意度：</td>
	  					<td>
	  						<input class="easyui-textbox" id="publicLowLimit" style="width:58px;">%至
	  						<input class="easyui-textbox" id="publicLimit" style="width:58px;">%
	  					</td>
	  					<td>毕业典礼满意度：</td>
	  					<td>
	  						<input class="easyui-textbox" id="cereLowLimit" style="width:58px;">%至
	  						<input class="easyui-textbox" id="cereLimit" style="width:58px;">%
	  					</td>
	  					<td>电教完成率：</td>
	  					<td>
	  						<input class="easyui-textbox" id="teachLowLimit" style="width:58px;">%至
	  						<input class="easyui-textbox" id="teachLimit" style="width:58px;">%
	  					</td>
	  					<td>家长会满意度：</td>
	  					<td>
	  						<input class="easyui-textbox" id="meetLowLimit" style="width:58px;">%至
	  						<input class="easyui-textbox" id="meetLimit" style="width:58px;">%
	  					</td>
	  				</tr>	
	  				<tr>		
	  					<td>老师：</td>
	  					<td>
	  						<select class="easyui-combobox" name="teacherId" id="teacherId" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>是否完成：</td>
	  					<td>
	  						<select class="easyui-combobox" name="isFinish" id="isFinish" style="width:150px;">
	  							
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
				<table class="easyui-datagrid" title="查询结果" style="width:100%;height:250px" id="list_data" fitColumns="true" rowsnumber="true">
					<thead>
						<tr>
							<th field="schoolId" align="center" width="6%" rowspan="2">校区</th>
							<th field="classId" align="center" width="6%" rowspan="2">班级</th>
							<th field="nowNum" align="center" width="6%" rowspan="2">在读人数</th>
							<th field="teacherA" align="center" width="6%" rowspan="2">老师A</th>
							<th field="teacherB" align="center" width="6%" rowspan="2">老师B</th>
							<th field="elecTeach" align="center" width="15%" colspan="3">电教</th>
							<th field="meeting" align="center" width="15%" colspan="3">家长会</th>
							<th field="celebration" align="center" width="15%" colspan="3">毕业典礼</th>
							<th field="publicClass" align="center" width="15%" colspan="3">公开课</th>
							<th field="isFinished" align="center" width="6%" rowspan="2">是否完成</th>
						</tr>
						<tr>
							<th field="joinNum1" align="center" width="5%">参与人数</th>
							<th field="elecNum" align="center" width="5%">2次电教人数</th>
							<th field="elecRate" align="center" width="5%">电教完成率</th>
							<th field="joinNum2" align="center" width="5%">参与人数</th>
							<th field="atteRate1" align="center" width="5%">出勤率</th>
							<th field="degreeRate1" align="center" width="5%">满意度</th>
							<th field="joinNum3" align="center" width="5%">参与人数</th>
							<th field="atteRate2" align="center" width="5%">出勤率</th>
							<th field="degreeRate2" align="center" width="5%">满意度</th>
							<th field="joinNum4" align="center" width="5%">参与人数</th>
							<th field="atteRate3" align="center" width="5%">出勤率</th>
							<th field="degreeRate3" align="center" width="5%">满意度</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
