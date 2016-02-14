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
			var gClassAttend = null;
			function addAttenceFunc()
			{
				ajaxLoading("正在处理，请稍待。。。");
				window.location.href = "/sys/shortClass/choiceForeignClassPage.jsp?funcNodeId=${funcNodeId}&shortClassInstId=${shortClassInstT.shortClassInstId}&classType="+encodeURI("外教课");
			}
			function cancelAttenceFunc()
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
			                			$(".headTr").after("<tr><td colspan='10' align='center'>暂无预约用户</td></tr>");
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
			function classAttendCheckbox(obj)
			{
				if(gClassAttend != null && gClassAttend != obj)
				{
					gClassAttend.checked = false;
				}
				gClassAttend = obj;			
			}
			function backFunc()
			{
				window.location.href = "/sys/shortClass/attenceForeignMan.jsp?funcNodeId=${funcNodeId}";
			}
		</script>
  	</head>
  	<body class="manage">
		<table align="center" class="tab" style="height:90px;width:99%;margin:0 auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" width="15%">班级名称：</td>
				<td width="18%">${shortClassInstT.className}</td>
				<td align="right" width="15%">计划上课时间：</td>
				<td width="18%"><fmt:formatDate value="${shortClassInstT.openDate}" pattern="yyyy-MM-dd" /></td>
				<td align="right" width="15%">预约人数：</td>
				<td width="18%">${shortClassInstT.realClassNum}</td>
			</tr>
			<tr>
				<td align="right">计划T老师：</td>
				<td>
					<c:forEach items="${shortClassTeacherTList}" var="teacherNode">
						<c:if test="${teacherNode.teacherType == 'T'}">
							${teacherNode.teacherT.teacherName}
						</c:if>
					</c:forEach>
				</td>
				<td align="right">计划TA老师：</td>
				<td>
					<c:forEach items="${shortClassTeacherTList}" var="teacherNode">
						<c:if test="${teacherNode.teacherType == 'TA'}">
							${teacherNode.teacherT.teacherName}
						</c:if>
					</c:forEach>
				</td>				
				<td align="right">&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align="right">创建人：</td>
				<td>
					${shortClassInstT.creatorObj.staffName}
				</td>
				<td align="right">创建时间：</td>
				<td>
					<fmt:formatDate value="${shortClassInstT.createDate}" pattern="yyyy-MM-dd HH:mm:ss" />
				</td>				
				<td align="right">&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		<div style="margin:0 auto;padding:0 0;text-align:left;padding-right:2px;width:99%;margin-top:5px">
   			<a href="javascript:void(0)" id="addAttenceBtn" class="easyui-linkbutton" iconCls="icon-add" onclick="addAttenceFunc()" style="width: 100px;">预约</a>
   			<a href="javascript:void(0)" id="cancelAttenceBtn" class="easyui-linkbutton" iconCls="icon-cancel" onclick="cancelAttenceFunc()" style="width: 100px;">取消预约</a>
		</div>
		<table region="center" class="tab" id="teacherList" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr class="headTr">
				<td>&nbsp;</td>
				<td>序号</td>
				<td>学员姓名</td>
				<td>班级类型</td>
				<td>业绩类型</td>
				<td>当前班级</td>
				<td>缴费日期</td>
				<td>课程状态</td>
				<td>证件号码</td>
				<td>联系电话</td>
			</tr>
			<c:choose>
				<c:when test="${fn:length(shortClassInstT.classStudentList) == 0}">
					<tr>
						<td colspan="10" align="center">暂无预约用户</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${shortClassInstT.classStudentList}" var="node" varStatus="i">
						<tr class="studentId" id="studentId${node.studentId}">
							<td align="center"><input type="checkbox" name="studentId" value="${node.studentId}" onclick="classAttendCheckbox(this)" /></td>
							<td align='center'>${i.count}</td>
							<td align='center'>${node.studentT.name}</td>
							<td align='center'>${node.studentCourseT.classType}</td>
							<td align='center'>
								<c:choose>
									<c:when test="${node.studentCourseT.feeType == '001'}">
										新招
									</c:when>
									<c:when test="${node.studentCourseT.feeType == '002'}">
										升学
									</c:when>
									<c:when test="${node.studentCourseT.feeType == '003'}">
										复读
									</c:when>
								</c:choose>	
							</td>
							<td align='center'>${node.studentCourseT.studentClassName}</td>
							<td align='center'>
								<fmt:formatDate value="${node.studentCourseT.payDate}" pattern="yyyy-MM-dd" />
							</td>
							<td align='center'>
								${node.studentCourseT.courseStateName}
							</td>
							<td align='center'>
								${node.studentT.identityId}
							</td>
							<td align='center'>
								<c:forEach items="${node.studentT.contactList}" var="item" varStatus="j">
									<c:choose>
										<c:when test="${j.last}">
											${item.phone}
										</c:when>
										<c:otherwise>
											${item.phone}/
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		<div style="margin:0 auto;padding:0 0;text-align:right;padding-right:2px;width:99%;margin-top:10px">
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
		</div>
 	</body>
</html>