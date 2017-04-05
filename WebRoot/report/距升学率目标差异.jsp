<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/higherRate.js"></script>
  	</head>
  
  	<body>
  		<div style="margin-right:5px;">
	  		<input type="hidden" id="higherType" value="gapRate"/>
	  		<input type="hidden" id="resourceId" value="711"/>
	  		<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId}"/>
  			<input type="hidden" id="staffSchoolId" value="${sessionScope.StaffT.schoolId }"/>
  			<input type="hidden" id="staffPost" value="${sessionScope.StaffT.post }"/>
  			<form id="qryFm">
	  			<table class="search_tab">
	  				<tr>
	  					<td align="right" width="50px"><span>校区：</span></td>
	  					<td width="100px">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        	</select>
						</td>
						<td align="right" width="50px"><span>年度：</span></td>
						<td width="100px">
							<select class="easyui-combobox" name="year" id="year" style="width:100px;height: 25px;" 
								editable="false" data-options="valueField:'val',textField:'text'">
							</select>
						</td>
	  					<td align="left">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1097">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
	  				</tr>
	  			</table>
  			</form>
				<table class="easyui-datagrid" style="height:auto;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th data-options="field:'schoolName',width:100,align:'center'">校区</th>
							<th data-options="field:'higherNum1',width:100,align:'center'">结课班升学率目标70%</th>
							<th data-options="field:'higherNum2',width:100,align:'center'">结课班升学率目标72%</th>
							<th data-options="field:'higherNum3',width:100,align:'center'">结课班升学率目标75%</th>
							<th data-options="field:'higherNum4',width:100,align:'center'">结课班升学率目标78%</th>
							<th data-options="field:'higherNum5',width:100,align:'center'">结课班升学率目标80%</th>
							<th data-options="field:'higherNum6',width:100,align:'center'">结课班升学率目标85%</th>
						</tr>
					</thead>
				</table>
			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
			</div>
  		</div>
  	</body>
</html>
<script>
	exportLink("export", "list_data");
</script>