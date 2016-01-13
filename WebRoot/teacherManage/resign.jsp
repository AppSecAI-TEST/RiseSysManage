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
		<script type="text/javascript" src="<%=path %>/js/teacherManage/teacherManage.js"></script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="教师档案信息">
 			<input type="hidden" id="teacherId" value="${obj.teacherId}" />
 			<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
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
  				<tr>
  					<td align="right"><span>预离职操作时间：</span></td>
  					<td align="left">${retObj.rlInfo.createDate}</td>
  					<td align="right"><span>操作人：</span></td>
  					<td align="left">${retObj.rlInfo.handlerName}</td>
  					<td align="right"></td>
  					<td align="left"></td>
  				</tr>
  				<tr>
	 				<td align="right"><span>预离职备注：</span></td>
	 				<td colspan="5"><textarea rows="7" cols="100" id="rlRemark" name="rlRemark" readonly="readonly" class="easyui-validatebox textbox">${retObj.rlInfo.description}</textarea></td>
 				</tr>
 				<tr>
	 				<td align="right"><span>离职备注：</span></td>
	 				<td colspan="5"><textarea rows="7" cols="100" id="rRemark" name="rRemark" class="easyui-validatebox textbox"></textarea></td>
 				</tr>
  			</table>
  		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:center">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="resignSubmit()"><span>提交</span></a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
  	</body>
</html>
