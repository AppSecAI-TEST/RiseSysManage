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
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="教师档案信息">
  			<table width="100%" cellpadding="5px" class="maintable" id="teacherTd">
  				<tr>
  					<td align="right"><span>校区：</span></td>
  					<td align="left">${obj.schoolName}</td>
  					<td align="right"><span>教师姓名：</span></td>
  					<td align="left">${obj.teacherName}</td>
  					<td align="right"><span>英文名：</span></td>
  					<td align="left">${obj.byname}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>联系电话：</span></td>
  					<td align="left">${obj.phone}</td>
  					<td align="right"><span>入职日期：</span></td>
  					<td align="left">${obj.joinDate}</td>
  					<td align="right"><span>入职时长（月）：</span></td>
  					<td align="left">${obj.joinTime}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>教师状态：</span></td>
  					<td align="left">${obj.stateVal}</td>
  					<td align="right"><span>职务：</span></td>
  					<td align="left">${obj.postVal}</td>
  					<td align="right"><span>国籍：</span></td>
  					<td align="left">${obj.nationality}</td>
  				</tr>
  			  	<tr>
  					<td align="right"><span>持证情况：</span></td>
  					<c:if test="${obj.licenses == ''}">
  						<td align="left">无</td>
  					</c:if>
  					<c:if test="${obj.licenses != ''}">
	  					<td align="left">${obj.licenses}</td>
  					</c:if>
  					<td align="right"><span>持证数量：</span></td>
  					<td align="left">${licenseNum}</td>
  					<td align="right"><span>在读带班班级：</span></td>
  					<c:if test="${obj.classNames == ''}">
  						<td align="left">无</td>
  					</c:if>
  					<c:if test="${obj.classNames != ''}">
	  					<td align="left">${obj.classNames}</td>
  					</c:if>
  				</tr>
  				<tr>
  					<td align="right"><span>在读带班阶段：</span></td>
  					<c:if test="${obj.stageIds == ''}">
  						<td align="left">无</td>
  					</c:if>
  					<c:if test="${obj.stageIds != ''}">
	  					<td align="left">${obj.stageIds}</td>
  					</c:if>
  					<td align="right"><span>待培训阶段：</span></td>
  					<c:if test="${obj.trainingStageIds == ''}">
  						<td align="left">无</td>
  					</c:if>
  					<c:if test="${obj.trainingStageIds != ''}">
	  					<td align="left">${obj.trainingStageIds}</td>
  					</c:if>
  					<td align="right"><span>在读带班持证率：</span></td>
  					<td align="left">${rate}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>年级组：</span></td>
  					<c:if test="${obj.gradeTeamVal == ''}">
  						<td align="left">无</td>
  					</c:if>
  					<c:if test="${obj.gradeTeamVal != ''}">
	  					<td align="left">${obj.gradeTeamVal}</td>
  					</c:if>
  					<td></td>
  					<td></td>
  					<td></td>
  					<td></td>
  				</tr>
  			</table>
  			<c:if test="${fn:length(retObj.changeInfo) > 0}">
  				<table width="100%" cellpadding="5px" style="margin-top: 5px;margin-bottom: 5px;border-top: 1px solid #ccc;" class="maintable">
	  				<tr>
	  					<td width="15%" align="center"><span>操作类型</span></td>
	  					<td width="10%" align="center"><span>操作人</span></td>
	  					<td width="15%" align="center" ><span>操作时间</span></td>
	  					<td width="60%" align="center"><span>备注说明</span></td>
	  				</tr>
	  				<c:forEach items="${retObj.changeInfo}" var="changeInfo">
		  				<tr>
							<td align="center">${changeInfo.operName}</td>
							<td align="center">${changeInfo.handlerName}</td>
							<td align="center">${changeInfo.createDate}</td>
							<td align="center">${changeInfo.description}</td>
						</tr>
	  				</c:forEach>
  				</table>
  			</c:if>
  		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:center">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
  	</body>
</html>
