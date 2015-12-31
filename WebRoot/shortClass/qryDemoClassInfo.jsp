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
			<table align="center" style="min-width:1200px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:5px auto;height:80px;" cellspacing="2">
				<tr>
					<td align="right" width="10%">
						校区：
					</td>
					<td width="10%">
						<select id="schoolId" name="schoolId" style="width:120px;" ></select>
					</td>
					<td align="right" width="10%">	
						班级状态：
					</td>
					<td width="10%">
						<select id="classState" name="classState" class="easyui-combobox" style="width:120px;">
      					</select>
					</td>
					<td align="right" width="10%">
						上课日期：
					</td>
					<td width="25%">
						<input name="schoolStartTime" id="schoolStartTime" type="text" style="width:120px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />&nbsp;至&nbsp;<input name="schoolendTime" id="schoolendTime" type="text" style="width:120px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />
					</td>
					<td>
					</td>
				</tr>
				<tr>
					<td align="right">
						DEMO T：
					</td>
					<td>
						<select id="demoT" name="demoT" class="easyui-combobox" style="width:120px;" ></select>								
					</td>
					<td align="right">
						DEMO Ta：
					</td>
					<td>
						<select id="demoTa" name="demoTa" class="easyui-combobox" style="width:120px;" ></select>				
					</td>
					<td align="right" colspan="2">
						<a href="javascript:void(0)" id="queryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="">重置</a>
					</td>
					<td></td>
				</tr>
			</table>
		</form>
		<div style="padding:5px 0;min-width:1100px; width:100%">
			<table class="easyui-datagrid" title="排课列表" style="height:550px" id="manList" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th width="1%" align="center" data-options="field:'shortClassInstId',checkbox:true"></th>
						<th width="12%" align="center" field="schoolName">校区</th>
						<th width="18%" align="center" field="schoolDate">上课时间</th>
						<th width="14%" align="center" field="classStateVal">班级状态</th>
						<th width="14%" align="center" field="demoT">计划Demo T</th>
						<th width="14%" align="center" field="demoTa">计划Demo TA</th>
						<th width="15%" align="center" field="createDate">创建时间</th>
						<th width="12%" align="center" field="handlerName">创建人</th>
					</tr>
				</thead>
			</table>
			<div id="toolbar">
	   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addClassManage()">排课管理</a>
	 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" onclick="cancleDemoClass()">取消排课</a>
 			</div>
		</div>
		<script type="text/javascript">
			ajaxLoading("加载中...");
			$.post("<%=path %>/pubData/qrySchoolList.do",function(data){
				$("#schoolId").combobox("loadData",data);
				ajaxLoadEnd();
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=DEMO&codeType=CLASS_STATE",function(data){
				$("#classState").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryData.do?param={'queryCode':'qryDemoTeacherInfo','teacherType':'T'}",function(data){
				$("#demoT").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryData.do?param={'queryCode':'qryDemoTeacherInfo','teacherType':'TA'}",function(data){
				$("#demoTa").combobox("loadData",data);
				ajaxLoadEnd();
			},"json");
			$(document).ready(function(){
				$("#schoolId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto'
				});
				$("#classState").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
				$("#demoT").combobox({
					formatter:formatTeacher, 
					valueField: 'teacherId', 
					textField: 'byname', 
					panelHeight: 'auto'
				});
				$("#demoTa").combobox({
					formatter:formatTeacher, 
					valueField: 'teacherId', 
					textField: 'byname', 
					panelHeight: 'auto'
				});
			});
			function queryFunc()
			{
				var obj = $("#manFm").serializeObject();
				obj["queryCode"] = "qryDemoClassInfo";
				obj["funcNodeId"] = "4620";
				obj = JSON.stringify(obj);
				$("#manList").datagrid({
					url:"/sys/pubData/qryDataListByPage.do",
					queryParams:{
						param : obj
					}
				});
			}
			function addClassManage()
			{
				window.location.href = "/sys/shortClass/addDemoClass.jsp";
			}
			function cancleDemoClass()
			{
				if(validateSelect("manList")) {
					var row = $("#manList").datagrid('getSelected');
					var classStateVal = row.classStateVal;
					if(classStateVal == "取消"){
						 $.messager.alert('提示', "该DEMO课已经取消排课！");
						   return;
					}
					$.messager.confirm("提示", "您确定要取消该DEMO课吗？", function (data) {
			            if(data){
			            	ajaxLoading("取消中...");
			            	$.post("/sys/shortBus/cancelShortClassFunc.do",{shortClassInstId:row.shortClassInstId,remark:"",handleId:${sessionScope.StaffT.staffId}},function(data){
			                	ajaxLoadEnd();
			                	if(data == "success")
			                	{
			                		window.location.reload();
			                	}
			                	else
			                	{
			                		$.messager.alert('提示',"取消DEMO课失败:"+data,"error");
			                	}
			                });
			            }
		       	 	});
				}
			}
			function validateSelect(object)
			{
				var flag = false;
				var obj = $("#"+object+"").datagrid('getSelections');
				if(obj.length > 0) {
					if(obj.length > 1) {
						$.messager.alert('提示', "只能选择一个DEMO课操作！");
					} else {
						flag = true;
					}
				} else {
					$.messager.alert('提示', "请先选择您要操作的DEMO课！");
				}
				return flag;
			}
		</script>
 	</body>
</html>