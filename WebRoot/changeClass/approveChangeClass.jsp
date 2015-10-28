<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String applyId = request.getParameter("applyId");
	String studentId = request.getParameter("studentId");
	String studentCourseId = request.getParameter("studentCourseId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/changeClass/approveChange.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="转班审批">
  			<form id="approveChangeClassFm">
  				<input type="hidden" id="applyId" name="applyId" value="<%=applyId %>"/>
  				<input type="hidden" id="applyType" name="applyType" value="001"/>
  				<input type="hidden" id="studentId" name="studentId" value="<%=studentId %>"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  				<input type="hidden" id="studentCourseId" name="studentCourseId" value="<%=studentCourseId %>"/>
  				<table width="100%" cellpadding="5px" class="maintable" id="approveChangeClassTd">
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
  						<td align="right" width="12%"><span>在读班级：</span></td>
  						<td width="14%"><span id="outClassNameText"></span></td>
  						<td align="right" width="12%"><span>课时进度：</span></td>
  						<td width="8%"><span id="classProgressText"></span></td>
  						<td align="right" width="12%"><span>课程状态：</span></td>
  						<td width="10%"><span id="courseStateText"></span></td>
  						<td align="right" width="12%"><span>本课程转班次数：</span></td>
  						<td width="20%"><span id="changeClassNumText"></span></td>
  					</tr>
  					<tr>
  						<td align="right" width="12%"><span>带班老师：</span></td>
  						<td width="14%"><span id="teacherNameText"></span></td>
  						<td align="right" width="12%"><span>计划转入班级：</span></td>
  						<td width="8%"><span id="inClassNameText"></span></td>
  						<td width="54%" align="center" colspan="4"></td>
  					</tr>
  					<tr>
  						<td align="right" width="12%"><span>申请时间：</span></td>
  						<td width="14%"><span id="applyDateText"></span></td>
  						<td align="right" width="12%"><span>申请人：</span></td>
  						<td width="8%"><span id="applyNameText"></span></td>
  						<td align="right" width="12%"><span>转班情况说明：</span></td>
  						<td width="34%" colspan="3"><span id="changeRemarkText"></span></td>
  					</tr>
  					<tr>
  						<td align="right" width="12%"><span>转班审批：</span></td>
  						<td width="88%" colspan="7">
	  						<input type="radio" value="Y" name="approveType"/><span>同意转班</span>
	      					&nbsp;<input type="radio" value="N" name="approveType"/><span>不同意转班</span>
	  					</td>
  					</tr>
  					<tr>
  						<td align="right" width="12%"><span>审批情况说明：</span></td>
  						<td width="88%" colspan="7">
	  						<textarea rows="6" cols="122" id="remark" name="remark" required="true" class="easyui-validatebox textbox"></textarea>
	  					</td>
  					</tr>
  				</table>
  			</form>
  		</div>
  		
  		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: left;margin-left: 800px;">
	      		<a href="javascript:void(0)" id="approveChangeSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      		&nbsp;<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
 	</body>
</html>
