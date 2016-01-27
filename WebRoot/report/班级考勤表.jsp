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
					<td align="right" width="5%">
						校区：
					</td>
					<td width="10%">
						<select id="schoolId" name="schoolId" style="width:100px" ></select>
					</td>
					<td align="right" width="7%">
						课程阶段：
					</td>
					<td width="10%">
						<select id="classPharse" name="classPharse" style="width:100px" ></select>
					</td>
					<td align="right" width="5%">
						班级：
					</td>
					<td width="10%">
						<select id="classInfo" name="classInfo" style="width:110px" ></select>
					</td>
					<td align="right" width="5%">
						月份：
					</td>
					<td width="10%">
						<input name="monthDate" id="monthDate" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myYearMonthformatter, parser:myparser" />
					</td>
					<td align="right" width="7%">
						带班老师：
					</td>
					<td width="10%">
						<input name="teacher" id="teacher" type="text" style="width:100px" class="easyui-textbox" />								
					</td>
					<td colspan="2" align="center">
						<a href="javascript:void(0)" id="queryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
		</form>
		<div style="padding:5px 0;min-width:1100px; width:100%;">
			<table class="easyui-datagrid" title="班级考勤表 " style="height:390px;" id="attList" url="" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th width="12.5%" field="schoolName">校区</th>
						<th width="12.5%" field="className">班级</th>
						<th width="12.5%" field="openDate">开课日期</th>
						<th width="12.5%" field="finishDate">结课日期</th>
						<th width="12.5%" field="classTime">上课时间段</th>
						<th width="12.5%" field="roomNames">教室</th>
						<th width="12.5%" field="teacherNames">带班老师</th>
						<th width="12.5%" field="monthday">月份</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="toolbar" style="padding: 2px; height: auto">
   			<a href="javascript:void(0)" id="hisViewBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;">导出</a>
		</div>
		<script type="text/javascript">
			ajaxLoading("正在处理，请稍待。。。");
			$.post("<%=path %>/pubData/qrySchoolList.do",function(data){
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
				$("#monthDate").datebox({
					onShowPanel:settingYearMonthPanel
				})
				$("#classInfo").combobox({
					formatter:function(row){
						return '<span>'+row.className+'</span>';
					},
					valueField: 'classInstId',
					textField: 'className',
					//panelHeight: 'auto'
					listHeight:200
				});
				$("#attList").datagrid({
					onClickRow:function(i,node){
						ajaxLoading("正在处理，请稍待。。。");
						window.location.href = "/sys/attend/getClassStudentAttenceInfo.do?classInstId="+node.classInstId+"&monthDate="+node.monthday;
					}
				});
				exportLink("hisViewBtn","attList");
			});
			function queryFunc()
			{
				var obj = $("#attFm").serializeObject();
				obj["queryCode"] = "qryAttenceClassReport";
				obj["funcNodeId"] = "38127";
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
				$("#monthDate").datebox("setValue","");
				$("#classInfo").combobox("setValue","");
				$("#teacher").textbox("setValue","");
			}
			function exportFunc()
			{
				
			}
		</script>
 	</body>
</html>