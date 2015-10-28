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
 		<form id="qryFm">
 			<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="15">
  				<tr>
  					<td width="5%" align="right"><span>年份：</span></td>
  					<td width="15%">
  						<select class="easyui-combobox" name="year" id="year" style="width:150px;height: 28px;"
  							data-options="valueField:'val',textField:'text', panelHeight: 'auto',editable:false">
  						</select>
  					</td>
  					<td align="left">
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qryBtn" funcNodeId="3050">查询</a>
  					</td>
  				</tr>
  			</table>
 		</form>
 			<table class="easyui-datagrid" title="休假时间" id="list_data" toolbar="#toolbar" >
	 			<thead>  	
		 			<tr>
			 			<th data-options="field:'ck',checkbox:true"></th>
						<th field="month" align="center" width="5%">月份</th>
						<th field="daysValue" align="center" width="94%">休假日期</th>
		 			</tr>
		 		</thead>
		 		<tbody>	
	 			</tbody>	
	 		</table>
 			<div id="toolbar" class="easyui-panel">
	   			<a href="javascript:void(0)" id="addBtn" class="easyui-linkbutton" iconCls="icon-add" plain="true"><span>创建</span></a>
	   			<a href="javascript:void(0)" id="updateBtn" class="easyui-linkbutton" iconCls="icon-edit" plain="true"><span>修改</span></a>
	   			<a href="javascript:void(0)" id="timeConfig" class="easyui-linkbutton" iconCls="icon-edit" plain="true"><span>上课时段配置</span></a>
 			</div>
 			<iframe id="dlg" class="easyui-dialog" style="width:800px; height: 450px; padding: 10px 20px" closed="true" modal="true">
			</iframe>
  	</body>
</html>
