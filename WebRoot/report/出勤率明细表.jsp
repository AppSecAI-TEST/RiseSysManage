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
		<form id="attFm">
			<input type="hidden" id="resourceId" value="751">
  			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId}"/>
			<table class="search_tab">
				<tr>
					<td align="right" width="70px">
						<span>校区：</span>
					</td>
					<td width="100px">
	  					<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        </select>
					</td>
					<td align="right" width="70px">
						<span>课程阶段：</span>
					</td>
					<td width="100px">
						<select id="classPharse" name="classPharse" style="width:100px;height:25px;" ></select>
					</td>
					<td align="right" width="70px">
						<span>上课日期：</span>
					</td>
					<td width="100px">
						<input name="classStart" id="classStart" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="classEnd" id="classEnd" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
					</td>
					<td align="right" width="50px">
						<span>班级：</span>
					</td>
					<td>
						<input name="classInfo" id="classInfo" type="text" style="width:100px;height:25px;" class="easyui-textbox" />	
					</td>
				</tr>
				<tr>
					<td align="right">
						<span>老师：</span>
					</td>
					<td>
						<input name="teacher" id="teacher" type="text" style="width:100px;height:25px;" class="easyui-textbox" />								
					</td>
					<td align="right">
						<span>出勤率：</span>
					</td>
					<td>
						<input name="attendStartRate" id="attendStartRate" type="text" style="width:88px;height:25px;" class="easyui-numberbox" data-options="precision:1,min:0,max:100" />% 至 <input name="attendEndRate" id="attendEndRate" type="text" style="width:88px;height:25px;" class="easyui-numberbox" data-options="precision:1,min:0,max:100" />%							
					</td>
					<td align="right">
						<span>校服穿着率：</span>
					</td>
					<td>
						<input name="schoolWearStartRate" id="schoolWearStartRate" type="text" style="width:88px;height:25px;" class="easyui-numberbox" data-options="precision:1,min:0,max:100" />% 至 <input name="schoolWearEndRate" id="schoolWearEndRate" type="text" style="width:88px;height:25px;" class="easyui-numberbox" data-options="precision:1,min:0,max:100" />%								
					</td>
					<td colspan="2" align="center">
						<a href="javascript:void(0)" id="queryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
		</form>
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
		<div id="toolbar" style="padding: 2px; height: auto">
   			<a href="javascript:void(0)" id="hisViewBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;">导出</a>
		</div>
		<script type="text/javascript">
			ajaxLoading("正在处理，请稍待。。。");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=STAGE_ID",function(data){
				$("#classPharse").combobox("loadData",data);
				ajaxLoadEnd();
			},"json");
			$(document).ready(function(){
				$("#classPharse").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
				initReportButton("resetBtn","attFm","schoolId")
				exportLink("hisViewBtn","attList");
			});
			function queryFunc()
			{
				var obj = $("#attFm").serializeObject();
				var classStart = $("#classStart").datebox("getValue");
				var classEnd = $("#classEnd").datebox("getValue");
				if(classStart != "" && classEnd == "")
				{
					obj["classEnd"] = "3000-12-31";
				}
				else if(classStart == "" && classEnd != "")
				{
					obj["classStart"] = "1900-01-01";
				}
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
				$("#classInfo").textbox("setValue","");
				$("#teacher").textbox("setValue","");
				$("#attendStartRate").numberbox("setValue","");
				$("#attendEndRate").numberbox("setValue","");
				$("#schoolWearStartRate").numberbox("setValue","");
				$("#schoolWearEndRate").numberbox("setValue","");
			}
		</script>
 	</body>
</html>