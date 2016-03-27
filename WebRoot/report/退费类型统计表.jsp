<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/refund.js"></script>
  	</head>
  	<body>
  		<div style="margin-right:5px;">
  			<input type="hidden" id="resourceId" value="718">
  			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId}"/>
  			<form id="qryFm">
	  			<table class="search_tab">
	  				<tr>
	  					<td align="right" width="80px"><span>校区：</span></td>
	  					<td align="left"  width="110px">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        	</select>
	  					</td>
	  					<td align="right" width="80px"><span>退费类型：</span></td>
	  					<td align="left"  width="110px">
	  						<select id="refundType" name="refundType" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      						url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_DETAIL_T&codeType=REFUND_TYPE">
				        	</select>
	  					</td>
	  					<td width="80px" align="right"><span>退费归属日期：</span></td>
						<td width="260px">
							<input class="easyui-datebox" type="text"  editable="false" style="width:110px; height: 25px;" id="startTime" name="startTime" data-options="formatter:myformatter, parser:myparser"/>
								至
							<input class="easyui-datebox" type="text"  editable="false" style="width:110px; height: 25px;" id="endTime" name="endTime" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="left">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="3702">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
	  				</tr>	
	  			</table>
  			</form>
				<table class="easyui-datagrid" style="height:435px;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th field="schoolName" align="center" width="8%">校区</th>
							<th field="totalNum" align="center" width="8%">退费总数</th>
							<th field="typeVal" align="center" width="8%">退费类型</th>
							<th field="num" align="center" width="8%">退费个数</th>
							<th field="per" align="center" width="8%">退费占比</th>
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
exportMergeLink("export","list_data","schoolId","0,1");
</script>