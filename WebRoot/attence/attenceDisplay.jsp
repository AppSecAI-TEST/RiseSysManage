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
				<c:if test="${node.attendType != 'K'}">
					<tr>
						<td align="center">${i.count}</td>
						<td align="center">${node.studentName}</td>
						<td align="center">${node.studentT.byName}</td>
						<td align="center">${node.studentCourseT.courseStateName}</td>
						<td align="center">
							<c:choose>
								<c:when test="${node.attendType == 'N'}">
									正常上课
								</c:when>
								<c:when test="${node.attendType == 'B'}">
									迟到
								</c:when>
								<c:when test="${node.attendType == 'L'}">
									请假
								</c:when>
								<c:when test="${node.attendType == 'T'}">
									旷课
								</c:when>
							</c:choose>
						</td>
						<td align="center">
							<c:choose>
								<c:when test="${node.attendType == 'L' || node.attendType == 'T'}">
									&nbsp;
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${node.dress == 'N'}">
											未穿校服
										</c:when>
										<c:when test="${node.dress == 'Y'}">
											已穿校服
										</c:when>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:if>
			</c:forEach>
		</table>
		<div style="margin:0 auto;padding:0 0;text-align:right;padding-right:2px;width:99%;margin-top:10px">
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
		</div>
		<script type="text/javascript">
			$(document).ready(function(){
				ajaxLoadEnd();
			});
			
			function backFunc()
			{
				ajaxLoading("返回中...");
				if("attenceView" == "${comeFlag}")
				{
					window.location.href = "/sys/attend/getAttendView.do?funcNodeId=${funcNodeId}&classInstId=${classInstId}&selDateStr=${selDateStr}";
				}
				else if("attenceMan" == "${comeFlag}")
				{
					window.location.href = "/sys/attence/attenceMan.jsp?funcNodeId=${funcNodeId}";
				}
				else if("attenceCalendarView" == "${comeFlag}")
				{
					window.location.href = "/sys/attend/getAttenceCalendarView.do?classInstId=${classInstId}&funcNodeId=${funcNodeId}";	
				}
				else
				{
					window.location.href = "/sys/attend/getAttendOperate.do?funcNodeId=${funcNodeId}&classInstId=${classInstId}&selDateStr=${selDateStr}";
				}
				
			}
		</script>
 	</body>
</html>