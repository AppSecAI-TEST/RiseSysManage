<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String studentId = request.getParameter("studentId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
  		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript">
			$(document).ready(function() {
				var studentId = $("#studentId").val();
				$("#tt").tabs({
					onSelect: function (title) {
						var src = "";
						if(title == "基础信息") {
							src = "/sys/student/viewStudent.jsp?studentId=" + studentId;
						} else if(title == "课程信息") {
							src = "/sys/course/studentCourseList.jsp?studentId=" + studentId;
						} else if(title == "赠品赠课") {
							src = "/sys/giftManage/viewGift.jsp?studentId=" + studentId;
						} else if(title == "异动维护") {
							src = "/sys/exceptionManage/studentExceptionList.jsp?studentId=" + studentId;
						} else if(title == "退费信息") {
							src = "/sys/refund/studentRefundList.jsp?studentId=" + studentId;
						} else if(title == "转班信息") {
							src = "/sys/change/viewChangeInfo.do?param={'studentId':'"+studentId+"','funcNodeId':'1032'}&changeType=changeClass";
						} else if(title == "转校信息") {
							src = "/sys/change/viewChangeInfo.do?param={'studentId':'"+studentId+"','funcNodeId':'1033'}&changeType=changeSchool";
						} else if(title == "休学信息") {
							src = "/sys/change/viewChangeInfo.do?param={'studentId':'"+studentId+"','funcNodeId':'1034'}&changeType=leave";
						} else if(title == "异常信息") {
							src = "/sys/change/viewChangeInfo.do?param={'studentId':'"+studentId+"','funcNodeId':'1035'}&changeType=exception";
						} else if(title == "VIP信息") {
							src = "/sys/student/qryStudentVipById.do?type=VIEW&studentId=" + studentId;
						}
						var p = $(this).tabs("getTab", title);
						p.find("iframe").attr("src", src);
					}
				});
			});
		</script>
  	</head>
  
  	<body style="padding-top:5px;">
  		<div id="tt" class="easyui-tabs" style="min-width:1110px; width:98%; height:auto;">
  			<input type="hidden" id="studentId" value="<%=studentId %>"/>
  			<div title="基础信息" style="padding:5px;display:block;">
  				<iframe scrolling="yes" frameborder="0" src="/sys/student/viewStudent.jsp?studentId=<%=studentId %>" style="width:100%;height:100%;"></iframe>
  			</div>
  			<div title="课程信息" style="padding:5px;display:block;">
  				<iframe scrolling="yes" frameborder="0" src="" style="width:100%;height:100%;"></iframe>
  			</div>
  			<div title="赠品赠课" style="padding:5px;display:block;">
  				<iframe scrolling="yes" frameborder="0" src="" style="width:100%;height:100%;"></iframe>
  			</div>
  			<div title="异动维护" style="padding:5px;display:block;">
  				<iframe scrolling="yes" frameborder="0" src="" style="width:100%;height:100%;"></iframe>
  			</div>
  			<div title="退费信息" style="padding:5px;display:block;">
  				<iframe scrolling="yes" frameborder="0" src="" style="width:100%;height:100%;"></iframe>
  			</div>
  			<div title="转班信息" style="padding:5px;display:block;">
  				<iframe scrolling="yes" frameborder="0" src="" style="width:100%;height:100%;"></iframe>
  			</div>
  			<div title="转校信息" style="padding:5px;display:block;">
  				<iframe scrolling="yes" frameborder="0" src="" style="width:100%;height:100%;"></iframe>
  			</div>
  			<div title="休学信息" style="padding:5px;display:block;">
  				<iframe scrolling="yes" frameborder="0" src="" style="width:100%;height:100%;"></iframe>
  			</div>
  			<div title="异常信息" style="padding:5px;display:block;">
  				<iframe scrolling="yes" frameborder="0" src="" style="width:100%;height:100%;"></iframe>
  			</div>
  			<div title="VIP信息" sty le="padding:5px;display:block;">
  				<iframe scrolling="yes" frameborder="0" src="" style="width:100%;height:100%;"></iframe>
  			</div>
  		</div>
  	</body>
</html>
