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
		<script type="text/javascript" src="<%=path %>/js/openClass/openClass.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1101px; width:100%;height:auto;" title="开班信息">
  			<form id="approveOpenFm">
  				<input type="hidden" id="channel" value="${obj.channel }"/>
  				<input type="hidden" id="applyId" name="applyId" value="${obj.createClassObj.applyId }"/>
  				<input type="hidden" id="classInstId" name="classInstId" value="${obj.createClassObj.classInstId }"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
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
  						<td align="right" width="10%"><span>开班申请说明：</span></td>
  						<td colspan="5" width="90%"><span>${obj.createClassObj.remark }</span></td>
  					</tr>
  					<tr>
  						<td align="right" width="10%"><span>开班审批：</span></td>
  						<td colspan="5" width="90%">
	  						<input type="radio" value="Y" name="approveType"/><span>同意开班</span>
	      					&nbsp;<input type="radio" value="N" name="approveType"/><span>不同意开班</span>
	  					</td>
  					</tr>
  					<tr>
  						<td align="right" width="10%"><span>审批意见：</span></td>
  						<td colspan="5" width="90%">
  							<textarea rows="6" cols="122" id="remark" name="remark" class="textarea easyui-validatebox" validType="length[0,120]"></textarea>
  						</td>
  					</tr>
  					<tr>
  						<td colspan="6" align="right">
  							<div style="text-align: right;">
	  							<a href="javascript:void(0)" id="approveSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	  							<c:if test="${empty obj.channel }">
			      					&nbsp;<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	  							</c:if>
	  							<c:if test="${not empty obj.channel }">
			      					&nbsp;<a href="javascript:void(0)" id="closeBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;">关闭</a>
	  							</c:if>
  							</div>
  						</td>
  					</tr>
	  			</table>
  			</form>
  		</div>
	    
	    <div style="padding:5px 0;min-width:1101px; width:100%;">
	  		<table class="easyui-datagrid" title="班级学员列表" style="height:auto;" id="list_data" 
	  			url="<%=path %>/pubData/qryDataListByPage.do?funcNodeId=1005&param={'classInstId':'${obj.createClassObj.classInstId }'}" 
		  		rownumbers="true" fitColumns="true" singleSelect="false">
				<thead>
					<tr>
						<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
						<th data-options="field:'byName',width:100,align:'center'">英文名</th>
						<th data-options="field:'payDate',width:100,align:'center'">缴费时间</th>
						<th data-options="field:'studentChannelType',width:100,align:'center'">学员来源</th>
						<th data-options="field:'identityId',width:200,align:'center'">证件号码</th>
						<th data-options="field:'phone',width:100,align:'center'">联系方式</th>
						<th data-options="field:'selectClassNum',width:100,align:'center'">定班次数</th>
						<th data-options="field:'waitClassDays',width:100,align:'center'">等班时长</th>
						<th data-options="field:'advisterName',width:100,align:'center'">业绩顾问</th>
						<th data-options="field:'adviserTeacherName',width:100,align:'center'">业绩老师</th>
					</tr>
				</thead>
			</table>
  		</div>
  	</body>
</html>
