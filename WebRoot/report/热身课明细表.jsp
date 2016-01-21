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
		<form id="manFm" style="margin:0 auto;">
			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:5px auto;height:80px;" cellspacing="2">
				<tr>
					<td align="right" width="8%">
						校区：
					</td>
					<td width="11%">
						<select id="schoolManId" name="schoolManId" style="width:100px" ></select>
					</td>
					<td align="right">
						开课日期：
					</td>
					<td>
						<input name="openStartDate" id="openStartDate" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="openEndDate" id="openEndDate" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
					</td>
					<td align="center">
						<a href="javascript:void(0)" id="queryManBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetManBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
		</form>
		<div style="padding:5px 0;min-width:1100px; width:100%">
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
		</div>
		<div id="toolManbar" style="padding: 2px; height: auto">
			<a href="javascript:void(0)" id="exportBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="exportFunc()">导出</a>
		</div>
		<script type="text/javascript">
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=851&fieldId=schoolId",function(data){
				$("#schoolManId").combobox("loadData",data);
			},"json");
			$(document).ready(function(){
				$("#schoolManId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto'
				});
			});
			function queryFunc()
			{
				var obj = $("#manFm").serializeObject();
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
			function resetFunc()
			{
				$("#schoolManId").combobox("setValue","");
				$("#openStartDate").datebox("setValue","");
				$("#openEndDate").datebox("setValue","");
			}
			function exportFunc()
			{
				exportLink("exportBtn","manList");
			}
		</script>
 	</body>
</html>