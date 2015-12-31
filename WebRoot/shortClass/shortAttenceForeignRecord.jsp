<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		<table class="tab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" width="10%">上课时间：</td>
				<td>周${shortSchooltimeT.weekTime} <fmt:formatDate value="${shortSchooltimeT.schooltime}" pattern="yyyy-MM-dd" /> <select id="classTime" name="classTime" style="width:200px" ></select></td>
			</tr>
			<tr>
				<td align="right">教室：</td>
				<td><select id="classRoomId" name="classRoomId" style="width:200px" ></select></td>
			</tr>
			<tr>
				<td align="right">课时：</td>
				<td><input name="classLessonHour" id="classLessonHour" type="text" style="width:200px" class="easyui-textbox" /></td>
			</tr>
		</table>
		<table class="tab" id="teacherTab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr class="headTr">
				<td>&nbsp;</td>
				<td>校区</td>
				<td>姓名</td>
				<td>课时类型</td>
				<td>课时量</td>
				<td>操作</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="center"><select id="attRecordSchoolId" name="attRecordSchoolId" style="width:150px" ></select></td>
				<td align="center"><select id="attRecordTeacherId" name="attRecordTeacherId" style="width:150px" ></select></td>
				<td align="center"><select id="attRecordClassType" name="attRecordClassType" style="width:150px" ></select></td>
				<td align="center"><input name="attRecordLessonHour" id="attRecordLessonHour" type="text" style="width:150px" class="easyui-textbox" /></td>
				<td align="center" width="15%"><a href="javascript:void(0)" id="addTeacherBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="addAttendTeacher()">添加</a></td>
			</tr>
			<c:forEach items="${shortSchooltimeT.classTeacherList}" var="node">
				<tr id="teacherId${node.teacherId}">
					<td align="right" teacherId="${node.teacherId}" schoolId="${node.schoolId}" teacherType="${node.teacherType}" hours="${node.lessionHours}">老师：</td>
					<td align="center">${node.schoolT.schoolName}</td>
					<td align="center">${node.teacherT.teacherName}</td>
					<td align="center">${node.teacherType}</td>
					<td align="center">${node.lessionHours}</td>
					<td align="center"><a href="javascript:void(0)" onclick="delTeacherFunc(${node.teacherId})">删除</a></td>
				</tr>
			</c:forEach>
		</table>
		<table class="tab" id="studentTab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr class="headTr">
				<td width="5%">序号</td>
				<td width="15%">校区</td>
				<td width="15%">学员姓名</td>
				<td width="15%">英文名</td>
				<td width="50%">考勤操作</td>
			</tr>
			<c:forEach items="${shortClassInstT.classStudentList}" var="node" varStatus="i">
				<tr id="studentId${node.studentId}" studentId="${node.studentId}" studentCourseId="${node.studentCourseId}" schoolId="${node.schoolId}">
					<td align="center">${i.count}</td>
					<td align="center">${node.studentT.schoolT.schoolName}</td>
					<td align="center">${node.studentT.name}</td>
					<td align="center">${node.studentT.byName}</td>
					<td align="center"><input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}1" value="N" checked="checked" /><label for="attendType${node.studentId}1">已到</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}2" value="T" /><label for="attendType${node.studentId}2">未到</label></td>
				</tr>
			</c:forEach>
		</table>
		<div style="margin:0 auto;padding:0 0;text-align:right;padding-right:2px;width:99%;margin-top:10px">
			<a href="javascript:void(0)" id="enterBtn" class="easyui-linkbutton" iconCls="icon-ok" style="width: 100px;" onclick="attendSubmit()">提交</a>
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
		</div>
		<script type="text/javascript">
			$(document).ready(function(){
				var classTimeData = '${hourRangeList}';
				var classRoomIdData = '${roomList}';
				var attRecordSchoolIdData = '${schoolList}';
				var attRecordClassType = '${teacherTypeList}';
				classTimeData = eval("("+classTimeData+")");
				classRoomIdData = eval("("+classRoomIdData+")");
				attRecordSchoolIdData = eval("("+attRecordSchoolIdData+")");
				attRecordClassType = eval("("+attRecordClassType+")");
				$(document).ready(function(){
					$("#classTime").combobox("setValue","${shortSchooltimeT.hourRange}");
					$("#classRoomId").combobox("setValue","${shortSchooltimeT.roomId}");
					$("#classLessonHour").textbox("setValue","${shortSchooltimeT.lessionHours}");
				});
				$("#classTime").combobox({
					formatter:formatParaConfig, 
					valueField: 'paramValue', 
					textField: 'paramDesc', 
					panelHeight: 'auto',
					data:classTimeData,
					onLoadSuccess:function(data){
						$("#classTime").combobox("setValue","${schooltimeInstT.hourRange}");
					}
				});
				$("#classRoomId").combobox({
					formatter:formatRoom, 
					valueField: 'roomId', 
					textField: 'roomName', 
					panelHeight: 'auto',
					data:classRoomIdData,
					onLoadSuccess:function(data){
						$("#classRoomId").combobox("setValue","${schooltimeInstT.roomId}");
					}
				});
				$("#attRecordSchoolId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					//panelHeight: 'auto',
					listHeight:150,
					data:attRecordSchoolIdData,
					onSelect:function(data){
						$("#attRecordTeacherId").combobox("setValue","");
						$.post("/sys/pubData/getTeacherBySchoolId.do",{schoolId:data.schoolId},function(data){
							$("#attRecordTeacherId").combobox("loadData",data);
						},"json");
					}
				});
				$("#attRecordTeacherId").combobox({
					formatter:formatTeacherName,
					valueField: 'teacherId', 
					textField: 'teacherName', 
					//panelHeight: 'auto',
					listHeight:150
				});
				$("#attRecordClassType").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto',
					data:attRecordClassType
				});
				$("#classLessonHour").textbox("setValue","${schooltimeInstT.lessionHours}");
			});
			
			function addAttendTeacher()
			{
				var attRecordSchoolId = $("#attRecordSchoolId").combobox("getValue");
				var attRecordTeacherId = $("#attRecordTeacherId").combobox("getValue");
				var attRecordClassType = $("#attRecordClassType").combobox("getValue");
				var attRecordLessonHour = $("#attRecordLessonHour").textbox("getValue");
				if(attRecordTeacherId == "")
				{
					$.messager.alert('提示',"请先选择老师后重新尝试");
				}
				else if(attRecordClassType == "")
				{
					$.messager.alert('提示',"请先选择课时类型后重新尝试");
				}
				else if(attRecordLessonHour == "")
				{
					$.messager.alert('提示',"请先输入课时量后重新尝试");
				}
				else
				{
					ajaxLoading("添加中...");
					$.post("/sys/teacherManage/getTeacherInfo.do",{teacherId:attRecordTeacherId},function(data){
						ajaxLoadEnd();
						var trData = "<tr id='teacherId"+data.teacherId+"'><td align='right' teacherId='"+data.teacherId+"' schoolId='"+data.schoolId+"' teacherType='"+$("#attRecordClassType").combobox("getText")+"' hours='"+attRecordLessonHour+"'>老师：</td><td align='center'>"+$("#attRecordSchoolId").combobox("getText")+"</td><td align='center'>"+$("#attRecordTeacherId").combobox("getText")+"</td><td align='center'>"+$("#attRecordClassType").combobox("getText")+"</td><td align='center'>"+attRecordLessonHour+"</td><td align='center'>"+(data.teacherLicenseList.length>0?"已持证":"未持证")+"</td><td align='center'><a href='javascript:void(0)' onclick='delTeacherFunc("+data.teacherId+")'>删除</a></td></tr>";
						$("#teacherTab tr:last").after(trData);
					},"json");
				}
			}
			
			function delTeacherFunc(val)
			{
				 $.messager.confirm("提示", "您确定要删除该老师吗？", function (data) {
		            if (data) {
		                $("#teacherId"+val).remove();
		            }
		        });
			}
			
			function attendSubmit()
			{
				var obj = {
					shortClassInstId:"${shortSchooltimeT.shortClassInstId}",
					shortSchooltimeId:"${shortSchooltimeT.shortSchooltimeId}",
					schoolId:"${shortClassInstT.schoolId}",
					hourRange:$("#classTime").combobox("getValue"),
					hours:$("#classLessonHour").textbox("getValue"),
					roomId:$("#classRoomId").combobox("getValue"),
					handerId:"${sessionScope.StaffT.staffId}",
					schooltime:'<fmt:formatDate value="${shortSchooltimeT.schooltime}" pattern="yyyy-MM-dd" />',
					teacherAttendList:null,
					studentAttendList:null
				};
				var teacherArr = [];
				$("#teacherTab tr:gt(1) td:nth-child(1)").each(function(i,node){
					var teacherObj = {
						shortClassInstId:"${shortSchooltimeT.shortClassInstId}",
						teacherId:$(node).attr("teacherId"),
						schoolId:$(node).attr("schoolId"),
						teacherType:$(node).attr("teacherType"),
						lessionHours:$(node).attr("hours"),
						handerId:"${sessionScope.StaffT.staffId}"
					};
					teacherArr.push(teacherObj);
				});
				obj.teacherAttendList = teacherArr;
				var studentArr = [];
				$("#studentTab tr:gt(0)").each(function(i,node){
					var attendTypeObj = $(node).find("input[name='attendType"+$(node).attr("studentId")+"']:checked").val();
					var studentObj = {
						shortClassInstId:"${shortSchooltimeT.shortClassInstId}",
						schoolId:$(node).attr("schoolId"),
						studentId:$(node).attr("studentId"),
						studentCourseId:$(node).attr("studentCourseId"),
						hours:$("#classLessonHour").textbox("getValue"),
						attendType:attendTypeObj,
						handlerId:"${sessionScope.StaffT.staffId}"
					};
					studentArr.push(studentObj);
				});
				obj.studentAttendList = studentArr;
				if(teacherArr.length == 0)
				{
					$.messager.alert("提示", "老师人数不能为零,请添加老师后重新尝试","warning");
				}
				else if(studentArr.length == 0)
				{
					$.messager.alert("提示", "学生人数不能为零,请添加学生后重新尝试","warning");
				}
				else
				{
					var json = JSON.stringify(obj);
					ajaxLoading("提交中...");
					$.post("/sys/shortBus/addShortAttendTInfo.do",{json:json},function(data){
						ajaxLoadEnd();
						if(data == "success")
						{
							$.messager.alert("提示", "反馈成功","info",function(){
								backFunc();
							});
						}
						else
						{
							try{
								var dataObj = eval("("+data+")");
								$.messager.alert("提示", dataObj.msg,"error");
							}catch(e){
								$.messager.alert("提示", data,"error");
							}
						}
					});
				}
			}
			
			function backFunc()
			{
				window.location.href = "/sys/shortClass/attenceForeignMan.jsp?funcNodeId=${funcNodeId}";
			}
		</script>
 	</body>
</html>