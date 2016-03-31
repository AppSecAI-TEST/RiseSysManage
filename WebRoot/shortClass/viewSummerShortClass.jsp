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
			function backFunc()
			{
				window.history.back();
			}
		</script>
  	</head>
  	<body class="manage">
  		<div class="panel datagrid easyui-fluid" style="width:99%">
		  <div class="panel-header">
		    <div class="panel-title">班级基本信息</div>
		    <div class="panel-tool"></div>
		  </div>
		</div>
		<table align="center" class="tab" style="height:90px;width:99%;margin:0px auto;margin-bottom:5px;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" width="15%">赠课类型：</td>
				<td width="18%">${shortClassInstT.giftTypeT.typeName}</td>
				<td align="right" width="15%">班级名称：</td>
				<td width="18%">${shortClassInstT.className}</td>
				<td align="right" width="15%">计划上课人数：</td>
				<td width="18%">${shortClassInstT.planClassNum}</td>
			</tr>
			<tr>
				<td align="right">计划课时：</td>
				<td>${shortClassInstT.planHours}</td>
				<td align="right">开课日期：</td>
				<td><fmt:formatDate value="${shortClassInstT.openDate}" pattern="yyyy-MM-dd" /></td>
				<td align="right">结课日期：</td>
				<td><fmt:formatDate value="${shortClassInstT.finishDate}" pattern="yyyy-MM-dd" /></td>
			</tr>
		</table>
		<div class="panel datagrid easyui-fluid" style="width:99%">
		  <div class="panel-header">
		    <div class="panel-title">课程计划信息</div>
		    <div class="panel-tool"></div>
		  </div>
		</div>
		<table region="center" class="tab" id="attendList" style="width:99%;margin:0px auto;margin-bottom:5px;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<c:choose>
				<c:when test="${fn:length(shortClassInstT.classSchooltimeList) == 0}">
					<tr>
						<td colspan="9" align="center">暂无上课计划</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${shortClassInstT.classSchooltimeList}" var="node" varStatus="i">
						<tr>
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
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		<div class="panel datagrid easyui-fluid" style="width:99%">
		  <div class="panel-header">
		    <div class="panel-title">操作信息</div>
		    <div class="panel-tool"></div>
		  </div>
		</div>
		<table region="center" class="tab" id="studentList" style="width:99%;margin:0px auto;margin-bottom:5px;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr class="headTr datagrid-header">
				<td width="10%">操作类型</td>
				<td width="20%">操作时间</td>
				<td width="10%">操作人</td>
				<td width="10%">审批意见</td>
				<td>情况说明</td>
			</tr>
			<tr>
				<td align="center">放班申请</td>
				<td align="center"><fmt:formatDate value="${shortClassInstT.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td align="center">${shortClassInstT.creatorObj.userName}</td>
				<td align="center">&nbsp;</td>
				<td>${shortClassInstT.remark}</td>
			</tr>
			<c:if test="${!empty shortClassInstT.approveDate}">
				<tr>
					<td align="center">放班审批</td>
					<td align="center"><fmt:formatDate value="${shortClassInstT.approveDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td align="center">${shortClassInstT.approvePersonObj.userName}</td>
					<td align="center"><c:choose><c:when test="${shortClassInstT.classState != '005'}">同意放班</c:when><c:otherwise>不同意放班</c:otherwise></c:choose></td>
					<td>${shortClassInstT.verifyRemark}</td>
				</tr>
			</c:if>
		</table>
		<div class="panel datagrid easyui-fluid" style="width:99%">
		  <div class="panel-header">
		    <div class="panel-title">课程学员信息</div>
		    <div class="panel-tool"></div>
		  </div>
		</div>
		<table region="center" class="tab" id="studentList" style="width:99%;margin:0px auto;margin-bottom:5px;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr class="headTr datagrid-header">
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
							<td align="center">${node.normalClassName}</td>
							<td align="center">${node.studentCourseT.adviserAObj.userName}<c:if test="${!empty node.studentCourseT.adviserBObj.userName}">/${node.studentCourseT.adviserBObj.userName}</c:if></td>
							<td align="center">${node.studentCourseT.adviserTeacherAObj.userName}<c:if test="${!empty node.studentCourseT.adviserTeacherBObj.userName}">/${node.studentCourseT.adviserTeacherBObj.userName}</c:if></td>
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