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
			var gSchooltimeInd = [];
			$.post("<%=path %>/pubData/qrySchoolList.do",function(data){
				$("#schoolManId").combobox("loadData",data);
			},"json");
			$.post("<%=path %>/shortBus/getGiftTypeList.do",function(data){
				$("#classType").combobox("loadData",data);
			},"json");
			$(document).ready(function(){
				var shortSchooltimeTShowArr = sessionStorage.getItem("shortSchooltimeTShowArr");
				if(shortSchooltimeTShowArr != null){
					shortSchooltimeTShowArr = eval("("+shortSchooltimeTShowArr+")");
					for(var i = 0,n = shortSchooltimeTShowArr.length;i < n;i++){
						var schooltimeAreaArr = [];
						gSchooltimeInd.push(i);
						schooltimeAreaArr.push("<tr class='shortSchooltimeId' id='shortSchooltimeId"+i+"' lessionHours='"+shortSchooltimeTShowArr[i].lessionHours+"' schooltime='"+shortSchooltimeTShowArr[i].schooltime+"'><td align='right'>上课计划：</td><td>"+shortSchooltimeTShowArr[i].schooltime+" "+shortSchooltimeTShowArr[i].startTime+"~"+shortSchooltimeTShowArr[i].endTime+"</td><td align='right'>教室：</td><td>"+shortSchooltimeTShowArr[i].roomName+"</td><td align='right'>课时：</td><td>"+shortSchooltimeTShowArr[i].lessionHours+"</td><td align='right'>老师：</td><td><ul>");
						for(var j = 0,m = shortSchooltimeTShowArr[i].classTeacherList.length;j < m;j++){
							schooltimeAreaArr.push("<li><span>"+shortSchooltimeTShowArr[i].classTeacherList[j].teacherName+"</span><span style='padding-left:15px'>"+shortSchooltimeTShowArr[i].classTeacherList[j].teacherType+"</span></li>");
						}
						schooltimeAreaArr.push("</ul></td><td><a href='javascript:void(0)' onclick='delShortSchooltime("+i+")'>删除</a></td></tr>");
						$("#schooltimeArea").before(schooltimeAreaArr.join(""));
					}
				}else{
					$("#schooltimeArea").before("<tr><td colspan='9' align='center'>暂无上课计划</td></tr>");
				}
				$("#classType").combobox({
					formatter:function(data){
						return '<span>'+data.typeName+'</span>';
					}, 
					valueField: 'giftType', 
					textField: 'typeName',
					panelHeight: 'auto',
					editable:false
				});
				$("#schoolManId").combobox({
					formatter:formatSchool, 
					valueField: 'schoolId', 
					textField: 'schoolName', 
					panelHeight: 'auto',
					editable:false
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
				$("textarea").each(function(i,node){
					$(node).attr("maxlength",500);
				});
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
				else if(isNaN(planHours))
				{
					$.messager.alert('提示',"计划课时量不合法,请核实后重新尝试","info");
				}
				else if(parseInt(planHours) > schooltimeCnt)
				{
					$.messager.alert('提示',"上课计划未达到计划总课时量,请核实后重新尝试","info");
				}
				else if(parseInt(planHours) < schooltimeCnt)
				{
					$.messager.alert('提示',"上课计划已超过计划总课时量,请核实后重新尝试","info");
				}
				else if(planClassNum == "")
				{
					$.messager.alert('提示',"计划上课人数不能为空,请核实后重新尝试","info");
				}
				else if(isNaN(planClassNum))
				{
					$.messager.alert('提示',"计划上课人数不合法,请核实后重新尝试","info");
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
						schoolId:schoolManId,
						classTypeId:classType,
						className:className,
						planClassNum:planClassNum,
						planHours:planHours,
						openDate:classStartTime,
						finishDate:classEndTime,
						remark:string2Json(remark),
						createId:${sessionScope.StaffT.staffId},
						handlerId:${sessionScope.StaffT.staffId}
					};
					ajaxLoading("正在处理，请稍待。。。");
					$.post("/sys/shortBus/addShortClassInstTInfo.do",{jsonClass:JSON.stringify(json),jsonSchooltimeGroup:sessionStorage.getItem("shortSchooltimeTArr"),className:encodeURI("小拼暑类班")},function(data){
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
					ajaxLoading("正在处理，请稍待。。。");
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
		            	$("#shortSchooltimeId"+val).remove();
                		var pos = gSchooltimeInd.indexOf(val);
                		var shortSchooltimeTShowArr = sessionStorage.getItem("shortSchooltimeTShowArr");
                		var shortSchooltimeTArr = sessionStorage.getItem("shortSchooltimeTArr");
                		if(shortSchooltimeTShowArr != null){
                			shortSchooltimeTShowArr = eval("("+shortSchooltimeTShowArr+")");
                			shortSchooltimeTArr = eval("("+shortSchooltimeTArr+")");
                			gSchooltimeInd.splice(pos,1);
	                		shortSchooltimeTShowArr.splice(pos,1);
	                		shortSchooltimeTArr.splice(pos,1);
                		}
                		sessionStorage.setItem("shortSchooltimeTShowArr" , JSON.stringify(shortSchooltimeTShowArr));
                		sessionStorage.setItem("shortSchooltimeTArr" , JSON.stringify(shortSchooltimeTArr));
                		if($("#schooltimeList").find("tr").length == 1){
                			$("#schooltimeList").prepend("<tr><td colspan='9' align='center'>暂无上课计划</td></tr>");
                		}
		            }
		        });
			}
			function backFunc()
			{
				sessionStorage.clear();
				window.location.href = "/sys/shortClass/summerClassMan.jsp?funcNodeId=${funcNodeId}";
			}
		</script>
  	</head>
  	<body class="manage">
 		<input type="hidden" id="shortClassInstId" value="${shortClassInstId}" />
 		<div class="panel datagrid easyui-fluid" style="width:99%">
		  <div class="panel-header">
		    <div class="panel-title">新增小拼暑期班</div>
		    <div class="panel-tool"></div>
		  </div>
		</div>
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
			<tr id="schooltimeArea">
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
