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
		<style type="text/css">
			.tab td{
				font-size:14px;
				height:30px;
				border-right:1px solid #ccc;
				border-bottom:1px solid #ccc;
				font-family:"微软雅黑";
				padding:2px;
			}
			.tab tr td:nth-last-child(2n+1){
				padding-left:4px;
			}
			.tab tr td:nth-last-child(2n){
				padding-right:4px;
			}
			.tab tr:first-child td{
				font-weight:bold;
				text-align:center;
			}
			.tab tr td input{
				vertical-align:middle;
			}
			.tab tr td label{
				vertical-align:middle;
			}
		</style>
  	</head>
  
  	<body class="manage">
		<table class="tab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr style="display:none;">
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align="right" width="10%">上课时间：</td>
				<td>周${classAttendT.attendDateWeek} <fmt:formatDate value="${classAttendT.schooltime}" pattern="yyyy-MM-dd" /> <select id="classTime" name="classTime" style="width:200px" ></select></td>
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
			<tr>
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
			<c:forEach items="${classAttendT.teacherAttendList}" var="node">
				<tr id="teacherId${node.teacherId}">
					<td align="right" teacherId="${node.teacherId}" teacherName="${node.teacherName}" teacherType="${node.teacherType}" hours="${node.hours}">老师：</td>
					<td align="center">${node.teacherT.schoolT.schoolName}</td>
					<td align="center">${node.teacherName}</td>
					<td align="center">${node.teacherType}</td>
					<td align="center">${node.hours}</td>
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
			<tr>
				<td width="5%">&nbsp;</td>
				<td width="5%">序号</td>
				<td width="10%">学员姓名</td>
				<td width="10%">英文名</td>
				<td width="10%">课程状态</td>
				<td width="40%">考勤操作</td>
				<td width="20%">校服着装情况</td>
			</tr>
			<c:forEach items="${classAttendT.studentAttendList}" var="node" varStatus="i">
				<tr>
					<td align="center" studentId="${node.studentId}" schoolId="${node.schoolId}" studentName="${node.studentT.name}"><input type="checkbox" name="studentId" /></td>
					<td align="center">${i.count}</td>
					<td align="center">${node.studentName}</td>
					<td align="center">${node.studentT.byName}</td>
					<td align="center">${node.studentCourseT.courseStateName}</td>
					<td align="center">
						<c:choose>
							<c:when test="${node.attendType=='N'}">
								<input type="radio" name="attendType" id="attendType${node.studentId}1" value="N" checked="checked" /><label for="attendType${node.studentId}1">正常上课</label>&nbsp;<input type="radio" name="attendType" id="attendType${node.studentId}2" value="B" /><label for="attendType${node.studentId}2">迟到</label>&nbsp;<input type="radio" name="attendType" id="attendType${node.studentId}3" value="L" /><label for="attendType${node.studentId}3">请假</label>&nbsp;<input type="radio" name="attendType" id="attendType${node.studentId}4" value="T" /><label for="attendType${node.studentId}4">旷课</label>&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-filebox" name="uploadAttenceLeave" data-options="prompt:'',buttonText:'上传请假单'" style="width:200px">
							</c:when>
							<c:when test="${node.attendType=='B'}">
								<input type="radio" name="attendType" id="attendType${node.studentId}1" value="N" /><label for="attendType${node.studentId}1">正常上课</label>&nbsp;<input type="radio" name="attendType" id="attendType${node.studentId}2" value="B" checked="checked" /><label for="attendType${node.studentId}2">迟到</label>&nbsp;<input type="radio" name="attendType" id="attendType${node.studentId}3" value="L" /><label for="attendType${node.studentId}3">请假</label>&nbsp;<input type="radio" name="attendType" id="attendType${node.studentId}4" value="T" /><label for="attendType${node.studentId}4">旷课</label>&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-filebox" name="uploadAttenceLeave" data-options="prompt:'',buttonText:'上传请假单'" style="width:200px">
							</c:when>
							<c:when test="${node.attendType=='L'}">
								<input type="radio" name="attendType" id="attendType${node.studentId}1" value="N" /><label for="attendType${node.studentId}1">正常上课</label>&nbsp;<input type="radio" name="attendType" id="attendType${node.studentId}2" value="B" /><label for="attendType${node.studentId}2">迟到</label>&nbsp;<input type="radio" name="attendType" id="attendType${node.studentId}3" value="L" checked="checked" /><label for="attendType${node.studentId}3">请假</label>&nbsp;<input type="radio" name="attendType" id="attendType${node.studentId}4" value="T" /><label for="attendType${node.studentId}4">旷课</label>&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-filebox" name="uploadAttenceLeave" data-options="prompt:'',buttonText:'上传请假单'" style="width:200px">
							</c:when>
							<c:when test="${node.attendType=='T'}">
								<input type="radio" name="attendType" id="attendType${node.studentId}1" value="N" /><label for="attendType${node.studentId}1">正常上课</label>&nbsp;<input type="radio" name="attendType" id="attendType${node.studentId}2" value="B" /><label for="attendType${node.studentId}2">迟到</label>&nbsp;<input type="radio" name="attendType" id="attendType${node.studentId}3" value="L" /><label for="attendType${node.studentId}3">请假</label>&nbsp;<input type="radio" name="attendType" id="attendType${node.studentId}4" value="T" checked="checked" /><label for="attendType${node.studentId}4">旷课</label>&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-filebox" name="uploadAttenceLeave" data-options="prompt:'',buttonText:'上传请假单'" style="width:200px">
							</c:when>
						</c:choose>
					</td>
					<td align="center">
						<c:choose>
							<c:when test="${node.dress == 'N'}">
								<input type="radio" name="dress" id="dress${node.studentId}1" value="N" checked="checked" /><label for="dress${node.studentId}1">未穿校服</label>&nbsp;&nbsp;<input type="radio" name="dress" id="dress${node.studentId}2" value="Y" /><label for="dress${node.studentId}2">已穿校服</label>
							</c:when>
							<c:when test="${node.dress == 'Y'}">
								<input type="radio" name="dress" id="dress${node.studentId}1" value="N" /><label for="dress${node.studentId}1">未穿校服</label>&nbsp;&nbsp;<input type="radio" name="dress" id="dress${node.studentId}2" value="Y" checked="checked" /><label for="dress${node.studentId}2">已穿校服</label>
							</c:when>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</table>
		<div style="margin:0 auto;padding:0 0;text-align:right;padding-right:2px;width:99%;margin-top:10px">
			<a href="javascript:void(0)" id="enterBtn" class="easyui-linkbutton" iconCls="icon-ok" style="width: 100px;" onclick="attendUpdate()">修改</a>
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
		</div>
		<script type="text/javascript">
			$(document).ready(function(){
				ajaxLoadEnd();
				var classTimeData = '${hourRangeList}';
				var classRoomIdData = '${roomList}';
				var attRecordSchoolIdData = '${schoolList}';
				var attRecordTeacherId = '${teacherList}';
				var attRecordClassType = '${teacherTypeList}';
				classTimeData = eval("("+classTimeData+")");
				classRoomIdData = eval("("+classRoomIdData+")");
				attRecordSchoolIdData = eval("("+attRecordSchoolIdData+")");
				attRecordTeacherId = eval("("+attRecordTeacherId+")");
				attRecordClassType = eval("("+attRecordClassType+")");
				$("#classTime").combobox({
					formatter:formatParam, 
					valueField: 'paramValue', 
					textField: 'param1', 
					panelHeight: 'auto',
					data:classTimeData,
					onLoadSuccess:function(data){
						$("#classTime").combobox("setValue","${classAttendT.hourRange}");
					}
				});
				$("#classRoomId").combobox({
					formatter:formatRoom, 
					valueField: 'roomId', 
					textField: 'roomName', 
					panelHeight: 'auto',
					data:classRoomIdData,
					onLoadSuccess:function(data){
						$("#classRoomId").combobox("setValue","${classAttendT.roomId}");
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
						$.post("/sys/pubData/getTeacherBySchoolId.do",{schoolId:data.schoolId},function(data){
							$("#attRecordTeacherId").combobox("loadData",data);
						},"json");
					},
					onLoadSuccess:function(data){
						if(attRecordSchoolIdData.length > 0)
						{
							$("#attRecordSchoolId").combobox("setValue",attRecordSchoolIdData[0].schoolId);
						}
					}
				});
				$("#attRecordTeacherId").combobox({
					formatter:formatTeacherName,
					valueField: 'teacherId', 
					textField: 'teacherName', 
					//panelHeight: 'auto',
					listHeight:150,
					data:attRecordTeacherId
				});
				$("#attRecordClassType").combobox({
					formatter:formatItem, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto',
					data:attRecordClassType
				});
				$("#classLessonHour").textbox("setValue","${classAttendT.hours}");
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
						var trData = "<tr id='teacherId"+data.teacherId+"'><td align='right' teacherId='"+data.teacherId+"' teacherName='"+$("#attRecordTeacherId").combobox("getText")+"' teacherType='"+$("#attRecordClassType").combobox("getText")+"' hours='"+attRecordLessonHour+"'>老师：</td><td align='center'>"+$("#attRecordSchoolId").combobox("getText")+"</td><td align='center'>"+$("#attRecordTeacherId").combobox("getText")+"</td><td align='center'>"+$("#attRecordClassType").combobox("getText")+"</td><td align='center'>"+attRecordLessonHour+"</td><td align='center'>"+(data.teacherLicenseList.length>0?"已持证":"未持证")+"</td><td align='center'><a href='javascript:void(0)' onclick='delTeacherFunc("+data.teacherId+")'>删除</a></td></tr>";
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
			
			function attendUpdate()
			{
				var obj = {
					classAttendId:"${classAttendT.classAttendId}",
					classInstId:"${classAttendT.classInstId}",
					classSchoolId:"${classAttendT.schoolId}",
					hourRange:$("#classTime").combobox("getValue"),
					hours:$("#classLessonHour").textbox("getValue"),
					roomId:$("#classRoomId").combobox("getValue"),
					classType:"${schooltimeInstT.classInstT.classType}",
					handlerId:"${sessionScope.StaffT.staffId}",
					schooltime:'<fmt:formatDate value="${classAttendT.schooltime}" pattern="yyyy-MM-dd" />',
					teacherList:null,
					studentList:null
				};
				var teacherArr = [];
				$("#teacherTab tr:gt(1) td:nth-child(1)").each(function(i,node){
					var teacherObj = {
						teacherId:$(node).attr("teacherId"),
						teacherName:$(node).attr("teacherName"),
						teacherType:$(node).attr("teacherType"),
						hours:$(node).attr("hours")
					};
					teacherArr.push(teacherObj);
				});
				obj.teacherList = teacherArr;
				var studentArr = [];
				$("#studentTab tr:gt(0)").each(function(i,node){
					var firstTr = $(node).find("td:nth-child(1)");
					var attendTypeObj = $(node).find("input[name='attendType']:checked").val();
					var dressObj = $(node).find("input[name='dress']:checked").val();
					var studentObj = {
						studentId:firstTr.attr("studentId"),
						studentName:firstTr.attr("studentName"),
						schoolId:firstTr.attr("schoolId"),
						dress:dressObj,
						attendType:attendTypeObj
					};
					studentArr.push(studentObj);
				});
				obj.studentList = studentArr;
				var json = JSON.stringify(obj);
				ajaxLoading("修改中...");
				$.post("/sys/attend/updateAttend.do",{json:json},function(data){
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
			
			function backFunc()
			{
				ajaxLoading("返回中...");
				window.location.href = "/sys/attend/getAttendOperate.do?funcNodeId=${funcNodeId}&classInstId=${classAttendT.classInstId}&selDateStr=${selDateStr}";
			}
		</script>
 	</body>
</html>