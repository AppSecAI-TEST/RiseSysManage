<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/timeResource/resourceList.js"></script>
  	</head>
  	<body>
  		<div style="margin-right:5px;">
 		<form id="qryFm">
 			<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<table class="search_tab">
  				<tr>
  					<td width="80px" align="right"><span>年份：</span></td>
  					<td align="left">
  						<select class="easyui-combobox" name="year" id="year" style="width:80px;height: 25px;"
  							data-options="valueField:'val',textField:'text', panelHeight: 'auto',editable:false">
  						</select>
  						&nbsp;&nbsp;&nbsp;
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:100px" id="qryBtn" funcNodeId="3050">查询</a>
  					</td>
  				</tr>
  			</table>
 		</form>
 		<table class="easyui-datagrid" title="休假时间" id="list_data" toolbar="#toolbar" >
	 			<thead>  	
		 			<tr>
			 			<th data-options="field:'ck',checkbox:true"></th>
						<th field="month" align="center" width="5%">月份</th>
						<th field="daysValue" align="center" width="93%">休假日期</th>
		 			</tr>
		 		</thead>
		 		<tbody>	
	 			</tbody>	
	 	</table>
 		<div id="toolbar" class="easyui-panel" style="padding:2px;height:auto">
	   		<a href="javascript:void(0)" id="addBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;"><span>创建</span></a>
	   		<a href="javascript:void(0)" id="updateBtn" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;"><span>修改</span></a>
	   		<a href="javascript:void(0)" id="timeConfig" class="easyui-linkbutton" iconCls="icon-edit" style="width: 150px;"><span>上课时段配置</span></a>
 		</div>
 		</div>
 		<iframe id="dlg" class="easyui-dialog" style="width:800px; height: 450px; padding: 10px 20px" closed="true" modal="true">
		</iframe>
  	</body>
</html>
