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
			<input type="hidden" name="classType" id="classType" value="${param.classType}" />
			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:5px auto;height:80px;" cellspacing="2">
				<tr>
					<td align="right">
						学员姓名：
					</td>
					<td>
						<input name="studentName" id="studentName" type="text" style="width:150px" class="easyui-textbox easyui-validatebox" />								
					</td>
					<td align="right" width="8%">	
						联系电话：
					</td>
					<td width="22%">
						<input name="phoneNum" id="phoneNum" type="text" style="width:150px" class="easyui-textbox easyui-validatebox" />
					</td>
					<td align="right" width="8%">
						缴费日期：
					</td>
					<td width="22%">
						<input name="payStartManTime" id="payStartManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="payEndManTime" id="payEndManTime" type="text" style="width:100px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
					</td>
				</tr>
				<tr>
					<td align="right" width="8%">
						校区：
					</td>
					<td width="12%">
						<select id="schoolManId" name="schoolManId" style="width:150px" ></select>
					</td>
					<td align="right">
						班级类型：
					</td>
					<td>
						<select id="shortClassType" name="shortClassType" style="width:150px" ></select>										
					</td>
					<td colspan="2" align="center">
						<a href="javascript:void(0)" id="queryManBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetManBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
		</form>
		<div style="padding:5px 0;min-width:1100px; width:100%">
			<table class="easyui-datagrid" title="学员列表" style="height:390px" id="studentList" toolbar="#toolManbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'studentId',checkbox:true"></th>
						<th width="14%" field="name">学员姓名</th>
						<th width="16%" field="identityId">证件号码</th>
						<th width="14%" field="schoolName">校区</th>
						<th width="14%" field="classType">班级类型</th>
						<th width="14%" field="payDate">缴费日期</th>
						<th width="14%" field="studentPhone">联系电话</th>
						<th width="14%" field="adviserName">业绩顾问</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="toolManbar" style="padding: 2px; height: auto">
			<a href="javascript:void(0)" id="manBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="manFunc()">确定</a>
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="backFunc()">返回</a>
		</div>
		<script type="text/javascript">
			$.post("<%=path %>/pubData/qrySchoolList.do",function(data){
				$("#schoolManId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/shortBus/getShortClassTypeList.do?typeName="+encodeURI("${param.classType}"),function(data){
				$("#shortClassType").combobox("loadData",data);
			},"json");
			$(document).ready(function(){
				$("#schoolManId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto'
				});
				$("#shortClassType").combobox({
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
				var obj = $("#manFm").serializeObject();
				obj["queryCode"] = "qryInterChoiceClassList";
				obj["funcNodeId"] = "38111";
				obj = JSON.stringify(obj);
				$("#studentList").datagrid({
					url:"/sys/pubData/qryDataListByPage.do",
					queryParams:{
						param : obj
					}
				});
			}
			function resetFunc()
			{
				$("#shortClassType").combobox("setValue","");
				$("#schoolManId").combobox("setValue","");
				$("#openStartManTime").datebox("setValue","");
				$("#openEndManTime").datebox("setValue","");
				$("#studentName").textbox("setValue","");
				$("#phoneNum").textbox("setValue","");
			}
			function manFunc()
			{
				var row = $("#studentList").datagrid('getSelected');
				if (row)
				{
					var json = {
						shortClassInstId:"${param.shortClassInstId}",
						studentId:row.studentId,
						studentCourseId:row.studentCourseId,
						schoolId:row.schoolId,
						handlerId:${sessionScope.StaffT.staffId}
					}
					$.post("/sys/shortBus/addShortStudentTInfo.do",{json:JSON.stringify(json)},function(data){
						if(data == "success")
						{
							backFunc();
						}
						else
						{
							$.messager.alert('提示',"学员选课失败:"+data,"error");		
						}
					});
				}
				else
				{
					$.messager.alert('提示',"请先选择要选课的学员");
				}
			}
			function backFunc()
			{
				//window.location.href = "/sys/shortBus/shortClassManInfo.do?funcNodeId=${param.funcNodeId}&shortClassInstId=${param.shortClassInstId}";
				window.location.href = "/sys/shortBus/accessShortClassPage.do?funcNodeId=${param.funcNodeId}&shortClassInstId=${param.shortClassInstId}&pageName=${param.pageName}&classType="+encodeURI("${param.classType}");
			}
		</script>
 	</body>
</html>