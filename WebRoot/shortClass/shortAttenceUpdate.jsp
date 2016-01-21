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
				<td><fmt:formatDate value="${shortClassAttendT.schooltime}" pattern="yyyy-MM-dd" /> <select id="classTime" name="classTime" style="width:200px" ></select></td>
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
				<td>是否持证</td>
				<td>操作</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="center"><select id="attRecordSchoolId" name="attRecordSchoolId" style="width:150px" ></select></td>
				<td align="center"><select id="attRecordTeacherId" name="attRecordTeacherId" style="width:150px" ></select></td>
				<td align="center"><select id="attRecordClassType" name="attRecordClassType" style="width:150px" ></select></td>
				<td align="center"><input name="attRecordLessonHour" id="attRecordLessonHour" type="text" style="width:150px" class="easyui-textbox" /></td>
				<td>&nbsp;</td>
				<td align="center" width="15%"><a href="javascript:void(0)" id="addTeacherBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="addAttendTeacher()">添加</a></td>
			</tr>
			<c:forEach items="${shortClassAttendT.teacherAttendList}" var="node">
				<tr id="teacherId${node.teacherId}">
					<td align="right" teacherId="${node.teacherId}" shortTeacherAttendId="${node.shortTeacherAttendId}" state="${node.state}" schoolId="${node.schoolId}" teacherType="${node.teacherType}" hours="${node.lessionHours}">老师：</td>
					<td align="center">${node.teacherT.schoolT.schoolName}</td>
					<td align="center">${node.teacherT.byName}</td>
					<td align="center">${node.teacherType}</td>
					<td align="center">${node.lessionHours}</td>
					<td align="center">
						<c:choose>
							<c:when test="${fn:length(node.teacherT.teacherLicenseList) == 0}">
								未持证
							</c:when>
							<c:otherwise>
								已持证
							</c:otherwise>
						</c:choose>
					</td>
					<td align="center"><a href="javascript:void(0)" onclick="delTeacherFunc(${node.teacherId})">删除</a></td>
				</tr>
			</c:forEach>
		</table>
		<table class="tab" id="studentTab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr class="headTr">
				<td width="3%"><input type="checkbox" name="studentId" id="studentAllId" value="" onclick="checkAllStudentFunc(this)" /></td>
				<td width="3%">序号</td>
				<td width="10%">学员姓名</td>
				<td width="10%">英文名</td>
				<td width="50%">考勤操作</td>
				<td width="16%">校服着装情况</td>
			</tr>
			<c:forEach items="${shortClassAttendT.studentAttendList}" var="node" varStatus="i">
				<tr id="studentId${node.studentId}">
					<td align="center" studentId="${node.studentId}" schoolId="${node.schoolId}" shortStudentAttendId="${node.shortStudentAttendId}" studentCourseId="${node.studentCourseId}"><input type="checkbox" name="studentId" value="${node.studentId}" onclick="studentCheckboxClick(this)" /></td>
					<td align="center">${i.count}</td>
					<td align="center">${node.studentT.name}</td>
					<td align="center">${node.studentT.byName}</td>
					<td align="center">
						<c:choose>
							<c:when test="${node.attendType=='N'}">
								<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}1" value="N" checked="checked" /><label for="attendType${node.studentId}1">正常上课</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}2" value="B" /><label for="attendType${node.studentId}2">迟到</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}3" value="L" /><label for="attendType${node.studentId}3">请假</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}4" value="T" /><label for="attendType${node.studentId}4">旷课</label>&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-filebox" name="uploadAttenceLeave${node.studentId}" data-options="prompt:'',buttonText:'上传请假单'" style="width:200px">
							</c:when>
							<c:when test="${node.attendType=='B'}">
								<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}1" value="N" /><label for="attendType${node.studentId}1">正常上课</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}2" value="B" checked="checked" /><label for="attendType${node.studentId}2">迟到</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}3" value="L" /><label for="attendType${node.studentId}3">请假</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}4" value="T" /><label for="attendType${node.studentId}4">旷课</label>&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-filebox" name="uploadAttenceLeave${node.studentId}" data-options="prompt:'',buttonText:'上传请假单'" style="width:200px">
							</c:when>
							<c:when test="${node.attendType=='L'}">
								<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}1" value="N" /><label for="attendType${node.studentId}1">正常上课</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}2" value="B" /><label for="attendType${node.studentId}2">迟到</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}3" value="L" checked="checked" /><label for="attendType${node.studentId}3">请假</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}4" value="T" /><label for="attendType${node.studentId}4">旷课</label>&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-filebox" name="uploadAttenceLeave${node.studentId}" data-options="prompt:'',buttonText:'上传请假单'" style="width:200px">
							</c:when>
							<c:when test="${node.attendType=='T'}">
								<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}1" value="N" /><label for="attendType${node.studentId}1">正常上课</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}2" value="B" /><label for="attendType${node.studentId}2">迟到</label>&nbsp;<input type="radio" name="attendType" id="attendType${node.studentId}3" value="L" /><label for="attendType${node.studentId}3">请假</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}4" value="T" checked="checked" /><label for="attendType${node.studentId}4">旷课</label>&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-filebox" name="uploadAttenceLeave${node.studentId}" data-options="prompt:'',buttonText:'上传请假单'" style="width:200px">
							</c:when>
						</c:choose>
					</td>
					<td align="center">
						<c:choose>
							<c:when test="${node.dress == 'N'}">
								<input type="radio" name="dress${node.studentId}" id="dress${node.studentId}2" value="Y" /><label for="dress${node.studentId}2">已穿校服</label>&nbsp;&nbsp;<input type="radio" name="dress${node.studentId}" id="dress${node.studentId}1" value="N" checked="checked" /><label for="dress${node.studentId}1">未穿校服</label>
							</c:when>
							<c:when test="${node.dress == 'Y'}">
								<input type="radio" name="dress${node.studentId}" id="dress${node.studentId}2" value="Y" checked="checked" /><label for="dress${node.studentId}2">已穿校服</label>&nbsp;&nbsp;<input type="radio" name="dress${node.studentId}" id="dress${node.studentId}1" value="N" /><label for="dress${node.studentId}1">未穿校服</label>
							</c:when>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</table>
		<div style="margin:0 auto;padding:0 0;text-align:right;padding-right:2px;width:99%;margin-top:10px">
			<a href="javascript:void(0)" id="enterBtn" class="easyui-linkbutton" iconCls="icon-ok" style="width: 100px;" onclick="attendSubmit()">提交</a>
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
		</div>
		<script type="text/javascript">
			ajaxLoadEnd();
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
					$("#classTime").combobox("setValue","${shortClassAttendT.hourRange}");
					$("#classRoomId").combobox("setValue","${shortClassAttendT.roomId}");
					$("#classLessonHour").textbox("setValue","${shortClassAttendT.hours}");
				});
				$("#classTime").combobox({
					formatter:formatParaConfig, 
					valueField: 'paramValue', 
					textField: 'paramDesc', 
					panelHeight: 'auto',
					editable:false,
					data:classTimeData,
					onLoadSuccess:function(data){
						$("#classTime").combobox("setValue","${shortClassAttendT.hourRange}");
					}
				});
				$("#classRoomId").combobox({
					formatter:formatRoom, 
					valueField: 'roomId', 
					textField: 'roomName', 
					panelHeight: 'auto',
					editable:false,
					data:classRoomIdData,
					onLoadSuccess:function(data){
						$("#classRoomId").combobox("setValue","${shortClassAttendT.roomId}");
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
				$("#attRecordClassType").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto',
					editable:false,
					data:attRecordClassType
				});
				$("#classLessonHour").textbox("setValue","${shortClassAttendT.hours}");
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
					$.messager.alert('提示',"您输入的课时量不合法,请核实后重新尝试");
				}
				else
				{
					var teacherFlag = true;
					var teacherNum = 0;
					$("#teacherTab tr:gt(1) td:nth-child(1)").each(function(i,node){
						if($(node).attr("teacherId") == attRecordTeacherId)
						{
							teacherFlag = false;
						}
						if($(node).attr("teacherType") == "T")
						{
							teacherNum += parseInt($(node).attr("hours"));
						}
					});
					if(teacherFlag)
					{
						var classLessonHour = $("#classLessonHour").textbox("getValue");
						if(classLessonHour == "" || isNaN(classLessonHour))
						{
							invokeGetTeacherInfo(attRecordTeacherId,attRecordLessonHour);
						}
						else
						{
							if(teacherNum+parseInt(attRecordLessonHour) > parseInt(classLessonHour) && attRecordClassType == "T")
							{
								$.messager.alert('提示',"当前添加的老师课时已经超过了排课课时,请核实后重新尝试");
							}
							else
							{
								invokeGetTeacherInfo(attRecordTeacherId,attRecordLessonHour)
							}
						}
					}
					else
					{
						$.messager.alert('提示',"该老师已经被添加,请核实后重新尝试");
					}
				}
			}
			
			function invokeGetTeacherInfo(attRecordTeacherId,attRecordLessonHour)
			{
				ajaxLoading("添加中...");
				$.post("/sys/teacherManage/getTeacherInfo.do",{teacherId:attRecordTeacherId},function(data){
					ajaxLoadEnd();
					var trData = "<tr id='teacherId"+data.teacherId+"'><td align='right' teacherId='"+data.teacherId+"' schoolId='"+data.schoolId+"' teacherType='"+$("#attRecordClassType").combobox("getText")+"' hours='"+attRecordLessonHour+"'>老师：</td><td align='center'>"+$("#attRecordSchoolId").combobox("getText")+"</td><td align='center'>"+$("#attRecordTeacherId").combobox("getText")+"</td><td align='center'>"+$("#attRecordClassType").combobox("getText")+"</td><td align='center'>"+attRecordLessonHour+"</td><td align='center'>"+(data.teacherLicenseList.length>0?"已持证":"未持证")+"</td><td align='center'><a href='javascript:void(0)' onclick='delTeacherFunc("+data.teacherId+")'>删除</a></td></tr>";
					$("#teacherTab tr:last").after(trData);
				},"json");
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
				var classTime = $("#classTime").combobox("getValue");
				var classLessonHour = $("#classLessonHour").textbox("getValue");
				var classRoomId = $("#classRoomId").combobox("getValue");
				var obj = {
					shortClassAttendId:"${shortClassAttendT.shortClassAttendId}",
					shortClassInstId:"${shortClassAttendT.shortClassInstId}",
					shortSchooltimeId:"${shortClassAttendT.shortSchooltimeId}",
					schoolId:"${shortClassInstT.schoolId}",
					hourRange:classTime,
					hours:classLessonHour,
					roomId:classRoomId,
					attendDate:'<fmt:formatDate value="${shortClassAttendT.attendDate}" pattern="yyyy-MM-dd" />',
					handerId:"${sessionScope.StaffT.staffId}",
					teacherAttendList:null,
					studentAttendList:null
				};
				var teacherArr = [];
				var teacherTime = 0;
				$("#teacherTab tr:gt(1) td:nth-child(1)").each(function(i,node){
					var teacherObj = {
						shortTeacherAttendId:$(node).attr("shortTeacherAttendId"),
						shortClassAttendId:"${shortClassAttendT.shortClassAttendId}",
						shortClassInstId:"${shortClassAttendT.shortClassInstId}",
						schoolId:$(node).attr("schoolId"),
						teacherId:$(node).attr("teacherId"),
						attendDate:'<fmt:formatDate value="${shortClassAttendT.attendDate}" pattern="yyyy-MM-dd" />',
						state:$(node).attr("state"),
						teacherType:$(node).attr("teacherType"),
						lessionHours:$(node).attr("hours"),
						handerId:"${sessionScope.StaffT.staffId}"
					};
					teacherArr.push(teacherObj);
					if($(node).attr("teacherType") == 'T')
					{
						teacherTime += parseInt($(node).attr("hours"));
					}
				});
				obj.teacherAttendList = teacherArr;
				var studentArr = [];
				$("#studentTab tr:gt(0)").each(function(i,node){
					var firstTr = $(node).find("td:nth-child(1)");
					var attendTypeObj = $(node).find("input[name='attendType"+firstTr.attr("studentId")+"']:checked").val();
					var dressObj = $(node).find("input[name='dress"+firstTr.attr("studentId")+"']:checked").val();
					var studentObj = {
						shortStudentAttendId:firstTr.attr("shortStudentAttendId"),
						shortClassAttendId:"${shortClassAttendT.shortClassAttendId}",
						shortClassInstId:"${shortClassAttendT.shortClassInstId}",
						schoolId:firstTr.attr("schoolId"),
						studentId:firstTr.attr("studentId"),
						attendDate:'<fmt:formatDate value="${shortClassAttendT.attendDate}" pattern="yyyy-MM-dd" />',
						studentCourseId:firstTr.attr("studentCourseId"),
						hours:$("#classLessonHour").textbox("getValue"),
						attendType:attendTypeObj,
						dress:dressObj,
						handlerId:"${sessionScope.StaffT.staffId}"
					};
					studentArr.push(studentObj);
				});
				obj.studentAttendList = studentArr;
				if(classTime == "")
				{
					$.messager.alert("提示", "请选择上课时间后重新尝试","warning");
				}
				else if(classRoomId == "")
				{
					$.messager.alert("提示", "请选择教室后重新尝试","warning");
				}
				else if(classLessonHour == "")
				{
					$.messager.alert("提示", "请选择课时后重新尝试","warning");
				}
				else if(isNaN(classLessonHour))
				{
					$.messager.alert("提示", "请检查课时是否合法后重新尝试","warning");
				}
				else if(teacherArr.length == 0)
				{
					$.messager.alert("提示", "老师人数不能为零,请添加老师后重新尝试","warning");
				}
				else if(studentArr.length == 0)
				{
					$.messager.alert("提示", "学生人数不能为零,请添加学生后重新尝试","warning");
				}
				else if(teacherTime > classLessonHour)
				{
					$.messager.alert("提示", "老师课时量已超过课程总课时量,请核实后重新尝试","warning");
				}
				else
				{
					var json = JSON.stringify(obj);
					ajaxLoading("提交中...");
					$.post("/sys/shortBus/updateShortAttendTInfo.do",{json:json},function(data){
						ajaxLoadEnd();
						if(data == "success")
						{
							$.messager.alert("提示", "修改考勤成功","info",function(){
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
			
			function checkAllStudentFunc(obj)
			{
				$("input[name='studentId']").each(function(i,node){
					node.checked = obj.checked;
				});
			}
			
			function studentCheckboxClick(obj)
			{
				if(!obj.checked)
				{
					$("#studentAllId").attr("checked",false);
				}
			}
			
			function backFunc()
			{
				ajaxLoading("返回中...");
				window.location.href = "/sys/shortBus/shortAttenceDetailPage.do?funcNodeId=${funcNodeId}&shortClassInstId=${shortClassAttendT.shortClassInstId}&pageName=${pageName}";
			}
		</script>
 	</body>
</html>