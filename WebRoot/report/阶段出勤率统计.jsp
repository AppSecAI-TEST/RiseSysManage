<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/attendRate.js"></script>
  	</head>
  
  	<body>
  		<div style="margin-right:5px;">
  			<input type="hidden" id="type" value="stageId"/>
  			<input type="hidden" id="resourceId" value="751"/>
  			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId }"/>
  			<input type="hidden" id="staffSchoolId" value="${sessionScope.StaffT.schoolId }"/>
  			<input type="hidden" id="staffPost" value="${sessionScope.StaffT.post }"/>
  			<form id="qryFm">
  				<table class="search_tab">
  					<tr>
  						<td align="right" style="min-width: 40px;"><span>校区：</span></td>
	  					<td align="left" style="min-width: 10px;">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        	</select>
	  					</td>
	  					<td align="right" style="min-width: 40px;"><span>阶段：</span></td>
						<td style="min-width: 100px;">
							<select id="stageId" name="stageId" class="easyui-combobox" style="width: 100px; height: 25px;"></select>					
						</td>
  						<td align="right" style="min-width: 40px"><span>年度：</span></td>
						<td style="min-width: 100px">
							<select class="easyui-combobox" name="year" id="year" style="width:100px;height: 25px;" editable="false" data-options="valueField:'val',textField:'text'">
							</select>
						</td>
  						<td align="right" style="min-width: 40px;"><span>月份：</span></td>
						<td style="min-width: 100px">
							<select id="month" name="month" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false" data-options="valueField:'val',textField:'text'"></select>
						</td>
						<td align="right" style="min-width: 60px;"><span>出勤率：</span></td>
						<td style="min-width: 220px;">
							<input name="minAttendRate" id="minAttendRate" type="text" style="width:88px;height:25px;" class="easyui-numberbox" data-options="precision:1,min:0,max:100"/>%
							至
							<input name="maxAttendRate" id="maxAttendRate" type="text" style="width:88px;height:25px;" class="easyui-numberbox" data-options="precision:1,min:0,max:100"/>%							
						</td>
						<td style="min-width: 210px;">
							<a href="javascript:void(0)" id="qryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;height:25px;" onclick="queryFunc()" funcNodeId="1104">查询</a>
							<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;height:25px;" onclick="resetFunc()">重置</a>
						</td>
  					</tr>
  				</table>
  			</form>
  			<table class="easyui-datagrid" style="height:435px;" id="list_data"
				title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
				<thead>
					<tr>
						<th data-options="field:'schoolName',width:'8%',align:'center'">校区</th>
						<th data-options="field:'stageId',width:'8%',align:'center'">阶段</th>
						<th data-options="field:'attendRate1',width:'8%',align:'center'">1月出勤率</th>
						<th data-options="field:'attendRate2',width:'8%',align:'center'">2月出勤率</th>
						<th data-options="field:'attendRate3',width:'8%',align:'center'">3月出勤率</th>
						<th data-options="field:'attendRate4',width:'8%',align:'center'">4月出勤率</th>
						<th data-options="field:'attendRate5',width:'8%',align:'center'">5月出勤率</th>
						<th data-options="field:'attendRate6',width:'8%',align:'center'">6月出勤率</th>
						<th data-options="field:'attendRate7',width:'8%',align:'center'">7月出勤率</th>
						<th data-options="field:'attendRate8',width:'8%',align:'center'">8月出勤率</th>
						<th data-options="field:'attendRate9',width:'8%',align:'center'">9月出勤率</th>
						<th data-options="field:'attendRate10',width:'8%',align:'center'">10月出勤率</th>
						<th data-options="field:'attendRate11',width:'8%',align:'center'">11月出勤率</th>
						<th data-options="field:'attendRate12',width:'8%',align:'center'">12月出勤率</th>
					</tr>
				</thead>
			</table>
			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;height:25px;">导出</a>
			</div>
  		</div>
  	</body>
</html>
<script>
	exportMergeLink("export", "list_data", "schoolName", "0");
</script>