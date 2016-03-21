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
			$(document).ready(function(){
				$("#classManState").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
			});
			function queryManFunc()
			{
				var obj = $("#manFm").serializeObject();
				obj["queryCode"] = "qryTourismAttendInfo";
				obj["funcNodeId"] = "38120";
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
				$("#classInfo").textbox("setValue","");
				$("#classManState").combobox("setValue","");
				$("#openStartManTime").datebox("setValue","");
				$("#openEndManTime").datebox("setValue","");
				$("#classStartManTime").datebox("setValue","");
				$("#classEndManTime").datebox("setValue","");
				$("#overClassStartManTime").datebox("setValue","");
				$("#overClassEndManTime").datebox("setValue","");
			}
			function manOperFunc()
			{
				var row = $('#manList').datagrid('getSelected');
				if (row)
				{
					if(row.classStateName == "未开课" || row.classStateName == "未开课" || row.classStateName == "开课在读" || row.classStateName == "结课")
					{
						ajaxLoading("正在处理，请稍待。。。");
						window.location.href = "/sys/shortBus/accessShortAttenceDetail.do?funcNodeId=${param.funcNodeId}&pageName=attenceTourismDetail&shortClassInstId="+row.shortClassInstId;
					}
					else if(row.classStateName == "取消")
					{
						$.messager.alert('提示',"该课程已被取消");		
					}
				}
				else
				{
					$.messager.alert('提示',"请先选择要考勤的班级");
				}
			}
			function manViewFunc()
			{
				var row = $('#manList').datagrid('getSelected');
				if (row)
				{
					ajaxLoading("正在处理，请稍待。。。");
					window.location.href = "/sys/shortBus/accessShortClassPage.do?funcNodeId=${param.funcNodeId}&shortClassInstId="+row.shortClassInstId+"&pageName=viewTourismShortClass&classType="+encodeURI("游学");
				}
				else
				{
					$.messager.alert('提示',"请先选择要考勤的班级");
				}
			}
		</script>
  	</head>
  	<body>
  		<div>
  			<div style="margin-right:5px;">
			<form id="manFm">
				<table class="search_tab">
					<tr>
						<td align="right" width="70px;">	
							班级：
						</td>
						<td width="100px;">
							<input name="classInfo" id="classInfo" type="text" class="easyui-textbox" style="width:100px;height:25px;"/>
						</td>
						<td align="left" width="70px;">
							放班日期：
						</td>
						<td width="225px;">
							<input name="openStartManTime" id="openStartManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="openEndManTime" id="openEndManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
						</td>
						<td align="right" width="70px;">
							班级状态：
						</td>
						<td align="left" style="min-width: 350px;">
							<select id="classManState" name="classManState" style="width:100px;height:25px;" ></select>
						</td>
					</tr>
					<tr>
						<td align="right">
							开课日期：
						</td>
						<td>
							<input name="classStartManTime" id="classStartManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="classEndManTime" id="classEndManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
						</td>
						<td align="left">
							结课日期：
						</td>
						<td>
							<input name="overClassStartManTime" id="overClassStartManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="overClassEndManTime" id="overClassEndManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />								
						</td>
						<td colspan="2" align="left">
							<a href="javascript:void(0)" id="queryManBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryManFunc()">查询</a>
							<a href="javascript:void(0)" id="resetManBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetManFunc()">重置</a>
						</td>
					</tr>
				</table>
			</form>
				<table class="easyui-datagrid" title="班级列表" style="height:390px" id="manList" toolbar="#toolManbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
							<th data-options="field:'shortClassInstId',checkbox:true"></th>
							<th width="12%" field="className">班级名称</th>
							<th width="12%" field="classStateName">班级状态</th>
							<th width="12%" field="realClassNum">定班人数</th>
							<th width="12%" field="maxNum">班级人数上限</th>
							<th width="12%" field="personNum">实际游学人数</th>
							<th width="12%" field="putClassDate">放班日期</th>
							<th width="12%" field="openDate">游学开始日期</th>
							<th width="12%" field="finishDate">游学结束日期</th>
						</tr>
					</thead>
				</table>
			</div>
			<div id="toolManbar" style="padding: 2px; height: auto">
				<a href="javascript:void(0)" id="manOperBtn" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="manOperFunc()">考勤维护</a>
	   			<a href="javascript:void(0)" id="manViewBtn" class="easyui-linkbutton" iconCls="icon-search" style="width:100px;" onclick="manViewFunc()">浏览</a>
			</div>
	    </div>
 	</body>
</html>