<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<html>
	<head>
	<%@ include file="../common/head.jsp" %>
	<%@ include file="../common/formvalidator.jsp" %>
	<style>
		.datagrid
		{
			min-width:200px;
		}
	</style>
	</head>
	<body>
		<table class="easyui-datagrid" align="center" title="校区优惠体系列表" id="schoolLinkPrice_data" style="width:380px;margin:5px auto;height:380px;" id="schoolList" url="<%=path %>/genCourseConfig/qryDataListByPage.do?param={'queryCode':'qryAllSchoolPrice','type':'FAVOR_PRICE'}" 
		border="true" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true" data-options="onLoadSuccess:function(data){$('#schoolLinkPrice_data').datagrid('clearSelections');}">
			<thead>
				<tr>
					<th field="schoolName" align="center" width="50%"><span>校区名称</span></th>
					<th field="priceName" align="center" width="50%"><span>优惠体系名称</span></th>
				</tr>
			</thead>
		</table>
		<div style="margin-top: 10px;text-align:right;">
	      	<a href="javascript:void(0)" id="back" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:parent.window.$('#linkDlg').dialog('close')">返回</a>
	     </div>
	</body>
</html>