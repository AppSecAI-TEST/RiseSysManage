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
		<form id="attFm" style="margin:0 auto;">
			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:5px auto;height:80px;" cellspacing="2">
				<tr>
					<td align="right" width="10%">
						校区：
					</td>
					<td width="10%">
						<select id="schoolId" name="schoolId" style="width:100px" ></select>
					</td>
					<td align="right" width="10%">
						月份：
					</td>
					<td width="10%">
						<input name="monthDate" id="monthDate" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myYearMonthformatter, parser:myparser" />
					</td>
					<td colspan="2" style="padding-left:60px">
						<a href="javascript:void(0)" id="queryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
		</form>
		<div style="padding:5px 0;min-width:1100px; width:100%;">
			<table class="easyui-datagrid" title="出勤率汇总表 " style="height:390px;text-align:center;" id="attList" url="" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
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
		</div>
		<div id="toolbar" style="padding: 2px; height: auto">
   			<a href="javascript:void(0)" id="hisViewBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;">导出</a>
		</div>
		<script type="text/javascript">
			ajaxLoading("正在处理，请稍待。。。");
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=901&fieldId=schoolId",function(data){
				$("#schoolId").combobox("loadData",data);
				ajaxLoadEnd();
			},"json");
			$(document).ready(function(){
				$("#schoolId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto',
					onLoadSuccess:function(data){
						if(data.length > 0)
						{
							$("#schoolId").combobox("setValue",data[0].schoolId);
						}
					}
				});
				$("#monthDate").datebox({
					onShowPanel:settingYearMonthPanel
				})
				exportLink("hisViewBtn","attList");
			});
			function queryFunc()
			{
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
			function resetFunc()
			{
				$("#schoolId").combobox("setValue","");
				$("#monthDate").datebox("setValue","");
			}
		</script>
 	</body>
</html>