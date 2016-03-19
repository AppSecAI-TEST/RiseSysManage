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
		<script type="text/javascript">
			ajaxLoadEnd();
			$(document).ready(function(){
				var classRoomIdData = '${roomList}';
				var attRecordSchoolIdData = '${schoolList}';
				var attRecordClassType = '${teacherTypeList}';
				classRoomIdData = eval("("+classRoomIdData+")");
				attRecordSchoolIdData = eval("("+attRecordSchoolIdData+")");
				attRecordClassType = eval("("+attRecordClassType+")");
				$(document).ready(function(){
					$("#classRoomId").combobox("setValue","${shortSchooltimeT.roomId}");
					$("#startTime").timespinner("setValue","${shortSchooltimeT.startTime}");
					$("#endTime").timespinner("setValue","${shortSchooltimeT.endTime}");
					$("#classLessonHour").textbox("setValue","${shortSchooltimeT.lessionHours}");
				});
				$("#classRoomId").combobox({
					formatter:formatRoom, 
					valueField: 'roomId', 
					textField: 'roomName', 
					panelHeight: 'auto',
					editable:false,
					data:classRoomIdData,
					onLoadSuccess:function(data){
						$("#classRoomId").combobox("setValue","${schooltimeInstT.roomId}");
					}
				});
				$("#attRecordSchoolId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto',
					//listHeight:150,
					editable:false,
					data:attRecordSchoolIdData,
					onChange:function(value){
						$("#attRecordTeacherId").combobox("setValue","");
						$.post("/sys/pubData/getTeacherBySchoolId.do",{schoolId:value},function(data){
							$("#attRecordTeacherId").combobox("loadData",data);
						},"json");
					}
				});
				$("#attRecordTeacherId").combobox({
					formatter:function(row){
						return "<span>"+row.byName+"</span>";
					},
					valueField: 'teacherId', 
					textField: 'byName', 
					//panelHeight: 'auto',
					listHeight:150,
					editable:false
				});
				$("#attRecordClassType").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto',
					editable:false,
					data:attRecordClassType
				});
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
				else if(isNaN(attRecordLessonHour))
				{
					$.messager.alert('提示',"课时量输入不合法请核实后重新尝试");
				}
				else
				{
					var teacherFlag = true;
					var teacherTime = 0;
					var teacherTaTime = 0;
					$("#teacherTab tr:gt(1) td:nth-child(1)").each(function(i,node){
						if($(node).attr("teacherId") == attRecordTeacherId)
						{
							teacherFlag = false;
						}
						if($(node).attr("teacherType") == 'T')
						{
							teacherTime += parseInt($(node).attr("hours"));
						}
						if($(node).attr("teacherType") == 'TA')
						{
							teacherTaTime += parseInt($(node).attr("hours"));
						}
					});
					if($("#classLessonHour").textbox("getValue") != "" && !isNaN($("#classLessonHour").textbox("getValue")) && attRecordClassType == "T" && parseInt(attRecordLessonHour)+teacherTime > parseInt($("#classLessonHour").textbox("getValue")))
					{
						$.messager.alert('提示',"添加老师课时量已超过课程总课时量,不能再添加老师");
						return ;
					}
					if(teacherTaTime+parseInt(attRecordLessonHour) > parseInt($("#classLessonHour").textbox("getValue")) && attRecordClassType == "TA")
					{
						$.messager.alert('提示',"添加老师课时量已超过课程总课时量,不能再添加老师");
						return ;
					}
					if(teacherFlag)
					{
						ajaxLoading("正在处理，请稍待。。。");
						$.post("/sys/teacherManage/getTeacherInfo.do",{teacherId:attRecordTeacherId},function(data){
							ajaxLoadEnd();
							var trData = "<tr id='teacherId"+data.teacherId+"'><td align='right' teacherId='"+data.teacherId+"' schoolId='"+data.schoolId+"' teacherType='"+$("#attRecordClassType").combobox("getText")+"' hours='"+attRecordLessonHour+"'>老师：</td><td align='center'>"+$("#attRecordSchoolId").combobox("getText")+"</td><td align='center'>"+$("#attRecordTeacherId").combobox("getText")+"</td><td align='center'>"+$("#attRecordClassType").combobox("getText")+"</td><td align='center'>"+attRecordLessonHour+"</td><td align='center'><a href='javascript:void(0)' onclick='delTeacherFunc("+data.teacherId+")'>删除</a></td></tr>";
							$("#teacherTab tr:last").after(trData);
						},"json");
					}
					else
					{
						$.messager.alert('提示',"当前老师已存在,不能重复添加");
					}
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
				var classLessonHour = $("#classLessonHour").textbox("getValue");
				var startTime = $("#startTime").timespinner("getValue");
				var endTime = $("#endTime").timespinner("getValue");
				var obj = {
					shortClassInstId:"${shortSchooltimeT.shortClassInstId}",
					shortSchooltimeId:"${shortSchooltimeT.shortSchooltimeId}",
					schoolId:"${shortClassInstT.schoolId}",
					startTime:startTime,
					endTime:endTime,
					hours:classLessonHour,
					roomId:$("#classRoomId").combobox("getValue"),
					handerId:"${sessionScope.StaffT.staffId}",
					schooltime:'<fmt:formatDate value="${shortSchooltimeT.schooltime}" pattern="yyyy-MM-dd" />',
					attendDate:'<fmt:formatDate value="${shortSchooltimeT.schooltime}" pattern="yyyy-MM-dd" />',
					teacherAttendList:null,
					studentAttendList:null
				};
				var teacherArr = [];
				var teacherTime = 0;
				var teacherTaTime = 0;
				$("#teacherTab tr:gt(1) td:nth-child(1)").each(function(i,node){
					var teacherObj = {
						shortClassInstId:"${shortSchooltimeT.shortClassInstId}",
						teacherId:$(node).attr("teacherId"),
						schoolId:$(node).attr("schoolId"),
						attendDate:'<fmt:formatDate value="${shortSchooltimeT.schooltime}" pattern="yyyy-MM-dd" />',
						teacherType:$(node).attr("teacherType"),
						lessionHours:$(node).attr("hours"),
						handerId:"${sessionScope.StaffT.staffId}"
					};
					teacherArr.push(teacherObj);
					if($(node).attr("teacherType") == 'T')
					{
						teacherTime += parseInt($(node).attr("hours"));
					}
					if($(node).attr("teacherType") == 'TA')
					{
						teacherTaTime += parseInt($(node).attr("hours"));
					}
				});
				obj.teacherAttendList = teacherArr;
				var studentArr = [];
				$("#studentTab tr:gt(0)").each(function(i,node){
					var attendTypeObj = $(node).find("input[name='attendType"+$(node).attr("studentId")+"']:checked").val();
					var studentObj = {
						shortClassInstId:"${shortSchooltimeT.shortClassInstId}",
						schoolId:$(node).attr("schoolId"),
						studentId:$(node).attr("studentId"),
						attendDate:'<fmt:formatDate value="${shortSchooltimeT.schooltime}" pattern="yyyy-MM-dd" />',
						studentCourseId:$(node).attr("studentCourseId"),
						hours:$("#classLessonHour").textbox("getValue"),
						attendType:attendTypeObj,
						handlerId:"${sessionScope.StaffT.staffId}"
					};
					studentArr.push(studentObj);
				});
				obj.studentAttendList = studentArr;
				if(startTime == "")
				{
					$.messager.alert('提示',"上课起始时间不能为空,请核实后重新尝试","warning");
				}
				else if(endTime == "")
				{
					$.messager.alert('提示',"上课结束时间不能为空,请核实后重新尝试","warning");
				}
				else if(classLessonHour == "")
				{
					$.messager.alert("提示", "课程总课时不能为空,请核实后重新尝试","warning");
				}
				else if(isNaN(classLessonHour))
				{
					$.messager.alert("提示", "课程总课时输入不合法,请核实后重新尝试","warning");
				}
				else if(classLessonHour <= 0)
				{
					$.messager.alert('提示',"上课结束时间必须大于上课起始时间,请核实后重新尝试","warning");
				}
				else if(teacherTime+teacherTaTime > classLessonHour)
				{
					$.messager.alert("提示", "老师课时量已超过课程总课时量,请核实后重新尝试","warning");
				}
				else if(teacherArr.length == 0)
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
					ajaxLoading("正在处理，请稍待。。。");
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
  	</head>
  	<body class="manage">
		<table class="tab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" width="10%">上课时间：</td>
				<td>周${shortSchooltimeT.weekTime} <fmt:formatDate value="${shortSchooltimeT.schooltime}" pattern="yyyy-MM-dd" /> <input class="easyui-timespinner" id="startTime" name="startTime" style="width:70px;height: 25px;"  data-options="showSeconds:false">&nbsp;&nbsp;<input class="easyui-timespinner" id="endTime" name="endTime" style="width:70px;height: 25px;"  data-options="showSeconds:false"></td>
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
					<td align="center">${node.teacherT.byName}</td>
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
 	</body>
</html>