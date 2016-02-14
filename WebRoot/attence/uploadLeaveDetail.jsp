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
		<script type="text/javascript">
			$(document).ready(function(){
				ajaxLoadEnd();
			});
			function attendUpdate()
			{
				var obj = {
					classAttendId:"${classAttendT.classAttendId}",
					handlerId:"${sessionScope.StaffT.staffId}",
					studentList:null
				};
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
						hours:${classAttendT.hours},
						classType:"${classInstT.classType}",
						dress:dressObj,
						attendType:attendTypeObj
					};
					studentArr.push(studentObj);
				});
				obj.studentList = studentArr;
				var json = JSON.stringify(obj);
				ajaxLoading("正在处理，请稍待。。。");
				$.post("/sys/attend/uploadLeaveOper.do",{json:json},function(data){
					ajaxLoadEnd();
					if(data == "success")
					{
						$.messager.alert("提示", "提交成功","info",function(){
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
			function backFunc()
			{
				window.history.back();
			}
		</script>
  	</head>
  	<body class="manage">
		<table class="tab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr style="display:none;">
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align="right" width="10%">上课时间：</td>
				<td>周${classAttendT.attendDateWeek} <fmt:formatDate value="${classAttendT.schooltime}" pattern="yyyy-MM-dd" /> ${classAttendT.hourRangeObj.paramDesc}</td>
			</tr>
			<tr>
				<td align="right">教室：</td>
				<td>${classAttendT.roomT.roomName}</td>
			</tr>
			<tr>
				<td align="right">课时：</td>
				<td>${classAttendT.hours}</td>
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
			</tr>
			<c:forEach items="${classAttendT.teacherAttendList}" var="node">
				<tr>
					<td align="right">老师：</td>
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
				</tr>
			</c:forEach>
		</table>
		<table class="tab" id="studentTab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="5%">序号</td>
				<td width="10%">学员姓名</td>
				<td width="10%">英文名</td>
				<td width="10%">课程状态</td>
				<td width="40%">考勤操作</td>
				<td width="20%">校服着装情况</td>
			</tr>
			<c:forEach items="${classAttendT.studentAttendList}" var="node" varStatus="i">
				<c:if test="${node.studentId == studentId}">
					<tr>
						<td align="center" studentId="${node.studentId}" schoolId="${node.schoolId}" studentName="${node.studentT.name}">${i.count}</td>
						<td align="center">${node.studentName}</td>
						<td align="center">${node.studentT.byName}</td>
						<td align="center">${node.studentCourseT.courseStateName}</td>
						<td align="center">
							<c:choose>
								<c:when test="${node.attendType=='N'}">
									<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}1" value="N" checked="checked" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}1">正常上课</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}2" value="B" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}2">迟到</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}3" value="L" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}3">请假</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}4" value="T" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}4">旷课</label>&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-filebox" name="uploadAttenceLeave${node.studentId}" data-options="prompt:'',buttonText:'上传请假单'" style="width:200px">
								</c:when>
								<c:when test="${node.attendType=='B'}">
									<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}1" value="N" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}1">正常上课</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}2" value="B" checked="checked" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}2">迟到</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}3" value="L" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}3">请假</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}4" value="T" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}4">旷课</label>&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-filebox" name="uploadAttenceLeave${node.studentId}" data-options="prompt:'',buttonText:'上传请假单'" style="width:200px">
								</c:when>
								<c:when test="${node.attendType=='L'}">
									<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}1" value="N" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}1">正常上课</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}2" value="B" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}2">迟到</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}3" value="L" checked="checked" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}3">请假</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}4" value="T" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}4">旷课</label>&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-filebox" name="uploadAttenceLeave${node.studentId}" data-options="prompt:'',buttonText:'上传请假单'" style="width:200px">
								</c:when>
								<c:when test="${node.attendType=='T'}">
									<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}1" value="N" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}1">正常上课</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}2" value="B" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}2">迟到</label>&nbsp;<input type="radio" name="attendType" id="attendType${node.studentId}3" value="L" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}3">请假</label>&nbsp;<input type="radio" name="attendType${node.studentId}" id="attendType${node.studentId}4" value="T" checked="checked" onclick="attendTypeClickFunc(this,'${node.studentId}')" /><label for="attendType${node.studentId}4">旷课</label>&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-filebox" name="uploadAttenceLeave${node.studentId}" data-options="prompt:'',buttonText:'上传请假单'" style="width:200px">
								</c:when>
							</c:choose>
						</td>
						<td align="center">
							<c:choose>
								<c:when test="${node.dress == 'N'}">
									<span id="dressArea${node.studentId}"><input type="radio" name="dress${node.studentId}" id="dress${node.studentId}1" value="N" checked="checked" /><label for="dress${node.studentId}1">未穿校服</label>&nbsp;&nbsp;<input type="radio" name="dress${node.studentId}" id="dress${node.studentId}2" value="Y" /><label for="dress${node.studentId}2">已穿校服</label></span>
								</c:when>
								<c:when test="${node.dress == 'Y'}">
									<span id="dressArea${node.studentId}"><input type="radio" name="dress${node.studentId}" id="dress${node.studentId}1" value="N" /><label for="dress${node.studentId}1">未穿校服</label>&nbsp;&nbsp;<input type="radio" name="dress${node.studentId}" id="dress${node.studentId}2" value="Y" checked="checked" /><label for="dress${node.studentId}2">已穿校服</label></span>
								</c:when>
							</c:choose>
						</td>
					</tr>
				</c:if>
			</c:forEach>
		</table>
		<div style="margin:0 auto;padding:0 0;text-align:right;padding-right:2px;width:99%;margin-top:10px">
			<a href="javascript:void(0)" id="enterBtn" class="easyui-linkbutton" iconCls="icon-ok" style="width: 100px;" onclick="attendUpdate()">提交</a>
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
		</div>
 	</body>
</html>