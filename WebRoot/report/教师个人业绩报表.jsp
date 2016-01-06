<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
			<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  	<body>
  		<div style="padding:5px 10px;">
  			<form id="qryFm">
	  			<table>
	  				<tr>
	  					<td>校区：</td>
	  					<td>
	  					<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
									data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
					      			onLoadSuccess:function(data){if(data.length > 0) $('#schoolId').combobox('setValue',data[0].schoolId);}"
					      			url="<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=&fieldId=schoolId">
				        		</select>
	  					</td>
	  					<td>老师：</td>
	  					<td>
	  						<input class="easyui-combobox"  id="teacherId" style="width:150px;">
	  					</td>
	  					<td>月份：</td>
	  					<td>
	  						<select class="easyui-combobox" name="time" id="time" style="width:150px;">
	  							
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
							<th field="seq" align="center" width="6%" rowspan="2">序号</th>
							<th field="schoolId" align="center" width="6%" rowspan="2">校区</th>
							<th field="chName" align="center" width="6%" rowspan="2">中文名</th>
							<th field="enName" align="center" width="6%" rowspan="2">英文名</th>
							<th field="entryDate" align="center" width="6%" rowspan="2">入职时间</th>
							<th field="entryDuration" align="center" width="6%" rowspan="2">入职时长</th>
							<th field="graAchieve" align="center" width="12%" colspan="2">升学业绩</th>
							<th field="graReturn" align="center" width="12%" colspan="2">升学退费情况</th>
							<th field="certNum" align="center" width="6" rowspan="2">口碑业绩</th>
							<th field="dutyStep" align="center" width="6%" rowspan="2">口碑退费</th>
							<th field="entryDuration" align="center" width="6%" rowspan="2">游学业绩</th>
							<th field="certStep" align="center" width="6%" rowspan="2">游学退费</th>
							<th field="certNum" align="center" width="6%" rowspan="2">国际班业绩</th>
							<th field="dutyStep" align="center" width="6%" rowspan="2">国际版退费</th>
						</tr>
						<tr>
							<th field="num1" align="center" width="6%">个数</th>
							<th field="year1" align="center" width="6%">年数</th>
							<th field="num2" align="center" width="6%">个数</th>
							<th field="year2" align="center" width="6%">年数</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
