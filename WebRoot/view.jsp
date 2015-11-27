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
  	</head>
  
  	<body style="padding-top:5px">
  		<div id="tt" class="easyui-tabs" style="min-width:1110px;width:98%;height:auto;">
  			<div title="基础信息" style="padding:5px;display:block;">
  				<iframe scrolling="yes" frameborder="0"  src="/sys/student/viewStudent.jsp?studentId=<%=studentId %>" style="width:100%;height:100%;"></iframe>
  			</div>
  			<div title="课程信息" style="padding:5px;display:block;">
  				<iframe scrolling="yes" frameborder="0"  src="/sys/course/studentCourseList.jsp?studentId=<%=studentId %>" style="width:100%;height:100%;"></iframe>
  			</div>
  			<div title="赠品赠课" style="padding:5px;display:block;">
  				<iframe scrolling="yes" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
  			</div>
  			<div title="异动维护" style="padding:5px;display:block;">
  				<iframe scrolling="yes" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
  			</div>
  			<div title="退费信息" style="padding:5px;display:block;">
  				<iframe scrolling="yes" frameborder="0"  src="/sys/refund/studentRefundList.jsp?studentId=<%=studentId %>" style="width:100%;height:100%;"></iframe>
  			</div>
  			<div title="转班信息" style="padding:5px;display:block;">
  				<iframe scrolling="yes" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
  			</div>
  			<div title="转校信息" style="padding:5px;display:block;">
  				<iframe scrolling="yes" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
  			</div>
  			<div title="休学信息" style="padding:5px;display:block;">
  				<iframe scrolling="yes" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
  			</div>
  			<div title="异常信息" style="padding:5px;display:block;">
  				<iframe scrolling="yes" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
  			</div>
  			<div title="VIP信息" sty le="padding:5px;display:block;">
  				<iframe scrolling="yes" frameborder="0"  src="/sys/student/qryStudentVipById.do?type=VIEW&studentId=<%=studentId %>" style="width:100%;height:100%;"></iframe>
  			</div>
  		</div>
  	</body>
</html>
