<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/finishInClass.js"></script>
  	</head>
  
  	<body>
  		<div style="magrin-right:5px;">
  			<form id="qryFm">
  				<input type="hidden" id="resourceId" value="717">
	  			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId }"/>
	  			<table class="search_tab">
	  				<tr>
	  					<td align="right" style="min-width: 50px"><span>校区：</span></td>
	  					<td style="min-width: 100px">
							<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;" editable="false">
				        	</select>
						</td>
						<td align="center" style="min-width: 210px">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1051">查询</a>
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
							<th data-options="field:'totalNum',width:100,align:'center'">升学未进班学员数</th>
							<th data-options="field:'avgWaitDays',width:100,align:'center'">平均等班时间（天）</th>
						</tr>
					</thead>
				</table>
				<div id="toolbar" style="padding: 2px; height: auto">
	   				<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
				</div>
  		</div>
  	</body>
</html>
