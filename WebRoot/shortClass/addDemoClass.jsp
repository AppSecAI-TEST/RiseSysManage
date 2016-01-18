<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  
  	<body class="manage">
		<table align="center" class="tab" style="width:99%;margin:0 auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" width="10%">日期：</td>
				<td width="35%" colspan="4">
					<input name="schooltimeDate" id="schooltimeDate" type="text" style="width:150px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />&nbsp;&nbsp;
					<select id="hourRange" name="hourRange" style="width:150px" ></select>
				</td>
			</tr>
			<tr>
				<td align="right">教室：</td>
				<td colspan="4"><select id="roomList" name="roomList" style="width:150px" ></select></td>
			</tr>
			<tr>
				<td align="right">课时：</td>
				<td colspan="4"><input name="lessonHour" id="lessonHour" type="text" style="width:150px" class="easyui-textbox" /></td>
			</tr>
			<tr>
				<td align="right">老师：</td>
				<td><select id="schoolId" name="schoolId" style="width:150px" ></select></td>
				<td><select id="teacherId" name="teacherId" style="width:150px" ></select></td>
				<td><select id="teacherType" name="teacherType" style="width:150px" ></select></td>
				<td><a href="javascript:void(0)" id="addTeacherBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;" onclick="addTeacherFunc()">添加</a></td>
			</tr>
		</table>
		<div style="margin:0 auto;padding:0 0;text-align:right;padding-right:2px;width:99%;margin-top:10px">
			<a href="javascript:void(0)" id="addSubmitBtn" class="easyui-linkbutton" iconCls="icon-ok" style="width: 100px;" onclick="addSubmitFunc()">提交</a>
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
		</div>
		<script type="text/javascript">
			ajaxLoadEnd();
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=801&fieldId=schoolId",function(data){
				$("#schoolId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryRoomList.do?schoolId=${sessionScope.StaffT.schoolId}",function(data){
				$("#roomList").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryParaConfigList.do?paramType=HOUR_RANGE",function(data){
				$("#hourRange").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=ACTION_T&codeType=TEACHER_TYPE",function(data){
				$("#teacherType").combobox("loadData",data);
			},"json");
			$(document).ready(function(){
				$("#roomList").combobox({
					formatter:formatRoom, 
					valueField: 'roomId', 
					textField: 'roomName',
					panelHeight: 'auto'
				});
				$("#hourRange").combobox({
					formatter:formatParaConfig, 
					valueField: 'paramValue', 
					textField: 'paramDesc',
					panelHeight: 'auto'
				});
				$("#teacherType").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName',
					panelHeight: 'auto'
				});
				$("#schoolId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					//panelHeight: 'auto',
					listHeight:150,
					onSelect:function(data){
						$("#teacherId").combobox("setValue","");
						$.post("/sys/pubData/getTeacherBySchoolId.do",{schoolId:data.schoolId},function(data){
							$("#teacherId").combobox("loadData",data);
						},"json");
					},
					onLoadSuccess:function(data){
						if(data.length > 0)
						{
							$("#schoolId").combobox("setValue",data.schoolId);
						}
					}
				});
				$("#teacherId").combobox({
					formatter:formatTeacherName,
					valueField: 'teacherId', 
					textField: 'teacherName', 
					//panelHeight: 'auto',
					listHeight:150
				});
			});
			function addTeacherFunc()
			{
				var schoolId = $("#schoolId").combobox("getValue");
				var teacherId = $("#teacherId").combobox("getValue");
				var teacherType = $("#teacherType").combobox("getValue");
				if(schoolId == "")
				{
					$.messager.alert('提示',"请先选择校区后重新尝试");
				}
				else if(teacherId == "")
				{
					$.messager.alert('提示',"请先选择老师后重新尝试");
				}
				else if(teacherType == "")
				{
					$.messager.alert('提示',"请先选择老师类型后重新尝试");
				}
				else
				{
					ajaxLoading("添加中...");
					$.post("/sys/teacherManage/getTeacherInfo.do",{teacherId:teacherId},function(data){
						ajaxLoadEnd();
						var trData = "<tr id='teacherId"+data.teacherId+"' class='teacherId'><td align='right' teacherId='"+data.teacherId+"' teacherName='"+$("#teacherId").combobox("getText")+"' teacherType='"+$("#teacherType").combobox("getText")+"' schoolId='"+data.schoolId+"'>老师：</td><td align='center'>"+$("#schoolId").combobox("getText")+"</td><td align='center'>"+$("#teacherId").combobox("getText")+"</td><td align='center'>"+$("#teacherType").combobox("getText")+"</td><td align='center'><a href='javascript:void(0)' onclick='delTeacherFunc("+data.teacherId+")'>删除</a></td></tr>";
						$(".tab tr:last").after(trData);
					},"json");
				}
			}
			function addSubmitFunc()
			{
				var schooltimeDate = $("#schooltimeDate").datebox("getValue");
				var hourRange = $("#hourRange").combobox("getValue");
				var roomList = $("#roomList").combobox("getValue");
				var lessonHour = $("#lessonHour").textbox("getValue");
				var arr = [];
				$(".teacherId").each(function(i,node){
					var teacherObj = $(node).find("td:eq(0)");
					var obj = {
						teacherId:teacherObj.attr("teacherId"),
						teacherType:teacherObj.attr("teacherType"),
						lessionHours:lessonHour,
						schoolId:teacherObj.attr("schoolId"),
						handlerId:${sessionScope.StaffT.staffId},
					};
					arr.push(obj);
				});
				if(schooltimeDate == "")
				{
					$.messager.alert('提示',"排课日期不能为空,请核实后重新尝试","info");
				}
				else if(hourRange == "")
				{
					$.messager.alert('提示',"排课时间范围不能为空,请核实后重新尝试","info");
				}
				else if(roomList == "")
				{
					$.messager.alert('提示',"排课教室不能为空,请核实后重新尝试","info");
				}
				else if(lessonHour == "")
				{
					$.messager.alert('提示',"排课课时不能为空,请核实后重新尝试","info");
				}
				else if(arr.length == 0)
				{
					$.messager.alert('提示',"排课老师不能为空,请添加排课老师","info");
				}
				else
				{
					var json = {
						roomId:roomList,
						schooltime:schooltimeDate,
						hourRange:hourRange,
						lessionHours:lessonHour,
						handlerId:${sessionScope.StaffT.staffId},
						classTeacherList:arr
					};
					ajaxLoading("排课中...");
					$.post("/sys/shortBus/addDirectShortClassInstInfo.do",{json:JSON.stringify(json),classType:encodeURI("DEMO"),schoolId:${sessionScope.StaffT.schoolId},stageId:""},function(data){
						ajaxLoadEnd();
						if(data == "success")
						{
							$.messager.alert('提示',"完成当前排课","",function(){
								backFunc();
							});
						}
						else
						{
							$.messager.alert('提示',"排课失败:"+data,"error");
						}
					})
				}
			}
			function delTeacherFunc(flagVal)
			{
				$("#teacherId"+flagVal).remove();
			}
			function backFunc()
			{
				window.history.back();			
			}
		</script>
 	</body>
</html>