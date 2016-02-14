<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1101px; width:100%;height:auto;" title="班级信息">
  			<form id="updateApplyClassFm">
	  			<table width="99.99%" cellpadding="5px" class="maintable" id="cancelApplyClassTd">
	  				<tr>
	  					<td align="right" width="10%"><span>课程阶段：</span></td>
	  					<td width="20%"><span id="stageId">${obj.createClassObj.stageId }</span></td>
	  					<td align="right" width="10%"><span>班级类型：</span></td>
	  					<td width="20%"><span id="classType">${obj.createClassObj.classType }</span></td>
	  					<td align="right" width="10%"><span>班级名称：</span></td>
	  					<td width="30%"><span id="className">${obj.createClassObj.className }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>开课时间：</span></td>
	  					<td width="20%"><span>${obj.createClassObj.startDate }</span></td>
	  					<td align="right" width="10%"><span>学员来源类型：</span></td>
	  					<td width="20%"><span id="studentChannelTypeVal">${obj.createClassObj.studentChannelTypeVal }</span></td>
	  					<td align="right" width="10%"><span>来源班级：</span></td>
	  					<td width="30%"><span id="higherSchoolName">${obj.createClassObj.higherSchoolName }</span></td>
	  				</tr>
	  				<c:if test="${!empty obj.higherSchoolObj.rows}">
		  				<tr>
		  					<td colspan="6">
		  						<table width="100%" cellpadding="5px" class="maintable">
		  							<c:forEach items="${obj.higherSchoolObj.rows }" var="higherSchool">
			  							<tr>
			  								<td align="right" width='10%'><span>班级：</span></td>
			  								<td width="15%"><span>${higherSchool.className }</span></td>
			  								<td align="right" width='10%'><span>课时进度：</span></td>
			  								<td width="15%"><span>${higherSchool.classProgress }</span></td>
			  								<td align="right" width='10%'><span>在读人数：</span></td>
			  								<td width="15%"><span>${higherSchool.classStudentNum }</span></td>
			  								<td align="right" width='10%'><span>已升学人数：</span></td>
			  								<td width="15%"><span>${higherSchool.higherStudentNum }</span></td>
			  							</tr>
		  							</c:forEach>
		  						</table>
		  					</td>
		  				</tr>
	  				</c:if>
	  				<tr>
  						<td colspan="6">
  							<table width="100%" cellpadding="5px" class="maintable">
  								<tr>
  									<td align="center" width='10%'><span>序号</span></td>
  									<td align="center" width='15%'><span>上课时段</span></td>
  									<td align="center" width='10%'><span>教室</span></td>
  									<td align="center" width='10%'><span>课时</span></td>
  									<td align="center" width='55%'><span>带班老师</span></td>
  								</tr>
  								<c:forEach items="${obj.schooltimeObj.rows }" var="schooltime" varStatus="status">
	  								<tr>
	  									<td align="center" width='10%'><span>${status.index + 1 }</span></td>
	  									<td align="center" width='15%'><span>${schooltime.schooltimeName }</span></td>
	  									<td align="center" width='10%'><span>${schooltime.roomName }</span></td>
	  									<td align="center" width='10%'><span>${schooltime.lessionHours }</span></td>
	  									<td width='55%'>
	  										<c:forEach items="${schooltime.classTeacherList }" var="classTeacher">
	  											<span>
	  												${classTeacher.schoolName }&nbsp;${classTeacher.byname }&nbsp;${classTeacher.hours }&nbsp;${classTeacher.isLicense }&nbsp;
	  											</span>
	  										</c:forEach>
	  									</td>
	  								</tr>
  								</c:forEach>
  							</table>
  						</td>
  					</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>备注：</span></td>
	  					<td width="90%" colspan="5"><span id="Applyremark">${obj.createClassObj.remark }</span></td>
	  				</tr>
	  			</table>
  			</form>
  		</div>
  		<div style="height: 5px;"></div>
  		<div style="padding:5px 0;min-width:1101px; width:100%;">
  			<table class="easyui-datagrid" style="height: auto; width: 100%" id="list_data" title="放班班操作历史信息" fitColumns="true" singleSelect="false"
  				url="<%=path %>/pubData/qryData.do?param={'classInstId':'${obj.createClassObj.classInstId }','funcNodeId':'1008'}">
				<thead>
					<tr>
						<th data-options="field:'operType',width:100,align:'center'">操作类型</th>
						<th data-options="field:'createDate',width:120,align:'center'">操作时间</th>
						<th data-options="field:'operName',width:100,align:'center'">操作人</th>
						<th data-options="field:'approveRemark',width:150,align:'center'">审批意见</th>
						<th data-options="field:'remark',width:350,align:'center'">情况说明</th>
					</tr>
				</thead>
			</table>
  		</div>
  		<div style="text-align:center;margin-top: 25px;min-width:1100px; width:99%;">
  			<div style="float: left;margin-left: 800px;">
		      	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 25px;" onclick="javascript:window.history.back()">返回</a>
  			</div>
	   </div>
  	</body>
</html>
