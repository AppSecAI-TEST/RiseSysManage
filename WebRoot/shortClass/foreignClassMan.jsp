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
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=816&fieldId=schoolId",function(data){
				$("#schoolManId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=CLASS_STATE",function(data){
				var classManStateArr = [];
				for(var i = 0,n = data.length;i < n;i++)
				{
					if(data[i].codeFlag == '001')
					{
						data[i].codeName = "未上课";
						classManStateArr.push(data[i]);
					}
					else if(data[i].codeFlag == '004')
					{
						data[i].codeName = "已上课";
						classManStateArr.push(data[i]);
					}
					else if(data[i].codeFlag == '005')
					{
						data[i].codeName = "取消";
						classManStateArr.push(data[i]);
					}
				}
				$("#classManState").combobox("loadData",classManStateArr);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=STAGE_ID",function(data){
				$("#classManPharse").combobox("loadData",data);
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
				var planStartManTime = $("#planStartManTime").datebox("getValue");
				var planEndManTime = $("#planEndManTime").datebox("getValue");
				if(planStartManTime != "" && planEndManTime == "")
				{
					obj["planEndManTime"] = "3000-12-31";
				}
				else if(planStartManTime == "" && planEndManTime != "")
				{
					obj["planStartManTime"] = "1900-01-01";
				}
				obj["queryCode"] = "qryForeignManList";
				obj["funcNodeId"] = "38138";
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
				var schoolData = $("#schoolManId").combobox("getData");
				if(schoolData != null && schoolData.length > 0)
				{
					$("#schoolManId").combobox("setValue",schoolData[0].schoolId);
				}
				$("#classManPharse").combobox("setValue","");
				$("#classManState").combobox("setValue","");
				$("#planStartManTime").datebox("setValue","");
				$("#planEndManTime").datebox("setValue","");
			}
			function classArrangementFunc()
			{
				ajaxLoading("正在处理，请稍待。。。");
				window.location.href = "/sys/shortClass/directShortClassInst.jsp?funcNodeId=${param.funcNodeId}&classType="+encodeURI("外教课");
			}
			function cancelClassFunc()
			{
				var row = $("#manList").datagrid("getSelected");
				if(row)
				{
					if(row.classStateName == "未上课")
					{
						ajaxLoading("正在处理，请稍待。。。");
						window.location.href = "/sys/shortBus/accessShortClassPage.do?funcNodeId=${param.funcNodeId}&shortClassInstId="+row.shortClassInstId+"&classType=外教课&pageName=cancelForeignClass";
					}
					else if(row.classStateName == "已上课")
					{
						$.messager.alert('提示',"该课程已经开课不能再被修改");		
					}
					else if(row.classStateName == "取消")
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
					ajaxLoading("正在处理，请稍待。。。");
					window.location.href = "/sys/shortBus/accessShortClassPage.do?funcNodeId=${param.funcNodeId}&shortClassInstId="+row.shortClassInstId+"&classType=外教课&pageName=viewForeignClass";
				}
				else
				{
					$.messager.alert('提示',"请选择要浏览的班级");
				}
			}
		</script>
  	</head>
  	<body>
  		<div style="margin-right:5px;">
		<form id="manFm">
			<table class="search_tab">
				<tr>
					<td align="right" width="7%">
						所属校区：
					</td>
					<td width="10%">
						<select id="schoolManId" name="schoolManId" style="width:100px;height:25px;" ></select>
					</td>
					<td align="right" width="7%">	
						课程阶段：
					</td>
					<td width="10%">
						<select id="classManPharse" name="classManPharse" style="width:100px;height:25px;" ></select>
					</td>
					<td align="right" width="11%">
						外教课班级状态：
					</td>
					<td width="10%">
						<select id="classManState" name="classManState" style="width:100px;height:25px;" ></select>
					</td>
					<td align="right" width="9%">
						计划上课日期：
					</td>
					<td width="22%">
						<input name="planStartManTime" id="planStartManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="planEndManTime" id="planEndManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
					</td>
				</tr>
				<tr>
					<td colspan="8" align="right" style="padding-right:85px">
						<a href="javascript:void(0)" id="queryManBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetManBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
		</form>
			<table class="easyui-datagrid" title="班级列表" style="height:430px" id="manList" toolbar="#toolManbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'shortClassInstId',checkbox:true"></th>
						<th width="12%" field="schoolName">校区</th>
						<th width="12%" field="stageId">外教课阶段</th>
						<th width="12%" field="schoolDate">计划上课时间</th>
						<th width="13%" field="teahcerT">计划T老师</th>
						<th width="13%" field="teahcerTa">计划Ta老师</th>
						<th width="12%" field="classStateName">外教课班级状态</th>
						<th width="12%" field="staffName">创建人</th>
						<th width="12%" field="createDate">创建时间</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="toolManbar" style="padding: 2px; height: auto">
			<a href="javascript:void(0)" id="classArrangementBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="classArrangementFunc()">排课管理</a>
			<a href="javascript:void(0)" id="cancelClassBtn" class="easyui-linkbutton" iconCls="icon-remove" style="width:100px;" onclick="cancelClassFunc()">取消课程</a>
   			<a href="javascript:void(0)" id="viewClassBtn" class="easyui-linkbutton" iconCls="icon-search" style="width:100px;" onclick="viewClassFunc()">浏览</a>
		</div>
 	</body>
</html>