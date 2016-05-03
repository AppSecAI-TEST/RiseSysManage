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
				text-align:center;
			}
			.tab tr td input{
				vertical-align:middle;
			}
			.tab tr td label{
				vertical-align:middle;
			}
		</style>
		<script type="text/javascript">
			var gTimeType = "mod";
			var attendTimeDate = [];
			var classTimeData = '${hourRangeList}';
			var classRoomIdData = '${roomList}';
			var attRecordSchoolIdData = '${schoolList}';
			var attRecordClassType = '${teacherTypeList}';
			$(document).ready(function(){
				ajaxLoadEnd();
				classTimeData = eval("("+classTimeData+")");
				if(classTimeData != null)
				{
					var gClassAttendIds = "${classAttendIdArr}";
					var gClassAttendIdsArr = gClassAttendIds.split("~");
					for(var i = classTimeData.length-1;i >= 0;i--)
					{
						for(var j = gClassAttendIdsArr.length-1;j >= 0;j--)
						{
							var objArr = gClassAttendIdsArr[j].split(";");
							if(classTimeData[i].paramValue == objArr[1])
							{
								attendTimeDate.push(classTimeData[i]);
								classTimeData.splice(i,1);
							}
						}
					}
				}
				classRoomIdData = eval("("+classRoomIdData+")");
				attRecordSchoolIdData = eval("("+attRecordSchoolIdData+")");
				attRecordClassType = eval("("+attRecordClassType+")");
				$("#classTime").combobox({
					formatter:formatParaConfig, 
					valueField: 'paramValue', 
					textField: 'paramDesc', 
					panelHeight: 'auto',
					editable:false,
					data:attendTimeDate,
					onLoadSuccess:function(data){
						$("#classTime").combobox("setValue","${classAttendT.hourRange}");
					},
					onSelect:function(data){
						$("#classLessonHour").textbox("setValue",data.param4);
						if(gTimeType == "change")
						{
							var classAttendIds = "${classAttendIdArr}";
							var schooltimeInstIds = "${schooltimeInstIdArr}";
							var classAttendIdArr = classAttendIds.split("~");
							var attendArr = [];
							var schooltimeArr = [];
							if(schooltimeInstIds != "")
							{
								var schooltimeInstIdArr = schooltimeInstIds.split("~");
								for(var i = 0,n = schooltimeInstIdArr.length;i < n;i++)
								{
									var objArr = schooltimeInstIdArr[i].split(";");
									schooltimeArr.push(objArr[0]);
								}
							}
							for(var i = 0,n = classAttendIdArr.length;i < n;i++)
							{
								var objArr = classAttendIdArr[i].split(";");
								attendArr.push(objArr[0]);
							}
							if(classAttendIds != "")
							{
								for(var i = 0,n = classAttendIdArr.length;i < n;i++)
								{
									var objArr = classAttendIdArr[i].split(";");
									if(objArr.length > 1 && objArr[1]==data.paramValue)
									{
										ajaxLoading("正在处理，请稍待。。。");
										window.location.href = "/sys/attend/getUpdateAttenceRecord.do?funcNodeId=${funcNodeId}&classAttendId="+objArr[0]+"&classAttendIds="+attendArr.join("~")+"&schooltimeInstIds="+schooltimeArr.join("~")+"&selDateStr=<fmt:formatDate value='${classAttendT.attendDate}' pattern='yyyy-MM' />&dateValue=<fmt:formatDate value='${classAttendT.attendDate}' pattern='dd' />";
										return ;
									}
								}
							}
							if(schooltimeInstIds != "")
							{
								var schooltimeInstIdArr = schooltimeInstIds.split("~");
								for(var i = 0,n = schooltimeInstIdArr.length;i < n;i++)
								{
									var objArr = schooltimeInstIdArr[i].split(";");
									if(objArr.length > 1 && objArr[1]==data.paramValue)
									{
										ajaxLoading("正在处理，请稍待。。。");
										window.location.href = "/sys/attend/getAttenceRecord.do?funcNodeId=${funcNodeId}&schooltimeInstId="+objArr[0]+"&classAttendIds="+classAttendIds+"&schooltimeInstIds="+schooltimeInstIds+"&selDateStr=<fmt:formatDate value='${classAttendT.attendDate}' pattern='yyyy-MM' />&dateValue=<fmt:formatDate value='${classAttendT.attendDate}' pattern='dd' />";
										return ;
									}
								}
							}
							ajaxLoading("正在处理，请稍待。。。");
							window.location.href = "/sys/attend/getAttenceRecordInst.do?funcNodeId=${funcNodeId}&classInstId=${classAttendT.classInstId}&classAttendIds="+classAttendIds+"&schooltimeInstIds="+schooltimeInstIds+"&hourRange="+data.paramValue+"&selDateStr=<fmt:formatDate value='${classAttendT.attendDate}' pattern='yyyy-MM' />&dateValue=<fmt:formatDate value='${classAttendT.attendDate}' pattern='dd' />";
						}
					}
				});
				$("#modifyClassTime").combobox({
					formatter:formatParaConfig, 
					valueField: 'paramValue', 
					textField: 'paramDesc', 
					panelHeight: 'auto',
					editable:false,
					data:classTimeData,
					onLoadSuccess:function(data){
						if(data.length > 0)
						{
							$("#modifyClassTime").combobox("setValue",data[0].paramValue);
						}
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
						$("#classRoomId").combobox("setValue","${classAttendT.roomId}");
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
					},
					onLoadSuccess:function(data){
						if(attRecordSchoolIdData.length > 0)
						{
							$("#attRecordSchoolId").combobox("setValue",attRecordSchoolIdData[0].schoolId);
						}
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
					if(teacherTaTime+parseInt(attRecordLessonHour) > teacherTime && attRecordClassType == "TA")
					{
						$.messager.alert('提示',"添加TA老师课时量已超过T老师总课时量,不能再添加老师");
						return ;
					}
					if(teacherFlag)
					{
						ajaxLoading("正在处理，请稍待。。。");
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
			
			function attendTypeClickFunc(obj,flag)
			{
				if(obj.value == 'L' || obj.value == 'T')
				{
					$("#dressArea"+flag).css("visibility","hidden");
				}
				else
				{
					$("#dressArea"+flag).css("visibility","visible");
				}
			}
			
			function attendUpdate()
			{
				if(gTimeType == "mod")
				{
					var classTime = $("#modifyClassTime").combobox("getValue");
					var classLessonHour = $("#classLessonHour").textbox("getValue");
					var classRoomId = $("#classRoomId").combobox("getValue");
					var obj = {
						classAttendId:"${classAttendT.classAttendId}",
						classInstId:"${classAttendT.classInstId}",
						classSchoolId:"${classAttendT.schoolId}",
						hourRange:classTime,
						hours:classLessonHour,
						roomId:classRoomId,
						classType:"${schooltimeInstT.classInstT.classType}",
						handlerId:"${sessionScope.StaffT.staffId}",
						teacherList:null,
						studentList:null
					};
					var teacherArr = [];
					var teacherTime = 0;
					var teacherTaTime = 0;
					$("#teacherTab tr:gt(1) td:nth-child(1)").each(function(i,node){
						var teacherObj = {
							teacherId:$(node).attr("teacherId"),
							teacherName:$(node).attr("teacherName"),
							teacherType:$(node).attr("teacherType"),
							attendDate:'<fmt:formatDate value="${classAttendT.schooltime}" pattern="yyyy-MM-dd" />',
							hours:$(node).attr("hours")
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
					obj.teacherList = teacherArr;
					var studentArr = [];
					$("#studentTab tr:gt(0)").each(function(i,node){
						var firstTr = $(node).find("td:nth-child(1)");
						var attendTypeObj = $(node).find("input[name='attendType"+firstTr.attr("studentId")+"']:checked").val();
						var dressObj = $(node).find("input[name='dress"+firstTr.attr("studentId")+"']:checked").val();
						var studentObj = {
							studentId:firstTr.attr("studentId"),
							studentName:firstTr.attr("studentName"),
							schoolId:firstTr.attr("schoolId"),
							attendDate:'<fmt:formatDate value="${classAttendT.schooltime}" pattern="yyyy-MM-dd" />',
							dress:dressObj,
							attendType:attendTypeObj
						};
						studentArr.push(studentObj);
					});
					obj.studentList = studentArr;
					if(classTime == "")
					{
						$.messager.alert("提示", "修改时段不能为空,请添加老师后重新尝试","warning");
					}
					else if(classRoomId == "")
					{
						$.messager.alert("提示", "教室不能为空,请添加老师后重新尝试","warning");
					}
					else if(classLessonHour == "")
					{
						$.messager.alert("提示", "课时不能为空,请添加老师后重新尝试","warning");
					}
					else if(isNaN(classLessonHour))
					{
						$.messager.alert("提示", "请检查课时是否合法后重新尝试","warning");
					}
					else if(teacherTime > classLessonHour)
					{
						$.messager.alert("提示", "老师课时量已超过课程总课时量,请核实后重新尝试","warning");
					}
					else if(teacherTaTime > teacherTime)
					{
						$.messager.alert('提示',"添加TA老师课时量已超过T老师总课时量,不能再添加老师","warning");
					}
					else
					{
						var json = JSON.stringify(obj);
						ajaxLoading("正在处理，请稍待。。。");
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
				}
				else
				{
					$.messager.alert('提示',"新增考勤下不能对当前考勤进行修改","warning");
				}
			}
			function classTimeTypeFunc(obj)
			{
				gTimeType = obj.value;
				if(gTimeType == "mod")
				{
					$("#modifyTimeArea").css("display","inline");
					$("#classTime").combobox({
						data:attendTimeDate,
						onLoadSuccess:function(data){
							if(data.length > 0)
							{
								$("#classTime").combobox("setValue",data[0].paramValue);
							}
						}
					});
				}
				else
				{
					$("#modifyTimeArea").css("display","none");
					$("#classTime").combobox({
						data:classTimeData,
						onLoadSuccess:function(data){
							if(data.length > 0)
							{
								$("#classTime").combobox("setValue",data[0].paramValue);
							}
						}
					});
				}
			}
			function backFunc()
			{
				ajaxLoading("返回中...");
				window.location.href = "/sys/attend/getAttendOperate.do?funcNodeId=${funcNodeId}&classInstId=${classAttendT.classInstId}&selDateStr=${selDateStr}";
			}
		</script>
  	</head>
  	<body class="manage">
		<div class="panel datagrid easyui-fluid" style="width:99%">
		  <div class="panel-header">
		    <div class="panel-title">修改考勤信息</div>
		    <div class="panel-tool"></div>
		  </div>
		</div>
		<table class="tab" style="width:99%;margin:0px auto;margin-bottom:5px;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr style="display:none;">
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align="right" width="10%">操作类型：</td>
				<td><input type="radio" name="classTimeType" id="classTimeTypeModified" value="mod" checked="checked" onclick="classTimeTypeFunc(this)" /><label for="classTimeTypeModified">修改考勤</label>&nbsp;&nbsp;<input type="radio" name="classTimeType" id="classTimeTypeChange" value="change" onclick="classTimeTypeFunc(this)" /><label for="classTimeTypeChange">新增考勤</label></td>
			</tr>
			<tr>
				<td align="right">上课时间：</td>
				<td>周${classAttendT.attendDateWeek} <fmt:formatDate value="${classAttendT.attendDate}" pattern="yyyy-MM-dd" /> <select id="classTime" name="classTime" style="width:200px" ></select><span id="modifyTimeArea">&nbsp;&nbsp;修改为&nbsp;&nbsp;<select id="modifyClassTime" name="modifyClassTime" style="width:200px" ></select></span></td>
			</tr>
			<tr>
				<td align="right">教室：</td>
				<td><select id="classRoomId" name="classRoomId" style="width:200px" ></select></td>
			</tr>
			<tr>
				<td align="right">课时：</td>
				<td><input name="classLessonHour" id="classLessonHour" type="text" style="width:200px" class="easyui-textbox" data-options="readonly:true" /></td>
			</tr>
		</table>
		<div class="panel datagrid easyui-fluid" style="width:99%">
		  <div class="panel-header">
		    <div class="panel-title">上课老师信息</div>
		    <div class="panel-tool"></div>
		  </div>
		</div>
		<table class="tab" id="teacherTab" style="width:99%;margin:0px auto;margin-bottom:5px;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;max-height:300px" border="0" cellpadding="0" cellspacing="0">
			<tr class="headTr datagrid-header">
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
		<div class="panel datagrid easyui-fluid" style="width:99%">
		  <div class="panel-header">
		    <div class="panel-title">课程学员信息</div>
		    <div class="panel-tool"></div>
		  </div>
		</div>
		<div style="max-height:300px;overflow:auto;">
			<table class="tab" id="studentTab" style="width:99%;margin:0px auto;margin-bottom:5px;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
				<tr class="headTr datagrid-header">
					<td width="5%">&nbsp;</td>
					<td width="5%">序号</td>
					<td width="10%">学员姓名</td>
					<td width="10%">英文名</td>
					<td width="10%">课程状态</td>
					<td width="40%">考勤操作</td>
					<td width="20%">校服着装情况</td>
				</tr>
				<c:forEach items="${classAttendT.studentAttendList}" var="node" varStatus="i">
					<c:if test="${node.attendType != 'K' && node.attendType != 'M'}">
						<tr>
							<td align="center" studentId="${node.studentId}" schoolId="${node.schoolId}" studentName="${node.studentT.name}" studentCourseId="${node.studentCourseId}" stageId="${classInstT.stageId}"><input type="checkbox" name="studentId" /></td>
							<td align="center">${i.count}</td>
							<td align="center">${node.studentName}</td>
							<td align="center">${node.studentT.byName}</td>
							<td align="center">${node.studentCourseT.courseStateName}</td>
							<td align="center">
								<c:choose>
									<c:when test="${node.attendType=='N'}">
										<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}1" value="N" onclick="attendTypeClickFunc(this,'${node.studentId}')" checked="checked" /><label for="attendType${node.studentId}1">正常上课</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}2" value="B" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}2">迟到</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}3" value="L" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}3">请假</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}4" value="T" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}4">旷课</label>&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-filebox" name="uploadAttenceLeave${node.studentId}" data-options="prompt:'',buttonText:'上传请假单'" style="width:200px">
									</c:when>
									<c:when test="${node.attendType=='B'}">
										<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}1" value="N" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}1">正常上课</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}2" value="B" onclick="attendTypeClickFunc(this,'${node.studentId}')" checked="checked" /><label for="attendType${node.studentId}2">迟到</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}3" value="L" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}3">请假</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}4" value="T" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}4">旷课</label>&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-filebox" name="uploadAttenceLeave${node.studentId}" data-options="prompt:'',buttonText:'上传请假单'" style="width:200px">
									</c:when>
									<c:when test="${node.attendType=='L'}">
										<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}1" value="N" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}1">正常上课</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}2" value="B" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}2">迟到</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}3" value="L" onclick="attendTypeClickFunc(this,'${node.studentId}')" checked="checked" /><label for="attendType${node.studentId}3">请假</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}4" value="T" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}4">旷课</label>&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-filebox" name="uploadAttenceLeave${node.studentId}" data-options="prompt:'',buttonText:'上传请假单'" style="width:200px">
									</c:when>
									<c:when test="${node.attendType=='T'}">
										<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}1" value="N" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}1">正常上课</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}2" value="B" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}2">迟到</label>&nbsp;<input type="radio" name="attendType" id="attendType${node.studentId}3" value="L" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}3">请假</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}4" value="T" checked="checked" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}4">旷课</label>&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-filebox" name="uploadAttenceLeave${node.studentId}" data-options="prompt:'',buttonText:'上传请假单'" style="width:200px">
									</c:when>
								</c:choose>
							</td>
							<td align="center">
								<c:choose>
									<c:when test="${node.attendType == 'L' || node.attendType == 'T'}">
										<c:choose>
											<c:when test="${node.dress == 'N'}">
												<span id="dressArea${node.studentId}" style="visibility:hidden;"><input type="radio" name="dress${node.studentId}" id="dress${node.studentId}2" value="Y" /><label for="dress${node.studentId}2">已穿校服</label>&nbsp;&nbsp;<input type="radio" name="dress${node.studentId}" id="dress${node.studentId}1" value="N" checked="checked" /><label for="dress${node.studentId}1">未穿校服</label></span>
											</c:when>
											<c:when test="${node.dress == 'Y'}">
												<span id="dressArea${node.studentId}" style="visibility:hidden;"><input type="radio" name="dress${node.studentId}" id="dress${node.studentId}2" value="Y" checked="checked" /><label for="dress${node.studentId}2">已穿校服</label>&nbsp;&nbsp;<input type="radio" name="dress${node.studentId}" id="dress${node.studentId}1" value="N" /><label for="dress${node.studentId}1">未穿校服</label></span>
											</c:when>
										</c:choose>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${node.dress == 'N'}">
												<span id="dressArea${node.studentId}" style="visibility:visible;"><input type="radio" name="dress${node.studentId}" id="dress${node.studentId}2" value="Y" /><label for="dress${node.studentId}2">已穿校服</label>&nbsp;&nbsp;<input type="radio" name="dress${node.studentId}" id="dress${node.studentId}1" value="N" checked="checked" /><label for="dress${node.studentId}1">未穿校服</label></span>
											</c:when>
											<c:when test="${node.dress == 'Y'}">
												<span id="dressArea${node.studentId}" style="visibility:visible;"><input type="radio" name="dress${node.studentId}" id="dress${node.studentId}2" value="Y" checked="checked" /><label for="dress${node.studentId}2">已穿校服</label>&nbsp;&nbsp;<input type="radio" name="dress${node.studentId}" id="dress${node.studentId}1" value="N" /><label for="dress${node.studentId}1">未穿校服</label></span>
											</c:when>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:if>
				</c:forEach>
			</table>
		</div>			
		<div style="margin:0 auto;padding:0 0;text-align:right;padding-right:2px;width:99%;margin-top:10px">
			<a href="javascript:void(0)" id="enterBtn" class="easyui-linkbutton" iconCls="icon-ok" style="width: 100px;" onclick="attendUpdate()">修改</a>
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
		</div>
 	</body>
</html>