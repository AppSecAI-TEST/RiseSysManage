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
			<input type="hidden" id="resourceId" value="753">
  			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId}"/>
			<table class="search_tab">
				<tr>
					<td align="right">
						校区：
					</td>
					<td width="100px;">
	  					<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        </select>
					</td>
					<td align="right">
						课程阶段：
					</td>
					<td width="100px;">
						<select id="classPharse" name="classPharse" style="width:100px" ></select>
					</td>
					<td align="right">
						班级：
					</td>
					<td width="100px;">
						<input name="classInfo" id="classInfo" type="text" style="width:100px" class="easyui-textbox" />
					</td>
					<td align="right">
						月份：
					</td>
					<td width="100px;">
						<input name="monthDate" id="monthDate" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myYearMonthformatter, parser:myparser" />
					</td>
					<td align="right">
						带班老师：
					</td>
					<td width="100px;">
						<input name="teacher" id="teacher" type="text" style="width:100px" class="easyui-textbox" />	
					</td>
					<td align="left">
						<a href="javascript:void(0)" id="queryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;">重置</a>
					</td>
				</tr>
			</table>
		</form>
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
				initReportButton("resetBtn","attFm","schoolId")
				$("#classPharse").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
				$("#monthDate").datebox({
					onShowPanel:settingYearMonthPanel
				})
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
		</script>
 	</body>
</html>