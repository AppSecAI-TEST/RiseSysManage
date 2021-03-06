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
			.tab td a{
				text-decoration:none;
				color:#000000;
			}
			.tab tr td:nth-last-child(2n+1){
				padding-left:4px;
			}
			.tab tr td:nth-last-child(2n){
				padding-right:4px;
			}
		</style>
		<script type="text/javascript">
			$(document).ready(function(){
				ajaxLoadEnd();
				var classAttendInfo = '${classAttendInfo}';
				var dataObj = null;
				if(classAttendInfo != "[]")
				{
					dataObj = eval("("+classAttendInfo+")");
				}
				else
				{
					dataObj = new Array();
				}
				$("#classAttendInfo").datagrid({
					data:dataObj,
					onClickRow:function(rowIndex, rowData){
				    	ajaxLoading("正在处理，请稍待。。。");
						window.location.href = "/sys/attend/showAttenceRecord.do?classAttendId="+rowData.classAttendId+"&funcNodeId=${funcNodeId}&selDateStr="+$("#selDateStr").html()+"&&classInstId=${classInstId}";
				    }
				});
			});
			function gotoAttendView(classAttendId)
			{
				ajaxLoading("正在处理，请稍待。。。");
				window.location.href = "/sys/attend/showAttenceRecord.do?classAttendId="+classAttendId+"&funcNodeId=${funcNodeId}&selDateStr="+$("#selDateStr").html()+"&classInstId=${classInstId}&comeFlag=attenceView";
			}
			function backFunc()
			{
				ajaxLoading("返回中...");
				window.location.href = "/sys/attend/getAttendDetail.do?funcNodeId=${funcNodeId}&classInstId=${classInstId}";
			}
		</script>
  	</head>
  	<body class="manage">
  		<input type="hidden" id="classInstId" value="${classInstId}" />
  		<input type="hidden" id="funcNodeId" value="${funcNodeId}" />
 		<input type="hidden" name="classInstId" value="${staffT.staffId}" />
		<div class="panel datagrid easyui-fluid" style="width:99%">
		  <div class="panel-header">
		    <div class="panel-title">考勤信息</div>
		    <div class="panel-tool"></div>
		  </div>
		</div>
		<table align="center" class="tab" style="height:55%;width:99%;margin:0px auto;margin-bottom:5px;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="left" colspan="14">月份：<span id="selDateStr">${selDateStr}</span></td>
			</tr>
			<tr>
				<td align="center" width="14%" colspan="2">周日</td>
				<td align="center" width="14%" colspan="2">周一</td>
				<td align="center" width="14%" colspan="2">周二</td>
				<td align="center" width="14%" colspan="2">周三</td>
				<td align="center" width="14%" colspan="2">周四</td>
				<td align="center" width="14%" colspan="2">周五</td>
				<td align="center" width="14%" colspan="2">周六</td>
			</tr>
			<c:set var="calendarInfoSize" value="${fn:length(calendarInfo)}" />
			<c:forEach items="${calendarInfo}" var="node" varStatus="i">
				<c:choose>
					<c:when test="${i.count == 1}">
						<tr>
							<c:choose>
								<c:when test="${node.dateValue == ''}">
									<td align="center" width="4%" style="background-color:#fafafa">&nbsp;</td>
									<td align="left" width="10%" style="background-color:#fafafa">&nbsp;</td>
								</c:when>
								<c:otherwise>
									<td align="center" width="4%"><a href="javascript:void(0)" <c:choose><c:when test="${node.calendarShow.realClassTime != ''}">onclick="gotoAttendView(${node.calendarHiddenRealList[0].classAttendId})"</c:when><c:otherwise>style="cursor:default"</c:otherwise></c:choose>>${node.dateValue}</a></td>
									<td align="left" width="10%" <c:if test="${fn:length(node.calendarHiddenPlanList) > 0 || fn:length(node.calendarHiddenRealList) > 0}">title="<c:if test="${fn:length(node.calendarHiddenPlanList) > 0}">计划:<br /><c:forEach items='${node.calendarHiddenPlanList}' var='nodeObj'>${nodeObj.hourRange}/${nodeObj.roomName}<br /><c:forEach items='${nodeObj.teacherList}' var='item'>${item.schoolName} ${item.teacherName} ${item.teacherType}<br /></c:forEach></c:forEach></c:if><c:if test="${fn:length(node.calendarHiddenRealList) > 0}">实际:<br /><c:forEach items='${node.calendarHiddenRealList}' var='nodeObj'>${nodeObj.hourRange}/${nodeObj.roomName}<br /><c:forEach items='${nodeObj.teacherList}' var='item'>${item.schoolName} ${item.teacherName} ${item.teacherType}<br /></c:forEach></c:forEach></c:if>" class="easyui-tooltip" style="cursor:pointer" </c:if>>
										<c:if test="${node.calendarShow.planClassTime != ''}">
											计划:${node.calendarShow.planClassTime}
										</c:if>
										<c:if test="${node.calendarShow.realClassTime != ''}">
											<br />
											实际:${node.calendarShow.realClassTime}
										</c:if>
									</td>	
								</c:otherwise>
							</c:choose>
					</c:when>
					<c:when test="${calendarInfoSize == i.count}">
							<c:choose>
								<c:when test="${node.dateValue == ''}">
									<td align="center" width="4%" style="background-color:#fafafa">&nbsp;</td>
									<td align="left" width="10%" style="background-color:#fafafa">&nbsp;</td>
								</c:when>
								<c:otherwise>
									<td align="center" width="4%"><a href="javascript:void(0)" <c:choose><c:when test="${node.calendarShow.realClassTime != ''}">onclick="gotoAttendView(${node.calendarHiddenRealList[0].classAttendId})"</c:when><c:otherwise>style="cursor:default"</c:otherwise></c:choose>>${node.dateValue}</a></td>
									<td align="left" width="10%" <c:if test="${fn:length(node.calendarHiddenPlanList) > 0 || fn:length(node.calendarHiddenRealList) > 0}">title="<c:if test="${fn:length(node.calendarHiddenPlanList) > 0}">计划:<br /><c:forEach items='${node.calendarHiddenPlanList}' var='nodeObj'>${nodeObj.hourRange}/${nodeObj.roomName}<br /><c:forEach items='${nodeObj.teacherList}' var='item'>${item.schoolName} ${item.teacherName} ${item.teacherType}<br /></c:forEach></c:forEach></c:if><c:if test="${fn:length(node.calendarHiddenRealList) > 0}">实际:<br /><c:forEach items='${node.calendarHiddenRealList}' var='nodeObj'>${nodeObj.hourRange}/${nodeObj.roomName}<br /><c:forEach items='${nodeObj.teacherList}' var='item'>${item.schoolName} ${item.teacherName} ${item.teacherType}<br /></c:forEach></c:forEach></c:if>" class="easyui-tooltip" style="cursor:pointer" </c:if>>
										<c:if test="${node.calendarShow.planClassTime != ''}">
											计划:${node.calendarShow.planClassTime}
										</c:if>
										<c:if test="${node.calendarShow.realClassTime != ''}">
											<br />
											实际:${node.calendarShow.realClassTime}
										</c:if>
									</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:when>
					<c:when test="${i.count%7 == 0}">
							<c:choose>
								<c:when test="${node.dateValue == ''}">
									<td align="center" width="4%" style="background-color:#fafafa">&nbsp;</td>
									<td align="left" width="10%" style="background-color:#fafafa">&nbsp;</td>
								</c:when>
								<c:otherwise>
									<td align="center" width="4%"><a href="javascript:void(0)" <c:choose><c:when test="${node.calendarShow.realClassTime != ''}">onclick="gotoAttendView(${node.calendarHiddenRealList[0].classAttendId})"</c:when><c:otherwise>style="cursor:default"</c:otherwise></c:choose>>${node.dateValue}</a></td>
									<td align="left" width="10%" <c:if test="${fn:length(node.calendarHiddenPlanList) > 0 || fn:length(node.calendarHiddenRealList) > 0}">title="<c:if test="${fn:length(node.calendarHiddenPlanList) > 0}">计划:<br /><c:forEach items='${node.calendarHiddenPlanList}' var='nodeObj'>${nodeObj.hourRange}/${nodeObj.roomName}<br /><c:forEach items='${nodeObj.teacherList}' var='item'>${item.schoolName} ${item.teacherName} ${item.teacherType}<br /></c:forEach></c:forEach></c:if><c:if test="${fn:length(node.calendarHiddenRealList) > 0}">实际:<br /><c:forEach items='${node.calendarHiddenRealList}' var='nodeObj'>${nodeObj.hourRange}/${nodeObj.roomName}<br /><c:forEach items='${nodeObj.teacherList}' var='item'>${item.schoolName} ${item.teacherName} ${item.teacherType}<br /></c:forEach></c:forEach></c:if>" class="easyui-tooltip" style="cursor:pointer" </c:if>>
										<c:if test="${node.calendarShow.planClassTime != ''}">
											计划:${node.calendarShow.planClassTime}
										</c:if>
										<c:if test="${node.calendarShow.realClassTime != ''}">
											<br />
											实际:${node.calendarShow.realClassTime}
										</c:if>
									</td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${node.dateValue == ''}">
								<td align="center" width="4%" style="background-color:#fafafa">&nbsp;</td>
								<td align="left" width="10%" style="background-color:#fafafa">&nbsp;</td>
							</c:when>
							<c:otherwise>
								<td align="center" width="4%"><a href="javascript:void(0)" <c:choose><c:when test="${node.calendarShow.realClassTime != ''}">onclick="gotoAttendView(${node.calendarHiddenRealList[0].classAttendId})"</c:when><c:otherwise>style="cursor:default"</c:otherwise></c:choose>>${node.dateValue}</a></td>
								<td align="left" width="10%" <c:if test="${fn:length(node.calendarHiddenPlanList) > 0 || fn:length(node.calendarHiddenRealList) > 0}">title="<c:if test="${fn:length(node.calendarHiddenPlanList) > 0}">计划:<br /><c:forEach items='${node.calendarHiddenPlanList}' var='nodeObj'>${nodeObj.hourRange}/${nodeObj.roomName}<br /><c:forEach items='${nodeObj.teacherList}' var='item'>${item.schoolName} ${item.teacherName} ${item.teacherType}<br /></c:forEach></c:forEach></c:if><c:if test="${fn:length(node.calendarHiddenRealList) > 0}">实际:<br /><c:forEach items='${node.calendarHiddenRealList}' var='nodeObj'>${nodeObj.hourRange}/${nodeObj.roomName}<br /><c:forEach items='${nodeObj.teacherList}' var='item'>${item.schoolName} ${item.teacherName} ${item.teacherType}<br /></c:forEach></c:forEach></c:if>" class="easyui-tooltip" style="cursor:pointer" </c:if>>
									<c:if test="${node.calendarShow.planClassTime != ''}">
										计划:${node.calendarShow.planClassTime}
									</c:if>
									<c:if test="${node.calendarShow.realClassTime != ''}">
										<br />
										实际:${node.calendarShow.realClassTime}
									</c:if>
								</td>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</table>
		<table id="classAttendInfo" class="easyui-datagrid" title="" style="margin:0 auto;height:180px;width:99%" pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="attendDateName" width="10%" align="center">上课日期</th>
					<th field="hourRangeName" width="10%" align="center">实际上课时间</th>
					<th field="roomName" width="7%" align="center">教室</th>
					<th field="hours" width="7%" align="center">课时</th>
					<th field="teacherNames" width="9%" align="center">实际上课老师</th>
					<th field="attendNum" width="7%" align="center">应到人数</th>
					<th field="realNum" width="7%" align="center">实到人数</th>
					<th field="lateNum" width="7%" align="center">迟到</th>
					<th field="leaveNum" width="7%" align="center">请假</th>
					<th field="truantNum" width="7%" align="center">旷课</th>
					<th field="attendRateNum" width="7%" align="center">出勤率</th>
					<th field="createDateName" width="8%" align="center">考勤录入时间</th>
					<th field="handlerName" width="7%" align="center">录入人</th>
				</tr>
			</thead>
		</table>
		<p style="text-align:right;margin-right:5px">
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
		</p>
 	</body>
</html>