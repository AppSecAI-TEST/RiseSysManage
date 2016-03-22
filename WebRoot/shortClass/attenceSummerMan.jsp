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
		<script type="text/javascript">
			ajaxLoading("正在处理，请稍待。。。");
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=809&fieldId=schoolId",function(data){
				$("#schoolManId").combobox("loadData",data);
				$("#schoolHisId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/shortBus/getGiftTypeList.do",function(data){
				$("#classType").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=CLASS_STATE",function(data){
				data = $.grep(data , function(node,i){
					if(i>=1 && i < data.length-1)
						return true;
					return false;
				});
				$("#classManState").combobox("loadData",data);
				$("#classHisState").combobox("loadData",data);
				ajaxLoadEnd();
			},"json");
			$(document).ready(function(){
				$("#schoolManId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto',
					onLoadSuccess:function(data){
						if(data.length > 0)
						{
							$("#schoolManId").combobox("setValue",data[0].schoolId);
						}
					}
				});
				$("#classType").combobox({
					formatter:function(data){
						return '<span>'+data.typeName+'</span>';
					}, 
					valueField: 'giftType', 
					textField: 'typeName',
					panelHeight: 'auto'
				});
				$("#classManState").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
				$("#schoolHisId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto',
					onLoadSuccess:function(data){
						if(data.length > 0)
						{
							$("#schoolHisId").combobox("setValue",data[0].schoolId);
						}
					}
				});
				$("#classHisState").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
				$('#tab').tabs({
				    border:true,
				    onSelect:function(title){
						
				    }
				});
			});
			function queryManFunc()
			{
				var obj = $("#manFm").serializeObject();
				var classStartManTime = $("#classStartManTime").datebox("getValue");
				var classEndManTime = $("#classEndManTime").datebox("getValue");
				var overClassStartManTime = $("#overClassStartManTime").datebox("getValue");
				var overClassEndManTime = $("#overClassEndManTime").datebox("getValue");
				if(classStartManTime != "" && classEndManTime == "")
				{
					obj["classEndManTime"] = "3000-12-31";
				}
				else if(classStartManTime == "" && classEndManTime != "")
				{
					obj["classStartManTime"] = "1900-01-01";
				}
				if(overClassStartManTime != "" && overClassEndManTime == "")
				{
					obj["overClassEndManTime"] = "3000-12-31";
				}
				else if(overClassStartManTime == "" && overClassEndManTime != "")
				{
					obj["overClassStartManTime"] = "1900-01-01";
				}
				obj["queryCode"] = "qrySummerAttenceList";
				obj["funcNodeId"] = "38132";
				obj = JSON.stringify(obj);
				$("#manList").datagrid({
					url:"/sys/pubData/qryDataListByPage.do",
					queryParams:{
						param : obj
					}
				});
			}
			function resetManFunc()
			{
				var schoolData = $("#schoolManId").combobox("getData");
				if(schoolData != null && schoolData.length > 0)
				{
					$("#schoolManId").combobox("setValue",schoolData[0].schoolId);
				}
				$("#classType").combobox("setValue","");
				$("#classManState").combobox("setValue","");
				$("#classMan").combobox("setValue","");
				$("#classStartManTime").datebox("setValue","");
				$("#classEndManTime").datebox("setValue","");
				$("#overClassStartManTime").datebox("setValue","");
				$("#overClassEndManTime").datebox("setValue","");
			}
			function manOperFunc()
			{
				var row = $('#manList').datagrid('getSelected');
				if (row)
				{
					ajaxLoading("正在处理，请稍待。。。");
					window.location.href = "/sys/shortBus/shortAttenceDetailPage.do?funcNodeId=${param.funcNodeId}&shortClassInstId="+row.shortClassInstId+"&pageName=shortAttenceSummerDetail";
				}
				else
				{
					$.messager.alert('提示',"请先选择要考勤的班级");
				}
			}
			function manViewFunc()
			{
				var row = $("#manList").datagrid("getSelected");
				if(row)
				{
					ajaxLoading("正在处理，请稍待。。。");
					window.location.href = "/sys/shortBus/viewShortClassPage.do?funcNodeId=${param.funcNodeId}&shortClassInstId="+row.shortClassInstId+"&pageName=viewSummerShortClass";
				}
				else
				{
					$.messager.alert('提示',"请选择要浏览的班级");
				}
			}
			function queryHisFunc()
			{
				var obj = $("#hisFm").serializeObject();
				var openApplyStartManTime = $("#openApplyStartManTime").datebox("getValue");
				var openApplyEndManTime = $("#openApplyEndManTime").datebox("getValue");
				var openAuditStartManTime = $("#openAuditStartManTime").datebox("getValue");
				var openAuditEndManTime = $("#openAuditEndManTime").datebox("getValue");
				if(openApplyStartManTime != "" && openApplyEndManTime == "")
				{
					obj["openApplyEndManTime"] = "3000-12-31";
				}
				else if(openApplyStartManTime == "" && openApplyEndManTime != "")
				{
					obj["openApplyStartManTime"] = "1900-01-01";
				}
				if(openAuditStartManTime != "" && openAuditEndManTime == "")
				{
					obj["openAuditEndManTime"] = "3000-12-31";
				}
				else if(openAuditStartManTime == "" && openAuditEndManTime != "")
				{
					obj["openAuditStartManTime"] = "1900-01-01";
				}
				obj["queryCode"] = "qryAttenceSummerHisInfo";
				obj["funcNodeId"] = "38133";
				obj = JSON.stringify(obj);
				$("#hisList").datagrid({
					url:"/sys/pubData/qryDataListByPage.do",
					queryParams:{
						param : obj
					}
				});
			}
			function resetHisFunc()
			{
				var schoolData = $("#schoolHisId").combobox("getData");
				if(schoolData != null && schoolData.length > 0)
				{
					$("#schoolHisId").combobox("setValue",schoolData[0].schoolId);
				}
				$("#classHisState").combobox("setValue","");
				$("#classHis").textbox("setValue","");
				$("#openApplyStartManTime").datebox("setValue","");
				$("#openApplyEndManTime").datebox("setValue","");
				$("#openAuditStartManTime").datebox("setValue","");
				$("#openAuditEndManTime").datebox("setValue","");
			}
			function hisViewFunc()
			{
				var row = $("#hisList").datagrid("getSelected");
				if(row)
				{
					ajaxLoading("正在处理，请稍待。。。");
					window.location.href = "/sys/shortBus/viewShortClassPage.do?funcNodeId=${param.funcNodeId}&shortClassInstId="+row.shortClassInstId+"&pageName=viewSummerShortClass";
				}
				else
				{
					$.messager.alert('提示',"请选择要浏览的班级");
				}
			}
		</script>
  	</head>
  
  	<body style="padding-top:5px">
  		<div id="tab" class="easyui-tabs" style="min-width:1110px;width:98%;height:auto;">
		    <div title="考勤管理" style="padding:5px;display:block;">
				<form id="manFm">
					<table class="search_tab">
						<tr>
							<td align="right" width="12%">
								所属校区：
							</td>
							<td width="22%">
								<select id="schoolManId" name="schoolManId" style="width:100px;height:25px;" ></select>
							</td>
							<td align="right" width="12%">	
								赠课类型：
							</td>
							<td width="22%">
								<select id="classType" name="classType" style="width:100px;height:25px;" ></select>
							</td>
							<td align="right" width="12%">
								班级状态：
							</td>
							<td>
								<select id="classManState" name="classManState" style="width:100px;height:25px;" ></select>
							</td>
						</tr>
						<tr>
							<td align="right">
								放班申请日期：
							</td>
							<td>
								<input name="classStartManTime" id="classStartManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="classEndManTime" id="classEndManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
							</td>
							<td align="right">
								放班审批日期：
							</td>
							<td>
								<input name="overClassStartManTime" id="overClassStartManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="overClassEndManTime" id="overClassEndManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
							</td>
							<td colspan="2" align="center">
								<a href="javascript:void(0)" id="queryManBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryManFunc()">查询</a>
								<a href="javascript:void(0)" id="resetManBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetManFunc()">重置</a>
							</td>
						</tr>
					</table>
				</form>
					<table class="easyui-datagrid" title="班级列表" style="height:370px" id="manList" toolbar="#toolManbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
						<thead>
							<tr>
								<th data-options="field:'shortClassInstId',checkbox:true"></th>
								<th width="7%" field="schoolName">校区</th>
								<th width="7%" field="typeName">赠课类型</th>
								<th width="8%" field="className">班级名称</th>
								<th width="7%" field="classStateName">班级状态</th>
								<th width="7%" field="planHours">计划课时</th>
								<th width="8%" field="classProgress">实际反馈课时</th>
								<th width="7%" field="planClassNum">应到人数</th>
								<th width="7%" field="realClassNum">实到人数</th>
								<th width="7%" field="realClassNum">定班人数</th>
								<th width="8%" field="putClassDate">申请时间</th>
								<th width="8%" field="approveDate">审批时间</th>
								<th width="8%" field="openDate">开课日期</th>
								<th width="8%" field="finishDate">结课日期</th>
							</tr>
						</thead>
					</table>
				<div id="toolManbar" style="padding: 2px; height: auto">
					<a href="javascript:void(0)" id="manOperBtn" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="manOperFunc()">考勤维护</a>
		   			<a href="javascript:void(0)" id="manViewBtn" class="easyui-linkbutton" iconCls="icon-search" style="width:100px;" onclick="manViewFunc()">浏览</a>
				</div>
		    </div>
		    <div title="历史考勤"  style="padding:5px;display:block;">
				<form id="hisFm">
					<table class="search_tab">
						<tr>
							<td align="right" width="12%">
								所属校区：
							</td>
							<td width="22%">
								<select id="schoolHisId" name="schoolHisId" style="width:100px;height:25px;" ></select>
							</td>
							<td align="right" width="12%">
								班级状态：
							</td>
							<td width="22%">
								<select id="classHisState" name="classHisState" style="width:100px;height:25px;" ></select>
							</td>
							<td align="right" width="12%">
								班级：
							</td>
							<td>
								<input name="classHis" id="classHis" type="text" class="easyui-textbox" style="width:100px;height:25px;"/>
							</td>
						</tr>
						<tr>
							<td align="right">
								放班申请日期：
							</td>
							<td>
								<input name="openApplyStartManTime" id="openApplyStartManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="openApplyEndManTime" id="openApplyEndManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
							</td>
							<td align="right">
								放班审批日期：
							</td>
							<td>
								<input name="openAuditStartManTime" id="openAuditStartManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="openAuditEndManTime" id="openAuditEndManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
							</td>
							<td colspan="2" align="center">
								<a href="javascript:void(0)" id="queryHisBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryHisFunc()">查询</a>
								<a href="javascript:void(0)" id="resetHisBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetHisFunc()">重置</a>
							</td>
						</tr>
					</table>
				</form>
					<table class="easyui-datagrid" title="历史考勤列表" style="height:390px;" id="hisList" url="" toolbar="#toolHisbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
						<thead>
							<tr>
								<th data-options="field:'shortClassInstId',checkbox:true"></th>
								<th width="11%" field="schoolName">校区</th>
								<th width="11%" field="className">热身课班级</th>
								<th width="11%" field="typeName">班级类型</th>
								<th width="11%" field="schoolDate">上课时间</th>
								<th width="11%" field="attendNum">应到人数</th>
								<th width="11%" field="realNum">实到人数</th>
								<th width="11%" field="leaveNum">请假人数</th>
								<th width="11%" field="lateNum">迟到人数</th>
								<th width="11%" field="truantNum">旷课人数</th>
							</tr>
						</thead>
					</table>
				<div id="toolHisbar" style="padding: 2px; height: auto">
		   			<a href="javascript:void(0)" id="hisViewBtn" class="easyui-linkbutton" iconCls="icon-search" style="width:100px;" onclick="hisViewFunc()">浏览</a>
				</div>
		    </div>
		</div>
 	</body>
</html>
