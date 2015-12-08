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
							班级：
						</td>
						<td width="22%">
							<select id="classInfo" name="classInfo" style="width:100px" ></select>
						</td>
						<td align="right" width="8%">
							放班日期：
						</td>
						<td width="22%">
							<input name="openStartManTime" id="openStartManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="openEndManTime" id="openEndManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
						</td>
						<td align="right" width="8%">
							班级状态：
						</td>
						<td width="12%">
							<select id="classManState" name="classManState" style="width:100px" ></select>
						</td>
					</tr>
					<tr>
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
							<th width="11%" field="schoolName">班级名称</th>
							<th width="11%" field="className">班级状态</th>
							<th width="11%" field="openDate">定班人数</th>
							<th width="11%" field="teacherNames">班级人数上限</th>
							<th width="11%" field="finishDate">实际游学人数</th>
							<th width="11%" field="classSchedule">班级人数上限</th>
							<th width="11%" field="classSchedule">放班日期</th>
							<th width="11%" field="classSchedule">游学开始日期</th>
							<th width="11%" field="classSchedule">游学结束日期</th>
						</tr>
					</thead>
				</table>
			</div>
			<div id="toolManbar" style="padding: 2px; height: auto">
				<a href="javascript:void(0)" id="manOperBtn" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="manOperFunc()">考勤维护</a>
	   			<a href="javascript:void(0)" id="manViewBtn" class="easyui-linkbutton" iconCls="icon-search" style="width:100px;" onclick="manViewFunc()">浏览</a>
			</div>
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
				});*/
			}
			function resetManFunc()
			{
				$("#classManState").combobox("setValue","");
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
		</script>
 	</body>
</html>