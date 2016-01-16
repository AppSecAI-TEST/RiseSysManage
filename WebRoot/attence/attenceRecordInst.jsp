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
			<tr style="display:none;">
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align="right" width="10%">上课时间：</td>
				<td>周${classWeekTime} ${classSchooltime} <select id="classTime" name="classTime" style="width:200px" ></select></td>
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
		</table>
		<c:if test="${isFirstFlag == 'Y'}">
			<div id="toolbar" style="width:99%;margin:5px auto;padding:0 0;">
				<a href="javascript:void(0)" id="removeStaffBtn" class="easyui-linkbutton" iconCls="icon-remove" style="width: 150px;" onclick="removeClassStudent()">移除学员</a>
	   			<a href="javascript:void(0)" id="convertExceptionBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 150px;" onclick="convertExceptionClass()">正常转异常开班</a>
			</div>
		</c:if>
		<table class="tab" id="studentTab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr class="headTr">
				<td width="3%"><input type="checkbox" name="studentId" id="studentAllId" value="" onclick="checkAllStudentFunc(this)" /></td>
				<td width="3%">序号</td>
				<td width="10%">学员姓名</td>
				<td width="10%">英文名</td>
				<td width="8%">课程状态</td>
				<td width="50%">考勤操作</td>
				<td width="16%">校服着装情况</td>
			</tr>
			<c:forEach items="${classInstT.classStudentList}" var="node" varStatus="i">
				<tr id="studentId${node.studentId}">
					<td align="center" studentId="${node.studentId}" schoolId="${node.schoolId}" studentName="${node.studentT.name}" studentCourseId="${node.studentCourseId}" stageId="${classInstT.stageId}"><input type="checkbox" name="studentId" value="${node.studentId}" courseId="${node.studentCourseT.studentCourseId}" onclick="studentCheckboxClick(this)" /></td>
					<td align="center">${i.count}</td>
					<td align="center">${node.studentT.name}</td>
					<td align="center">${node.studentT.byName}</td>
					<td align="center">${node.studentCourseT.courseStateName}</td>
					<td align="center"><input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}1" value="N" checked="checked" /><label for="attendType${node.studentId}1">正常上课</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}2" value="B" /><label for="attendType${node.studentId}2">迟到</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}3" value="L" /><label for="attendType${node.studentId}3">请假</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}4" value="T" /><label for="attendType${node.studentId}4">旷课</label>&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-filebox" name="uploadAttenceLeave${node.studentId}" data-options="prompt:'',buttonText:'上传请假单'" style="width:200px"></td>
					<td align="center"><input type="radio" name="dress${node.studentId}" id="dress${node.studentId}2" value="Y" checked="checked" /><label for="dress${node.studentId}2">已穿校服</label>&nbsp;&nbsp;<input type="radio" name="dress${node.studentId}" id="dress${node.studentId}1" value="N" /><label for="dress${node.studentId}1">未穿校服</label></td>
				</tr>
			</c:forEach>
		</table>
		<div style="margin:0 auto;padding:0 0;text-align:right;padding-right:2px;width:99%;margin-top:10px">
			<a href="javascript:void(0)" id="enterBtn" class="easyui-linkbutton" iconCls="icon-ok" style="width: 100px;" onclick="attendSubmit()">提交</a>
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
					formatter:formatParaConfig, 
					valueField: 'paramValue', 
					textField: 'paramDesc', 
					panelHeight: 'auto',
					data:classTimeData
				});
				$("#classRoomId").combobox({
					formatter:formatRoom, 
					valueField: 'roomId', 
					textField: 'roomName', 
					panelHeight: 'auto',
					data:classRoomIdData
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
					textField: 'byName', 
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
						var trData = "<tr id='teacherId"+data.teacherId+"'><td align='right' teacherId='"+data.teacherId+"' teacherName='"+$("#attRecordTeacherId").combobox("getText")+"' teacherType='"+$("#attRecordClassType").combobox("getText")+"' hours='"+attRecordLessonHour+"'>老师：</td><td align='center'>"+$("#attRecordSchoolId").combobox("getText")+"</td><td align='center'>"+$("#attRecordTeacherId").combobox("getText")+"</td><td align='center'>"+$("#attRecordClassType").combobox("getText")+"</td><td align='center'>"+attRecordLessonHour+"</td><td align='center'>";
						var i = 0,n = data.teacherLicenseList.length;
						for(;i < n;i++)
						{
							if("${classInstT.stageId}" == data.teacherLicenseList[i].stageId)
							{
								break;
							}
						}
						if(i >= n)
						{
							trData+="未持证";
						}
						else
						{
							trData+="已持证";
						}
						trData+="</td><td align='center'><a href='javascript:void(0)' onclick='delTeacherFunc("+data.teacherId+")'>删除</a></td></tr>";
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
				var classOpenDate = '<fmt:formatDate value="${classInstT.openDate}" pattern="yyyy-MM-dd" />';
				var calDate = "${classSchooltime}";
				if(classOpenDate != calDate && "${isFirstFlag}" == "Y")
				{
					$.messager.alert("提示", "第一次考勤时间与开课时间不一致,请核实后重新尝试","warning");
				}
				else
				{
					var classTime = $("#classTime").combobox("getValue");
					var classLessonHour = $("#classLessonHour").textbox("getValue");
					var classRoomId = $("#classRoomId").combobox("getValue");
					var obj = {
						classInstId:"${classInstT.classInstId}",
						classSchoolId:"${classInstT.schoolId}",
						hourRange:classTime,
						hours:classLessonHour,
						roomId:classRoomId,
						classType:"${classInstT.classType}",
						handlerId:"${sessionScope.StaffT.staffId}",
						schooltime:'${classSchooltime}',
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
						var attendTypeObj = $(node).find("input[name='attendType"+firstTr.attr("studentId")+"']:checked").val();
						var dressObj = $(node).find("input[name='dress"+firstTr.attr("studentId")+"']:checked").val();
						var studentObj = {
							studentId:firstTr.attr("studentId"),
							studentCourseId:firstTr.attr("studentCourseId"),
							stageId:firstTr.attr("stageId"),
							studentName:firstTr.attr("studentName"),
							schoolId:firstTr.attr("schoolId"),
							hours:classLessonHour,
							dress:dressObj,
							attendType:attendTypeObj
						};
						studentArr.push(studentObj);
					});
					obj.studentList = studentArr;
					if(classTime == "")
					{
						$.messager.alert("提示", "上课时段不能为空,请添加老师后重新尝试","warning");
					}
					else if(classRoomId == "")
					{
						$.messager.alert("提示", "教室不能为空,请添加老师后重新尝试","warning");
					}
					else if(classLessonHour == "")
					{
						$.messager.alert("提示", "课时不能为空,请添加老师后重新尝试","warning");
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
						ajaxLoading("提交中...");
						$.post("/sys/attend/addAttend.do",{json:json},function(data){
							ajaxLoadEnd();
							if(data == "success")
							{
								$.messager.alert("提示", "考勤成功","info",function(){
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
			
			function removeClassStudent()
			{
				var studentArr = [];
				var courseArr = [];
				$("input[name='studentId']:checked").each(function(i,node){
					studentArr.push($(node).val());
					courseArr.push($(node).attr("courseId"));
					$("#studentId"+$(node).val()).remove();
				});
				var obj = {
					classStudentId:studentArr.join(","),
					studentCourseId:courseArr.join(","),
					handlerId:"${sessionScope.StaffT.staffId}"
				};
				$.post("/sys/applyClass/batchRemoveStudent.do",{param:JSON.stringify(obj)},function(data){
					alert(JSON.stringify(data));
					if(data.flag == true)
					{
						$.messager.alert("提示", "所选学员已被成功移除");
					}
					else
					{
						$.messager.alert("提示", "学员移除失败","error");
					}
				},"json");				
			}
			
			function convertExceptionClass()
			{
				$.post("/sys/attend/convertClassOpenType.do",{classInstId:"${classInstT.classInstId}"},function(data){
					if(data == "success")
					{
						$.messager.alert("提示", "当前班级已被转换成异常开班");
					}
					else
					{
						$.messager.alert("提示", data,"error");
					}
				});
			}
			
			function backFunc()
			{
				ajaxLoading("返回中...");
				window.location.href = "/sys/attend/getAttendOperate.do?funcNodeId=${funcNodeId}&classInstId=${classInstT.classInstId}&selDateStr=${selDateStr}";
			}
		</script>
 	</body>
</html>