<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String applyId = request.getParameter("applyId");
	String channel = request.getParameter("channel");
	String classInstId = request.getParameter("classInstId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/applyClass/cancelApplyClass.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="放班申请信息">
  			<input type="hidden" id="schoolId"/>
  			<input type="hidden" id="type" value="APPLY"/>
  			<input type="hidden" id="channel" value="<%=channel %>"/>
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
  					<td align="right" width="10%"><span>学员来源类型：</span></td>
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
  				<input type="hidden" id="approveApplyType" name="approveApplyType" value="APPLY"/>
	  			<table width="100%" cellpadding="5px" class="maintable" id="cancelApplyClassTd">
	  				<tr>
	  					<td align="right" width="10%"><span>放班审批：</span></td>
	  					<td width="90%">
	  						<input type="radio" value="Y" name="approveType"/><span>同意放班</span>
	      					&nbsp;<input type="radio" value="N" name="approveType"/><span>不同意放班</span>
	      					&nbsp;<a href="javascript:void(0)" id="view" class="easyui-linkbutton" iconCls="icon-redo" style="margin-left: 600px; width: 120px; height: 28px;">查看排期表</a>
	  					</td>
	  				</tr>
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
	      	<a href="javascript:void(0)" id="approveSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      	&nbsp;<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	&nbsp;<a href="javascript:void(0)" id="closeBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px; display: none;">关闭</a>
	    </div>
  	</body>
</html>
<script type="text/javascript" >
	$("#view").click(function() {
		var schoolId = $("#schoolId").val();
		parent.openUrl(10000 , '/sys/time/planRoom.jsp?schoolId='+schoolId , '排期表');
	});
</script>