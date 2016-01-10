<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/exceptionBudget.js"></script>
  	</head>
  
  	<body>
  		<div style="padding:5px 0;">
  			<form id="qryFm" style="margin:0 auto;">
  				<input type="hidden" id="tableName" value="report_exception_budget"/>
	  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:80px;" cellspacing="2">
	  				<tr>
	  					<td align="right" width="50px"><span>校区：</span></td>
	  					<td width="115px">
							<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
								onLoadSuccess:function(data){if(data.length > 0) {$('#schoolId').combobox('setValue', data[0].schoolId);}}"
					      		url="<%=path %>/pubData/qrySchoolList.do?schoolId=">
				        	</select>
						</td>
	  					<td align="right" width="50px"><span>月份：</span></td>
	  					<td width="230px">
	  						<select id="year" name="year" class="easyui-combobox" style="width: 100px; height: 25px;">
	  						</select>
	  						<select id="month" name="month" class="easyui-combobox" style="width: 100px; height: 25px;">
	  						</select>
	  					</td>
	  					<td align="left" width="250px">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1073">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
						<td align="left" width="400px">&nbsp;</td>
	  				</tr>
	  			</table>
  			</form>
			<div style="padding:5px 0;min-width:1100px; width:100%;">
				<table class="easyui-datagrid" style="height:auto;" id="list_data" data-options="onClickCell: onClickCell"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th field="schoolName" align="center" width="6%" rowspan="2">校区</th>
							<th field="endDate" align="center" width="8%" rowspan="2">日期</th>
							<th field="studentInSchoolNum" align="center" width="6%" rowspan="2">在校人数</th>
							<th field="studyingNum" align="center" width="6%" rowspan="2">在读人数</th>
							<th field="exceptionNum" align="center" width="7%" rowspan="2">异动总人数</th>
							<th field="exceptionRate" align="center" width="7%" rowspan="2">异动总占比</th>
							<th data-options="field:'exceptionInClassNum', width:'8%', align:'center', rowspan:2, editor:{type:'numberbox',options:{precision:0, min:0, max:100}}">异动进班人数</th>
							<th field="endClass" align="center" width="10%" colspan="2">本周结课</th>
							<th data-options="field:'newPlanNum', width:'6%', align:'center', rowspan:2, editor:{type:'numberbox',options:{precision:0, min:0, max:100}}">新招计划</th>
							<th data-options="field:'changeOutClassNum', width:'6%', align:'center', rowspan:2, editor:{type:'numberbox',options:{precision:0, min:0, max:100}}">转出进班</th>
							<th data-options="field:'changeInClassNum', width:'6%', align:'center', rowspan:2, editor:{type:'numberbox',options:{precision:0, min:0, max:100}}">转入进班</th>
							<th data-options="field:'exceptionRefundNum', width:'6%', align:'center', rowspan:2, editor:{type:'numberbox',options:{precision:0, min:0, max:100}}">异动退费</th>
							<th data-options="field:'studyingRefundNum', width:'6%', align:'center', rowspan:2, editor:{type:'numberbox',options:{precision:0, min:0, max:100}}">在读退费</th>
						</tr>
						<tr>
							<th data-options="field:'finishStudyingNum', width:'5%', align:'center', editor:{type:'numberbox',options:{precision:0, min:0, max:100}}">在读</th>
							<th data-options="field:'finishHigherNum', width:'5%', align:'center', editor:{type:'numberbox',options:{precision:0, min:0, max:100}}">已升</th>
						</tr>
					</thead>
				</table>
			</div>
			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px;">导出</a>
	   			<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 120px;">提交异动预算</a>
	   			<a href="javascript:void(0)" id="create" class="easyui-linkbutton" iconCls="icon-add" style="width: 150px;">创建下月异动预算</a>
			</div>
  		</div>
  	</body>
</html>
