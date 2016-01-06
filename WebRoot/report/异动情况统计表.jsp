<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/excDetail.js"></script>
  	</head>
  
  	<body>
  		<div style="padding:5px 0;">
  			<form id="qryFm" style="margin:0 auto;">
  				<input type="hidden" id="tableName" value="school_exception_report"/>
	  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:80px;" cellspacing="2">
	  				<tr>
	  					<td align="right" width="50px"><span>校区：</span></td>
	  					<td width="115px">
							<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
					      		url="<%=path %>/pubData/qrySchoolList.do?schoolId=">
				        	</select>
						</td>
						<td align="right" width="25px"><span>周：</span></td>
						<td width="270px">
							<input class="easyui-datebox" type="text" style="width:80px; height: 25px;" id="year" name="year" data-options="formatter:yearFormatter, parser:yearParser"/>
							<select id="month" name="month" class="easyui-combobox" style="width: 80px; height: 25px;">
	  						</select>
	  						<select id="week" name="week" class="easyui-combobox" style="width: 80px; height: 25px;">
	  						</select>
						</td>
						<td align="left" width="250px">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1065">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
						<td align="left" width="400px">&nbsp;</td>
	  				</tr>
	  			</table>
  			</form>
			<div style="padding:5px 0;min-width:1100px; width:100%;">
				<table class="easyui-datagrid" style="height:auto;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th field="schoolName" align="center" width="6%" rowspan="2">校区</th>
							<th field="studentInSchoolNum" align="center" width="7%" rowspan="2">在校生人数</th>
							<th field="waitReturn" align="center" width="11%" colspan="2">待退费</th>
							<th field="changeClassNum" align="center" width="5%" rowspan="2">转班</th>
							<th field="changeSchoolNum" align="center" width="5%" rowspan="2">转校</th>
							<th field="exceptionNum" align="center" width="11%" colspan="2">异常</th>
							<th field="leaveNum" align="center" width="11%" colspan="2">休学</th>
							<th field="higherNotInClassNum" align="center" width="9%" rowspan="2">升学未进班总数</th>
							<th field="newNotInClassNum" align="center" width="9%" rowspan="2">新生未进班总数</th>
							<th field="excNum" align="center" width="6%" rowspan="2">异动人数</th>
							<th field="academicChangeRate" align="center" width="6%" rowspan="2">学术异动</th>
							<th field="newChangeRate" align="center" width="6%" rowspan="2">新招异动</th>
							<th field="above14AcademicChangeRate" align="center" width="10%" rowspan="2">学术异动（不含2周内结课）</th>
							<th field="above1NewChangeRate" align="center" width="10%" rowspan="2">新招异动（不含1个月内新招）</th>
						</tr>
						<tr>
							<th field="nonAcademicRefundNum" align="center" width="6%">非学术</th>
							<th field="academicRefundNum" align="center" width="5%">学术</th>
							<th field="lower3MonthExcNum" align="center" width="5%">3个月内</th>
							<th field="above3MonthExcNum" align="center" width="6%">3个月以上</th>
							<th field="lower3MonthLeaveNum" align="center" width="5%">3个月内</th>
							<th field="above3MonthLeaveNum" align="center" width="6%">3个月以上</th>
						</tr>
					</thead>
				</table>
				<div id="dlg" class="easyui-dialog" closed="true" modal="true">
					<table class="easyui-datagrid" title="升学未进班阶段明细" style="width:100%;height:250px" id="list_data1" fitColumns="true">
						<thead>
							<tr>
								<th field="stageId" align="center" width="30%">阶段</th>
								<th field="inTwoWeeks" align="center" width="35%">2周内结课人数</th>
								<th field="aftTwoWeeks" align="center" width="35%">2周以上结课人数</th>
							</tr>
						</thead>
					</table>
				</div>
				<div id="dlg1" class="easyui-dialog" closed="true" modal="true">
					<table class="easyui-datagrid" title="新生未进班阶段明细" style="width:100%;height:250px" id="list_data2" fitColumns="true">
						<thead>
							<tr>
								<th field="stageId" align="center" width="30%">阶段</th>
								<th field="inMonth" align="center" width="35%">1个月以内新招未进</th>
								<th field="aftMonth" align="center" width="35%">1个月以上新招未进班</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
			</div>
  		</div>
  	</body>
</html>
