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
							${teacherNode.teacherT.byName}
						</c:if>
					</c:forEach>
				</td>
				<td align="right">计划TA老师：</td>
				<td>
					<c:forEach items="${shortClassTeacherTList}" var="teacherNode">
						<c:if test="${teacherNode.teacherType == 'TA'}">
							${teacherNode.teacherT.byName}
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
					<fmt:formatDate value="${shortClassInstT.createDate}" pattern="yyyy-MM-dd HH:mm:ss" timeZone="GMT"/>
				</td>				
				<td align="right">&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align="right">取消操作人：</td>
				<td>&nbsp;</td>
				<td align="right">取消时间：</td>
				<td>&nbsp;</td>				
				<td align="right">备注：</td>
				<td>${shortClassInstT.remark}</td>
			</tr>
		</table>
		<table region="center" class="tab" id="teacherList" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr class="headTr">
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
						<td colspan="9" align="center">暂无预约用户</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${shortClassInstT.classStudentList}" var="node" varStatus="i">
						<tr>
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
		<script type="text/javascript">
			ajaxLoadEnd();
			function backFunc()
			{
				window.history.back();
			}
		</script>
 	</body>
</html>