<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String applyId = request.getParameter("applyId");
	String channel = request.getParameter("channel");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/changeClass/view.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="浏览转班信息">
  			<input type="hidden" id="applyId" value="<%=applyId %>"/>
  			<input type="hidden" id="channel" value="<%=channel %>"/>
  			<table width="100%" cellpadding="5px" class="maintable" id="updateChangeClassTd">
  				<tr>
  					<td align="right" width="10%"><span>转班状态：</span></td>
  					<td width="12%"><span id="changeStateText"></span></td>
  					<td align="right" width="10%"><span>原班级：</span></td>
  					<td width="12%"><span id="outClass"></span></td>
  					<td align="right" width="12%"><span>转入班级：</span></td>
  					<td width="44%" colspan="3"><span id="inClass"></span></td>
  				</tr>
  				<tr>
  					<td align="right" width="10%"><span>业绩顾问：</span></td>
  					<td width="12%"><span id="adviserName"></span></td>
  					<td align="right" width="10%"><span>原带班老师：</span></td>
  					<td width="12%"><span id="outClassTeacherName"></span></td>
  					<td align="right" width="12%"><span>原课程状态：</span></td>
  					<td width="44%" colspan="3"><span id="oldCourseStateText"></span></td>
  				</tr>
  				<tr id="applyTr" style="display: none;">
  					<td align="right" width="10%"><span>申请时间：</span></td>
  					<td width="12%"><span id="applyDate"></span></td>
  					<td align="right" width="10%"><span>申请人：</span></td>
  					<td width="12%"><span id="applyName"></span></td>
  					<td align="right" width="12%"><span>申请说明：</span></td>
  					<td width="44%" colspan="3"><span id="applyRemark"></span></td>
  				</tr>
  				<tr id="approveTr" style="display: none;">
  					<td align="right" width="10%"><span>审批时间：</span></td>
  					<td width="12%"><span id="approveDate"></span></td>
  					<td align="right" width="10%"><span>审批人：</span></td>
  					<td width="12%"><span id="approveName"></span></td>
  					<td align="right" width="12%"><span>审批意见：</span></td>
  					<td width="10%"><span id="approveTypeText"></span></td>
  					<td align="right" width="10%"><span>审批说明：</span></td>
  					<td width="24%"><span id="approveRemark"></span></td>
  				</tr>
  				<tr id="outTr" style="display: none;">
  					<td align="right" width="10%"><span>转出时间：</span></td>
  					<td width="12%"><span id="outDate"></span></td>
  					<td align="right" width="12%"><span>转出人：</span></td>
  					<td width="68%" colspan="5"><span id="outName"></span></td>
  				</tr>
  				<tr id="inTr" style="display: none;">
  					<td align="right" width="12%"><span>转入时间：</span></td>
  					<td width="12%"><span id="inDate"></span></td>
  					<td align="right" width="10%"><span>转入人：</span></td>
  					<td width="68%" colspan="5"><span id="inName"></span></td>
  				</tr>
  				<tr id="cancelTr" style="display: none;">
  					<td align="right" width="10%"><span>取消时间：</span></td>
  					<td width="12%"><span id="cancelDate"></span></td>
  					<td align="right" width="10%"><span>取消人：</span></td>
  					<td width="68%" colspan="5"><span id="cancelName"></span></td>
  				</tr>
  				<tr id="stopTr" style="display: none;">
  					<td align="right" width="10%"><span>终止时间：</span></td>
  					<td width="12%"><span id="stopDate"></span></td>
  					<td align="right" width="10%"><span>终止人：</span></td>
  					<td width="68%" colspan="5"><span id="stopName"></span></td>
  				</tr>
  				<tr id="finishTr" style="display: none;">
  					<td align="right" width="10%"><span>完成时间：</span></td>
  					<td width="12%"><span id="finishDate"></span></td>
  					<td align="right" width="10%"><span>考勤人：</span></td>
  					<td width="68%" colspan="5"><span id="finishName"></span></td>
  				</tr>
  			</table>
  		</div>
  		<div style="text-align:right;margin-top: 25px;min-width:1100px; width:99%;">
			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 25px;" onclick="javascript:window.history.back()">返回</a>
  			<a href="javascript:void(0)" id="closeBtn" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px; display: none;">关闭</a>
	   </div>
  	</body>
</html>
