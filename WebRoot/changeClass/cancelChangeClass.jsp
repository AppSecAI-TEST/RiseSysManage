<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String applyId = request.getParameter("applyId");
	String schoolId = request.getParameter("schoolId");
	String studentId = request.getParameter("studentId");
	String studentCourseId = request.getParameter("studentCourseId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/changeClass/cancelChange.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="取消转班">
  			<form id="cancelChangeClassFm">
  				<input type="hidden" id="outClassId" name="outClassId"/>
  				<input type="hidden" id="courseState" name="courseState"/>
  				<input type="hidden" id="oldCourseState" name="oldCourseState"/>
  				<input type="hidden" id="applyId" name="applyId" value="<%=applyId %>"/>
  				<input type="hidden" id="studentId" name="studentId" value="<%=studentId %>"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  				<input type="hidden" id="studentCourseId" name="studentCourseId" value="<%=studentCourseId %>"/>
  				<table width="100%" cellpadding="5px" class="maintable" id="cancelChangeClassTd">
  					<tr>
  						<td align="right" width="12%"><span>校区：</span></td>
  						<td width="14%"><span id="schoolNameText"></span></td>
  						<td align="right" width="12%"><span>学员姓名：</span></td>
  						<td width="8%"><span id="nameText"></span></td>
  						<td align="right" width="12%"><span>英文名：</span></td>
  						<td width="10%"><span id="byNameText"></span></td>
  						<td align="right" width="12%"><span>联系电话：</span></td>
  						<td width="20%"><span id="phoneText"></span></td>
  					</tr>
  					<tr>
  						<td align="right" width="12%"><span>原课程状态：</span></td>
  						<td width="14%"><span id="oldCourseStateText"></span></td>
  						<td align="right" width="12%"><span>本课程转班次数：</span></td>
  						<td width="8%"><span id="changeClassNumText"></span></td>
  						<td align="right" width="12%"><span>计划转入班级：</span></td>
  						<td width="10%"><span id="planInClassNameText"></span></td>
  						<td align="right" width="12%"><span>转出班带班老师：</span></td>
  						<td width="20%"><span id="teacherNameText"></span></td>
  					</tr>
  					<tr>
  						<td align="right" width="12%"><span>转出时间：</span></td>
  						<td width="14%"><span id="outDateText"></span></td>
  						<td align="right" width="12%"><span>转出操作人：</span></td>
  						<td width="8%"><span id="outHandlerNameText"></span></td>
  						<td align="right" width="12%"><span>转出班级：</span></td>
  						<td width="10%"><span id="outClassNameText"></span></td>
  						<td align="right" width="12%"><span>转出班级课时进度：</span></td>
  						<td width="20%"><span id="outClassProgressText"></span></td>
  					</tr>
  					<tr>
  						<td align="right" width="12%"><span>转入时间：</span></td>
  						<td width="14%"><span id="inDateText"></span></td>
  						<td align="right" width="12%"><span>转入操作人：</span></td>
  						<td width="8%"><span id="inHandlerNameText"></span></td>
  						<td align="right" width="12%"><span>转入班级：</span></td>
  						<td width="10%"><span id="inClassNameText"></span></td>
  						<td align="right" width="12%"><span>转入班级课时进度：</span></td>
  						<td width="20%"><span id="inClassProgressText"></span></td>
  					</tr>
  					<tr>
  						<td align="center" width="12%"><span>申请人</span></td>
  						<td align="center" width="14%"><span>申请时间</span></td>
  						<td width="74%" colspan="6">
  							<span style="display: inline-block; width: 100px;">转班情况说明</span>
  							<span style="display: none; width: 100px; margin-left: 450px;" id="imgUrl">
  								<a href="#" id="url" class="linkmore">查看转班申请单</a>
  							</span>
  						</td>
  					</tr>
  					<tr>
  						<td align="center" width="12%"><span id="applyNameText"></span></td>
  						<td align="center" width="14%"><span id="applyDateText"></span></td>
  						<td width="74%" colspan="6"><span id="applyRemarkText"></span></td>
  					</tr>
  					<tr>
  						<td align="center" width="12%"><span>审批人</span></td>
  						<td align="center" width="14%"><span>审批时间</span></td>
  						<td align="center" width="12%"><span>审批意见</span></td>
  						<td width="62%" colspan="5"><span>审批情况说明</span></td>
  					</tr>
  					<tr>
  						<td align="center" width="12%"><span id="approveNameText"></span></td>
  						<td align="center" width="14%"><span id="approveDateText"></span></td>
  						<td align="center" width="12%"><span id="approveTypeText"></span></td>
  						<td width="62%" colspan="5"><span id="approveRemarkText"></span></td>
  					</tr>
  					<tr>
  						<td align="right"><span>取消转班原因：</span></td>
  						<td colspan="7">
  							<textarea rows="6" cols="122" id="remark" name="remark" class="easyui-validatebox textbox"></textarea>
  						</td>
  					</tr>
  				</table>
  			</form>
  		</div>
  		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: left;margin-left: 800px;">
	      		<a href="javascript:void(0)" id="cancelChangeSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      		&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
  	</body>
</html>
