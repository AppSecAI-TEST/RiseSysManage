<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
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
  					<td width="20%"><span id="effectDate"></span></td>
  					<td align="right" width="10%"><span>学员来源：</span></td>
  					<td width="20%" colspan="3"><span id="studentChannelTypeVal"></span></td>
  					<td align="right" width="10%"><span>升学班级：</span></td>
  					<td width="30%"><span id="higherSchoolName"></span></td>
  				</tr>
  				<tr>
  					<td align="right" width="10%"><span>备注：</span></td>
  					<td width="90%" colspan="7"><span id="Applyremark"></span></td>
  				</tr>
  			</table>
  		</div>
  		<div style='height: 10px;'></div>
  		<div class='easyui-panel' style='min-width:1100px; width:99%;height:auto;' title='放班审批信息'>
  			<form id="cancelApplyClassFm">
  				<input type="hidden" id="applyId" name="applyId" value="<%=applyId %>"/>
  				<input type="hidden" id="classInstId" name="classInstId" value="<%=classInstId %>"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
	  			<table width="100%" cellpadding="5px" class="maintable" id="cancelApplyClassTd">
	  				<tr>
	  					<td align="right" width="10%"><span>放班审批：</span></td>
	  					<td width="90%">
	  						<input type="radio" value="Y" name="approveType"/><span>同意放班</span>
	      					&nbsp;<input type="radio" value="N" name="approveType"/><span>不同意放班</span>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>备注：</span></td>
  						<td width="90%">
  							<textarea rows="6" cols="122" id="remark" name="remark" required="true" class="easyui-validatebox textbox"></textarea>
  						</td>
	  				</tr>
  				</table>
  			</form>
  		</div>
  		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: left;margin-left: 900px;">
	      		<a href="javascript:void(0)" id="applyApproveSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      		&nbsp;<a href="javascript:void(0)" id="activityBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	    </div>
  	</body>
</html>
