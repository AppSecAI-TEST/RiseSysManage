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
			$.post("<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=822&fieldId=schoolId",function(data){
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
					panelHeight: 'auto',
					//listHeight:150,
					editable:false,
					onSelect:function(data){
						$.post("/sys/pubData/getTeacherBySchoolId.do",{schoolId:data.schoolId},function(data){
							$("#teacherId").combobox("loadData",data);
						},"json");
					},
					onLoadSuccess:function(data){
						if(data.length > 0)
						{
							$("#schoolId").combobox("setValue",data[0].schoolId);
						}
					}
				});
				$("#tourismClassType").combobox({
					formatter:function(data){
						return '<span>'+data.classType+'</span>';
					}, 
					valueField: 'classTypeId', 
					textField: 'classType',
					panelHeight: 'auto',
					editable:false
				});
				$("#teacherId").combobox({
					formatter:function(row){
						return "<span>"+row.byName+"</span>";
					},
					valueField: 'teacherId', 
					textField: 'byName', 
					//panelHeight: 'auto',
					listHeight:150,
					editable:false
				});
				$("#tourismClassType").combobox("setValue","${shortClassInstT.classTypeId}");
				$("#className").textbox("setValue","${shortClassInstT.className}");
				$("#planClassNum").textbox("setValue","${shortClassInstT.planClassNum}");
				$("#classStartTime").datebox("setValue","<fmt:formatDate value='${shortClassInstT.openDate}' pattern='yyyy-MM-dd' />");
				$("#classEndTime").datebox("setValue","<fmt:formatDate value='${shortClassInstT.finishDate}' pattern='yyyy-MM-dd' />");
			});
			function addSubmitFunc()
			{
				var shortClassInstId = "${shortClassInstT.shortClassInstId}";
				var className = $("#className").textbox("getValue");
				var tourismClassType = $("#tourismClassType").combobox("getValue");
				var classStartTime = $("#classStartTime").datebox("getValue");
				var planClassNum = $("#planClassNum").textbox("getValue");
				var classEndTime = $("#classEndTime").combobox("getValue");
				var nowDate = new Date();
				var classStartTimeDate = new Date(classStartTime);
				var classEndTimeDate = new Date(classEndTime);
				if(classStartTime == "")
				{
					$.messager.alert('提示',"开课日期不能为空,请核实后重新尝试","info");
				}
				else if(classEndTime == "")
				{
					$.messager.alert('提示',"结课日期不能为空,请核实后重新尝试","info");
				}
				else if(planClassNum == "")
				{
					$.messager.alert('提示',"计划招生人数不能为空,请核实后重新尝试","info");
				}
				else if(isNaN(planClassNum))
				{
					$.messager.alert('提示',"计划招生人数不合法,请核实后重新尝试","info");
				}
				else if(classStartTimeDate.getTime() < nowDate.getTime())
				{
					$.messager.alert('提示',"游学开始日期必须大于当前时间,请核实后重新尝试","info");
				}
             	else if(classEndTimeDate.getTime() <= classStartTimeDate.getTime())
				{
					$.messager.alert('提示',"游学结束日期必须大于游学开始日期,请核实后重新尝试","info");
				}
				else if($(".teacherId").length == 0)
             	{
             		$.messager.alert('提示',"上课老师不能为空,请核实后重新尝试","info");
             	}
				else
				{
					var json = {
						shortClassInstId:shortClassInstId,
						className:className,
						classTypeId:tourismClassType,
						planClassNum:planClassNum,
						openDate:classStartTime,
						finishDate:classEndTime,
						handlerId:${sessionScope.StaffT.staffId},
						teacherList:null
					};
					var arr = [];
					$(".teacherId").each(function(i,node){
						var teacherObj = $(node).find("td:eq(0)");
						var obj = {
							shortClassTeacherId:teacherObj.attr("shortClassTeacherId"),
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
			function studentBoxFunc(obj)
			{
				$("input[name='studentId']").each(function(i,node){
					node.checked = obj.checked;
				});
			}
			function selectClassFunc()
			{
				ajaxLoading("正在处理，请稍待。。。");
				window.location.href = "/sys/shortClass/choiceTourismClassPage.jsp?funcNodeId=${funcNodeId}&shortClassInstId=${shortClassInstT.shortClassInstId}&pageName=shortTourismClassMan&classType="+encodeURI("游学");
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
					var teacherFlag = true;
					$(".teacherId").each(function(i,node){
						var teacherObj = $(node).find("td:eq(0)");
						if(teacherObj.attr("teacherId") == teacherId)
						{
							teacherFlag = false;
						}
					});
					if(teacherFlag)
					{
						if($(".teacherId").length == 0)
						{
							$("#emptyTeacher").remove();
						}
						ajaxLoading("正在处理，请稍待。。。");
						$.post("/sys/teacherManage/getTeacherInfo.do",{teacherId:teacherId},function(data){
							ajaxLoadEnd();
							var trData = "<tr id='teacherId"+data.teacherId+"' class='teacherId'><td align='center' width='15%' teacherId='"+data.teacherId+"' schoolId='"+data.schoolId+"'>"+$("#schoolId").combobox("getText")+"</td><td align='center' width='15%'>"+$("#teacherId").combobox("getText")+"</td><td align='left' width='70%' style='padding-left:30px'><a href='javascript:void(0)' onclick='delTeacherFunc("+data.teacherId+")'>删除</a></td></tr>";
							$("#teacherList tr:last").after(trData);
						},"json");
					}
					else
					{
						$.messager.alert('提示',"该老师已经被添加,请核实后重新尝试");
					}
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
			function viewClassFunc()
			{
				
			}
			function backFunc()
			{
				window.location.href = "/sys/shortClass/tourismClassMan.jsp?funcNodeId=${funcNodeId}";
			}
		</script>
  	</head>
  	<body class="manage">
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
			<c:choose>
				<c:when test="${fn:length(shortClassTeacherTList) == 0}">
					<tr id="emptyTeacher">
						<td colspan="3" align="center">暂无安排老师</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${shortClassTeacherTList}" var="node" varStatus="i">
						<tr id='teacherId${node.teacherT.teacherId}' class='teacherId'><td align='center' width='15%' shortClassTeacherId='${node.shortClassTeacherId}' teacherId='${node.teacherT.teacherId}' schoolId='${node.schoolId}'>${node.schoolT.schoolName}</td><td align='center' width='15%'>${node.teacherT.byName}</td><td width='70%' style='padding-left:30px'><a href='javascript:void(0)' onclick='delTeacherFunc("${node.teacherT.teacherId}")'>删除</a></td></tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		<div style="margin:0 auto;padding:0 0;text-align:left;padding-right:2px;width:99%;margin-top:5px">
			<a href="javascript:void(0)" id="selectClassBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;" onclick="selectClassFunc()">选班</a>
			<a href="javascript:void(0)" id="removeClassBtn" class="easyui-linkbutton" iconCls="icon-remove" style="width: 100px;" onclick="removeClassFunc()">移除</a>
			<a href="javascript:void(0)" id="viewClassBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="viewClassFunc()">浏览</a>
		</div>
		<table region="center" class="tab" id="studentList" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr class="headTr">
				<td><input type="checkbox" id="studentAllBox" onclick="studentBoxFunc(this)" /></td>
				<td>序号</td>
				<td>学员姓名</td>
				<td>英文名</td>
				<td>校区</td>
				<td>缴费日期</td>
				<td>本人证件号码</td>
				<td>联系方式</td>
				<td>班级</td>
				<td>业绩顾问</td>
				<td>业绩老师</td>
			</tr>
			<c:choose>	
				<c:when test="${fn:length(shortClassInstT.classStudentList) == 0}">
					<tr>
						<td colspan="11" align="center">暂无学生报名</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${shortClassInstT.classStudentList}" var="node" varStatus="i">
						<tr class="studentId" id="studentId${node.studentId}">
							<td align="center"><input type="checkbox" name="studentId" value="${node.studentId}" /></td>
							<td align="center">${i.count}</td>
							<td align="center">${node.studentT.name}</td>
							<td align="center">${node.studentT.byName}</td>
							<td align="center">${node.studentT.schoolT.schoolName}</td>
							<td align="center"><fmt:formatDate value="${node.studentCourseT.payDate}" pattern="yyyy-MM-dd" /></td>
							<td align="center">${node.studentT.identityId}</td>
							<td align="center"><c:forEach items="${node.studentT.contactList}" var="item" varStatus="j"><c:choose><c:when test="${j.last}">${item.phone}</c:when><c:otherwise>${item.phone},</c:otherwise></c:choose></c:forEach></td>
							<td align="center">${shortClassInstT.className}</td>
							<td align="center">${node.studentCourseT.adviserAObj.staffName} ${node.studentCourseT.adviserBObj.staffName}</td>
							<td align="center">${node.studentCourseT.adviserTeacherAObj.staffName} ${node.studentCourseT.adviserTeacherBObj.staffName}</td>
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