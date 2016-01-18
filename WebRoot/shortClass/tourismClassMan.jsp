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
						游学班级：
					</td>
					<td width="22%">
						<select id="classInfo" name="classInfo" style="width:100px;height:25px;" ></select>
					</td>
					<td align="right" width="8%">
						班级状态：
					</td>
					<td width="22%">
						<select id="classManState" name="classManState" style="width:100px;height:25px;" ></select>
					</td>
					<td align="right" width="8%">
						放班日期：
					</td>
					<td>
						<input name="openStartManTime" id="openStartManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="openEndManTime" id="openEndManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
					</td>
				</tr>
				<tr>
					<td align="right">
						开课日期：
					</td>
					<td>
						<input name="classStartManTime" id="classStartManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="classEndManTime" id="classEndManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
					</td>
					<td align="right">
						结课日期：
					</td>
					<td>
						<input name="overClassStartManTime" id="overClassStartManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="overClassEndManTime" id="overClassEndManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
					</td>
					<td colspan="2" style="padding-left:20px">
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
						<th width="11%" field="className">班级名称</th>
						<th width="11%" field="classType">班级类型</th>
						<th width="11%" field="classStateName">班级状态</th>
						<th width="11%" field="personNum">定班人数</th>
						<th width="11%" field="maxNum">班级人数上限</th>
						<th width="11%" field="realPersonNum">实际游学人数</th>
						<th width="11%" field="putClassDate">放班日期</th>
						<th width="11%" field="openDate">游学开始日期</th>
						<th width="11%" field="finishDate">游学结束日期</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="toolManbar" style="padding: 2px; height: auto">
			<a href="javascript:void(0)" id="classArrangementBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="classArrangementFunc()">放班排课</a>
			<a href="javascript:void(0)" id="cancelClassBtn" class="easyui-linkbutton" iconCls="icon-remove" style="width:100px;" onclick="cancelClassFunc()">取消放班</a>
			<a href="javascript:void(0)" id="manClassBtn" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="manClassFunc()">班级维护</a>
   			<a href="javascript:void(0)" id="viewClassBtn" class="easyui-linkbutton" iconCls="icon-search" style="width:100px;" onclick="viewClassFunc()">浏览</a>
		</div>
		<script type="text/javascript">
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=CLASS_STATE",function(data){
				$("#classManState").combobox("loadData",data);
			},"json");
			$(document).ready(function(){
				$("#classInfo").combobox({
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
			});
			function queryFunc()
			{
				var obj = $("#manFm").serializeObject();
				obj["queryCode"] = "qryTourismClassInfo";
				obj["funcNodeId"] = "38115";
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
				$("#classInfo").combobox("setValue","");
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
				ajaxLoading("加载中...");
				window.location.href = "/sys/shortBus/accessShortClassPage.do?funcNodeId=${param.funcNodeId}&pageName=addTourismClass&classType="+encodeURI("游学");
			}
			function cancelClassFunc()
			{
				var row = $("#manList").datagrid("getSelected");
				if(row)
				{
					if(row.classStateName == "未开课" || row.classStateName == "未开课")
					{
						ajaxLoading("加载中...");
						window.location.href = "/sys/shortBus/accessShortClassPage.do?funcNodeId=${param.funcNodeId}&shortClassInstId="+row.shortClassInstId+"&pageName=cancelTourismClass&classType="+encodeURI("游学");
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
						ajaxLoading("加载中...");
						window.location.href = "/sys/shortBus/accessShortClassPage.do?funcNodeId=${param.funcNodeId}&shortClassInstId="+row.shortClassInstId+"&pageName=shortTourismClassMan&classType="+encodeURI("游学");
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
						ajaxLoading("加载中...");
						window.location.href = "/sys/shortBus/accessShortClassPage.do?funcNodeId=${param.funcNodeId}&shortClassInstId="+row.shortClassInstId+"&pageName=viewTourismShortClass&classType="+encodeURI("游学");
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
		</script>
 	</body>
</html>