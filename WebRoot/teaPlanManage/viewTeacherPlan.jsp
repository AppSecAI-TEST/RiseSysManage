<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="教质计划浏览">
  			<table width="98%" style="border:1px solid #ccc;font-family:'微软雅黑';margin-top:5px;height:30px;" align="center" cellspacing="2">
  				<tr>
					<td align="right" width="10%"><span>教质月份：</span></td>
					<td align="left" width="10%">${month}</td>
  					<td align="right" width="8%"><span>校区：</span></td>
	  				<td align="left" width="10%">${schoolName}</td>
					<td align="center" width="60%"></td>
  				</tr>
  			</table>
  			<table width="98%" cellpadding="2px" style="margin-top: 5px;margin-bottom: 5px;border:1px solid #ccc;" align="center" class="maintable">
	      	   <tr>
	      	     <td align="center" width="3%"><span>序号</span></td>
	      	   	 <td align="center" width="9%"><span>班级</span></td>
	      	   	 <td align="center" width="12%"><span>电教</span></td>
	      	   	 <td align="center" width="12%"><span>家长会</span></td>
	      	   	 <td align="center" width="12%"><span>公开课</span></td>
	      	   	 <td align="center" width="12%"><span>毕业典礼</span></td>
	      	   	 <td align="center" width="15%"><span>是否开教质事件</span></td>
	      	   	 <td align="center" width="25%"><span>说明</span></td>
     	       </tr>
     	       <c:forEach items="${obj.teachingPlan}" var="teachingPlan" varStatus="status">
				<tr>
					<td align="center">${status.count}</td>
					<td align="center">${teachingPlan.className}</td>
					<td align="center">${teachingPlan.teachingDate}</td>
					<td align="center">${teachingPlan.meetingDate}</td>
					<td align="center">${teachingPlan.openClassDate}</td>
					<td align="center">${teachingPlan.gradDate}</td>
					<c:if test="${teachingPlan.teachingIsOpen == 'Y'}">
						<td align="center">是</td>
					</c:if>
					<c:if test="${teachingPlan.teachingIsOpen == 'N'}">
						<td align="center">否</td>
					</c:if>
					<td align="left">${teachingPlan.remark}</td>
				</tr>
			</c:forEach>
      	    </table>
  		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:right">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:80px; height: 28px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
  	</body>
</html>
