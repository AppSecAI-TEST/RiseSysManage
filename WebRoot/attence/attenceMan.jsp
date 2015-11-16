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
  		<div id="tab" class="easyui-tabs" style="min-width:1100px;width:99%;height:530px;font-family:'微软雅黑';margin:0 auto;padding:0 0">
		    <div title="考勤管理">
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
							<td width="22%">
								<select id="classManPharse" name="classManPharse" style="width:100px" ></select>
							</td>
							<td align="right" width="8%">
								班级状态：
							</td>
							<td width="22%">
								<select id="classManState" name="classManState" style="width:100px" ></select>
							</td>
							<td align="right" width="8%">
								班级：
							</td>
							<td width="12%">
								<select id="classMan" name="classMan" style="width:100px" ></select>
							</td>
						</tr>
						<tr>
							<td align="right">
								带班老师：
							</td>
							<td>
								<input name="teacherMan" id="teacherMan" type="text" style="width:100px" class="easyui-textbox" />								
							</td>
							<td align="right">
								开课日期：
							</td>
							<td>
								<input name="classStartManTime" id="classStartManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="classEndManTime" id="classEndManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
							</td>
							<td align="right">
								结课日期：
							</td>
							<td>
								<input name="overClassStartManTime" id="overClassStartManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="overClassEndManTime" id="overClassEndManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
							</td>
							<td colspan="2" align="center">
								<a href="javascript:void(0)" id="queryManBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryManFunc()">查询</a>
								<a href="javascript:void(0)" id="resetManBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetManFunc()">重置</a>
							</td>
						</tr>
					</table>
				</form>
				<div style="padding:5px 0;min-width:1100px; width:100%">
					<table class="easyui-datagrid" title="班级列表" style="height:390px" id="manList" toolbar="#toolManbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
						<thead>
							<tr>
								<th data-options="field:'classInstId',checkbox:true"></th>
								<th width="14%" field="schoolName">校区</th>
								<th width="14%" field="className">班级名称</th>
								<th width="14%" field="openDate">开课日期</th>
								<th width="14%" field="teacherNames">带班老师</th>
								<th width="14%" field="finishDate">结课日期</th>
								<th width="14%" field="classStateName">班级状态</th>
								<th width="14%" field="classSchedule">课时进度</th>
							</tr>
						</thead>
					</table>
				</div>
				<div id="toolManbar" style="padding: 2px; height: auto">
					<a href="javascript:void(0)" id="manOperBtn" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="manOperFunc()">考勤管理</a>
		   			<a href="javascript:void(0)" id="manViewBtn" class="easyui-linkbutton" iconCls="icon-search" style="width:100px;" onclick="manViewFunc()">浏览考勤</a>
		   			<a href="javascript:void(0)" id="manLeaveBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="manLeaveFunc()">请假补课</a>
				</div>
		    </div>
		    <div title="历史考勤">
				<form id="hisFm" style="margin:0 auto;">
					<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:5px auto;height:80px;" cellspacing="2">
						<tr>
							<td align="right" width="8%">
								校区：
							</td>
							<td width="12%">
								<select id="schoolHisId" name="schoolHisId" style="width:100px" ></select>
							</td>
							<td align="right" width="8%">
								课程阶段：
							</td>
							<td width="22%">
								<select id="classHisPharse" name="classHisPharse" style="width:100px" ></select>
							</td>
							<td align="right" width="8%">
								上课日期：
							</td>
							<td width="22%">
								<input name="classHisStart" id="classHisStart" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="classHisEnd" id="classHisEnd" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
							</td>
							<td align="right" width="8%">
								班级：
							</td>
							<td width="12%">
								<select id="classHis" name="classHis" style="width:100px" ></select>
							</td>
						</tr>
						<tr>
							<td align="right">
								老师：
							</td>
							<td>
								<input name="teacherHis" id="teacherHis" type="text" style="width:100px" class="easyui-textbox" />								
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
								<th width="7%" field="postName">校区</th>
								<th width="7%" field="postTypeName">上课时间</th>
								<th width="7%" field="deptName">班级名称</th>
								<th width="7%" field="schoolIdsName">上课T老师</th>
								<th width="7%" field="createDate">上课TA老师</th>
								<th width="7%" field="postName">实际课时</th>
								<th width="7%" field="postTypeName">应到人数</th>
								<th width="7%" field="deptName">实到人数</th>
								<th width="7%" field="schoolIdsName">请假人数</th>
								<th width="7%" field="createDate">旷课人数</th>
								<th width="7%" field="createDate">迟到人数</th>
								<th width="7%" field="createDate">校服穿着人数</th>
								<th width="7%" field="createDate">出勤率</th>
								<th width="7%" field="createDate">校服穿着率</th>
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
				$("#classHisPharse").combobox("loadData",data);
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
				var row = $('#manList').datagrid('getSelected');
				if (row){
					window.location.href = "/sys/attend/getAttendDetail.do?funcNodeId=${param.funcNodeId}&classInstId="+row.classInstId;
				}
				else
				{
					$.messager.alert('提示',"请先选择要考勤的班级");
				}
			}
			function manViewFunc()
			{
				
			}
			function manLeaveFunc()
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