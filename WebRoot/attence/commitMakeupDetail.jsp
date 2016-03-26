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
			var gTeacherList = null;
			var gClassList = null;
			var classTimeData = '${hourRangeArr}';
			var classHoursData = '${classHours}';
			classTimeData = eval("("+classTimeData+")");
			classHoursData = eval("("+classHoursData+")");
			$.post("/sys/pubData/qryClassInstList.do",{schoolId:${classAttendT.schoolId},courseType:'${classAttendT.studentAttendList[0].studentCourseT.courseType}',stageId:'${classAttendT.studentAttendList[0].stageId}',classType:'${classAttendT.studentAttendList[0].classType}',classState:"'001','002','003'",classInstId:""},function(data){
				gClassList = data;
				$("#makeupValue").combobox({
   					valueField : "classInstId",
   					textField : "className",
   					panelHeight : "auto",
   					data:gClassList,
   					formatter : function(data) {
   						return "<span>" + data.className + "</span>";
   					}
   				});
   				$("#makeupValue").combobox("setValue","");
				$("#makeupValue").combobox("setText","请选择补课班级");
			},"json");
			$.post("/sys/pubData/getTeacherBySchoolId.do",{schoolId:${classAttendT.schoolId}},function(data){
				gTeacherList = data;
			},"json");
			$(document).ready(function(){
				ajaxLoadEnd();
				$("#classTime").combobox({
					formatter:formatParaConfig, 
					valueField: 'paramValue', 
					textField: 'paramDesc', 
					panelHeight: 'auto',
					data:classTimeData,
					onLoadSuccess:function(data){
						$("#classTime").combobox("setValue","${classAttendT.hourRange}");
					}
				});
				$("#classProgress").combobox({
					panelHeight: 'auto',
					formatter : function(data) {
   						return "<span>" + data.keyInfo + "</span>";
   					},
   					valueField: 'attachInfo', 
					textField: 'keyInfo',
					data:classHoursData,
					onLoadSuccess:function(data){
						if(data.length > 0)
						{
							$("#classProgress").combobox("setValue",data[0].attachInfo);
						}
					}
				});
			});
			function choiceClassFunc()
			{
				$("#makeupValue").combobox("loadData",new Array());
				$("#makeupValue").combobox({
   					valueField : "classInstId",
   					textField : "className",
   					panelHeight : "auto",
   					data:gClassList,
   					formatter : function(data) {
   						return "<span>" + data.className + "</span>";
   					}
   				});
				$("#makeupValue").combobox("setValue","");
				$("#makeupValue").combobox("setText","请选择补课班级");
			}
			function choiceTeacherFunc()
			{
				$("#makeupValue").combobox("loadData",new Array());
				$("#makeupValue").combobox({
					formatter:formatTeacher,
					valueField: 'teacherId', 
					textField: 'byName',
					data:gTeacherList,
				});
				$("#makeupValue").combobox("setValue","");
				$("#makeupValue").combobox("setText","请选择补课老师");
			}
			function makeupFunc()
			{
				var hourRange = $("#classTime").combobox("getValue");
				var classProgress = $("#classProgress").combobox("getText");
				var studentAttendId = $("#classProgress").combobox("getValue");
				var makeupType = $("input[name='makeupType']:checked").val();
				var makeupValue = $("#makeupValue").combobox("getValue");
				var attendDate = $("#attendDate").datebox("getValue");
				if(attendDate == "")
				{
					$.messager.alert('提示',"请先选择补课时间后重新尝试");
				}
				else if(classProgress == "")
				{
					$.messager.alert('提示',"请先选择课时进度后重新尝试");
				}
				else if(makeupType == "")
				{
					$.messager.alert('提示',"请先选择补课方式后重新尝试");
				}
				else if(makeupValue == "")
				{
					$.messager.alert('提示',"请先选择对应的"+("F" == makeupType?"班级":"老师")+"后重新尝试");
				}
				else if(hourRange == "")
				{
					$.messager.alert('提示',"请先选择补课时间后重新尝试");
				}
				else
				{
					var classInstId = null;
					var teacherId = null;
					if("F" == makeupType)
					{
						classInstId = makeupValue;
						teacherId = "";
					}
					else
					{
						classInstId = "";
						teacherId = makeupValue;
					}
					var timeArr = classProgress.split("~");
					var obj = {
						studentAttendId:studentAttendId,
						makeupType:makeupType,
						schooltime:attendDate,
						hourRange:hourRange,
						baseHour:(parseInt(timeArr[0])-1),
						hours:(parseInt(timeArr[1])-parseInt(timeArr[0])+1),
						classInstId:classInstId,
						teacherId:teacherId,
						leaveUrl:"",
						makeupUrl:""
					};
					var json = JSON.stringify(obj);
					ajaxLoading("正在处理，请稍待。。。");
					$.post("/sys/attend/addStudentMakeupInfo.do",{json:json},function(data){
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
			}
			function backFunc()
			{
				window.location.href = "/sys/attend/commitMakeupPage.do?studentCourseId=${studentCourseId}&funcNodeId=${funcNodeId}"
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
				<td align="right" width="10%">缺课日期：</td>
				<td><fmt:formatDate value="${classAttendT.attendDate}" pattern="yyyy-MM-dd" /></td>
			</tr>
			<tr>
				<td align="right" width="10%">补课时间：</td>
				<td><input name="attendDate" id="attendDate" type="text" style="width:100px;height:25px;" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /> <select id="classTime" name="classTime" style="width:200px" ></select></td>
			</tr>
			<tr>
				<td align="right">课时进度：</td>
				<td><select id="classProgress" name="classProgress" style="width:200px" ></select></td>
			</tr>
			<tr>
				<td align="right">补课方式：</td>
				<td><input type="radio" name="makeupType" id="makeupType1" value="F" onclick="choiceClassFunc()" checked="checked" /><label for="makeupType1">跟班补</label>&nbsp;<input type="radio" name="makeupType" id="makeupType2" value="S" onclick="choiceTeacherFunc()" /><label for="makeupType2">单独补</label>&nbsp;<select id="makeupValue" name="makeupValue" style="width:200px" ></select></td>
			</tr>
			<tr>
				<td align="right">补课单据：</td>
				<td><input class="easyui-filebox" data-options="prompt:'',buttonText:' 浏览 '" style="width:400px"></td>
			</tr>
		</table>
		<div style="margin:0 auto;padding:0 0;text-align:right;padding-right:2px;width:99%;margin-top:10px">
			<a href="javascript:void(0)" id="enterBtn" class="easyui-linkbutton" iconCls="icon-ok" style="width: 100px;" onclick="makeupFunc()">提交</a>
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
		</div>
	 	</body>
</html>