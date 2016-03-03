<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/newRecruit.js"></script>
  	</head>
  
  	<body>
  		<div style="margin-right:5px;">
  			<form id="qryFm">
  				<input type="hidden" id="type" value="inClass30Rate"/>
  				<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId }"/>
	  			<table class="search_tab">
	  				<tr>
	  					<td align="right" width="70px"><span>校区：</span></td>
	  					<td width="100px">
							<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
				        	</select>
						</td>
	  					<td align="right" width="80px"><span>进班日期：</span></td>
	  					<td width="225px">
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeAttend" name="startTimeAttend" data-options="formatter:myformatter, parser:myparser"/>
							至
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeAttend" name="endTimeAttend" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="left">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1041">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
	  				</tr>
	  			</table>
  			</form>
				<table class="easyui-datagrid" style="height:435px;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th data-options="field:'schoolName',width:100,align:'center'">校区</th>
							<th data-options="field:'inNum',width:150,align:'center'">30天内新招进班人数</th>
							<th data-options="field:'newTotalNum',width:150,align:'center'">新招进班人数</th>
							<th data-options="field:'inPercentage',width:150,align:'center'">新招30天内进班占比</th>
							<th data-options="field:'avgWaitDays',width:150,align:'center'">30天内新招平均等班时间（天）</th>
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
	exportLink("export","list_data");
</script>