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
		<script type="text/javascript">
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=815&fieldId=schoolId",function(data){
				$("#schoolRoomId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qrySchoolListWithTS.do",function(data){
				$("#schoolId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=ACTION_T&codeType=TEACHER_TYPE",function(data){
				$("#teacherType").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=STAGE_ID",function(data){
				$("#classPharse").combobox("loadData",data);
				ajaxLoadEnd();
			},"json");
			$(document).ready(function(){
				$("#roomList").combobox({
					formatter:formatRoom, 
					valueField: 'roomId', 
					textField: 'roomName',
					editable:false,
					panelHeight: 'auto'
				});
				$("#teacherType").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName',
					editable:false,
					panelHeight: 'auto'
				});
				$("#classPharse").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName',
					editable:false,
					panelHeight: 'auto'
				});
				$("#teacherId").combobox({
					formatter:function(row){
						return "<span>"+row.byName+"</span>"
					},
					valueField: 'teacherId', 
					textField: 'byName', 
					//panelHeight: 'auto',
					listHeight:150,
					editable:false
				});
				$("#schoolId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto',
					//listHeight:150,
					editable:false,
					onChange:function(value){
						$("#teacherId").combobox("setValue","");
						$.post("<%=path %>/pubData/getTeacherBySchoolId.do",{schoolId:value},function(data){
							$("#teacherId").combobox("loadData",data);
						},"json");
					},
					onLoadSuccess:function(data){
						if(data.length > 0)
						{
							$("#schoolId").combobox("setValue",data[0].schoolId);
						}
					}
				});
				$("#schoolRoomId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto',
					//listHeight:150,
					editable:false,
					onChange:function(value){
						$("#roomList").combobox("setValue","");
						$.post("<%=path %>/pubData/qryRoomList.do",{schoolId:value},function(data){
							$("#roomList").combobox("loadData",data);
						},"json");
					},
					onLoadSuccess:function(data){
						if(data.length > 0)
						{
							$("#schoolRoomId").combobox("setValue",data[0].schoolId);
						}
					}
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
					var teacherFlag = true;
					$(".teacherId").each(function(i,node){
						var teacherObj = $(node).find("td:eq(0)");
						if(teacherObj.attr("teacherId") == teacherId)
						{
							teacherFlag = false;
						}
					});
					if(teacherFlag)
					{
						ajaxLoading("正在处理，请稍待。。。");
						$.post("/sys/teacherManage/getTeacherInfo.do",{teacherId:teacherId},function(data){
							ajaxLoadEnd();
							var trData = "<tr id='teacherId"+data.teacherId+"' class='teacherId'><td align='right' teacherId='"+data.teacherId+"' teacherName='"+$("#teacherId").combobox("getText")+"' teacherType='"+$("#teacherType").combobox("getText")+"' schoolId='"+data.schoolId+"'>老师：</td><td align='center'>"+$("#schoolId").combobox("getText")+"</td><td align='center'>"+$("#teacherId").combobox("getText")+"</td><td align='center'>"+$("#teacherType").combobox("getText")+"</td><td align='center'><a href='javascript:void(0)' onclick='delTeacherFunc("+data.teacherId+")'>删除</a></td></tr>";
							$(".tab tr:last").after(trData);
						},"json");
					}
					else
					{
						$.messager.alert('提示',"该老师已经被添加,请核实后重新尝试");
					}
				}
			}
			function addSubmitFunc()
			{
				var schooltimeDate = $("#schooltimeDate").datebox("getValue");
				var startTime = $("#startTime").timespinner("getValue");
				var endTime = $("#endTime").timespinner("getValue");
				var roomList = $("#roomList").combobox("getValue");
				var lessonHour = $("#lessonHour").textbox("getValue");
				var stageId = $("#classPharse").combobox("getValue");
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
				else if(startTime == "")
				{
					$.messager.alert('提示',"排课起始时间不能为空,请核实后重新尝试","info");
				}
				else if(endTime == "")
				{
					$.messager.alert('提示',"排课结课时间不能为空,请核实后重新尝试","info");
				}
				else if(stageId == "")
				{
					$.messager.alert('提示',"请先选择课程阶段后重新尝试");
				}
				else if(roomList == "")
				{
					$.messager.alert('提示',"排课教室不能为空,请核实后重新尝试","info");
				}
				else if(lessonHour == "")
				{
					$.messager.alert('提示',"排课课时不能为空,请核实后重新尝试","info");
				}
				else if(isNaN(lessonHour))
				{
					$.messager.alert('提示',"排课课时不合法,请核实后重新尝试","info");
				}
				else if(parseInt(lessonHour) <= 0)
				{
					$.messager.alert('提示',"排课结课时间必须大于排课起始时间,请核实后重新尝试","info");
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
						startTime:startTime,
						endTime:endTime,
						lessionHours:lessonHour,
						handlerId:${sessionScope.StaffT.staffId},
						classTeacherList:arr
					};
					ajaxLoading("正在处理，请稍待。。。");
					$.post("/sys/shortBus/addDirectShortClassInstInfo.do",{json:JSON.stringify(json),classType:encodeURI("${param.classType}"),schoolId:$("#schoolRoomId").combobox("getValue"),stageId:stageId},function(data){
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
  	</head>
  	<body class="manage">
		<div class="panel datagrid easyui-fluid" style="width:99%">
		  <div class="panel-header">
		    <div class="panel-title">新增外教课</div>
		    <div class="panel-tool"></div>
		  </div>
		</div>
		<table align="center" class="tab" style="width:99%;margin:0 auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" width="10%">日期：</td>
				<td width="35%" colspan="4">
					<input name="schooltimeDate" id="schooltimeDate" type="text" style="width:150px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" />&nbsp;&nbsp;
					<input class="easyui-timespinner" id="startTime" name="startTime" style="width:70px;height: 25px;"  data-options="showSeconds:false">&nbsp;&nbsp;<input class="easyui-timespinner" id="endTime" name="endTime" style="width:70px;height: 25px;"  data-options="showSeconds:false"></select>
				</td>
			</tr>
			<tr>
				<td align="right">教室：</td>
				<td colspan="4">
					<select id="schoolRoomId" name="schoolRoomId" style="width:150px" ></select>&nbsp;&nbsp;
					<select id="roomList" name="roomList" style="width:150px" ></select>
				</td>
			</tr>
			<tr>
				<td align="right">课程阶段：</td>
				<td colspan="4"><select id="classPharse" name="classPharse" style="width:150px" ></select></td>
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
 	</body>
</html>