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
  	</head>
  
  	<body class="easyui-layout manage">
  		<input type="hidden" id="classInstId" value="${classInstId}" />
  		<input type="hidden" id="funcNodeId" value="${funcNodeId}" />
  		<form id="fm" method="post">
			<div data-options="region:'north',title:'考勤信息',collapsible:false,height:550,maxHeight:550,border:false" style="min-width:1100px;width:99%;font-family:'微软雅黑';margin:0 auto;">
				<table align="center" class="tab" style="height:85%;width:99%;margin:0 auto;padding:0 0;border-top:1px solid #ccc;border-left:1px solid #ccc" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td align="left" colspan="14">考勤月份：<select id="yearList" name="yearList" style="width:100px" ></select>&nbsp;&nbsp;<select id="monthList" name="monthList" style="width:100px" ></select></td>
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
											<td align="center" width="3%" style="background-color:#fafafa">&nbsp;</td>
											<td align="left" width="11%" style="background-color:#fafafa">&nbsp;</td>
										</c:when>
										<c:otherwise>
											<td align="center" width="3%"><a href="javascript:void(0)" onclick="gotoAttendRecord('${node.classInstId}','${node.dateValue}','${node.classAttendId}','${node.calendarShow.realClassTime}')">${node.dateValue}</a></td>
											<td align="left" width="11%" style="font-size:12px">
												<c:if test="${node.calendarHidden.hourRange != ''}">
													${node.calendarHidden.hourRange}/${node.calendarHidden.roomName}<br />
													<c:forEach items="${node.calendarHidden.teacherList}" var="item">
														${item.schoolName} ${item.teacherName} ${item.teacherType}<br />
													</c:forEach>
												</c:if>
												<c:if test="${node.calendarShow.realClassTime != ''}">
													<c:choose>
														<c:when test="${node.calendarShow.planClassTime != ''}">
															计划日 已反馈
														</c:when>
														<c:otherwise>
															非计划日 已反馈
														</c:otherwise>
													</c:choose>
												</c:if>
												&nbsp;
											</td>	
										</c:otherwise>
									</c:choose>
							</c:when>
							<c:when test="${calendarInfoSize == i.count}">
									<c:choose>
										<c:when test="${node.dateValue == ''}">
											<td align="center" width="3%" style="background-color:#fafafa">&nbsp;</td>
											<td align="left" width="11%" style="background-color:#fafafa">&nbsp;</td>
										</c:when>
										<c:otherwise>
											<td align="center" width="3%"><a href="javascript:void(0)" onclick="gotoAttendRecord('${node.classInstId}','${node.dateValue}','${node.classAttendId}','${node.calendarShow.realClassTime}')">${node.dateValue}</a></td>
											<td align="left" width="11%" style="font-size:12px">
												<c:if test="${node.calendarHidden.hourRange != ''}">
													${node.calendarHidden.hourRange}/${node.calendarHidden.roomName}<br />
													<c:forEach items="${node.calendarHidden.teacherList}" var="item">
														${item.schoolName} ${item.teacherName} ${item.teacherType}<br />
													</c:forEach>
												</c:if>
												<c:if test="${node.calendarShow.realClassTime != ''}">
													<c:choose>
														<c:when test="${node.calendarShow.planClassTime != ''}">
															计划日 已反馈
														</c:when>
														<c:otherwise>
															非计划日 已反馈
														</c:otherwise>
													</c:choose>
												</c:if>
												&nbsp;
											</td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:when>
							<c:when test="${i.count%7 == 0}">
									<c:choose>
										<c:when test="${node.dateValue == ''}">
											<td align="center" width="3%" style="background-color:#fafafa">&nbsp;</td>
											<td align="left" width="11%" style="background-color:#fafafa">&nbsp;</td>
										</c:when>
										<c:otherwise>
											<td align="center" width="3%"><a href="javascript:void(0)" onclick="gotoAttendRecord('${node.classInstId}','${node.dateValue}','${node.classAttendId}','${node.calendarShow.realClassTime}')">${node.dateValue}</a></td>
											<td align="left" width="11%" style="font-size:12px">
												<c:if test="${node.calendarHidden.hourRange != ''}">
													${node.calendarHidden.hourRange}/${node.calendarHidden.roomName}<br />
													<c:forEach items="${node.calendarHidden.teacherList}" var="item">
														${item.schoolName} ${item.teacherName} ${item.teacherType}<br />
													</c:forEach>
												</c:if>
												<c:if test="${node.calendarShow.realClassTime != ''}">
													<c:choose>
														<c:when test="${node.calendarShow.planClassTime != ''}">
															计划日 已反馈
														</c:when>
														<c:otherwise>
															非计划日 已反馈
														</c:otherwise>
													</c:choose>
												</c:if>
												&nbsp;
											</td>
										</c:otherwise>
									</c:choose>
								</tr>
								<tr>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${node.dateValue == ''}">
										<td align="center" width="3%" style="background-color:#fafafa">&nbsp;</td>
										<td align="left" width="11%" style="background-color:#fafafa">&nbsp;</td>
									</c:when>
									<c:otherwise>
										<td align="center" width="3%"><a href="javascript:void(0)" onclick="gotoAttendRecord('${node.classInstId}','${node.dateValue}','${node.classAttendId}','${node.calendarShow.realClassTime}')">${node.dateValue}</a></td>
										<td align="left" width="11%" style="font-size:12px">
											<c:if test="${node.calendarHidden.hourRange != ''}">
												${node.calendarHidden.hourRange}/${node.calendarHidden.roomName}<br />
												<c:forEach items="${node.calendarHidden.teacherList}" var="item">
													${item.schoolName} ${item.teacherName} ${item.teacherType}<br />
												</c:forEach>
											</c:if>
											<c:if test="${node.calendarShow.realClassTime != ''}">
												<c:choose>
													<c:when test="${node.calendarShow.planClassTime != ''}">
														计划日 已反馈
													</c:when>
													<c:otherwise>
														非计划日 已反馈
													</c:otherwise>
												</c:choose>
											</c:if>
											&nbsp;
										</td>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</table>
				<p style="text-align:right;margin-right:5px">
					<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="backFunc()">返回</a>
				</p>
			</div>
		</form>
		<script type="text/javascript">
			var gYearMonthInfo = '${yearMonthInfo}';
			var gFirstFlag = false;
			try{
				gYearMonthInfo = eval("("+gYearMonthInfo+")");
			}catch(e){
			
			}
			$(document).ready(function(){
				ajaxLoadEnd();
				$("#yearList").combobox({
					formatter:function(data){
						return '<span>'+data.yearObj+'</span>';
					}, 
					valueField: 'yearObj', 
					textField: 'yearObj',
					panelHeight: 'auto',
					data:gYearMonthInfo,
					onLoadSuccess:function(data){
						$("#yearList").combobox("setValue","${year}");
					},
					onChange:function (data) {
						gFirstFlag = false;
						for(var i = 0,n = gYearMonthInfo.length;i < n;i++)
						{
							if(data == gYearMonthInfo[i].yearObj)
							{
								$("#monthList").combobox({data:gYearMonthInfo[i].monthArr});								
								return;
							}
						}
					}
				});
				$("#monthList").combobox({
					formatter:function(data){
						return '<span>'+data.monthObj+'</span>';
					}, 
					valueField: 'monthObj', 
					textField: 'monthObj',
					panelHeight: 'auto',
					onLoadSuccess:function(data){
						$("#monthList").combobox("setValue","${month}");
					},
					onChange:function (data) {
						if(gFirstFlag)
						{
							window.location.href = "/sys/attend/getAttenceCalendarView.do?classInstId=${classInstId}&year="+$("#yearList").combobox("getValue")+"&month="+$("#monthList").combobox("getValue")+"&funcNodeId=${funcNodeId}";
						}
						else
						{
							gFirstFlag = true;
						}
					}
				});
			});
			function gotoAttendRecord(classInstId,dateValue,classAttendId,realClassTime)
			{
				if(realClassTime != "")
				{
					ajaxLoading("加载中...");
					window.location.href = "/sys/attend/showAttenceRecord.do?classAttendId="+classAttendId+"&funcNodeId=${funcNodeId}&selDateStr=&classInstId=${classInstId}&comeFlag=attenceCalendarView";
				}
			}
			function backFunc()
			{
				window.location.href = "/sys/attence/attenceMan.jsp?funcNodeId=${funcNodeId}";
			}
		</script>
 	</body>
</html>