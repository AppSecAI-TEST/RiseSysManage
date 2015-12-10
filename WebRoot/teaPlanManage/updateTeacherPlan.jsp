<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/pub/js/json.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json2.js"></script>
		<script type="text/javascript" src="<%=path %>/js/teaPlanManage/teaPlanManage.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/css/style.css">
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="教质计划修改">
  		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<table width="100%" style="border:1px solid #ccc;font-family:'微软雅黑';margin:0 auto;height:30px;" cellspacing="2">
  				<tr>
					<td align="right" width="10%"><span>教质月份：</span></td>
					<td align="left" width="10%">${month}</td>
  					<td align="right" width="8%"><span>校区：</span></td>
	  				<td align="left" width="10%">${schoolName}</td>
					<td align="center" width="60%"></td>
  				</tr>
  			</table>
  			<table width="100%" cellpadding="5px" style="margin-top: 5px;margin-bottom: 5px;border-top: 1px solid #ccc;border-bottom: 1px solid #ccc;" class="maintable">
	      	   <tr id="planTr">
	      	   	 <td align="center">班级</td>
	      	   	 <td align="center">电教</td>
	      	   	 <td align="center">家长会</td>
	      	   	 <td align="center">公开课</td>
	      	   	 <td align="center">毕业典礼</td>
     	       </tr>
     	       <c:forEach items="${obj.teachingPlan}" var="teachingPlan" varStatus="status">
     	        <input type="hidden" name="qualityId" id="qualityId${status.index}" value="${teachingPlan.qualityId}"/>
				<tr>
					<td align="center">${teachingPlan.className}</td>
					<td align="center"><input id="teachingDate${status.index}" dateVal="${teachingPlan.teachingDate}" class="easyui-datebox"  style='width:120px;' /></td>
					<td align="center"><input id="meetingDate${status.index}" dateVal="${teachingPlan.meetingDate}" class="easyui-datebox"  style='width:120px;' /></td>
					<td align="center"><input id="openClassDate${status.index}" dateVal="${teachingPlan.openClassDate}" class="easyui-datebox"  style='width:120px;' /></td>
					<td align="center"><input id="gradDate${status.index}" dateVal="${teachingPlan.gradDate}" class="easyui-datebox"  style='width:120px;' /></td>
				</tr>
			   </c:forEach>
      	    </table>
  		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: right;">
	      		<a href="javascript:void(0)" id="updatePlanSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;" onclick="updatePlanSubmit()">提交</a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
  	</body>
  	<script type="text/javascript">
		$(document).ready(function(){
   			for(var i = 0;i < ${fn:length(obj.teachingPlan)};i++){
   				var teachingDate = $("#teachingDate"+i+"").attr('dateVal');
   				if(teachingDate != "/"){
	   				$("#teachingDate"+i+"").datebox('setValue',teachingDate);
   				}
   				var meetingDate = $("#meetingDate"+i+"").attr('dateVal');
   				if(meetingDate != "/"){
	   				$("#meetingDate"+i+"").datebox('setValue',meetingDate);
   				}
   				var openClassDate = $("#openClassDate"+i+"").attr('dateVal');
   				if(openClassDate != "/"){
	   				$("#openClassDate"+i+"").datebox('setValue',openClassDate);
   				}
   				var gradDate = $("#gradDate"+i+"").attr('dateVal');
   				if(gradDate != "/"){
	   				$("#gradDate"+i+"").datebox('setValue',gradDate);
   				}
   			}
   		});
	</script>
</html>
