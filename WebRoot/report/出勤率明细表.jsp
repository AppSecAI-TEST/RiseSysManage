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
		<input type="hidden" id="resourceId" value="751">
  		<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId}"/>
		<form id="attFm">
			<table class="search_tab">
				<tr>
					<td align="right" style="min-width: 40px;"><span>校区：</span></td>
					<td style="min-width: 100px;">
	  					<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        </select>
					</td>
					<td align="right" style="min-width: 80px;"><span>课程阶段：</span></td>
					<td style="min-width: 100px;">
						<select id="classPharse" name="classPharse" style="width:100px;height:25px;"></select>
					</td>
					<td align="right" style="min-width: 100px;"><span>出勤率：</span></td>
					<td style="min-width: 200px;">
						<input name="attendStartRate" id="attendStartRate" type="text" style="width:88px;height:25px;" class="easyui-numberbox" data-options="precision:1,min:0,max:100" />%
						至 
						<input name="attendEndRate" id="attendEndRate" type="text" style="width:88px;height:25px;" class="easyui-numberbox" data-options="precision:1,min:0,max:100" />%							
					</td>
					<td align="right" style="min-width: 80px;"><span>上课日期：</span></td>
					<td style="min-width: 230px;">
						<input name="classStart" id="classStart" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
						至 
						<input name="classEnd" id="classEnd" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
					</td>
				</tr>
				<tr>
					<td align="right" style="min-width: 40px;"><span>班级：</span></td>
					<td style="min-width: 100px;">
						<input name="classInfo" id="classInfo" type="text" style="width:100px;height:25px;" class="easyui-textbox" />	
					</td>
					<td align="right" style="min-width: 80px;"><span>老师：</span></td>
					<td style="min-width: 100px;">
						<input name="teacher" id="teacher" type="text" style="width:100px;height:25px;" class="easyui-textbox" />								
					</td>
					<td align="right" style="min-width: 100px;"><span>校服穿着率：</span></td>
					<td style="min-width: 200px;" colspan="2">
						<input name="schoolWearStartRate" id="schoolWearStartRate" type="text" style="width:88px;height:25px;" class="easyui-numberbox" data-options="precision:1,min:0,max:100" />%
						至
						<input name="schoolWearEndRate" id="schoolWearEndRate" type="text" style="width:88px;height:25px;" class="easyui-numberbox" data-options="precision:1,min:0,max:100" />%								
					</td>
					<td  style="min-width: 230px;">
						<a href="javascript:void(0)" id="qryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()" funcNodeId="38126">查询</a>
						&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
		</form>
			<table class="easyui-datagrid" title="出勤率明细表 " style="height:390px;" id="attList" url="" 
				toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'schoolName',width:'8.333%',align:'center'">校区</th>
						<th data-options="field:'attendDate',width:'8.333%',align:'center'">上课日期</th>
						<th data-options="field:'weekday',width:'4%',align:'center'">星期</th>
						<th data-options="field:'className',width:'8.333%',align:'center'">班级</th>
						<th data-options="field:'teacherNames',width:'8.333%',align:'center'">上课教师</th>
						<th data-options="field:'schoolDate',width:'12%',align:'center'">上课时间</th>
						<th data-options="field:'realHours',width:'8.333%',align:'center'">实际课时</th>
						<th data-options="field:'attendNum',width:'8.333%',align:'center'">在读人数</th>
						<th data-options="field:'realNum',width:'8.333%',align:'center'">出勤人数</th>
						<th data-options="field:'dressNum',width:'10%',align:'center'">学员校服穿着人数</th>
						<th data-options="field:'attendRate',width:'8.333%',align:'center'">出勤率</th>
						<th data-options="field:'dressRate',width:'8.333%',align:'center'">校服穿着率</th>
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
				initReportButton("resetBtn", "attFm", "schoolId")
				exportLink("hisViewBtn", "attList");
			});
			function queryFunc()
			{
				initPageNumber("attList");
				var obj = $("#attFm").serializeObject();
				var classStart = $("#classStart").datebox("getValue");
				var classEnd = $("#classEnd").datebox("getValue");
				var attendStartRate = $("#attendStartRate").textbox("getValue");
				var attendEndRate = $("#attendEndRate").textbox("getValue");
				var schoolWearStartRate = $("#schoolWearStartRate").textbox("getValue");
				var schoolWearEndRate = $("#schoolWearEndRate").textbox("getValue");
				if(classStart != "" && classEnd == "")
				{
					obj["classEnd"] = "3000-12-31";
				}
				else if(classStart == "" && classEnd != "")
				{
					obj["classStart"] = "1900-01-01";
				}
				if(attendStartRate != "" && attendEndRate == "")
				{
					obj["attendEndRate"] = "100";
				}
				else if(attendStartRate == "" && attendEndRate != "")
				{
					obj["attendStartRate"] = "0";
				}
				if(schoolWearStartRate != "" && schoolWearEndRate == "")
				{
					obj["schoolWearEndRate"] = "100";
				}
				else if(schoolWearStartRate == "" && schoolWearEndRate != "")
				{
					obj["schoolWearStartRate"] = "0";
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
