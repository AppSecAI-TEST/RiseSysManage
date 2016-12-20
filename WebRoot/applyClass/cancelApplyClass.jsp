<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String classInstId = request.getParameter("classInstId");
	String applyId = request.getParameter("applyId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/applyClass/cancelApplyClass.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="取消放班申请信息">
	  		<input type="hidden" id="type" value="APPLY"/>
  			<table width="100%" cellpadding="5px" class="maintable" id="cancelApplyClassTd">
  				<tr>
  					<td align="right" width="10%"><span>课程阶段：</span></td>
  					<td width="20%"><span id="stageId"></span></td>
  					<td align="right" width="10%"><span>班级类型：</span></td>
  					<td width="20%" colspan="3"><span id="classType"></span></td>
  					<td align="right" width="10%"><span>班级名称：</span></td>
  					<td width="30%"><span id="className"></span></td>
  				</tr>
  				<tr>
  					<td align="right" width="10%"><span>开课时间：</span></td>
  					<td width="20%"><span id="startDate"></span></td>
  					<td align="right" width="10%"><span>放班申请时间：</span></td>
  					<td width="20%" colspan="3"><span id="applyDate"></span></td>
  					<td align="right" width="10%"><span>申请人：</span></td>
  					<td width="30%"><span id="applyName"></span></td>
  				</tr>
  				<tr>
  					<td align="right" width="10%"><span>学员来源类型：</span></td>
  					<td width="20%"><span id="studentChannelTypeVal"></span></td>
  					<td align="right" width="10%"><span>升学班级：</span></td>
  					<td colspan="5" width="60%"><span id="higherSchoolName"></span></td>
  				</tr>
  				<tr>
  					<td align="right" width="10%"><span>备注：</span></td>
  					<td width="90%" colspan="7"><span id="Applyremark"></span></td>
  				</tr>
  			</table>
  		</div>
  		<div style='height: 10px;'></div>
  		<div class='easyui-panel' style='min-width:1100px; width:99%;height:auto;' title='审批历史信息' id="tacheHistDiv">
  				
  		</div>
  		
  		<div id="schooltimeDiv" style="display: none;">
  			<tr>
	  			<td align="right" width="10%"><span id="schooltimeNameTd"></span></td>
		  		<td width="20%"><span id="schooltimeName"></span></td>
		  		<td align="right" width="10%"><span>教室：</span></td>
		  		<td width="5%"><span id="roomName"></span></td>
		  		<td align="right" width="10%"><span>课时：</span></td>
		  		<td width="5%"><span id="lessionHours"></span></td>
		  		<td align="right" width="10%"><span>带班老师：</span></td>
		  		<td width="30%"><span id="schoolTeacherName"></span></td>
		  	</tr>
  		</div>
  		
  		<div id="applyClassDiv" style="display: none;">
		  	<table width="100%" cellpadding="5px" class="maintables" id="applyClassApproveTd">
		  		<tr>
		  			<td align="right" width="10%"><span>审批人：</span></td>
		  			<td width="20%"><span id="userName"></span></td>
		  			<td align="right" width="10%"><span>审批结果：</span></td>
		  			<td width="20%"><span id="approveType"></span></td>
		  			<td align="right" width="10%"><span>审批时间：</span></td>
		  			<td width="30%"><span id="createDate"></span></td>
		  		</tr>
		  		<tr>
		  			<td align="right" width="10%"><span>备注：</span></td>
		  			<td width="90%" colspan="5"><span id="applyClassApproveRemark"></span></td>
		  		</tr>
		  	</table>
		</div>
  		
  		<div style="height: 10px;"></div>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="取消放班申请">
  			<form id="cancelApplyClassFm">
  				<input type="hidden" id="schoolId"/>
  				<input type="hidden" id="applyId" name="applyId" value="<%=applyId %>"/>
  				<input type="hidden" id="classInstId" name="classInstId" value="<%=classInstId %>"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
	  			<table width="100%" cellpadding="5px" class="maintable" id="cancelApplyClassTd">
	  				<tr>
	  					<td align="right" width="10%"><span>备注：</span></td>
  						<td width="90%">
  							<textarea rows="6" cols="122" id="remark" name="remark" class="textarea easyui-validatebox" validType="length[0,120]"></textarea>
  						</td>
	  				</tr>
  				</table>
  			</form>
  		</div>
  		
  		<div style="margin-top: 25px;min-width:1100px; width:99%;text-align: right">
	      	<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      	&nbsp;<a href="javascript:void(0)" id="activityBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	    </div>
  	</body>
</html>
