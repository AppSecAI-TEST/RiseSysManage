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
					<td align="right" width="7%">
						校区：
					</td>
					<td width="10%">
						<select id="schoolManId" name="schoolManId" style="width:100px" ></select>
					</td>
					<td align="right" width="7%">	
						课程阶段：
					</td>
					<td width="10%">
						<select id="classManPharse" name="classManPharse" style="width:100px" ></select>
					</td>
					<td align="right" width="11%">
						外教课班级状态：
					</td>
					<td width="10%">
						<select id="classManState" name="classManState" style="width:100px" ></select>
					</td>
					<td align="right" width="9%">
						实际上课日期：
					</td>
					<td width="22%">
						<input name="openStartManTime" id="openStartManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="openEndManTime" id="openEndManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
					</td>
				</tr>
				<tr>
					<td colspan="8" align="center">
						<a href="javascript:void(0)" id="queryManBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetManBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
		</form>
		<div style="padding:5px 0;min-width:1100px; width:100%">
			<table class="easyui-datagrid" title="班级列表" style="height:430px" id="manList" toolbar="#toolManbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'shortClassInstId',checkbox:true"></th>
						<th width="12%" field="schoolName">校区</th>
						<th width="12%" field="classType">外教课阶段</th>
						<th width="12%" field="className">计划上课时间</th>
						<th width="12%" field="className">实际上课时间</th>
						<th width="12%" field="className">已预约人数</th>
						<th width="12%" field="className">实际上课人数</th>
						<th width="13%" field="teacherNames">计划T老师</th>
						<th width="13%" field="teacherNames">实际T老师</th>
						<th width="13%" field="classStateName">计划Ta老师</th>
						<th width="13%" field="classStateName">实际Ta老师</th>
						<th width="12%" field="totalLessionHours">外教课班级状态</th>
						<th width="12%" field="classProgress">创建人</th>
						<th width="12%" field="personNum">创建时间</th>
						<th width="12%" field="classProgress">反馈人</th>
						<th width="12%" field="personNum">反馈时间</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="toolManbar" style="padding: 2px; height: auto">
			<a href="javascript:void(0)" id="classArrangementBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="classArrangementFunc()">预约管理</a>
			<a href="javascript:void(0)" id="cancelClassBtn" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="cancelClassFunc()">反馈管理</a>
   			<a href="javascript:void(0)" id="viewClassBtn" class="easyui-linkbutton" iconCls="icon-search" style="width:100px;" onclick="viewClassFunc()">浏览</a>
		</div>
		<script type="text/javascript">
			$.post("<%=path %>/pubData/qrySchoolList.do",function(data){
				$("#schoolManId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=CLASS_STATE",function(data){
				$("#classManState").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=STAGE_ID",function(data){
				$("#classManPharse").combobox("loadData",data);
			},"json");
			$(document).ready(function(){
				$("#schoolManId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto'
				});
				$("#classManState").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
				$("#classManPharse").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
			});
			function queryFunc()
			{
				var obj = $("#manFm").serializeObject();
				obj["queryCode"] = "qryInterClassList";
				obj["funcNodeId"] = "38110";
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
				$("#classManPharse").combobox("setValue","");
				$("#classManState").combobox("setValue","");
				$("#schoolManId").combobox("setValue","");
				$("#planStartManTime").datebox("setValue","");
				$("#planEndManTime").datebox("setValue","");
			}
			function classArrangementFunc()
			{
				window.location.href = "/sys/shortBus/getAddShortClassInfo.do?funcNodeId=${param.funcNodeId}";
			}
			function cancelClassFunc()
			{
				var row = $("#manList").datagrid("getSelected");
				if(row)
				{
					if(row.classStateName == "未开课" || row.classStateName == "未开课")
					{
						window.location.href = "/sys/shortBus/cancelShortClassInfo.do?funcNodeId=${param.funcNodeId}&shortClassInstId="+row.shortClassInstId;
					}
					else if(row.classStateName == "开课在读")
					{
						$.messager.alert('提示',"该课程已经开课不能再被修改");		
					}
					else if(row.classStateName == "结课")
					{
						$.messager.alert('提示',"该课程已经结课");		
					}
					else if(row.classStateName == "解散")
					{
						$.messager.alert('提示',"该课程已被取消");		
					}
				}
				else
				{
					$.messager.alert('提示',"请选择要取消的班级");
				}
			}
			function viewClassFunc()
			{
				var row = $("#manList").datagrid("getSelected");
				if(row)
				{
					if(row.classStateName != "解散")
					{
						window.location.href = "/sys/shortBus/viewShortClassPage.do?funcNodeId=${param.funcNodeId}&shortClassInstId="+row.shortClassInstId;
					}
					else
					{
						$.messager.alert('提示',"该课程已被取消");		
					}
				}
				else
				{
					$.messager.alert('提示',"请选择要浏览的班级");
				}
			}
		</script>
 	</body>
</html>