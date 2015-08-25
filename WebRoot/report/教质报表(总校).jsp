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
	  					<td>时间：</td>
	  					<td>
	  						<select class="easyui-combobox" name="month" id="month" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td>综合完成率：</td>
	  					<td>
	  						<input class="easyui-textbox" id="totalLowLimit" style="width:58px;">%至
	  						<input class="easyui-textbox" id="totalLimit" style="width:58px;">%
	  					</td>	
	  					<td>综合满意度：</td>
	  					<td>
	  						<input class="easyui-textbox" id="totalSatis" style="width:150px;">
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
							<th field="schoolId" align="center" width="8%" rowspan="2">校区</th>
							<th field="classNum" align="center" width="10%" rowspan="2">当月开展教质事件班级数</th>
							<th field="shouldNum" align="center" width="10%" rowspan="2">应参与在读学员人数</th>
							<th field="elecTeach" align="center" width="24%" colspan="3">电教调查</th>
							<th field="meeting" align="center" width="24%" colspan="3">家长会</th>
							<th field="celebration" align="center" width="24%" colspan="3">毕业典礼</th>
							<th field="publicClass" align="center" width="24%" colspan="3">公开课</th>
							<th field="finishRate" align="center" width="8%" rowspan="2">综合完成率</th>
							<th field="satisRate" align="center" width="32%" colspan="4">满意度情况</th>
						</tr>
						<tr>
							<th field="joinNum" align="center" width="8%">参与人数</th>
							<th field="elecNum" align="center" width="8%">2次电教人数</th>
							<th field="elecRate" align="center" width="8%">电教完成率</th>
							<th field="planMeet" align="center" width="8%">计划家长会次数</th>
							<th field="actuMeet" align="center" width="8%">实际家长会次数</th>
							<th field="meetRate" align="center" width="8%">家长会完成率</th>
							<th field="planPublic" align="center" width="8%">计划公开课次数</th>
							<th field="actuPublic" align="center" width="8%">实际公开课次数</th>
							<th field="publicRate" align="center" width="8%">公开课完成率</th>
							<th field="planCele" align="center" width="8%">计划毕业典礼次数</th>
							<th field="actuCele" align="center" width="8%">实际毕业典礼次数</th>
							<th field="celeRate" align="center" width="8%">毕业典礼完成率</th>
							<th field="meetDegree" align="center" width="8%">家长会满意度</th>
							<th field="publicDegree" align="center" width="8%">公开课满意度</th>
							<th field="celeDegree" align="center" width="8%">毕业典礼满意度</th>
							<th field="totlaDegree" align="center" width="8%">综合满意度</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
