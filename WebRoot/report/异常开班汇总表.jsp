<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/exceptionOpenClass.js"></script>
  	</head>
  
  	<body>
  		<div style="margin-right:5px;">
  			<input id="staffId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<input type="hidden" id="resourceId" value="503">
  			<form id="qryFm">
  				<table class="search_tab">
  					<tr>
  						<td align="right"><span>校区：</span></td>
	  					<td>
							<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false" 
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        	</select>
						</td>
						<td align="right"><span>异常开班数量：</span></td>
	  					<td>
	  						<input name="minOpenNum" id="minOpenNum" type="text" class="easyui-numberbox" style="width: 40px; height: 25px;"/>
							至
							<input name="maxOpenNum" id="maxOpenNum" type="text" class="easyui-numberbox" style="width: 40px; height: 25px;"/>
	  					</td>
	  					<td align="right"><span>异常开班占比：</span></td>
	  					<td>
	  						<input name="minOpenRate" id="minOpenRate" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
							至
							<input name="maxOpenRate" id="maxOpenRate" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
	  					</td>
	  					<td align="right"><span>开课日期：</span></td>
	  					<td>
							<input class="easyui-datebox" type="text" style="width:120px; height: 25px;" id="startTimeOpen" name="startTimeOpen" data-options="formatter:myformatter, parser:myparser"/>
							至
							<input class="easyui-datebox" type="text" style="width:120px; height: 25px;" id="endTimeOpen" name="endTimeOpen" data-options="formatter:myformatter, parser:myparser"/>
						</td>
					</tr>
					<tr>	
						<td align="center" colspan="8">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1058">查询</a>
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
							<th data-options="field:'openTotalNum',width:100,align:'center'">开班总数</th>
							<th data-options="field:'exceptionOpenNum',width:100,align:'center'">异常开班数量</th>
							<th data-options="field:'exceptionOpenRate',width:100,align:'center'">异常开班占比</th>
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
initReportButton("resetBtn","qryFm","schoolId");
exportLink("export","list_data");
</script>