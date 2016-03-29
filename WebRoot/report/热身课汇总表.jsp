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
  			<input type="hidden" id="resourceId" value="757">
  			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId}"/>
		<form id="manFm">
			<input type="hidden" id="warmupCnt" name="warmupCnt" />
			<table class="search_tab">
				<tr>
					<td align="right" width="70px">
						校区：
					</td>
					<td width="100px">
						<select id="schoolManId" name="schoolManId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        </select>
					</td>
					<td align="right" width="80px">
						热身课次数：
					</td>
					<td width="150px">
						<input name="warmupStart" id="warmupStart" type="text" class="easyui-textbox" style="width:60px; height: 25px;" />&nbsp;至&nbsp;<input name="warmupEnd" id="warmupEnd" type="text" class="easyui-textbox" style="width:60px; height: 25px;" />								
					</td>
					<td align="right" width="70px">
						计划课时：
					</td>
					<td width="150px">
						<input name="planTimesStart" id="planTimesStart" type="text" class="easyui-textbox" style="width:60px; height: 25px;" />&nbsp;至&nbsp;<input name="planTimesEnd" id="planTimesEnd" type="text" class="easyui-textbox" style="width:60px; height: 25px;" />								
					</td>
					<td align="left">
						<a href="javascript:void(0)" id="queryManBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetManBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;">重置</a>
					</td>
				</tr>
			</table>
		</form>
			<table class="easyui-datagrid" title="班级列表" style="height:390px" id="manList" toolbar="#toolManbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true" showFooter="true">
				<thead>
					<tr>
						<th width="33%" field="schoolName">校区</th>
						<th width="33%" field="warmupTimes">热身课次数</th>
						<th width="33%" field="planHoursNum">热身课计划总课时</th>
					</tr>
				</thead>
			</table>
		<div id="toolManbar" style="padding: 2px; height: auto">
			<a href="javascript:void(0)" id="exportBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="exportFunc()">导出</a>
		</div>
	</div>	
		<script type="text/javascript">
			$(document).ready(function(){
				initReportButton("resetManBtn","manFm","schoolManId")
			});
			function queryFunc()
			{
				var obj = $("#manFm").serializeObject();
				var warmupStart = $("#warmupStart").textbox("getValue");
				var warmupEnd = $("#warmupEnd").textbox("getValue");
				var planTimesStart = $("#planTimesStart").textbox("getValue");
				var planTimesEnd = $("#planTimesEnd").textbox("getValue");
				$("#warmupCnt").val("");
				if(warmupStart != "" && warmupEnd == "")
				{
					obj["warmupEnd"] = "99999999";
					$("#warmupCnt").val("1");
				}
				else if(warmupStart == "" && warmupEnd != "")
				{
					obj["warmupStart"] = "0";
					$("#warmupCnt").val("1");
				}
				else if(warmupStart != "" && warmupEnd != "")
				{
					$("#warmupCnt").val("1");
				}
				if(planTimesStart != "" && planTimesEnd == "")
				{
					obj["planTimesEnd"] = "99999999";
					$("#warmupCnt").val("1");
				}
				else if(planTimesStart == "" && planTimesEnd != "")
				{
					obj["planTimesStart"] = "0";
					$("#warmupCnt").val("1");
				}
				else if(planTimesStart != "" && planTimesEnd != "")
				{
					$("#warmupCnt").val("1");
				}
				obj["queryCode"] = "qryWarmupSummary";
				obj["funcNodeId"] = "38142";
				obj = JSON.stringify(obj);
				$("#manList").datagrid({
					url:"/sys/shortBus/qryDataListByPage.do",
					queryParams:{
						param : obj
					}
				});
			}
			function exportFunc()
			{
				exportLink("exportBtn","manList");
			}
		</script>
 	</body>
</html>