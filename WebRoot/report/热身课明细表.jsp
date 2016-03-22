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
  			<input type="hidden" id="resourceId" value="756">
  			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId}"/>
		<form id="manFm">
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
					<td align="right" width="70px">
						开课日期：
					</td >
					<td width="225px">
						<input name="openStartDate" id="openStartDate" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="openEndDate" id="openEndDate" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
					</td>
					<td align="left">
						<a href="javascript:void(0)" id="queryManBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetManBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;">重置</a>
					</td>
				</tr>
			</table>
		</form>
			<table class="easyui-datagrid" title="班级列表" style="height:390px" id="manList" toolbar="#toolManbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th width="12%" field="schoolName">校区</th>
						<th width="12%" field="className">热身课班级编号</th>
						<th width="13%" field="openDate">热身课开始时间</th>
						<th width="13%" field="finishDate">热身课结束时间</th>
						<th width="12%" field="planHours">计划总课时</th>
						<th width="12%" field="classProgress">实际反馈课时</th>
						<th width="12%" field="planClassNum">申请热身课人数</th>
						<th width="12%" field="realClassNum">实际上课人数</th>
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
				var openStartDate = $("#openStartDate").datebox("getValue");
				var openEndDate = $("#openEndDate").datebox("getValue");
				if(openStartDate != "" && openEndDate == "")
				{
					obj["openEndDate"] = "3000-12-31";
				}
				else if(openStartDate == "" && openEndDate != "")
				{
					obj["openStartDate"] = "1900-01-01";
				}
				obj["queryCode"] = "qryWarmupClassInfo";
				obj["funcNodeId"] = "38122";
				obj = JSON.stringify(obj);
				$("#manList").datagrid({
					url:"/sys/pubData/qryDataListByPage.do",
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