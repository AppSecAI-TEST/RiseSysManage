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
		<table align="center" class="tab" style="height:90px;width:99%;margin:0 auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right">上课校区：</td>
				<td><select name="schoolManId" id="schoolManId" style="width:150px" ></select></td>
				<td align="right" width="15%">赠课类型：</td>
				<td width="18%"><select name="classType" id="classType" style="width:150px" ></select></td>
				<td align="right" width="15%">赠送课班级名称：</td>
				<td width="18%"><input name="className" id="className" type="text" style="width:150px" class="easyui-textbox easyui-validatebox" /></td>
			</tr>
			<tr>
				<td align="right" width="15%">开课时间：</td>
				<td width="18%"><input name="classStartTime" id="classStartTime" type="text" style="width:150px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /></td>
				<td align="right">结课时间：</td>
				<td><input name="classEndTime" id="classEndTime" type="text" style="width:150px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /></td>
				<td align="right">计划课时量：</td>
				<td><input name="planHours" id="planHours" type="text" style="width:150px" class="easyui-textbox easyui-validatebox" /></td>
			</tr>
			<tr>
				<td align="right">计划上课人数：</td>
				<td><input name="planClassNum" id="planClassNum" type="text" style="width:150px" class="easyui-textbox easyui-validatebox" /></td>
				<td align="right">&nbsp;</td>
				<td>&nbsp;</td>
				<td align="right">&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		<div style="margin:0 auto;padding:0 0;text-align:left;padding-right:2px;width:99%;margin-top:5px">
			<a href="javascript:void(0)" id="addPlanBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px;" onclick="addPlanFunc()">添加上课计划</a>
		</div>
		<table region="center" class="tab" id="schooltimeList" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<c:choose>
				<c:when test="${fn:length(shortClassList) == 0}">
					<tr>
						<td colspan="9" align="center">暂无上课计划</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${shortClassList}" var="node" varStatus="i">
						<tr class="shortSchooltimeId" id="shortSchooltimeId${node.shortSchooltimeId}">
							<td align="right">上课计划：</td>
							<td><fmt:formatDate value="${node.schooltime}" pattern="yyyy-MM-dd" /> ${node.hourRangeObj.paramDesc}</td>
							<td align="right">教室：</td>
							<td>${node.roomT.roomName}</td>
							<td align="right">课时：</td>
							<td>${node.lessionHours}</td>
							<td align="right">老师：</td>
							<td>
								<ul>
									<c:forEach items="${node.classTeacherList}" var="item" varStatus="i">
										<li><span>${item.teacherT.byName}</span><span style="padding-left:15px">${item.teacherType}</span></li>
									</c:forEach>
								</ul>
							</td>
							<td><a href="javascript:void(0)" onclick="delShortSchooltime(${node.shortSchooltimeId})">删除</a></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
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
				$("#schoolManId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/shortBus/getGiftTypeList.do",function(data){
				$("#classType").combobox("loadData",data);
			},"json");
			$(document).ready(function(){
				$("#classType").combobox({
					formatter:function(data){
						return '<span>'+data.typeName+'</span>';
					}, 
					valueField: 'giftType', 
					textField: 'typeName',
					panelHeight: 'auto'
				});
				$("#schoolManId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto'
				});
				var schoolManId = sessionStorage.getItem("schoolManId");
				var classType = sessionStorage.getItem("classType");
				var className = sessionStorage.getItem("className");
				var classStartTime = sessionStorage.getItem("classStartTime");
				var classEndTime = sessionStorage.getItem("classEndTime");
				var planHours = sessionStorage.getItem("planHours");
				var planClassNum = sessionStorage.getItem("planClassNum");
				var remark = sessionStorage.getItem("remark");
				$("#schoolManId").combobox("setValue",schoolManId);
				$("#classType").combobox("setValue",classType);
				$("#className").textbox("setValue",className);
				$("#classStartTime").datebox("setValue",classStartTime);
				$("#classEndTime").datebox("setValue",classEndTime);
				$("#planHours").textbox("setValue",planHours);
				$("#planClassNum").textbox("setValue",planClassNum);
				$("#remark").textbox("setValue",remark);
			});
			function addSubmitFunc()
			{
				var shortClassInstId = $("#shortClassInstId").val();
				var classType = $("#classType").combobox("getValue");
				var className = $("#className").textbox("getValue");
				var schoolManId = $("#schoolManId").combobox("getValue");
				var planClassNum = $("#planClassNum").textbox("getValue");
				var planHours = $("#planHours").textbox("getValue");
				var classStartTime = $("#classStartTime").datebox("getValue");
				var classEndTime = $("#classEndTime").combobox("getValue");
				var remark = $("#remark").textbox("getValue");
				if(schoolManId == "")
				{
					$.messager.alert('提示',"请先选择上课校区","info");
				}
				else if(classType == "")
				{
					$.messager.alert('提示',"请先选择课程类型","info");
				}
				else if(className == "")
				{
					$.messager.alert('提示',"班级名称不能为空,请核实后重新尝试","info");
				}
				else if(classStartTime == "")
				{
					$.messager.alert('提示',"开课日期不能为空,请核实后重新尝试","info");
				}
				else if(classEndTime == "")
				{
					$.messager.alert('提示',"结课日期不能为空,请核实后重新尝试","info");
				}
				else if(planHours == "")
				{
					$.messager.alert('提示',"计划课时量不能为空,请核实后重新尝试","info");
				}
				else if(planClassNum == "")
				{
					$.messager.alert('提示',"计划上课人数不能为空,请核实后重新尝试","info");
				}
				else if($(".shortSchooltimeId").length == 0)
				{
					$.messager.alert('提示',"上课计划不能为空,请核实后重新尝试","info");
				}
				else
				{
					var json = {
						shortClassInstId:shortClassInstId,
						schoolId:schoolManId,
						classTypeId:classType,
						className:className,
						planClassNum:planClassNum,
						planHours:planHours,
						openDate:classStartTime,
						finishDate:classEndTime,
						remark:remark,
						createId:${sessionScope.StaffT.staffId},
						handlerId:${sessionScope.StaffT.staffId}
					};
					ajaxLoading("放班中...");
					$.post("/sys/shortBus/addShortClassInstTInfo.do",{json:JSON.stringify(json),className:encodeURI("小拼暑类班")},function(data){
						ajaxLoadEnd();
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
			function addPlanFunc()
			{
				var schoolManId = $("#schoolManId").combobox("getValue");
				var classType = $("#classType").combobox("getValue");
				var className = $("#className").textbox("getValue");
				var classStartTime = $("#classStartTime").datebox("getValue");
				var classEndTime = $("#classEndTime").datebox("getValue");
				var planHours = $("#planHours").textbox("getValue");
				var planClassNum = $("#planClassNum").textbox("getValue");
				var remark = $("#remark").textbox("getValue");
				sessionStorage.setItem("schoolManId",schoolManId);
				sessionStorage.setItem("classType",classType);
				sessionStorage.setItem("className",className);
				sessionStorage.setItem("classStartTime",classStartTime);
				sessionStorage.setItem("classEndTime",classEndTime);
				sessionStorage.setItem("planHours",planHours);
				sessionStorage.setItem("planClassNum",planClassNum);
				sessionStorage.setItem("remark",remark);
				if(schoolManId != "")
				{
					window.location.href = "/sys/shortClass/addSchooltimeClass.jsp?funcNodeId=${funcNodeId}&shortClassInstId=${shortClassInstId}&pageName=addSummerClass&classType=小拼暑类班&schoolId="+schoolManId+"&paramFlag=ADD";
				}
				else
				{
					$.messager.alert('提示',"请先选择所属校区","info");
				}
			}
			function delShortSchooltime(val)
			{
				$.messager.confirm("提示", "您确定要删除该上课计划吗？", function (data) {
		            if(data){
		            	ajaxLoading("删除中...");
		                $.post("/sys/shortBus/delShortSchooltimeTInfo.do",{shortSchooltimeId:val},function(data){
		                	ajaxLoadEnd();
		                	if(data == "success")
		                	{
		                		$("#shortSchooltimeId"+val).remove();
		                		if($("#schooltimeList").find("tr").length == 1)
		                		{
		                			$("#schooltimeList").prepend("<tr><td colspan='9' align='center'>暂无上课计划</td></tr>");
		                		}
		                	}
		                	else
		                	{
		                		$.messager.alert('提示',"删除上课计划失败:"+data,"error");
		                	}
		                });
		            }
		        });
			}
			function backFunc()
			{
				sessionStorage.clear();
				window.location.href = "/sys/shortClass/summerClassMan.jsp?funcNodeId=${funcNodeId}";
			}
		</script>
 	</body>
</html>