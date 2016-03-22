<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String operate =request.getParameter("operate");
	String year =request.getParameter("year");
	String month =request.getParameter("month");
	String days =request.getParameter("days");
	String schoolTimeId =request.getParameter("schoolTimeId");
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/timeResource/addDays.js"></script>
		<style>
			.calendar-header
			{
				display:none;
			}
			
			.calendar-other-month
			{
				visibility:hidden;
			}
		</style>		
	</head>
	<body>
		<input id="year" type="hidden" value="<%=year%>"/>
		<input id="month" type="hidden" value="<%=month%>"/>
		<input id="days" type="hidden" value="<%=days%>"/>
		<input id="operate" type="hidden" value="<%=operate%>"/>
		<input id="schoolTimeId" type="hidden" value="<%=schoolTimeId%>"/>
		<div id="showDiv" class="easyui-calendar">
		</div>
  		<div style="text-align:right;margin:20px 0;">
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px" id="submitBtn">提交</a>
  				&nbsp;&nbsp;&nbsp;&nbsp;
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px" id="backBtn" >返回</a>	
  		</div>	
	</body>
</html>		