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
  		<div style="padding:5px 0;">
  			<input type="hidden" id="higherType" value="gapRate"/>
  			<form id="qryFm" style="margin:0 auto;">
	  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:80px;" cellspacing="2">
	  				<tr>
	  					<td align="right" width="50px"><span>校区：</span></td>
	  					<td width="114px">
							<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;">
				        	</select>
						</td>
	  					<td align="left" colspan="2" width="650px">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1063">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
	  				</tr>
	  			</table>
  			</form>
			<div style="padding:5px 0;min-width:1100px; width:100%;">
				<table class="easyui-datagrid" style="height:auto;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th data-options="field:'schoolName',width:100,align:'center'">校区</th>
							<th data-options="field:'75HigherNum',width:100,align:'center'">75%</th>
							<th data-options="field:'80HigherNum',width:100,align:'center'">80%</th>
							<th data-options="field:'80HigherNum',width:100,align:'center'">85%</th>
							<th data-options="field:'90HigherNum',width:100,align:'center'">90%</th>
							<th data-options="field:'95HigherNum',width:100,align:'center'">95%</th>
							<th data-options="field:'100HigherNum',width:100,align:'center'">100%</th>
						</tr>
					</thead>
				</table>
			</div>
			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
			</div>
  		</div>
  	</body>
</html>
