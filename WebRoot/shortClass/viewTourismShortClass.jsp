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
		<table align="center" class="tab" style="height:90px;width:99%;margin:0 auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" width="15%">游学类型：</td>
				<td width="18%">${shortClassInstT.shortClassTypeT.classType}</td>
				<td align="right" width="15%">班级名称：</td>
				<td width="18%">${shortClassInstT.className}</td>
				<td align="right" width="15%">计划招生人数：</td>
				<td width="18%">${shortClassInstT.planClassNum}</td>
			</tr>
			<tr>
				<td align="right">游学开始日期：</td>
				<td><fmt:formatDate value="${shortClassInstT.openDate}" pattern="yyyy-MM-dd" /></td>
				<td align="right">游学结束日期：</td>
				<td><fmt:formatDate value="${shortClassInstT.finishDate}" pattern="yyyy-MM-dd" /></td>				
				<td align="right">&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		<table region="center" class="tab" id="teacherList" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<c:choose>
				<c:when test="${fn:length(shortClassTeacherTList) == 0}">
					<tr>
						<td colspan="9" align="center">暂无安排老师</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${shortClassTeacherTList}" var="node" varStatus="i">
						<tr>
							<tr><td align='center' width='15%'>${node.schoolT.schoolName}</td><td align='center' width='15%'>${node.teacherT.byName}</td><td width='70%' style='padding-left:30px'>&nbsp;</td></tr>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		<table region="center" class="tab" id="studentList" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr class="headTr">
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
						<td colspan="10" align="center">暂无学生报名</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${shortClassInstT.classStudentList}" var="node" varStatus="i">
						<tr class="studentId" id="studentId${node.studentId}">
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
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
		</div>
		<script type="text/javascript">
			ajaxLoadEnd();
			function backFunc()
			{
				window.history.back();
			}
		</script>
 	</body>
</html>