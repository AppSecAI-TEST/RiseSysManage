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
			<input type="hidden" name="classType" id="classType" value="Y" />
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
						<input name="payStartManTime" id="payStartManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> 至 <input name="payEndManTime" id="payEndManTime" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
					</td>
				</tr>
				<tr>
					<td align="right" width="8%">
						所属校区：
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
			<table class="easyui-datagrid" title="学员列表" style="height:390px" id="studentList" toolbar="#toolManbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false">
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
			ajaxLoadEnd();
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=812&fieldId=schoolId",function(data){
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
					panelHeight: 'auto',
					onLoadSuccess:function(data){
						if(data.length > 0)
						{
							$("#schoolManId").combobox("setValue",data[0].schoolId);
						}
					}
				});
				$("#shortClassType").combobox({
					formatter:function(data){
						return '<span>'+data.classType+'</span>';
					}, 
					valueField: 'classType', 
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
				var schoolData = $("#schoolManId").combobox("getData");
				if(schoolData != null && schoolData.length > 0)
				{
					$("#schoolManId").combobox("setValue",schoolData[0].schoolId);
				}
				$("#shortClassType").combobox("setValue","");
				$("#payStartManTime").datebox("setValue","");
				$("#payEndManTime").datebox("setValue","");
				$("#studentName").textbox("setValue","");
				$("#phoneNum").textbox("setValue","");
			}
			function manFunc()
			{
				var rows = $("#studentList").datagrid('getChecked');
				if (rows && rows.length >0)
				{
					var arr = [];
					for(var i = 0,n = rows.length;i < n;i++)
					{
						var json = {
							shortClassInstId:"${param.shortClassInstId}",
							studentId:rows[i].studentId,
							studentCourseId:rows[i].studentCourseId,
							schoolId:rows[i].schoolId,
							handlerId:${sessionScope.StaffT.staffId}
						}
						arr.push(json);
					}
					ajaxLoading("正在处理，请稍待。。。");
					$.post("/sys/shortBus/addShortStudentTInfo.do",{json:JSON.stringify(arr),classType:encodeURI("国际班"),shortClassInstId:"${param.shortClassInstId}"},function(data){
						ajaxLoadEnd();
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
				ajaxLoading("返回中...");
				if("游学" == "${param.classType}")
				{
					window.location.href = "/sys/shortBus/accessShortClassPage.do?funcNodeId=${param.funcNodeId}&shortClassInstId=${param.shortClassInstId}&pageName=${param.pageName}&classType="+encodeURI("${param.classType}");
				}
				else
				{
					window.location.href = "/sys/shortBus/shortClassManInfo.do?funcNodeId=${param.funcNodeId}&shortClassInstId=${param.shortClassInstId}&pageName=${param.pageName}";
				}
			}
		</script>
 	</body>
</html>
