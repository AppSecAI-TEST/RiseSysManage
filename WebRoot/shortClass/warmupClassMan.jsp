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
  		<div id="tab" class="easyui-tabs" style="min-width:1150px;width:99%;height:528px;font-family:'微软雅黑';margin:0 auto;padding:0 0">
		    <div title="班级管理">
				<form id="manFm" style="margin:0 auto;">
					<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:5px auto;height:80px;" cellspacing="2">
						<tr>
							<td align="right" width="8%">
								校区：
							</td>
							<td width="11%">
								<select id="schoolManId" name="schoolManId" style="width:100px" ></select>
							</td>
							<td align="right" width="9%">	
								课程阶段：
							</td>
							<td width="22%">
								<select id="classManPharse" name="classManPharse" style="width:100px" ></select>
							</td>
							<td align="right" width="9%">	
								班级：
							</td>
							<td colspan="2">
								<select id="classInfo" name="classInfo" style="width:100px" ></select>
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
								<input name="openStartManTime" id="openStartManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="openEndManTime" id="openEndManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
							</td>
							<td align="right">
								放班审批日期：
							</td>
							<td>
								<input name="verifyStartManTime" id="verifyStartManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="verifyEndManTime" id="verifyEndManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
							</td>
							<td align="center">
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
								<th data-options="field:'shortClassInstId',checkbox:true"></th>
								<th width="9%" field="schoolName">校区</th>
								<th width="9%" field="className">热身课班级名称</th>
								<th width="9%" field="classStateName">班级状态</th>
								<th width="9%" field="planClassNum">计划课时量</th>
								<th width="9%" field="classProgress">实际反馈课时量</th>
								<th width="9%" field="personNum">计划上课人数</th>
								<th width="9%" field="maxNum">实际上课人数</th>
								<th width="9%" field="putClassDate">申请时间</th>
								<th width="9%" field="putClassDate">审批时间</th>
								<th width="9%" field="openDate">开课日期</th>
								<th width="9%" field="finishDate">结课日期</th>
							</tr>
						</thead>
					</table>
				</div>
				<div id="toolManbar" style="padding: 2px; height: auto">
					<a href="javascript:void(0)" id="classArrangementBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="classArrangementFunc()">放班申请</a>
					<a href="javascript:void(0)" id="cancelClassBtn" class="easyui-linkbutton" iconCls="icon-remove" style="width:100px;" onclick="cancelClassFunc()">学员维护</a>
					<a href="javascript:void(0)" id="manClassBtn" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="manClassFunc()">班级调整</a>
		   			<a href="javascript:void(0)" id="viewClassBtn" class="easyui-linkbutton" iconCls="icon-search" style="width:100px;" onclick="viewClassFunc()">浏览</a>
				</div>
			</div>
		    <div title="审批管理">
				<form id="hisFm" style="margin:0 auto;">
					<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:5px auto;height:80px;" cellspacing="2">
						<tr>
							<td align="right" width="8%">
								校区：
							</td>
							<td width="11%">
								<select id="schoolVerId" name="schoolVerId" style="width:100px" ></select>
							</td>
							<td align="right" width="9%">
								班级：
							</td>
							<td width="22%">
								<select id="classVerInfo" name="classVerInfo" style="width:100px" ></select>
							</td>
							<td align="right" width="9%">
								审批状态：
							</td>
							<td width="22%">
								<select id="verifyState" name="verifyState" style="width:100px" ></select>
							</td>
							<td>
								<input name="myVerify" id="myVerify" type="checkbox" value="是" /><label for="feeReturnYes">查看我的审批</label>
							</td>
						</tr>
						<tr>
							<td align="right">
								班级状态：
							</td>
							<td>
								<select id="classManVerState" name="classManVerState" style="width:100px" ></select>
							</td>
							<td align="right">
								放班申请时间：
							</td>
							<td>
								<input name="openApplyStartManTime" id="openApplyStartManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="openApplyEndManTime" id="openApplyEndManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />							
							</td>
							<td align="right">
								放班审批时间：
							</td>
							<td>
								<input name="openVerStartManTime" id="openVerStartManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="openVerEndManTime" id="openVerEndManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />							
							</td>
							<td align="left">
								<a href="javascript:void(0)" id="queryVerBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryVerFunc()">查询</a>
								<a href="javascript:void(0)" id="resetVerBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetVerFunc()">重置</a>
							</td>
						</tr>
					</table>
				</form>
				<div style="padding:5px 0;min-width:1100px; width:100%;">
					<table class="easyui-datagrid" title="班级申请列表" style="height:390px;" id="hisList" url="" toolbar="#toolHisbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
						<thead>
							<tr>
								<th data-options="field:'postId',checkbox:true"></th>
								<th width="8%" field="postName">校区</th>
								<th width="8%" field="postTypeName">热身课名称</th>
								<th width="8%" field="deptName">审批状态</th>
								<th width="8%" field="schoolIdsName">计划课时量</th>
								<th width="8%" field="createDate">实际反馈课时量</th>
								<th width="8%" field="postName">计划上课人数</th>
								<th width="8%" field="postTypeName">实际上课人数</th>
								<th width="8%" field="deptName">定班人数</th>
								<th width="8%" field="schoolIdsName">申请时间</th>
								<th width="8%" field="createDate">审批时间</th>
								<th width="8%" field="createDate">开课时间</th>
								<th width="8%" field="createDate">结课时间</th>
							</tr>
						</thead>
					</table>
				</div>
				<div id="toolHisbar" style="padding: 2px; height: auto">
		   			<a href="javascript:void(0)" id="veriftyManBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="verifyManFunc()">审批</a>
		   			<a href="javascript:void(0)" id="viewManBtn" class="easyui-linkbutton" iconCls="icon-search" style="width:100px;" onclick="viewManFunc()">浏览</a>
				</div>
		    </div>
		</div>
		<script type="text/javascript">
			$.post("<%=path %>/pubData/qrySchoolList.do",function(data){
				$("#schoolManId").combobox("loadData",data);
				$("#schoolVerId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=CLASS_STATE",function(data){
				$("#classManState").combobox("loadData",data);
				$("#classManVerState").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=STAGE_ID",function(data){
				$("#classManPharse").combobox("loadData",data);
			},"json");
			$(document).ready(function(){
				sessionStorage.clear();
				$("#classInfo").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
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
				$("#classVerInfo").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
				$("#schoolVerId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto'
				});
				$("#verifyState").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
				$("#classManVerState").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
			});
			function queryFunc()
			{
				var obj = $("#manFm").serializeObject();
				obj["queryCode"] = "qryWarmupClassList";
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
				$("#classInfo").combobox("setValue","");
				$("#classManState").combobox("setValue","");
				$("#schoolManId").combobox("setValue","");
				$("#openStartManTime").datebox("setValue","");
				$("#openEndManTime").datebox("setValue","");
				$("#verifyStartManTime").datebox("setValue","");
				$("#verifyEndManTime").datebox("setValue","");
			}
			function classArrangementFunc()
			{
				window.location.href = "/sys/shortBus/getAddShortClassInfo.do?funcNodeId=${param.funcNodeId}&pageName=addWarmupClass";
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
			function manClassFunc()
			{
				var row = $("#manList").datagrid("getSelected");
				if(row)
				{
					if(row.classStateName == "未开课" || row.classStateName == "未开课")
					{
						window.location.href = "/sys/shortBus/shortClassManInfo.do?funcNodeId=${param.funcNodeId}&shortClassInstId="+row.shortClassInstId;
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
					$.messager.alert('提示',"请选择要维护的班级");
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
			function queryVerFunc()
			{
				
			}
			function resetVerFunc()
			{
				
			}
			function verifyManFunc()
			{
				
			}
			function viewManFunc()
			{
				
			}
		</script>
 	</body>
</html>