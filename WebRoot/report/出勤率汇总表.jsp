<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<style type="text/css">
			td{
				font-size:14px;
				font-family:"微软雅黑";
			}
		</style>
  	</head>
  
  	<body>
  		<div style="margin-right:5px;">
		<input type="hidden" id="resourceId" value="752">
  		<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId}"/>
		<form id="attFm">
			<table class="search_tab">
				<tr>
					<td align="right" width="70px;">
						<span>校区：</span>
					</td>
					<td width="100px;">
	  					<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        </select>
					</td>
					<td align="right" width="40px;">
						<span>月份：</span>
					</td>
					<td width="100px">
						<input name="monthDate" id="monthDate" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myYearMonthformatter, parser:myparser" />
					</td>
					<td colspan="2" align="left">
						<a href="javascript:void(0)" id="qryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()" funcNodeId="38128">查询</a>
						<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
		</form>
			<table class="easyui-datagrid" title="出勤率汇总表 " style="height:390px;text-align:center;" id="attList" 
				url="" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th width="16.7%" field="schoolName">校区</th>
						<th width="16.7%" field="attendNums">应到人数</th>
						<th width="16.7%" field="realNums">实到人数</th>
						<th width="16.7%" field="attendRates">出勤率</th>
						<th width="16.7%" field="dressNums">实穿校服人次</th>
						<th width="16.7%" field="dressRates">校服穿着率</th>
					</tr>
				</thead>
			</table>
		<div id="toolbar" style="padding: 2px; height: auto">
   			<a href="javascript:void(0)" id="hisViewBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;">导出</a>
		</div>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#monthDate").datebox({
					onShowPanel:settingYearMonthPanel
				})
				initReportButton("resetBtn","attFm","schoolId")
				exportLink("hisViewBtn","attList");
			});
			function queryFunc()
			{
				initPageNumber("attList");
				var obj = $("#attFm").serializeObject();
				obj["queryCode"] = "qryAttenceSummaryReport";
				obj["funcNodeId"] = "38128";
				obj = JSON.stringify(obj);
				$("#attList").datagrid({
					url:"/sys/pubData/qryDataListByPage.do",
					queryParams:{
						param : obj
					}
				});
			}
		</script>
 	</body>
</html>
