<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/sys/log.js"></script>
  	</head>
  
  	<body>
  		<div style ="margin-right:5px;">
  			<form id="qryFm">
  				<table class="search_tab">
  					<tr>
  						<td align="right" style="width: 100px;"><span>登录名称：</span></td>
  						<td style="width: 100px;">
							<input id="sysName" name="sysName" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
						</td>
						<td align="right" style="width: 100px;"><span>日志描述：</span></td>
  						<td style="width: 150px;">
							<input id="desc" name="desc" type="text" class="easyui-textbox" style="width: 150px; height: 25px;"/>
						</td>
						<td align="right" style="width: 70px;"><span>操作时间：</span></td>
						<td align="left">
							<input class="easyui-datebox" type="text" style="width:100; height: 25px;" id="startTime" name="startTime" data-options="formatter:myformatter, parser:myparser"/>
							至
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTime" name="endTime" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="left">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1088">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
  					</tr>
  				</table>
  			</form>
  			<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="list_data" 
		  		toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false">
		  		<thead>
		  			<tr>
		  				<th data-options="field:'ck',checkbox:true"></th>
		  				<th data-options="field:'createDate',width:150,align:'center'">操作时间</th>
		  				<th data-options="field:'staffName',width:100,align:'center'">操作人</th>
		  				<th data-options="field:'busDesc',width:200,align:'center'">操作功能</th>
		  				<th data-options="field:'logDesc',width:700,align:'center'">描述</th>
		  			</tr>
		  		</thead>
		  	</table>
		  	<div id="toolbar" style="padding: 2px; height: auto">
   				<a href="javascript:void(0)" id="deleteBtn" class="easyui-linkbutton" iconCls="icon-remove" style="width: 80px;">删除</a>
   				<a href="javascript:void(0)" id="deleteAllBtn" class="easyui-linkbutton" iconCls="icon-remove" style="width: 100px;">删除全部</a>
			</div>
  		</div>
  	</body>
</html>
