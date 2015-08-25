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
  			<form id="qryFm1">
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
				<table class="easyui-datagrid" title="班级情况和教室资源统计表" style="width:100%;height:250px" id="list_data">
					<thead>
						<tr>
							<th field="schoolId" align="center" width="10%" rowspan="2">教室 </th>
							<th field="mon" align="center" width="15%" colspan="3">星期一 </th>
							<th field="tues" align="center" width="15%" colspan="3">星期二 </th>
							<th field="wed" align="center" width="15%" colspan="3">星期三 </th>
							<th field="thur" align="center" width="15%" colspan="3">星期四 </th>
							<th field="fri" align="center" width="15%" colspan="3">星期五 </th>
							<th field="sat" align="center" width="25%" colspan="5">星期六 </th>
							<th field="sun" align="center" width="25%" colspan="5">星期日 </th>
						</tr>
						<tr>
							<th field="monM" align="center" width="5%">上午 </th>
							<th field="monA" align="center" width="5%">下午 </th>
							<th field="monE" align="center" width="5%">晚上 </th>
							<th field="tuesM" align="center" width="5%">上午 </th>
							<th field="tuesA" align="center" width="5%">下午 </th>
							<th field="tuesE" align="center" width="5%">晚上 </th>
							<th field="wedM" align="center" width="5%">上午 </th>
							<th field="wedA" align="center" width="5%">下午 </th>
							<th field="wedE" align="center" width="5%">晚上 </th>
							<th field="thurM" align="center" width="5%">上午 </th>
							<th field="thurA" align="center" width="5%">下午 </th>
							<th field="thurE" align="center" width="5%">晚上 </th>
							<th field="friM" align="center" width="5%">上午 </th>
							<th field="friA" align="center" width="5%">下午 </th>
							<th field="firE" align="center" width="5%">晚上 </th>
							<th field="satM1" align="center" width="5%">上午1 </th>
							<th field="satM2" align="center" width="5%">上午2 </th>
							<th field="satA1" align="center" width="5%">下午1 </th>
							<th field="satA2" align="center" width="5%">下午2 </th>
							<th field="satE" align="center" width="5%">晚上 </th>
							<th field="sunM1" align="center" width="5%">上午1 </th>
							<th field="sunM2" align="center" width="5%">上午2 </th>
							<th field="sunA1" align="center" width="5%">下午1 </th>
							<th field="sunA2" align="center" width="5%">下午2</th>
							<th field="sunE" align="center" width="5%">晚上 </th>
						</tr>
					</thead>
				</table>
				<div style="height:10px;"></div>
				<table class="easyui-datagrid" title="老师上课时间安排表" style="width:100%;height:250px" id="list_datas">
					<thead>
						<tr>
							<th field="teacher" align="center" width="10%" rowspan="2">教师 </th>
							<th field="lessonNum" align="center" width="5%" >班级课时数 </th>
							<th field="mon_t" align="center" width="15%" colspan="3">星期一 </th>
							<th field="tues_t" align="center" width="15%" colspan="3">星期二 </th>
							<th field="wed_t" align="center" width="15%" colspan="3">星期三 </th>
							<th field="thur_t" align="center" width="15%" colspan="3">星期四 </th>
							<th field="fri_t" align="center" width="15%" colspan="3">星期五 </th>
							<th field="sat_t" align="center" width="25%" colspan="5">星期六 </th>
							<th field="sun_t" align="center" width="25%" colspan="5">星期日 </th>
						</tr>
						<tr>
							<th field="mainT" align="center" width="5%">主T</th>
							<th field="monM_t" align="center" width="5%">上午 </th>
							<th field="monA_t" align="center" width="5%">下午 </th>
							<th field="monE_t" align="center" width="5%">晚上 </th>
							<th field="tuesM_t" align="center" width="5%">上午 </th>
							<th field="tuesA_t" align="center" width="5%">下午 </th>
							<th field="tuesE_t" align="center" width="5%">晚上 </th>
							<th field="wedM_t" align="center" width="5%">上午 </th>
							<th field="wedA_t" align="center" width="5%">下午 </th>
							<th field="wedE_t" align="center" width="5%">晚上 </th>
							<th field="thurM_t" align="center" width="5%">上午 </th>
							<th field="thurA_t" align="center" width="5%">下午 </th>
							<th field="thurE_t" align="center" width="5%">晚上 </th>
							<th field="friM_t" align="center" width="5%">上午 </th>
							<th field="friA_t" align="center" width="5%">下午 </th>
							<th field="firE_t" align="center" width="5%">晚上 </th>
							<th field="satM1_t" align="center" width="5%">上午1 </th>
							<th field="satM2_t" align="center" width="5%">上午2 </th>
							<th field="satA1_t" align="center" width="5%">下午1 </th>
							<th field="satA2_t" align="center" width="5%">下午2 </th>
							<th field="satE_t" align="center" width="5%">晚上 </th>
							<th field="sunM1_t" align="center" width="5%">上午1 </th>
							<th field="sunM2_t" align="center" width="5%">上午2 </th>
							<th field="sunA1_t" align="center" width="5%">下午1 </th>
							<th field="sunA2_t" align="center" width="5%">下午2</th>
							<th field="sunE_t" align="center" width="5%">晚上 </th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
