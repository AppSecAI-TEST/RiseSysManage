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
			sessionStorage.clear();
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=817&fieldId=schoolId",function(data){
				$("#schoolManId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=CLASS_STATE",function(data){
				var classManStateArr = [];
				for(var i = 0,n = data.length;i < n;i++)
				{
					if(data[i].codeFlag != '002')
					{
						if(data[i].codeFlag == '005')
						{
							data[i].codeName = "取消";
						}
						classManStateArr.push(data[i]);
					}
				}
				$("#classManState").combobox("loadData",classManStateArr);
			},"json");
			$.post("<%=path %>/shortBus/getShortClassTypeList.do?typeName="+encodeURI("国际班"),function(data){
				$("#interClassType").combobox("loadData",data);
			},"json");
			$(document).ready(function(){
				sessionStorage.clear();
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
				$("#interClassType").combobox({
					formatter:function(data){
						return '<span>'+data.classType+'</span>';
					}, 
					valueField: 'classTypeId', 
					textField: 'classType',
					panelHeight: 'auto'
				});
			});
			function queryFunc()
			{
				initPageNumber("manList");
				var obj = $("#manFm").serializeObject();
				var openStartManTime = $("#openStartManTime").datebox("getValue");
				var openEndManTime = $("#openEndManTime").datebox("getValue");
				var classStartManTime = $("#classStartManTime").datebox("getValue");
				var classEndManTime = $("#classEndManTime").datebox("getValue");
				var overClassStartManTime = $("#overClassStartManTime").datebox("getValue");
				var overClassEndManTime = $("#overClassEndManTime").datebox("getValue");
				if(openStartManTime != "" && openEndManTime == "")
				{
					obj["openEndManTime"] = "3000-12-31";
				}
				else if(openStartManTime == "" && openEndManTime != "")
				{
					obj["openStartManTime"] = "1900-01-01";
				}
				if(classStartManTime != "" && classEndManTime == "")
				{
					obj["classEndManTime"] = "3000-12-31";
				}
				else if(classStartManTime == "" && classEndManTime != "")
				{
					obj["classStartManTime"] = "1900-01-01";
				}
				if(overClassStartManTime != "" && overClassEndManTime == "")
				{
					obj["overClassEndManTime"] = "3000-12-31";
				}
				else if(overClassStartManTime == "" && overClassEndManTime != "")
				{
					obj["overClassStartManTime"] = "1900-01-01";
				}
				obj["queryCode"] = "qryInterClassList";
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
				var schoolData = $("#schoolManId").combobox("getData");
				if(schoolData != null && schoolData.length > 0)
				{
					$("#schoolManId").combobox("setValue",schoolData[0].schoolId);
				}
				$("#interClassType").combobox("setValue","");
				$("#classInfo").textbox("setValue","");
				$("#classManState").combobox("setValue","");
				$("#openStartManTime").datebox("setValue","");
				$("#openEndManTime").datebox("setValue","");
				$("#classStartManTime").datebox("setValue","");
				$("#classEndManTime").datebox("setValue","");
				$("#overClassStartManTime").datebox("setValue","");
				$("#overClassEndManTime").datebox("setValue","");
			}
			function classArrangementFunc()
			{
				ajaxLoading("正在处理，请稍待。。。");
				window.location.href = "/sys/shortBus/getAddShortClassInfo.do?funcNodeId=${param.funcNodeId}&pageName=addInterClass";
			}
			function cancelClassFunc()
			{
				var row = $("#manList").datagrid("getSelected");
				if(row)
				{
					if(row.classStateName == "未开课" || row.classStateName == "未开课")
					{
						ajaxLoading("正在处理，请稍待。。。");
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
			function manClassFunc()
			{
				var row = $("#manList").datagrid("getSelected");
				if(row)
				{
					if(row.classStateName == "未开课" || row.classStateName == "未开课")
					{
						ajaxLoading("正在处理，请稍待。。。");
						window.location.href = "/sys/shortBus/shortClassManInfo.do?funcNodeId=${param.funcNodeId}&shortClassInstId="+row.shortClassInstId+"&pageName=shortInterClassMan";
					}
					else if(row.classStateName == "开课在读")
					{
						$.messager.alert('提示',"该课程已经开课不能再被修改");		
					}
					else if(row.classStateName == "结课")
					{
						$.messager.alert('提示',"该课程已经结课");		
					}
					else if(row.classStateName == "取消")
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
					ajaxLoading("正在处理，请稍待。。。");
					window.location.href = "/sys/shortBus/viewShortClassPage.do?funcNodeId=${param.funcNodeId}&pageName=viewInterShortClass&shortClassInstId="+row.shortClassInstId;
				}
				else
				{
					$.messager.alert('提示',"请选择要浏览的班级");
				}
			}
		</script>
  	</head>
  	<body>
  		<div style="magrin-right:5px;">
		<form id="manFm">
			<table class="search_tab">
				<tr>
					<td align="right">
						国际班类型：
					</td>
					<td width="12%">
						<select id="interClassType" name="interClassType" style="width:120px;height:25px;" ></select>								
					</td>
					<td align="right" width="8%">	
						班级名称：
					</td>
					<td width="12%">
						<input name="classInfo" id="classInfo" type="text" class="easyui-textbox" style="width:120px;height:25px;"/>
					</td>
					<td align="right" width="8%">
						放班日期：
					</td>
					<td width="22%">
						<input name="openStartManTime" id="openStartManTime" type="text" style="width:120px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="openEndManTime" id="openEndManTime" type="text" style="width:120px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
					</td>
					<td align="right">
						开课日期：
					</td>
					<td width="22%">
						<input name="classStartManTime" id="classStartManTime" type="text" style="width:120px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="classEndManTime" id="classEndManTime" type="text" style="width:120px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
					</td>
				</tr>
				<tr>
					<td align="right" width="8%">
						上课校区：
					</td>
					<td width="12%">
						<select id="schoolManId" name="schoolManId" style="width:120px;height:25px;" ></select>
					</td>
					<td align="right" width="8%">
						班级状态：
					</td>
					<td width="12%">
						<select id="classManState" name="classManState" style="width:120px;height:25px;" ></select>
					</td>
					<td align="right">
						结课日期：
					</td>
					<td colspan="2">
						<input name="overClassStartManTime" id="overClassStartManTime" type="text" style="width:120px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="overClassEndManTime" id="overClassEndManTime" type="text" style="width:120px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
					</td>
					<td>
						<a href="javascript:void(0)" id="queryManBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 120px;" onclick="queryFunc()">查询</a>
						&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" id="resetManBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 120px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
		</form>
			<table class="easyui-datagrid" title="班级列表" id="manList" toolbar="#toolManbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'shortClassInstId',checkbox:true"></th>
						<th width="8%" field="schoolName">上课校区</th>
						<th width="8%" field="classType">国际班类型</th>
						<th width="8%" field="className">班级名称</th>
						<th width="8%" field="teacherNames">带班老师</th>
						<th width="8%" field="classStateName">班级状态</th>
						<th width="8%" field="totalLessionHours">总课时量</th>
						<th width="8%" field="classProgress">课时进度</th>
						<th width="8%" field="personNum">定班人数</th>
						<th width="8%" field="maxNum">班级人数上限</th>
						<th width="8%" field="putClassDate">放班日期</th>
						<th width="8%" field="openDate">开课日期</th>
						<th width="8%" field="finishDate">结课日期</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="toolManbar" style="padding: 2px; height: auto">
			<a href="javascript:void(0)" id="classArrangementBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:120px;" onclick="classArrangementFunc()">放班排课</a>
			<a href="javascript:void(0)" id="cancelClassBtn" class="easyui-linkbutton" iconCls="icon-remove" style="width:120px;" onclick="cancelClassFunc()">取消放班</a>
			<a href="javascript:void(0)" id="manClassBtn" class="easyui-linkbutton" iconCls="icon-edit" style="width:120px;" onclick="manClassFunc()">班级维护</a>
   			<a href="javascript:void(0)" id="viewClassBtn" class="easyui-linkbutton" iconCls="icon-search" style="width:120px;" onclick="viewClassFunc()">浏览</a>
		</div>
 	</body>
</html>
