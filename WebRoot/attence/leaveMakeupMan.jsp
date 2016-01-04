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
					<td width="12%">
						<select id="schoolManId" name="schoolManId" style="width:100px" ></select>
					</td>
					<td align="right" width="8%">
						课程阶段：
					</td>
					<td width="12%">
						<select id="classPharse" name="classPharse" style="width:100px" ></select>
					</td>
					<td align="right" width="8%">
						班级名称：
					</td>
					<td colspan="2">
						<input name="classInfo" id="classInfo" type="text" style="width:100px" class="easyui-textbox" />
					</td>
				</tr>
				<tr>
					<td align="right">
						学员姓名：
					</td>
					<td>
						<input name="staffName" id="staffName" type="text" style="width:100px" class="easyui-textbox"  />								
					</td>
					<td align="right">
						联系电话：
					</td>
					<td>
						<input name="contactNum" id="contactNum" type="text" style="width:100px" class="easyui-textbox" />								
					</td>
					<td align="right">
						带班老师：
					</td>
					<td>
						<input name="teacherMan" id="teacherMan" type="text" style="width:100px" class="easyui-textbox" />								
					</td>
					<td>
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
						<th data-options="field:'studentAttendId',checkbox:true"></th>
						<th width="12%" field="schoolName">校区</th>
						<th width="12%" field="name">学员姓名</th>
						<th width="12%" field="byName">英文名</th>
						<th width="13%" field="phoneNums">联系电话</th>
						<th width="12%" field="className">班级名称</th>
						<th width="13%" field="teacherNames">带班老师</th>
						<th width="13%" field="payDate">缴费日期</th>
						<th width="12%" field="courseStateName">课程状态</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="toolManbar" style="padding: 2px; height: auto">
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 120px;" onclick="backFunc()">返回</a>
			<a href="javascript:void(0)" id="uploadLevelBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:120px;" onclick="uploadLevelFunc()">上传请假单</a>
			<a href="javascript:void(0)" id="commitMakeupBtn" class="easyui-linkbutton" iconCls="icon-remove" style="width:120px;" onclick="commitMakeupFunc()">提交补课记录</a>
		</div>
		<script type="text/javascript">
			$.post("<%=path %>/pubData/qrySchoolList.do",function(data){
				$("#schoolManId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=STAGE_ID",function(data){
				$("#classPharse").combobox("loadData",data);
			},"json");
			$(document).ready(function(){
				$("#schoolManId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto'
				});
				$("#classPharse").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
			});
			function queryFunc()
			{
				var obj = $("#manFm").serializeObject();
				obj["queryCode"] = "qryLevelMakeupList";
				obj["funcNodeId"] = "38137";
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
				$("#classPharse").combobox("setValue","");
				$("#classInfo").textbox("setValue","");
				$("#staffName").textbox("setValue","");
				$("#contactNum").textbox("setValue","");
				$("#teacherMan").textbox("setValue","");
			}
			function uploadLevelFunc()
			{
				var row = $("#manList").datagrid("getSelected");
				if(row)
				{
					window.location.href = "/sys/attend/uploadLeavePage.do?studentId="+row.studentId+"&funcNodeId=${param.funcNodeId}";
				}
				else
				{
					$.messager.alert('提示',"请先选择要上传请假单的学员");
				}
			}
			function commitMakeupFunc()
			{
				var row = $("#manList").datagrid("getSelected");
				if(row)
				{
					window.location.href = "/sys/attend/commitMakeupPage.do?studentId="+row.studentId+"&funcNodeId=${param.funcNodeId}";
				}
				else
				{
					$.messager.alert('提示',"请先选择要提交补课记录的学员");
				}
			}
			function backFunc()
			{
				window.location.href = "/sys/attence/attenceMan.jsp?funcNodeId=${param.funcNodeId}";
			}
		</script>
 	</body>
</html>