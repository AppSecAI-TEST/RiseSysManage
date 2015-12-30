<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
 		<input type="hidden" id="shortClassInstId" value="${shortClassInstId}" />
 		<input type="hidden" id="shortClassId" value="${shortClassId}" />
		<table align="center" class="tab" style="height:90px;width:99%;margin:0 auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" width="15%">游学类型：</td>
				<td width="18%"><select name="tourismClassType" id="tourismClassType" style="width:150px" ></select></td>
				<td align="right" width="15%">班级名称：</td>
				<td width="18%"><input name="className" id="className" type="text" style="width:150px" class="easyui-textbox easyui-validatebox" /></td>
				<td align="right" width="15%">计划招生人数：</td>
				<td width="18%"><input name="planClassNum" id="planClassNum" type="text" style="width:150px" class="easyui-textbox easyui-validatebox" /></td>
			</tr>
			<tr>
				<td align="right">游学开始日期：</td>
				<td><input name="classStartTime" id="classStartTime" type="text" style="width:150px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /></td>
				<td align="right">游学结束日期：</td>
				<td><input name="classEndTime" id="classEndTime" type="text" style="width:150px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /></td>				
				<td align="right">&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		<table region="center" class="tab" id="teacherList" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="3"><select id="schoolId" name="schoolId" style="width:120px" ></select>&nbsp;&nbsp;<select id="teacherId" name="teacherId" style="width:120px" ></select>&nbsp;&nbsp;<a href="javascript:void(0)" id="addTeacherBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;" onclick="addTeacherFunc()">添加</a></td>
			</tr>
			<tr id="emptyTeacher">
				<td colspan="3" align="center">暂未安排老师</td>
			</tr>
		</table>
		<table region="center" class="tab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="10%" align="right">备注：</td>
				<td colspan="8">
					<input name="remark" id="remark" type="text" style="width:95%;height:100px" class="easyui-textbox" data-options="multiline:true" />
				</td>
			</tr>
		</table>
		<div style="margin:0 auto;padding:0 0;text-align:right;padding-right:2px;width:99%;margin-top:10px">
			<a href="javascript:void(0)" id="addSubmitBtn" class="easyui-linkbutton" iconCls="icon-ok" style="width: 100px;" onclick="addSubmitFunc()">提交</a>
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
		</div>
		<script type="text/javascript">
			$.post("<%=path %>/pubData/qrySchoolList.do",function(data){
				$("#schoolId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/shortBus/getShortClassTypeList.do?typeName="+encodeURI("游学"),function(data){
				$("#tourismClassType").combobox("loadData",data);
			},"json");
			$(document).ready(function(){
				$("#schoolId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					//panelHeight: 'auto',
					listHeight:150,
					onSelect:function(data){
						$("#teacherId").combobox("setValue","");
						$.post("/sys/pubData/getTeacherBySchoolId.do",{schoolId:data.schoolId},function(data){
							$("#teacherId").combobox("loadData",data);
						},"json");
					},
					onLoadSuccess:function(data){
						if(data.length > 0)
						{
							$("#schoolId").combobox("setValue",data.schoolId);
						}
					}
				});
				$("#tourismClassType").combobox({
					formatter:function(data){
						return '<span>'+data.classType+'</span>';
					}, 
					valueField: 'classTypeId', 
					textField: 'classType',
					panelHeight: 'auto'
				});
				$("#teacherId").combobox({
					formatter:formatTeacherName,
					valueField: 'teacherId', 
					textField: 'teacherName', 
					//panelHeight: 'auto',
					listHeight:150
				});
			});
			function addTeacherFunc()
			{
				var schoolId = $("#schoolId").combobox("getValue");
				var teacherId = $("#teacherId").combobox("getValue");
				if(schoolId == "")
				{
					$.messager.alert('提示',"请先选择校区后重新尝试");
				}
				else if(teacherId == "")
				{
					$.messager.alert('提示',"请先选择老师后重新尝试");
				}
				else
				{
					if($(".teacherId").length == 0)
					{
						$("#emptyTeacher").remove();
					}
					ajaxLoading("添加中...");
					$.post("/sys/teacherManage/getTeacherInfo.do",{teacherId:teacherId},function(data){
						ajaxLoadEnd();
						var trData = "<tr id='teacherId"+data.teacherId+"' class='teacherId'><td align='center' width='15%' teacherId='"+data.teacherId+"' schoolId='"+data.schoolId+"'>"+$("#schoolId").combobox("getText")+"</td><td align='center' width='15%'>"+$("#teacherId").combobox("getText")+"</td><td align='left' width='70%' style='padding-left:30px'><a href='javascript:void(0)' onclick='delTeacherFunc("+data.teacherId+")'>删除</a></td></tr>";
						$("#teacherList tr:last").after(trData);
					},"json");
				}
			}
			function delTeacherFunc(flagVal)
			{
				$("#teacherId"+flagVal).remove();
				if($(".teacherId").length == 0)
				{
					$("#teacherList tr:last").after("<tr id='emptyTeacher'><td colspan='3' align='center'>暂未安排老师</td></tr>");
				}
			}
			function addSubmitFunc()
			{
				var shortClassInstId = $("#shortClassInstId").val();
				var shortClassId = $("#shortClassId").val();
				var tourismClassType = $("#tourismClassType").combobox("getValue");
				var className = $("#className").textbox("getValue");
				var planClassNum = $("#planClassNum").textbox("getValue");
				var classStartTime = $("#classStartTime").datebox("getValue");
				var classEndTime = $("#classEndTime").combobox("getValue");
				var remark = $("#remark").textbox("getValue");
				if(tourismClassType == "")
				{
					$.messager.alert('提示',"请先选择游学类型","info");
				}
				else if(className == "")
				{
					$.messager.alert('提示',"班级名称不能为空,请核实后重新尝试","info");
				}
				else if(planClassNum == "")
				{
					$.messager.alert('提示',"计划招生人数不能为空,请核实后重新尝试","info");
				}
				else if(classStartTime == "")
				{
					$.messager.alert('提示',"开课日期不能为空,请核实后重新尝试","info");
				}
				else if(classEndTime == "")
				{
					$.messager.alert('提示',"结课日期不能为空,请核实后重新尝试","info");
				}
				else if($(".teacherId").length == 0)
				{
					$.messager.alert('提示',"老师不能为空,请核实后重新尝试","info");
				}
				else
				{
					var json = {
						shortClassInstId:shortClassInstId,
						schoolId:"",
						shortClassId:shortClassId,
						classTypeId:tourismClassType,
						className:className,
						planClassNum:planClassNum,
						openDate:classStartTime,
						finishDate:classEndTime,
						remark:remark,
						createId:${sessionScope.StaffT.staffId},
						handlerId:${sessionScope.StaffT.staffId},
						teacherList:null
					};
					var arr = [];
					$(".teacherId").each(function(i,node){
						var teacherObj = $(node).find("td:eq(0)");
						var obj = {
							shortClassInstId:shortClassInstId,
							teacherId:teacherObj.attr("teacherId"),
							teacherType:"",
							lessionHours:"",
							schoolId:teacherObj.attr("schoolId"),
							handlerId:${sessionScope.StaffT.staffId},
						};
						arr.push(obj);
					});
					json.teacherList = arr;
					$.post("/sys/shortBus/addTourismClassInfo.do",{json:JSON.stringify(json)},function(data){
						if(data == "success")
						{
							$.messager.alert('提示',"完成当前放班","",function(){
								backFunc();
							});
						}
						else
						{
							$.messager.alert('提示',"放班失败:"+data,"error");
						}
					});
				}
			}
			function backFunc()
			{
				window.location.href = "/sys/shortClass/tourismClassMan.jsp?funcNodeId=${funcNodeId}";
			}
		</script>
 	</body>
</html>