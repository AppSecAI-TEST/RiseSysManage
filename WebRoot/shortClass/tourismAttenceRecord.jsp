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
				<td align="right" width="15%">游学开始日期：</td>
				<td width="15%"><input name="openDate" id="openDate" type="text" style="width:150px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /></td>
				<td align="right" width="15%">游学结束日期：</td>
				<td><input name="finishDate" id="finishDate" type="text" style="width:150px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /></td>
			</tr>
		</table>
		<table class="tab" id="teacherTab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr class="headTr">
				<td width="15%">&nbsp;</td>
				<td width="15%">校区</td>
				<td width="15%">姓名</td>
				<td>操作</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="center"><select id="attRecordSchoolId" name="attRecordSchoolId" style="width:150px" ></select></td>
				<td align="center"><select id="attRecordTeacherId" name="attRecordTeacherId" style="width:150px" ></select></td>
				<td align="center"><a href="javascript:void(0)" id="addTeacherBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="addAttendTeacher()">添加</a></td>
			</tr>
			<c:forEach items="${shortClassTeacherTList}" var="node">
				<tr id="teacherId${node.teacherId}">
					<td align="right" teacherId="${node.teacherId}" schoolId="${node.schoolId}" >老师：</td>
					<td align="center">${node.schoolT.schoolName}</td>
					<td align="center">${node.teacherT.teacherName}</td>
					<td align="center"><a href="javascript:void(0)" onclick="delTeacherFunc(${node.teacherId})">删除</a></td>
				</tr>
			</c:forEach>
		</table>
		<table class="tab" id="studentTab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr class="headTr">
				<td width="5%">序号</td>
				<td width="15%">校区</td>
				<td width="15%">姓名</td>
				<td width="15%">英文名</td>
				<td width="50%">考勤操作</td>
			</tr>
			<c:forEach items="${shortClassInstT.classStudentList}" var="node" varStatus="i">
				<tr id="studentId${node.studentId}">
					<td align="center" studentId="${node.studentId}" schoolId="${node.schoolId}" studentCourseId="${node.studentCourseId}">${i.count}</td>
					<td align="center">${node.studentT.schoolT.schoolName}</td>
					<td align="center">${node.studentT.name}</td>
					<td align="center">${node.studentT.byName}</td>
					<td align="center"><input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}1" value="Y" checked="checked" /><label for="attendType${node.studentId}1">参加</label>&nbsp;&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}2" value="N" /><label for="attendType${node.studentId}2">未参加</label></td>
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
				var attRecordSchoolIdData = '${schoolList}';
				attRecordSchoolIdData = eval("("+attRecordSchoolIdData+")");
				$(document).ready(function(){
					$("#openDate").datebox("setValue",'<fmt:formatDate value="${shortClassInstT.openDate}" pattern="yyyy-MM-dd" />');
					$("#finishDate").datebox("setValue",'<fmt:formatDate value="${shortClassInstT.finishDate}" pattern="yyyy-MM-dd" />');
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
						return "<span>"+row.byName+"</span>"
					},
					valueField: 'teacherId', 
					textField: 'byName', 
					//panelHeight: 'auto',
					listHeight:150,
					editable:false
				});
			});
			
			function addAttendTeacher()
			{
				var attRecordSchoolId = $("#attRecordSchoolId").combobox("getValue");
				var attRecordTeacherId = $("#attRecordTeacherId").combobox("getValue");
				if(attRecordTeacherId == "")
				{
					$.messager.alert('提示',"请先选择老师后重新尝试");
				}
				else
				{
					var teacherFlag = true;
					$("#teacherTab tr:gt(1) td:nth-child(1)").each(function(i,node){
						if($(node).attr("teacherId") == attRecordTeacherId)
						{
							teacherFlag = false;
						}
					});
					if(teacherFlag)
					{
						ajaxLoading("正在处理，请稍待。。。");
						$.post("/sys/teacherManage/getTeacherInfo.do",{teacherId:attRecordTeacherId},function(data){
							ajaxLoadEnd();
							var trData = "<tr id='teacherId"+data.teacherId+"'><td align='right' teacherId='"+data.teacherId+"' schoolId='"+data.schoolId+"'>老师：</td><td align='center'>"+$("#attRecordSchoolId").combobox("getText")+"</td><td align='center'>"+$("#attRecordTeacherId").combobox("getText")+"</td><td align='center'><a href='javascript:void(0)' onclick='delTeacherFunc("+data.teacherId+")'>删除</a></td></tr>";
							$("#teacherTab tr:last").after(trData);
						},"json");
					}
					else
					{
						$.messager.alert('提示',"该老师已经被添加,请核实后重新尝试");				
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
				var attendDate = new Date().format("yyyy-MM-dd");
				var obj = {
					shortClassInstId:"${shortClassInstT.shortClassInstId}",
					shortSchooltimeId:"",
					schoolId:"",
					hourRange:"",
					hours:"",
					roomId:"",
					handerId:"${sessionScope.StaffT.staffId}",
					schooltime:attendDate,
					attendDate:attendDate,
					teacherAttendList:null,
					studentAttendList:null,
					openDate:$("#openDate").datebox("getValue"),
					finishDate:$("#finishDate").datebox("getValue")
				};
				var openDateTime = new Date(obj.openDate);
				var finishDateTime = new Date(obj.finishDate);
				var teacherArr = [];
				$("#teacherTab tr:gt(1) td:nth-child(1)").each(function(i,node){
					var teacherObj = {
						shortClassInstId:"${shortClassInstT.shortClassInstId}",
						teacherId:$(node).attr("teacherId"),
						schoolId:$(node).attr("schoolId"),
						attendDate:attendDate,
						teacherType:"",
						lessionHours:"",
						handerId:"${sessionScope.StaffT.staffId}"
					};
					teacherArr.push(teacherObj);
				});
				obj.teacherAttendList = teacherArr;
				var studentArr = [];
				$("#studentTab tr:gt(0)").each(function(i,node){
					var firstTr = $(node).find("td:nth-child(1)");
					var attendTypeObj = $(node).find("input[name='attendType"+firstTr.attr("studentId")+"']:checked").val();
					var studentObj = {
						shortClassInstId:"${shortClassInstT.shortClassInstId}",
						schoolId:firstTr.attr("schoolId"),
						studentId:firstTr.attr("studentId"),
						studentCourseId:firstTr.attr("studentCourseId"),
						attendDate:attendDate,
						hours:"",
						attendType:attendTypeObj,
						dress:"",
						handlerId:"${sessionScope.StaffT.staffId}"
					};
					studentArr.push(studentObj);
				});
				obj.studentAttendList = studentArr;
				if(obj.openDate == "")
				{
					$.messager.alert("提示", "游学开始日期不能为空,请选择后重新尝试","warning");
				}
				else if(obj.finishDate == "")
				{
					$.messager.alert("提示", "游学结束日期不能为空,请选择后重新尝试","warning");
				}
				else if(openDateTime.getTime() >= finishDateTime.getTime())
				{
					$.messager.alert('提示',"游学结束日期必须大于游学开始日期,请核实后重新尝试","info");
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
					$.post("/sys/shortBus/addShortTourismAttendTInfo.do",{json:json},function(data){
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
			
			function backFunc()
			{
				ajaxLoading("返回中...");
				window.location.href = "/sys/shortBus/accessShortAttenceDetail.do?funcNodeId=${funcNodeId}&pageName=attenceTourismDetail&shortClassInstId=${shortClassInstT.shortClassInstId}";
			}
		</script>
 	</body>
</html>