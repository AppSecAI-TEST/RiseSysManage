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
			$.post("<%=path %>/pubData/qrySchoolList.do",function(data){
				$("#schoolManId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/shortBus/getShortClassTypeList.do?typeName="+encodeURI("国际班"),function(data){
				$("#interClassType").combobox("loadData",data);
			},"json");
			$(document).ready(function(){
				$("#interClassType").combobox({
					formatter:function(data){
						return '<span>'+data.classType+'</span>';
					}, 
					valueField: 'classTypeId', 
					textField: 'classType',
					editable:false,
					panelHeight: 'auto'
				});
				$("#schoolManId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName',
					editable:false,
					panelHeight: 'auto'
				});
				var interClassType = sessionStorage.getItem("interClassType");
				var className = sessionStorage.getItem("className");
				var classStartTime = sessionStorage.getItem("classStartTime");
				var schoolManId = sessionStorage.getItem("schoolManId");
				var planHours = sessionStorage.getItem("planHours");
				var classEndTime = sessionStorage.getItem("classEndTime");
				var remark = sessionStorage.getItem("remark");
				$("#interClassType").combobox("setValue",interClassType);
				$("#className").textbox("setValue",className);
				$("#classStartTime").datebox("setValue",classStartTime);
				$("#schoolManId").combobox("setValue",schoolManId);
				$("#planHours").textbox("setValue",planHours);
				$("#classEndTime").datebox("setValue",classEndTime);
				$("#remark").textbox("setValue",remark);
			});
			function addSubmitFunc()
			{
				var shortClassInstId = $("#shortClassInstId").val();
				var interClassType = $("#interClassType").combobox("getValue");
				var className = $("#className").textbox("getValue");
				var classStartTime = $("#classStartTime").datebox("getValue");
				var schoolManId = $("#schoolManId").combobox("getValue");
				var planHours = $("#planHours").textbox("getValue");
				var classEndTime = $("#classEndTime").combobox("getValue");
				var remark = $("#remark").textbox("getValue");
				var classStartDate = new Date(classStartTime);
				var classEndDate = new Date(classEndTime);
				var schooltimeCnt = 0;
				$(".shortSchooltimeId").each(function(i,node){
					schooltimeCnt += parseInt($(node).attr("lessionHours"));
				});
				if(interClassType == "")
				{
					$.messager.alert('提示',"请先选择国际班类型","info");
				}
				else if(className == "")
				{
					$.messager.alert('提示',"班级名称不能为空,请核实后重新尝试","info");
				}
				else if(schoolManId == "")
				{
					$.messager.alert('提示',"请先选择国际班上课校区","info");
				}
				else if(planHours == "")
				{
					$.messager.alert('提示',"计划总课时量不能为空,请核实后重新尝试","info");
				}
				else if(isNaN(planHours))
				{
					$.messager.alert('提示',"计划总课时量不合法,请核实后重新尝试","info");
				}
				else if(parseInt(planHours) > schooltimeCnt)
				{
					$.messager.alert('提示',"上课计划未达到计划总课时量,请核实后重新尝试","info");
				}
				else if(parseInt(planHours) < schooltimeCnt)
				{
					$.messager.alert('提示',"上课计划已超过计划总课时量,请核实后重新尝试","info");
				}
				else if(classStartTime == "")
				{
					$.messager.alert('提示',"开课日期不能为空,请核实后重新尝试","info");
				}
				else if(classEndTime == "")
				{
					$.messager.alert('提示',"结课日期不能为空,请核实后重新尝试","info");
				}
				else if($(".shortSchooltimeId").length == 0)
				{
					$.messager.alert('提示',"上课计划不能为空,请核实后重新尝试","info");
				}
				else if(classEndDate.getTime() <= classStartDate.getTime())
				{
					$.messager.alert('提示',"结课时间必须大于开课时间,请核实后重新尝试","info");
				}
				else
				{
					var json = {
						shortClassInstId:shortClassInstId,
						schoolId:schoolManId,
						classTypeId:interClassType,
						className:className,
						planHours:planHours,
						openDate:classStartTime,
						finishDate:classEndTime,
						remark:string2Json(remark),
						createId:${sessionScope.StaffT.staffId},
						handlerId:${sessionScope.StaffT.staffId}
					};
					ajaxLoading("正在处理，请稍待。。。");
					$.post("/sys/shortBus/addShortClassInstTInfo.do",{json:JSON.stringify(json),className:encodeURI("国际班")},function(data){
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
				var interClassType = $("#interClassType").combobox("getValue");
				var className = $("#className").textbox("getValue");
				var classStartTime = $("#classStartTime").datebox("getValue");
				var schoolManId = $("#schoolManId").combobox("getValue");
				var planHours = $("#planHours").textbox("getValue");
				var classEndTime = $("#classEndTime").datebox("getValue");
				var remark = $("#remark").textbox("getValue");
				sessionStorage.setItem("interClassType",interClassType);
				sessionStorage.setItem("className",className);
				sessionStorage.setItem("classStartTime",classStartTime);
				sessionStorage.setItem("schoolManId",schoolManId);
				sessionStorage.setItem("planHours",planHours);
				sessionStorage.setItem("classEndTime",classEndTime);
				sessionStorage.setItem("remark",remark);
				if(schoolManId != "")
				{
					ajaxLoading("正在处理，请稍待。。。");
					window.location.href = "/sys/shortClass/addSchooltimeClass.jsp?funcNodeId=${funcNodeId}&shortClassInstId=${shortClassInstId}&pageName=addInterClass&classType=国际班&schoolId="+schoolManId+"&paramFlag=ADD";
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
		            	ajaxLoading("正在处理，请稍待。。。");
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
				window.location.href = "/sys/shortClass/interClassMan.jsp?funcNodeId=${funcNodeId}";
			}
		</script>
  	</head>
  
  	<body class="manage">
 		<input type="hidden" id="shortClassInstId" value="${shortClassInstId}" />
		<table align="center" class="tab" style="height:90px;width:99%;margin:0 auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" width="15%">国际班类型：</td>
				<td width="18%"><select name="interClassType" id="interClassType" style="width:150px" ></select></td>
				<td align="right" width="15%">班级名称：</td>
				<td width="18%"><input name="className" id="className" type="text" style="width:150px" class="easyui-textbox easyui-validatebox" /></td>
				<td align="right" width="15%">开课日期：</td>
				<td width="18%"><input name="classStartTime" id="classStartTime" type="text" style="width:150px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /></td>
			</tr>
			<tr>
				<td align="right">国际班上课校区：</td>
				<td><select name="schoolManId" id="schoolManId" style="width:150px" ></select></td>
				<td align="right">计划总课时量：</td>
				<td><input name="planHours" id="planHours" type="text" style="width:150px" class="easyui-textbox easyui-validatebox" /></td>
				<td align="right">结课日期：</td>
				<td><input name="classEndTime" id="classEndTime" type="text" style="width:150px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" /></td>
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
						<tr class="shortSchooltimeId" id="shortSchooltimeId${node.shortSchooltimeId}" lessionHours="${node.lessionHours}">
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
 	</body>
</html>
