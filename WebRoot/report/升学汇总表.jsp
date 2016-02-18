<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/higherSummary.js"></script>
  	</head>
  
  	<body>
  		<div style="padding:5px 0;">
  			<form id="qryFm" style="margin:0 auto;">
  				<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId }"/>
  				<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:80px;" cellspacing="2">
  					<tr>
  						<td align="right" width="50px"><span>校区：</span></td>
	  					<td width="100px">
							<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;">
				        	</select>
						</td>
						<td align="right" width="100px"><span>缴费日期：</span></td>
						<td width="100px">
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimePay" name="startTimePay" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="center" width="14px"><span>至</span></td>
						<td width="100px">
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimePay" name="endTimePay" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="center">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1083">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
						<td width="400px">&nbsp;</td>
  					</tr>
  				</table>
  			</form>
  			<div style="padding:5px 0; min-width:1100px; width:100%;">
  				<table class="easyui-datagrid" title="查询结果" style="min-height: 435px; height: auto;" id="list_data" 
				  		toolbar="#toolbar" pagination="false" rownumbers="false" fitColumns="true">
				  	<thead>
				  		<tr>
				  			<th field="schoolName" align="center" width="6%" rowspan="2">校区</th>
				  			<th field="stageId" align="center" width="8%" rowspan="2">课程阶段</th>
				  			<th field="planInfo" align="center" width="16%" colspan="2">计划新增（升学）</th>
				  			<th field="realityInfo" align="center" width="16%" colspan="2">实际完成（升学）</th>
				  			<th field="refundCourseNum" align="center" width="8%" rowspan="2">退费个数</th>
							<th field="refundYearNum" align="center" width="8%" rowspan="2">退费年数</th>
							<th field="realityCourseNum" align="center" width="10%" rowspan="2">最后完成个数</th>
							<th field="realityYearNum" align="center" width="10%" rowspan="2">最后完成年数</th>
							<th field="courseRate" align="center" width="9%" rowspan="2">个数完成率</th>
							<th field="yearRate" align="center" width="9%" rowspan="2">年数完成率</th>
				  		</tr>
				  		<tr>
				  			<th field="planCourseNum" align="center" width="8%">个数</th>
				  			<th field="planYearNum" align="center" width="8%">年数</th>
				  			<th field="courseNum" align="center" width="8%">个数</th>
				  			<th field="yearNum" align="center" width="8%">年数</th>
				  		</tr>
				  	</thead>
				</table>
  			</div>
  		</div>
  	</body>
</html>
