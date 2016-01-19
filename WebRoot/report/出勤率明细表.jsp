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
					<td align="right" width="8%">
						校区：
					</td>
					<td width="12%">
						<select id="schoolId" name="schoolId" style="width:100px" ></select>
					</td>
					<td align="right" width="8%">
						课程阶段：
					</td>
					<td width="22%">
						<select id="classPharse" name="classPharse" style="width:100px" ></select>
					</td>
					<td align="right" width="8%">
						上课日期：
					</td>
					<td width="22%">
						<input name="classStart" id="classStart" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="classEnd" id="classEnd" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
					</td>
					<td align="right" width="8%">
						班级：
					</td>
					<td width="12%">
						<select id="classInfo" name="classInfo" style="width:110px" ></select>
					</td>
				</tr>
				<tr>
					<td align="right">
						老师：
					</td>
					<td>
						<input name="teacher" id="teacher" type="text" style="width:100px" class="easyui-textbox" />								
					</td>
					<td align="right">
						出勤率：
					</td>
					<td>
						<input name="attendStartRate" id="attendStartRate" type="text" style="width:88px" class="easyui-numberbox" data-options="precision:1,min:0,max:100" />% 至 <input name="attendEndRate" id="attendEndRate" type="text" style="width:88px" class="easyui-numberbox" data-options="precision:1,min:0,max:100" />%							
					</td>
					<td align="right">
						校服穿着率：
					</td>
					<td>
						<input name="schoolWearStartRate" id="schoolWearStartRate" type="text" style="width:88px" class="easyui-numberbox" data-options="precision:1,min:0,max:100" />% 至 <input name="schoolWearEndRate" id="schoolWearEndRate" type="text" style="width:88px" class="easyui-numberbox" data-options="precision:1,min:0,max:100" />%								
					</td>
					<td colspan="2" align="center">
						<a href="javascript:void(0)" id="queryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
		</form>
		<div style="padding:5px 0;min-width:1100px; width:100%;">
			<table class="easyui-datagrid" title="出勤率明细表 " style="height:390px;" id="attList" url="" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th width="8.333%" field="schoolName">校区</th>
						<th width="8.333%" field="attendDate">上课日期</th>
						<th width="4%" field="weekday">星期</th>
						<th width="8.333%" field="className">班级</th>
						<th width="12%" field="teacherNames">上课教师</th>
						<th width="10%" field="schoolDate">上课时间</th>
						<th width="8.333%" field="realHours">实际课时</th>
						<th width="8.333%" field="attendNum">在读人数</th>
						<th width="8.333%" field="realNum">出勤人数</th>
						<th width="10%" field="dressNum">学员校服穿着人数</th>
						<th width="8.333%" field="attendRate">出勤率</th>
						<th width="8.333%" field="dressRate">校服穿着率</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="toolbar" style="padding: 2px; height: auto">
   			<a href="javascript:void(0)" id="hisViewBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;">导出</a>
		</div>
		<script type="text/javascript">
			ajaxLoading("加载中...");
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=840&fieldId=schoolId",function(data){
				$("#schoolId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=STAGE_ID",function(data){
				$("#classPharse").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pub/pageComboxList.do?funcNodeId=381&fieldId=classMan",function(data){
				$("#classInfo").combobox("loadData",data);
				ajaxLoadEnd();
			},"json");
			$(document).ready(function(){
				$("#schoolId").combobox({
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
				$("#classInfo").combobox({
					formatter:function(row){
						return '<span>'+row.className+'</span>';
					},
					valueField: 'classInstId',
					textField: 'className',
					//panelHeight: 'auto'
					listHeight:200
				});
				exportLink("hisViewBtn","attList");
			});
			function queryFunc()
			{
				var obj = $("#attFm").serializeObject();
				obj["queryCode"] = "qryAttenceDetailReport";
				obj["funcNodeId"] = "38126";
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
				$("#classPharse").combobox("setValue","");
				$("#classStart").datebox("setValue","");
				$("#classEnd").datebox("setValue","");
				$("#classInfo").combobox("setValue","");
				$("#teacher").textbox("setValue","");
				$("#attendStartRate").numberbox("setValue","");
				$("#attendEndRate").numberbox("setValue","");
				$("#schoolWearStartRate").numberbox("setValue","");
				$("#schoolWearEndRate").numberbox("setValue","");
			}
			function exportFunc()
			{
				
			}
		</script>
 	</body>
</html>