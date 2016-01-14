

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  	<body>
  		<div style="margin-right:5px;">
 		<form id="qryFm">
  			<table class="search_tab">
  				<tr>
  					<td align="right" width="80px"><span>校区：</span></td>
  					<td width="110px">
  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:100px;height: 25px;" editable="false"
  							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
  							onLoadSuccess:function(data){if(data.length > 0) $('#schoolId').combobox('setValue',data[0].schoolId);}"
  							url="<%=path%>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=701&fieldId=schoolId&headFlag=N">
  						</select>
  					</td>
  					<td width="80px" align="right"><span>班级状态：</span></td>
  					<td width="140px">
  						<select class="easyui-combobox" name="classState" id="classState" style="width:100px;height:25px;" editable="false"
  							  data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      				 		url="<%=path %>/pubData/qryCodeNameList.do?tableName=DEMO&codeType=CLASS_STATE">
  						</select>
  					</td>
  					<td width="100px" align="right"><span>上课日期：</span></td>
  					<td width="250px">
  						<input class="easyui-datebox" name="startTime" id="startTime"  style="width:100px;height: 25px;" editable="false"/>
  						至
  						<input class="easyui-datebox" name="endTime" id="endTime"  style="width:100px;height: 25px;" editable="false"/>
  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>DemoT：</span></td>
  					<td>
  						<select class="easyui-combobox" name="DemoT" id="DemoT" style="width:100px;height:25px;" editable="false"
  							data-options="formatter:formatTeacher, valueField: 'teacherId',textField: 'byname', panelHeight: 'auto'"
  							url ="<%=path %>/pubData/qryData.do?param={'queryCode':'qryDemoTeacherInfo','teacherType':'T'}">
  						</select>
  					</td>
  					<td align="right"><span>DemoTa：</span></td>
  					<td>
  						<select class="easyui-combobox" name="DemoTA" id="DemoTA" style="width:100px;height:25px;" editable="false"
  							data-options="formatter:formatTeacher, valueField: 'teacherId',textField: 'byname', panelHeight: 'auto'"
  							url ="<%=path %>/pubData/qryData.do?param={'queryCode':'qryDemoTeacherInfo','teacherType':'TA'}">
  						</select>
  					</td>
  					<td align="right"><span>DEMO转化率：</span></td>
  					<td>
  						<input class="easyui-numberbox" name="min" id="min"  style="width:92px;height:25px;" data-options="min:0,max:99,precision:0" />%
  						-
  						<input class="easyui-numberbox" name="max" id="max"  style="width:92px;height:25px;" data-options="min:1,max:100,precision:0"/>%
  					</td>
  					<td>
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:100px;height:25px;" id="qryBtn" funcNodeId ="3500" ><span>查询</span></a>
  						&nbsp;&nbsp;
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:100px;height:25px;" id="resetBtn" ><span>重置</span></a>
  					</td>
  				</tr>
  			</table>
 		</form>
 		
 		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:450" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="schoolName" align="center" width="5%">校区</th>
					<th field="schoolTime" align="center" width="20%">上课时间</th>
					<th field="stateVal" align="center" width="8%">班级状态</th>
					<th field="stuNum" align="center" width="12%">参与Demo人数</th>
					<th field="orderNum" align="center" width="15%">定金个数</th>
					<th field="allNum" align="center" width="15%">全费个数</th>
					<th field="turnNum" align="center" width="10%">定金转全费</th>
					<th field="repayNum" align="center" width="15%">补缴全费</th>
					<th field="demoRate" align="center" width="10%">Demo转化率</th>
					<th field="demoT" align="center" width="10%">反馈DemoT</th>
					<th field="demoTa" align="center" width="10%">反馈DemoTa</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
   			<a href="javascript:void(0)" id="feedbackManage" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;"><span>反馈管理</span></a>
   			<a href="javascript:void(0)" id="insertData" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;"><span>录入数据</span></a>
   			<a href="javascript:void(0)" id="viewInfo" class="easyui-linkbutton" iconCls="icon-redo" style="width: 100px;"><span>浏览</span></a>
 		</div>
 	</div>	
  	</body>
</html>
<script>
	$(document).ready(function(){
		
		initQryButton("qryBtn","resetBtn","qryFm","list_data");
		$("#feedbackManage").click(function(){
			manageFeedBack();
		});
		$("#insertData").click(function(){
			insertData();
		});
		$("#viewInfo").click(function(){
			if(validateSelect())
			{
				var row = $('#list_data').datagrid('getSelected');
				window.location.href="demoFeedbackView.jsp?shortClassInstId="+row.shortClassInstId+"&classState="+row.classState;
			}
		});
	});
	
	function manageFeedBack()
	{
		if(validateSelect())
		{
			var row = $('#list_data').datagrid('getSelected');
			if(row.classState!="005")
			{
				window.location.href="demoFeedback.jsp?shortClassInstId="+row.shortClassInstId+"&classState="+row.classState;
			}
			else
			{
				$.messager.alert('提示', "不能反馈已取消的DEMO课");
			}	
		}	
	}
	
	function insertData()
	{
		if(validateSelect())
		{
			var row = $('#list_data').datagrid('getSelected');
			if(row.classState!="001"&&row.classState!="005")
			{
				window.location.href="demoStudentInfo.jsp?shortClassInstId="+row.shortClassInstId;
			}
			else
			{
				$.messager.alert('提示', "不能录入未开课和已取消状态的DEMO课");
			}	
		}	
	}
	
	function validateSelect()
	{
		var flag = false;
		var obj = $("#list_data").datagrid('getSelections');
		if(obj.length > 0) {
			if(obj.length > 1) {
				$.messager.alert('提示', "只能选择一条记录操作！");
			} else {
				flag = true;
			}
		} else {
			$.messager.alert('提示', "请先选择一条记录！");
		}
		return flag;
	}
</script>