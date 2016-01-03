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
				<td align="right" width="10%">补课时间：</td>
				<td><fmt:formatDate value="${classAttendT.schooltime}" pattern="yyyy-MM-dd" /> <select id="classTime" name="classTime" style="width:200px" ></select></td>
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
		<script type="text/javascript">
			var gTeacherList = null;
			var gClassList = null;
			var classTimeData = '${hourRangeArr}';
			classTimeData = eval("("+classTimeData+")");
			$.post("/sys/pubData/getTeacherBySchoolId.do",{schoolId:${sessionScope.StaffT.schoolId}},function(data){
				gTeacherList = data;
			},"json");
			$.post("/sys/pubData/qryClassInstList.do",{schoolId:${sessionScope.StaffT.schoolId},courseType:'${classAttendT.studentAttendList[0].studentCourseT.courseType}',stageId:'${classAttendT.studentAttendList[0].stageId}',classType:'${classAttendT.studentAttendList[0].classType}',classState:"'001','002','003','004','005'",classInstId:""},function(data){
				gClassList = data;
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
					panelHeight: 'auto'
				});
				$("#makeupValue").combobox({listHeight:150
				});
				$("#classProgress").combobox("setValue","${classHours}");
				$("#classProgress").combobox("setText","${classHours}");
				choiceClassFunc();
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
					formatter:formatTeacherName,
					valueField: 'teacherId', 
					textField: 'teacherName',
					data:gTeacherList,
				});
				$("#makeupValue").combobox("setValue","");
				$("#makeupValue").combobox("setText","请选择补课老师");
			}
			function makeupFunc()
			{
				var obj = {
					classAttendId:"${classAttendT.classAttendId}",
					handlerId:"${sessionScope.StaffT.staffId}",
					studentList:null
				};
				var studentArr = [];
				obj.studentList = studentArr;
				var json = JSON.stringify(obj);
				ajaxLoading("提交中...");
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
			function backFunc()
			{
				window.history.back();
			}
		</script>
 	</body>
</html>