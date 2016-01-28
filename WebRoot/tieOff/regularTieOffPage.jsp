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
	  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:80px;" cellspacing="2">
	  				<tr>
	  					<td align="right"><span>校区：</span></td>
	  					<td align="left"  width="120px">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width:100px;height:25px;" editable="false" data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',onLoadSuccess:function(data){if(data.length > 0){$('#schoolId').combobox('setValue',data[0].schoolId);}}" url="<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=860&fieldId=schoolId">
				        	</select>
	  					</td>
	  					<td width="100px" align="right"><span>日期：</span></td>
						<td width="114px">
							<input class="easyui-datebox" type="text" style="width:100px;height:25px;" id="startTime" name="startTime" data-options="formatter:myYearMonthformatter, parser:myparser" />
						</td>
						<td align="center" width="14px"><span>至</span></td>
						<td width="114px">
							<input class="easyui-datebox" type="text" style="width:100px;height:25px;" id="endTime" name="endTime" data-options="formatter:myYearMonthformatter, parser:myparser" />
						</td>
						<td style="padding-left:60px">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" onclick="queryFunc()">查询</a>&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset" onclick="resetFunc()">重置</a>
						</td>
	  				</tr>	
	  			</table>
  			</form>
			<div style="padding:5px 0;min-width:1100px; width:100%;">
				<table class="easyui-datagrid" style="height:435px;" id="list_data" title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th field="schoolName" align="center" width="25%">校区</th>
							<th field="monthDate" align="center" width="25%">月份</th>
							<th field="handlerName" align="center" width="25%">操作人</th>
							<th field="createDate" align="center" width="25%">操作时间</th>
						</tr>
					</thead>
				</table>
			</div>
			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
	   			<a href="javascript:void(0)" id="tieOffBtn" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;" onclick="tieOffOper()">扎帐</a>
			</div>
  		</div>
  		<script type="text/javascript">
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
				obj["queryCode"] = "qryRegularTieOffList";
				obj["funcNodeId"] = "38145";
				obj = JSON.stringify(obj);
				$("#list_data").datagrid({
					url:"/sys/pubData/qryDataListByPage.do",
					queryParams:{
						param : obj
					}
				});
			}
			function resetFunc()
			{
				$("#schoolId").combobox("setValue","");
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
				window.location.href = "/sys/incomeFinish/accessRecordPage.do?incomeFlag=regular";
			}
  		</script>
  	</body>
</html>
