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
  		<div style="margin-right:5px;">
  			<input type="hidden" id="resourceId" value="754">
  			<input type="hidden" id="tableName" value="report_school_exception"/>
  			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId}"/>
  			<input type="hidden" id="staffSchoolId" value="${sessionScope.StaffT.schoolId }"/>
  			<input type="hidden" id="staffPost" value="${sessionScope.StaffT.post }"/>
  			<form id="qryFm">
	  			<table class="search_tab">
	  				<tr>
	  					<td align="right" style="min-width: 40px;"><span>校区：</span></td>
	  					<td style="min-width: 100px;">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        	</select>
						</td>
						<td align="right" style="min-width: 40px;" id="regionTitleTd"><span>片区：</span></td>
						<td style="min-width: 100px;" id="regionTd">
		  					<select id="regionId" name="regionId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
									data-options="formatter:formatRegion, valueField: 'regionId', textField: 'regionName', panelHeight: 'auto'">
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
						<td align="left">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1065">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
	  				</tr>
	  			</table>
  			</form>
				<table class="easyui-datagrid" style="height:auto;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th field="schoolName" align="center" width="6%" rowspan="2">校区</th>
							<th field="studentInSchoolNum" align="center" width="7%" rowspan="2">在校生人数</th>
							<th field="studyingNum" align="center" width="5%" rowspan="2">在读人数</th>
							<th field="waitReturn" align="center" width="11%" colspan="2">待退费</th>
							<th field="changeClassNum" align="center" width="5%" rowspan="2">转班</th>
							<th field="changeSchoolNum" align="center" width="5%" rowspan="2">转校</th>
							<th field="exceptionNum" align="center" width="11%" colspan="2">异常</th>
							<th field="leaveNum" align="center" width="11%" colspan="2">休学</th>
							<th data-options="field:'higherNotInClassNum', width:'9%', align:'center', rowspan:2, formatter:formatHigherNotInClass">升学未进班总数</th>
							<th data-options="field:'newNotInClassNum', width:'9%', align:'center', rowspan:2, formatter:formatNewNotInClass">新招未进班总数</th>
							<th field="excNum" align="center" width="6%" rowspan="2">异动人数</th>
							<th field="academicChangeRate" align="center" width="6%" rowspan="2">学术异动</th>
							<th field="newChangeRate" align="center" width="6%" rowspan="2">新招异动</th>
							<th field="above14AcademicChangeRate" align="center" width="10%" rowspan="2">学术异动（不</br>含2周内结课）</th>
							<th field="above1NewChangeRate" align="center" width="10%" rowspan="2">新招异动（不含</br>1个月内新招）</th>
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
				<div id="higher_dlg" class="easyui-dialog" closed="true" modal="true">
					<table class="easyui-datagrid" style="width:900px;height:400px" id="higher_list_data" fitColumns="true">
						<thead>
							<tr>
								<th field="stageId" align="center" width="150px">阶段</th>
								<th field="above14Num" align="center" width="200px">2周内结课人数</th>
								<th field="above14InClassNum" align="center" width="100px">已定班人数</th>
								<th field="lower14Num" align="center" width="200px">2周以上结课人数</th>
								<th field="lower14InClassNum" align="center" width="100px">已定班人数</th>
								<th field="total" align="center" width="150px">阶段人数总计</th>
							</tr>
						</thead>
					</table>
				</div>
				<div id="new_dlg" class="easyui-dialog" closed="true" modal="true">
					<table class="easyui-datagrid" style="width:900px;height:400px" id="new_list_data" fitColumns="true">
						<thead>
							<tr>
								<th field="stageId" align="center" width="150px">阶段</th>
								<th field="above1Num" align="center" width="200px">1个月以内新招未进</th>
								<th field="above1InClassNum" align="center" width="100px">已定班人数</th>
								<th field="lower1Num" align="center" width="200px">1个月以上新招未进班</th>
								<th field="lower1InClassNum" align="center" width="100px">已定班人数</th>
								<th field="total" align="center" width="150px">阶段人数总计</th>
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
<script>
	exportLink("export","list_data");
</script>