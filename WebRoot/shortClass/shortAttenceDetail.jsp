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
			}
			.tab tr td:nth-last-child(2n+1){
				padding-left:4px;
			}
			.tab tr td:nth-last-child(2n){
				padding-right:4px;
			}
		</style>
  	</head>
  
  	<body class="manage">
 		<table align="center" class="tab" style="height:90px;width:99%;margin:0 auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" width="15%">国际班类型：</td>
				<td width="18%">${shortClassInstT.shortClassTypeT.classType}</td>
				<td align="right" width="15%">班级名称：</td>
				<td width="18%">${shortClassInstT.className}</td>
				<td align="right" width="15%">开课日期：</td>
				<td width="18%"><fmt:formatDate value="${shortClassInstT.openDate}" pattern="yyyy-MM-dd" /></td>
			</tr>
			<tr>
				<td align="right">国际班上课校区：</td>
				<td>${shortClassInstT.schoolT.schoolName}</td>
				<td align="right">课时进度：</td>
				<td>${shortClassInstT.classProgress}/<c:choose><c:when test="${empty shortClassInstT.totalLessionHours}">${shortClassInstT.planHours}</c:when><c:otherwise>${shortClassInstT.totalLessionHours}</c:otherwise></c:choose></td>
				<td align="right">结课日期：</td>
				<td><fmt:formatDate value="${shortClassInstT.finishDate}" pattern="yyyy-MM-dd" /></td>
			</tr>
			<tr>
				<td align="right">班级状态：</td>
				<td>
					<c:choose>
						<c:when test="${shortClassInstT.classState == '001'}">
							未开课
						</c:when>
						<c:when test="${shortClassInstT.classState == '002'}">
							待开课
						</c:when>
						<c:when test="${shortClassInstT.classState == '003'}">
							开课在读
						</c:when>
						<c:when test="${shortClassInstT.classState == '004'}">
							结课
						</c:when>
						<c:when test="${shortClassInstT.classState == '005'}">
							解散
						</c:when>
					</c:choose>
				</td>
				<td align="right">放班人：</td>
				<td>${shortClassInstT.creatorObj.staffName}</td>
				<td align="right">放班日期：</td>
				<td><fmt:formatDate value="${shortClassInstT.putClassDate}" pattern="yyyy-MM-dd" /></td>
			</tr>
		</table>
		<table region="center" class="tab" style="width:99%;margin:5px auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc;" border="0" cellpadding="0" cellspacing="0">
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
							<td><fmt:formatDate value="${node.schooltime}" pattern="yyyy-MM-dd" /> ${node.hourRangeObj.paramDesc}</td>
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
			<tr class="headTr">
				<td>&nbsp;</td>
				<td>序号</td>
				<td>上课日期</td>
				<td>创建人</td>
				<td>创建时间</td>
				<td>是否已扎帐</td>
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
							<td align="center">${node.handlerObj.staffName}</td>
							<td align="center"><fmt:formatDate value="${node.createDate}" pattern="yyyy-MM-dd" timeZone="GMT"/></td>
							<td align="center"><c:choose><c:when test="${node.isTieOff == 0}">否</c:when><c:otherwise>是</c:otherwise></c:choose></td>
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
		<script type="text/javascript">
			var gClassAttend = null;
			function addAttenceFunc()
			{
				window.location.href = "/sys/shortBus/getShortClassAttendTInfo.do?funcNodeId=${funcNodeId}&shortClassInstId=${shortClassInstT.shortClassInstId}";
			}
			function updateAttenceFunc()
			{
				if (gClassAttend != null)
				{
					window.location.href =  "/sys/shortBus/shortAttenceUpdatePage.do?funcNodeId=${funcNodeId}&shortClassAttendId="+gClassAttend.value;
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
					window.location.href =  "/sys/shortBus/shortAttenceViewPage.do?funcNodeId=${funcNodeId}&shortClassAttendId="+gClassAttend.value;
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
				window.location.href = "/sys/shortClass/attenceInterMan.jsp?funcNodeId=${funcNodeId}";
			}
		</script>
 	</body>
</html>