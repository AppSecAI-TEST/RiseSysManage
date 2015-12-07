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
  		<div id="tab" class="easyui-tabs" style="min-width:1100px;width:99%;height:528px;font-family:'微软雅黑';margin:0 auto;padding:0 0">
		    <div title="考勤管理">
				<form id="manFm" style="margin:0 auto;">
					<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:5px auto;height:100px;" cellspacing="2">
						<tr>
							<td align="right" width="12%">
								校区：
							</td>
							<td width="12%">
								<select id="schoolManId" name="schoolManId" style="width:100px" ></select>
							</td>
							<td align="right" width="12%">	
								课程阶段：
							</td>
							<td width="25%">
								<select id="classManPharse" name="classManPharse" style="width:100px" ></select>
							</td>
							<td align="right" width="12%">
								班级：
							</td>
							<td>
								<select id="classMan" name="classMan" style="width:100px" ></select>
							</td>
						</tr>
						<tr>
							<td align="right">
								班级状态：
							</td>
							<td>
								<select id="classManState" name="classManState" style="width:100px" ></select>
							</td>
							<td align="right">
								放班申请日期：
							</td>
							<td>
								<input name="classStartManTime" id="classStartManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="classEndManTime" id="classEndManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
							</td>
							<td align="right">
								放班审批日期：
							</td>
							<td>
								<input name="overClassStartManTime" id="overClassStartManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="overClassEndManTime" id="overClassEndManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
							</td>
						</tr>
						<tr>
							<td colspan="6" align="center">
								<a href="javascript:void(0)" id="queryManBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryManFunc()">查询</a>
								<a href="javascript:void(0)" id="resetManBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetManFunc()">重置</a>
							</td>
						</tr>
					</table>
				</form>
				<div style="padding:5px 0;min-width:1100px; width:100%">
					<table class="easyui-datagrid" title="班级列表" style="height:370px" id="manList" toolbar="#toolManbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
						<thead>
							<tr>
								<th data-options="field:'classInstId',checkbox:true"></th>
								<th width="8%" field="schoolName">校区</th>
								<th width="8%" field="className">热身课班级</th>
								<th width="8%" field="openDate">班级状态</th>
								<th width="8%" field="teacherNames">计划课时量</th>
								<th width="8%" field="finishDate">实际反馈课时量</th>
								<th width="8%" field="classStateName">应到人数</th>
								<th width="8%" field="classSchedule">实到人数</th>
								<th width="8%" field="classSchedule">定班人数</th>
								<th width="8%" field="classSchedule">申请时间</th>
								<th width="8%" field="classSchedule">审批时间</th>
								<th width="8%" field="classSchedule">开课时间</th>
								<th width="8%" field="classSchedule">结课时间</th>
							</tr>
						</thead>
					</table>
				</div>
				<div id="toolManbar" style="padding: 2px; height: auto">
					<a href="javascript:void(0)" id="manOperBtn" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="manOperFunc()">考勤维护</a>
		   			<a href="javascript:void(0)" id="manViewBtn" class="easyui-linkbutton" iconCls="icon-search" style="width:100px;" onclick="manViewFunc()">浏览</a>
				</div>
		    </div>
		    <div title="历史考勤">
				<form id="hisFm" style="margin:0 auto;">
					<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:5px auto;height:80px;" cellspacing="2">
						<tr>
							<td align="right" width="12%">
								校区：
							</td>
							<td width="22%">
								<select id="schoolHisId" name="schoolHisId" style="width:100px" ></select>
							</td>
							<td align="right" width="12%">
								班级状态：
							</td>
							<td width="22%">
								<select id="classHisPharse" name="classHisPharse" style="width:100px" ></select>
							</td>
							<td align="right" width="12%">
								班级：
							</td>
							<td>
								<select id="classHis" name="classHis" style="width:100px" ></select>
							</td>
						</tr>
						<tr>
							<td align="right">
								放班申请日期：
							</td>
							<td>
								<input name="openApplyStartManTime" id="openApplyStartManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="openApplyEndManTime" id="openApplyEndManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
							</td>
							<td align="right">
								放班审批日期：
							</td>
							<td>
								<input name="openAuditStartManTime" id="openAuditStartManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="openAuditEndManTime" id="openAuditEndManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
							</td>
							<td colspan="2" align="center">
								<a href="javascript:void(0)" id="queryHisBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryHisFunc()">查询</a>
								<a href="javascript:void(0)" id="resetHisBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetHisFunc()">重置</a>
							</td>
						</tr>
					</table>
				</form>
				<div style="padding:5px 0;min-width:1100px; width:100%;">
					<table class="easyui-datagrid" title="历史考勤列表" style="height:390px;" id="hisList" url="" toolbar="#toolHisbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
						<thead>
							<tr>
								<th data-options="field:'postId',checkbox:true"></th>
								<th width="11%" field="postName">校区</th>
								<th width="11%" field="postTypeName">热身课班级</th>
								<th width="11%" field="deptName">班级状态</th>
								<th width="11%" field="schoolIdsName">上课时间</th>
								<th width="11%" field="createDate">应到人数</th>
								<th width="11%" field="postName">实到人数</th>
								<th width="11%" field="postTypeName">请假人数</th>
								<th width="11%" field="deptName">迟到人数</th>
								<th width="11%" field="schoolIdsName">旷课人数</th>
							</tr>
						</thead>
					</table>
				</div>
				<div id="toolHisbar" style="padding: 2px; height: auto">
		   			<a href="javascript:void(0)" id="hisViewBtn" class="easyui-linkbutton" iconCls="icon-search" style="width:100px;" onclick="hisViewFunc()">浏览</a>
				</div>
		    </div>
		</div>
		<script type="text/javascript">
			ajaxLoading("加载中...");
			$.post("<%=path %>/pubData/qrySchoolList.do?schoolId=${sessionScope.StaffT.schoolId}",function(data){
				$("#schoolManId").combobox("loadData",data);
				$("#schoolHisId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=STAGE_ID",function(data){
				$("#classManPharse").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=CLASS_STATE",function(data){
				$("#classManState").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pub/pageComboxList.do?funcNodeId=${param.funcNodeId}&fieldId=classMan",function(data){
				$("#classMan").combobox("loadData",data);
				$("#classHis").combobox("loadData",data);
				ajaxLoadEnd();
			},"json");
			$(document).ready(function(){
				$("#schoolManId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto'
				});
				$("#classManPharse").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
				$("#classManState").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
				$("#classMan").combobox({
					formatter:function(row){
						return '<span>'+row.className+'</span>';
					},
					valueField: 'classInstId',
					textField: 'className',
					panelHeight: 'auto'
				});
				$("#schoolHisId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto'
				});
				$("#classHisPharse").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
				$("#classHis").combobox({
					formatter:function(row){
						return '<span>'+row.className+'</span>';
					},
					valueField: 'classInstId',
					textField: 'className',
					panelHeight: 'auto'
				});
				$('#tab').tabs({
				    border:true,
				    onSelect:function(title){
						console.log(title+' is selected');
				    }
				});
			});
			function queryManFunc()
			{
				/*
				var obj = $("#manFm").serializeObject();
				obj["queryCode"] = "qryAttendManList";
				obj["funcNodeId"] = "38101";
				obj = JSON.stringify(obj);
				$("#manList").datagrid({
					url:"/sys/pubData/qryDataListByPage.do",
					queryParams:{
						param : obj
					}
				});
				*/
			}
			function resetManFunc()
			{
				$("#schoolManId").combobox("setValue","");
				$("#classManPharse").combobox("setValue","");
				$("#classManState").combobox("setValue","");
				$("#classMan").combobox("setValue","");
				$("#teacherMan").textbox("setValue","");
				$("#classStartManTime").datebox("setValue","");
				$("#classEndManTime").datebox("setValue","");
				$("#overClassStartManTime").datebox("setValue","");
				$("#overClassEndManTime").datebox("setValue","");
			}
			function manOperFunc()
			{
				/*
				var row = $('#manList').datagrid('getSelected');
				if (row){
					window.location.href = "/sys/attend/getAttendDetail.do?funcNodeId=${param.funcNodeId}&classInstId="+row.classInstId;
				}
				else
				{
					$.messager.alert('提示',"请先选择要考勤的班级");
				}
				*/
			}
			function manViewFunc()
			{
				
			}
			function queryHisFunc()
			{
				
			}
			function resetHisFunc()
			{
				$("#schoolHisId").combobox("setValue","");
				$("#classHisPharse").combobox("setValue","");
				$("#classHisStart").datebox("setValue","");
				$("#classHisEnd").datebox("setValue","");
				$("#classHis").combobox("setValue","");
				$("#teacherHis").textbox("setValue","");
				$("#attendStartRate").numberbox("setValue","");
				$("#attendEndRate").numberbox("setValue","");
				$("#schoolWearStartRate").numberbox("setValue","");
				$("#schoolWearEndRate").numberbox("setValue","");
			}
			function hisViewFunc()
			{
				
			}
		</script>
 	</body>
</html>