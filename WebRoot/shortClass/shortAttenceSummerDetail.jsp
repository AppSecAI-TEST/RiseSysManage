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
				height:30px;
				border-right:1px solid #ccc;
				border-bottom:1px solid #ccc;
			}
			.tab tr td:nth-last-child(2n+1){
				padding-left:4px;
			}
			.tab tr td:nth-last-child(2n){
				padding-right:4px;
			}
		</style>
		<script type="text/javascript">
			ajaxLoadEnd();
			var gClassAttend = null;
			function addAttenceFunc()
			{
				ajaxLoading("正在处理，请稍待。。。");
				window.location.href = "/sys/shortBus/getShortClassAttendTInfo.do?funcNodeId=${funcNodeId}&shortClassInstId=${shortClassInstT.shortClassInstId}&pageName=shortAttenceSummerDetail";
			}
			function updateAttenceFunc()
			{
				if (gClassAttend != null)
				{
					ajaxLoading("正在处理，请稍待。。。");
					window.location.href =  "/sys/shortBus/shortAttenceUpdatePage.do?funcNodeId=${funcNodeId}&shortClassAttendId="+gClassAttend.value+"&pageName=shortAttenceSummerDetail";
				}
				else
				{
					$.messager.alert('提示',"请先选择要维护的考勤");
				}
			}
			function viewAttenceFunc()
			{
				if (gClassAttend != null)
				{
					ajaxLoading("正在处理，请稍待。。。");
					window.location.href =  "/sys/shortBus/shortAttenceViewPage.do?funcNodeId=${funcNodeId}&shortClassAttendId="+gClassAttend.value+"&pageName=shortAttenceSummerDetail";
				}
				else
				{
					$.messager.alert('提示',"请先选择要浏览的考勤");
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
				window.location.href = "/sys/shortClass/attenceSummerMan.jsp?funcNodeId=${funcNodeId}";
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
 		<table align="center" class="tab" style="height:90px;width:99%;margin:0 auto;margin-bottom:5px;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" width="15%">赠课类型：</td>
				<td width="18%">${shortClassInstT.giftTypeT.typeName}</td>
				<td align="right" width="15%">班级名称：</td>
				<td width="18%">${shortClassInstT.className}</td>
				<td align="right" width="15%">计划上课人数：</td>
				<td width="18%">${shortClassInstT.planClassNum}</td>
			</tr>
			<tr>
				<td align="right">计划课时量：</td>
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
		<table region="center" class="tab" style="width:99%;margin:0px auto;margin-bottom:5px;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
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
		<div style="margin:0 auto;padding:0 0;text-align:left;padding-right:2px;width:99%;margin-top:5px">
			<c:if test="${shortClassInstT.classState != '004'}">
	   			<a href="javascript:void(0)" id="addAttenceBtn" class="easyui-linkbutton" iconCls="icon-add" onclick="addAttenceFunc()" style="width: 100px;">添加考勤</a>
			</c:if>
   			<a href="javascript:void(0)" id="updateAttenceBtn" class="easyui-linkbutton" iconCls="icon-edit" onclick="updateAttenceFunc()" style="width: 100px;">修改考勤</a>
   			<a href="javascript:void(0)" id="viewAttenceBtn" class="easyui-linkbutton" iconCls="icon-search" onclick="viewAttenceFunc()" style="width: 100px;">浏览</a>
		</div>
		<table region="center" class="tab" id="attendList" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr class="headTr datagrid-header">
				<td>&nbsp;</td>
				<td>序号</td>
				<td>上课日期</td>
				<td>创建人</td>
				<td>创建时间</td>
				<td>应到人数</td>
				<td>实到人数</td>
				<td>请假人数</td>
				<td>旷课人数</td>
				<td>迟到人数</td>
			</tr>
			<c:choose>
				<c:when test="${fn:length(shortClassAttendTList) == 0}">
					<tr>
						<td colspan="11" align="center">暂无考勤记录</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${shortClassAttendTList}" var="node" varStatus="i">
						<tr>
							<td align="center"><input type="checkbox" name="shortClassAttendId" value="${node.shortClassAttendId}" onclick="classAttendCheckbox(this)" /></td>
							<td align="center">${i.count}</td>
							<td align="center"><fmt:formatDate value="${node.schooltime}" pattern="yyyy-MM-dd" /></td>
							<td align="center">${node.handlerObj.userName}</td>
							<td align="center"><fmt:formatDate value="${node.createDate}" pattern="yyyy-MM-dd" timeZone="GMT"/></td>
							<td align="center">${node.attendNum}</td>
							<td align="center">${node.realNum}</td>
							<td align="center">${node.leaveNum}</td>
							<td align="center">${node.truantNum}</td>
							<td align="center">${node.lateNum}</td>
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