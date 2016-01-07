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
		<script type="text/javascript" src="<%=path %>/js/finishClass/finishClassList.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:98%;height:auto;" title="基数调整">
  			<form id="finishClassFm">
  				<input type="hidden" id="applyId" name="applyId" value="${obj.attendClassObj.applyId }"/>
  				<input type="hidden" id="schoolId" name="schoolId" value="${obj.attendClassObj.schoolId }"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  				<input type="hidden" id="classInstId" name="classInstId" value="${obj.attendClassObj.classInstId }"/>
  				<div class="easyui-panel" style="min-width:1100px; width:100%; height:auto;">
	  				<table width="100%" cellpadding="5px" class="maintable">
	  					<tr>
		  					<td align="right" width="10%"><span>课程阶段：</span></td>
		  					<td width="20%"><span id="stageIdText">${obj.attendClassObj.stageId }</span></td>
		  					<td align="right" width="10%"><span>班级类型：</span></td>
		  					<td width="20%"><span id="classTypeText">${obj.attendClassObj.classType }</span></td>
		  					<td align="right" width="10%"><span>班级名称：</span></td>
		  					<td width="30%"><span id="classNameText">${obj.attendClassObj.className }</span></td>
		  				</tr>
		  				<tr>
		  					<td align="right" width="10%"><span>开课时间：</span></td>
		  					<td width="20%"><span>${obj.attendClassObj.startDate }</span></td>
		  					<td align="right" width="10%"><span>学员来源类型：</span></td>
		  					<td width="20%"><span id="studentChannelTypeVal">${obj.attendClassObj.studentChannelTypeText }</span></td>
		  					<td align="right" width="10%"><span>来源班级：</span></td>
		  					<td width="30%"><span id="higherSchoolName">${obj.attendClassObj.higherSchoolName }</span></td>
		  				</tr>
		  				<tr>
		  					<td align="right" width="10%"><span>开班类型：</span></td>
		  					<td width="20%"><span>${obj.attendClassObj.openClassTypeText }</span></td>
		  					<td align="right" width="10%"><span>开班人数：</span></td>
		  					<td width="20%"><span id="studentChannelTypeVal">${obj.attendClassObj.openClassNum }</span></td>
		  					<td align="right" width="10%"><span>在读人数：</span></td>
		  					<td width="30%"><span id="higherSchoolName">${obj.attendClassObj.classStudentNum }</span></td>
		  				</tr>
		  				<tr>
		  					<td align="right" width="10%"><span>升学基数：</span></td>
		  					<td width="20%"><span>${obj.attendClassObj.classStudentNum }</span></td>
		  					<td align="right" width="10%"><span>已升学人数：</span></td>
		  					<td width="20%"><span id="studentChannelTypeVal">${obj.attendClassObj.higherStudentNum }</span></td>
		  					<td align="right" width="10%"><span>升学率：</span></td>
		  					<td width="30%"><span id="higherSchoolName">${obj.attendClassObj.higherRateText }</span></td>
		  				</tr>
		  				<tr>
		  					<td align="right" width="10%"><span>课时进度：</span></td>
		  					<td width="20%"><span>${obj.attendClassObj.classProgress }</span></td>
		  					<td align="right" width="10%"><span>持证率：</span></td>
		  					<td width="20%"><span id="studentChannelTypeVal">${obj.attendClassObj.licenseRateText }</span></td>
		  					<td align="right" width="10%"><span>班级性质：</span></td>
		  					<td width="30%"><span id="higherSchoolName">${obj.attendClassObj.handTypeText }</span></td>
		  				</tr>
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
	  					 
	  				</table>
			  		<div style="height: 5px;"></div>
			  		<div style="padding:5px 0;min-width:1100px; width:100%;">
			  			<table class="easyui-datagrid" title="调整历史" style="height:auto;" id="list_data" fitColumns="true" singleSelect="false"
			  				url="<%=path %>/pubData/qryDataListByPage.do?param={'classInstId':'${obj.attendClassObj.classInstId }','funcNodeId':'50047'}">
					  		<thead>
					  			<tr>
					  				<th data-options="field:'staffName',width:100,align:'center'">修改人</th>
					  				<th data-options="field:'createDate',width:80,align:'center'">修改时间</th>
					  				<th data-options="field:'originStudyingNum',width:100,align:'center'">原在读人数</th>
					  				<th data-options="field:'studyingNum',width:100,align:'center'">变更后在读人数</th>
					  				<th data-options="field:'originHigherBaseNum',width:180,align:'center'">原升学基数</th>
					  				<th data-options="field:'higherBaseNum',width:100,align:'center'">变更后升学基数</th>
					  				<th data-options="field:'originHigherNum',width:100,align:'center'">原升已升学人数</th>
					  				<th data-options="field:'higherNum',width:80,align:'center'">变更后升已升学人数</th>
					  			</tr>
					  		</thead>
					  	</table>
			  		</div>
  				</div>
  			</form>
  		</div>
  	</body>
</html>
