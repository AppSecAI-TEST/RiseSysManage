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
		<script type="text/javascript">
			ajaxLoadEnd();
			$.post("<%=path %>/pubData/qryStage.do",function(data){
				$("#classType").combobox("loadData",data);
			},"json");
			$(document).ready(function(){
				$("#classType").combobox({
					formatter:formatStageId, 
					valueField: 'stageId', 
					textField: 'stageId', 
					panelHeight: 'auto',
					editable:false
				});
				$("#classType").combobox("setValue","${shortClassInstT.classTypeId}");
				$("#classInfo").textbox("setValue","${shortClassInstT.className}");
				$("#planHours").textbox("setValue","${shortClassInstT.planHours}");
				$("#planClassNum").textbox("setValue","${shortClassInstT.planClassNum}");
				$("#classStartTime").datebox("setValue","<fmt:formatDate value='${shortClassInstT.openDate}' pattern='yyyy-MM-dd' />");
				$("#classEndTime").datebox("setValue","<fmt:formatDate value='${shortClassInstT.finishDate}' pattern='yyyy-MM-dd' />");
			});
			function addSubmitFunc()
			{
				var shortClassInstId = "${shortClassInstT.shortClassInstId}";
				var classType = $("#classType").combobox("getValue");
				var classInfo = $("#classInfo").textbox("getValue");
				var planClassNum = $("#planClassNum").textbox("getValue");
				var planHours = $("#planHours").textbox("getValue");
				var classStartTime = $("#classStartTime").datebox("getValue");
				var classEndTime = $("#classEndTime").datebox("getValue");
				var nowDate = new Date(new Date().format("yyyy-MM-dd"));
				var classStartTimeDate = new Date(classStartTime);
				var classEndTimeDate = new Date(classEndTime);
				var schooltimeCnt = 0;
				var schooltimeFlag = false;
				$(".shortSchooltimeId").each(function(i,node){
					schooltimeCnt += parseInt($(node).attr("lessionHours"));
					var schooltime = new Date($(node).attr("schooltime"));
					if(!(classStartTimeDate.getTime() <= schooltime.getTime() && schooltime.getTime() <= classEndTimeDate.getTime()))
					{
						schooltimeFlag = true;
					}
				});
				if(classInfo == "")
				{
					$.messager.alert('提示',"热身课班级名称不能为空,请核实后重新尝试","info");
				}
				else if(planClassNum == "")
				{
					$.messager.alert('提示',"计划上课人数不能为空,请核实后重新尝试","info");
				}
				else if(isNaN(planClassNum))
				{
					$.messager.alert('提示',"计划上课人数不合法,请核实后重新尝试","info");
				}
				else if(planHours == "")
				{
					$.messager.alert('提示',"计划课时量不能为空,请核实后重新尝试","info");
				}
				else if(isNaN(planHours))
				{
					$.messager.alert('提示',"计划课时量不合法,请核实后重新尝试","info");
				}
				else if(parseInt(planHours) > schooltimeCnt)
				{
					$.messager.alert('提示',"上课计划未达到计划课时量,请核实后重新尝试","info");
				}
				else if(parseInt(planHours) < schooltimeCnt)
				{
					$.messager.alert('提示',"上课计划已超过计划课时量,请核实后重新尝试","info");
				}
				else if(classStartTime == "")
				{
					$.messager.alert('提示',"开课日期不能为空,请核实后重新尝试","info");
				}
				else if(classEndTime == "")
				{
					$.messager.alert('提示',"结课日期不能为空,请核实后重新尝试","info");
				}
				else if(classStartTimeDate.getTime() < nowDate.getTime())
				{
					$.messager.alert('提示',"开课时间必须大于当前时间,请核实后重新尝试","info");
				}
				else if(classStartTimeDate.getTime() >= classEndTimeDate.getTime())
				{
					$.messager.alert('提示',"结课时间必须大于开课时间,请核实后重新尝试","info");
				}
				else if($(".shortSchooltimeId").length == 0)
				{
					$.messager.alert('提示',"上课计划不能为空,请核实后重新尝试","info");
				}
				else if(schooltimeFlag)
				{
					$.messager.alert('提示',"计划课时必须在开课与结课日期之间,请核实后重新尝试","info");
				}
				else
				{
					var json = {
						shortClassInstId:shortClassInstId,
						className:classInfo,
						classTypeId:classType,
						planClassNum:planClassNum,
						planHours:planHours,
						openDate:classStartTime,
						finishDate:classEndTime,
						handlerId:${sessionScope.StaffT.staffId}
					};
					ajaxLoading("正在处理，请稍待。。。");
					$.post("/sys/shortBus/updateShortClassInstTInfo.do",{json:JSON.stringify(json)},function(data){
						ajaxLoadEnd();
						if(data == "success")
						{
							$.messager.alert('提示',"修改当前班级信息成功","",function(){
								backFunc();
							});
						}
						else
						{
							$.messager.alert('提示',"修改当前班级信息失败:"+data,"error");
						}
					});
				}
			}
			function addPlanFunc()
			{
				ajaxLoading("正在处理，请稍待。。。");
				window.location.href = "/sys/shortClass/addSchooltimeClass.jsp?funcNodeId=${funcNodeId}&shortClassInstId=${shortClassInstT.shortClassInstId}&pageName=shortWarmupClassMan&classType=热身课&schoolId=${shortClassInstT.schoolId}&paramFlag=UPDATE";
			}
			function studentBoxFunc(obj)
			{
				$("input[name='studentId']").each(function(i,node){
					node.checked = obj.checked;
				});
			}
			function delShortSchooltime(val)
			{
				$.messager.confirm("提示", "您确定要删除该上课计划吗？", function (data) {
		            if(data){
		            	ajaxLoading("正在处理，请稍待。。。");
		                $.post("/sys/shortBus/delShortSchooltimeTInfo.do",{shortSchooltimeId:val},function(data){
		                	ajaxLoadEnd();
		                	if(data == "success")
		                	{
		                		$("#shortSchooltimeId"+val).remove();
		                		if($(".shortSchooltimeId").length == 0)
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
			function selectClassFunc()
			{
				ajaxLoading("正在处理，请稍待。。。");
				window.location.href = "/sys/shortClass/choiceWarmupClassPage.jsp?funcNodeId=${funcNodeId}&shortClassInstId=${shortClassInstT.shortClassInstId}&pageName=shortWarmupClassMan&classType="+encodeURI("热身课");
			}
			function removeClassFunc()
			{
				var stuArr = [];
				$("input[name='studentId']").each(function(i,node){
					if(node.checked)
					{
						stuArr.push(node.value);
					}
				});
				if(stuArr.length == 0)
				{
					$.messager.alert('提示',"移除所勾选的学员失败:");
				}
				else
				{
					$.messager.confirm("提示", "您确定要移除所勾选的学员吗？", function (data) {
			            if(data){
			            	ajaxLoading("正在处理，请稍待。。。");
			                $.post("/sys/shortBus/delShortStudentList.do",{shortClassInstId:${shortClassInstT.shortClassInstId},studentIds:stuArr.join(","),handlerId:${sessionScope.StaffT.staffId}},function(data){
			                	ajaxLoadEnd();
			                	if(data == "success")
			                	{
			                		for(var i = 0,n = stuArr.length;i < n;i++)
			                		{
				                		$("#studentId"+stuArr[i]).remove();
			                		}
			                		if($(".studentId").length == 0)
			                		{
			                			$(".headTr").after("<tr><td colspan='11' align='center'>暂无学生报名</td></tr>");
			                		}
			                	}
			                	else
			                	{
			                		$.messager.alert('提示',"移除所勾选的学员失败:"+data,"error");
			                	}
			                });
			            }
			        });
				}
			}
			function viewClassFunc()
			{
				var stuArr = [];
				$("input[name='studentId']").each(function(i,node){
					if(node.checked)
					{
						stuArr.push(node.value);
					}
				});
				if(stuArr.length == 0)
				{
					$.messager.alert('提示',"请先选择要浏览的学员");
				}
				else if(stuArr.length == 0)
				{
					$.messager.alert('提示',"不能选择多名要浏览的学员");
				}
				else
				{
					window.location.href = "/sys/view.jsp?studentId="+stuArr[0]+"&title=学员基础信息";
				}
			}
			function backFunc()
			{
				window.location.href = "/sys/shortClass/warmupClassMan.jsp?funcNodeId=${funcNodeId}";
			}
		</script>
  	</head>
  	<body class="manage">
		<div class="panel datagrid easyui-fluid" style="width:99%">
		  <div class="panel-header">
		    <div class="panel-title">课程信息</div>
		    <div class="panel-tool"></div>
		  </div>
		</div>
		<table align="center" class="tab" style="height:90px;width:99%;margin:0px auto;margin-bottom:5px;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" width="15%">课程类型：</td>
				<td width="18%"><select id="classType" name="classType" style="width:100px;height:25px;" ></select></td>
				<td align="right" width="15%">热身课班级名称：</td>
				<td width="18%"><input name="classInfo" id="classInfo" type="text" style="width:150px" class="easyui-textbox easyui-validatebox" /></td>
				<td align="right" width="15%">计划上课人数：</td>
				<td width="18%"><input name="planClassNum" id="planClassNum" type="text" style="width:150px" class="easyui-textbox easyui-validatebox" /></td>
			</tr>
			<tr>
				<td align="right">计划课时量：</td>
				<td><input name="planHours" id="planHours" type="text" style="width:150px" class="easyui-textbox easyui-validatebox" /></td>
				<td align="right">开课日期：</td>
				<td><input name="classStartTime" id="classStartTime" type="text" style="width:150px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /></td>
				<td align="right">结课日期：</td>
				<td><input name="classEndTime" id="classEndTime" type="text" style="width:150px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /></td>
			</tr>
		</table>
		<div style="margin:0 auto;padding:0 0;text-align:left;padding-right:2px;width:99%;margin-top:5px">
			<a href="javascript:void(0)" id="addPlanBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px;" onclick="addPlanFunc()">添加上课计划</a>
		</div>
		<table region="center" class="tab" id="schooltimeList" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<c:choose>
				<c:when test="${fn:length(shortClassInstT.classSchooltimeList) == 0}">
					<tr>
						<td colspan="9" align="center">暂无上课计划</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${shortClassInstT.classSchooltimeList}" var="node" varStatus="i">
						<tr class="shortSchooltimeId" id="shortSchooltimeId${node.shortSchooltimeId}" lessionHours="${node.lessionHours}" schooltime="<fmt:formatDate value='${node.schooltime}' pattern='yyyy-MM-dd' />">
							<td align="right">上课计划：</td>
							<td><fmt:formatDate value="${node.schooltime}" pattern="yyyy-MM-dd" /> ${node.startTime}~${node.endTime}</td>
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
		</table>
		<div style="margin:0 auto;padding:0 0;text-align:right;padding-right:2px;width:99%;margin-top:10px">
			<a href="javascript:void(0)" id="addSubmitBtn" class="easyui-linkbutton" iconCls="icon-ok" style="width: 100px;" onclick="addSubmitFunc()">提交</a>
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
		</div>
 	</body>
</html>