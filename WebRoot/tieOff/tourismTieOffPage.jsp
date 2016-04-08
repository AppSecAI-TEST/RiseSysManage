<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
  	</head>
  	<body>
  		<div style="padding:5px 0;">
  			<form id="qryFm" style="margin:0 auto;">
	  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto">
	  				<tr>
	  					<td width="80px" align="right"><span>日期：</span></td>
						<td width="114px">
							<input class="easyui-datebox" type="text" style="width:100px;height:25px;" id="startTime" name="startTime" data-options="formatter:myYearMonthformatter, parser:myparser" />
						</td>
						<td align="center" width="14px"><span>至</span></td>
						<td width="114px">
							<input class="easyui-datebox" type="text" style="width:100px;height:25px;" id="endTime" name="endTime" data-options="formatter:myYearMonthformatter, parser:myparser" />
						</td>
						<td style="padding-left:20px">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" onclick="queryFunc()">查询</a>&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset" onclick="resetFunc()">重置</a>
						</td>
	  				</tr>	
	  			</table>
  			</form>
			<div style="padding:5px 0;min-width:1100px;width:99%;margin:0 auto">
				<table class="easyui-datagrid" id="manList" title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th field="className" align="center" width="17%">游学班级名称</th>
							<th field="openDate" align="center" width="17%">游学出发日期</th>
							<th field="finishDate" align="center" width="17%">游学返回日期</th>
							<th field="monthDate" align="center" width="16%">月份</th>
							<th field="handlerName" align="center" width="16%">操作人</th>
							<th field="createDate" align="center" width="17%">操作时间</th>
						</tr>
					</thead>
				</table>
			</div>
			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
	   			<a href="javascript:void(0)" id="tieOffBtn" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;" onclick="tieOffOper()">扎帐</a>
			</div>
  		</div>
		<script language="javascript">
			ajaxLoadEnd();
			$(document).ready(function(){
				$("#startTime").datebox({
					onShowPanel:settingYearMonthPanel
				});
				$("#endTime").datebox({
					onShowPanel:settingYearMonthPanel
				});
			});
			function queryFunc()
			{
				var obj = $("#qryFm").serializeObject();
				var startTime = $("#startTime").datebox("getValue");
				var endTime = $("#endTime").datebox("getValue");
				if(startTime != "" && endTime == "")
				{
					obj["endTime"] = "3000-12-31";
				}
				else if(startTime == "" && endTime != "")
				{
					obj["startTime"] = "1900-01-01";
				}
				obj["queryCode"] = "qryTourismTieOffList";
				obj["funcNodeId"] = "38144";
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
				$("#startTime").datebox("setValue","");
				$("#endTime").datebox("setValue","");
			}
			function backFunc()
			{
				window.history.back();
			}
			function tieOffOper()
			{
				ajaxLoading("正在处理，请稍待。。。");
				window.location.href = "/sys/incomeFinish/accessRecordPage.do?incomeFlag=tourism";
			}
		</script>
  	</body>
</html>