<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String changeSource = request.getParameter("changeSource");
	String studentCourseId = request.getParameter("studentCourseId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/changeClass/applyChange.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="转班申请">
  			<form id="applyChangeClassFm" method="post" enctype="multipart/form-data">
  				<input type="hidden" id="stageId"/>
  				<input type="hidden" id="classType"/>
  				<input type="hidden" id="schoolId" name="schoolId"/>
  				<input type="hidden" id="studentId" name="studentId"/>
  				<input type="hidden" id="outClassId" name="outClassId"/>
  				<input type="hidden" id="courseState" name="courseState"/>
  				<input type="hidden" id="applyType" name="applyType" value="001"/>
  				<input type="hidden" id="changeSource" name="changeSource" value="<%=changeSource %>"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  				<input type="hidden" id="studentCourseId" name="studentCourseId" value="<%=studentCourseId %>"/>
  				<table width="100%" cellpadding="5px" class="maintable" id="applyChangeClassTd">
  					<tr>
  						<td align="right"><span>校区：</span></td>
  						<td><span id="schoolNameText"></span></td>
  						<td align="right"><span>学员姓名：</span></td>
  						<td><span id="nameText"></span></td>
  						<td align="right"><span>英文名：</span></td>
  						<td><span id="byNameText"></span></td>
  					</tr>
  					<tr>
  						<td align="right"><span>联系电话：</span></td>
  						<td><span id="phoneText"></span></td>
  						<td align="right"><span>在读班级：</span></td>
  						<td><span id="classNameText"></span></td>
  						<td align="right"><span>课时进度：</span></td>
  						<td><span id="classProgressText"></span></td>
  					</tr>
  					<tr>
  						<td align="right"><span>带班老师：</span></td>
  						<td><span id="teacherNameText"></span></td>
  						<td align="right"><span>课程状态：</span></td>
  						<td><span id="courseStateText"></span></td>
  						<td align="right"><span>本课程转班次数：</span></td>
  						<td><span id="changeClassNumText"></span></td>
  					</tr>
  					<tr>
  						<td align="right"><span>计划转入班级：</span></td>
  						<td colspan="5">
  							<select id="planInClassId" name="planInClassId" class="easyui-combobox" style="width: 200px; height: 25px;" editable="false">
				        	</select>
  						</td>
  					</tr>
  					<tr>
  						<td align="right"><span>上传转班单据：</span></td>
  						<td colspan="5">
							<input type="hidden" name="imgUrl" id="imgUrl"/>
	                        <input style="width: 500px; height: 28px;" class="easyui-filebox" name="fileName" id="fileName" data-options="prompt:''"/>
	                        <a href="javascript:void(0)" class="easyui-linkbutton" id="uploadBtn" iconCls="icon-save" iconCls="icon-save" style="width: 80px; height: 28px;">上传</a>
	                        <a href="javascript:void(0)" class="easyui-linkbutton" id="cancelUploadBtn" iconCls="icon-cancel" iconCls="icon-cancel" style="width: 80px; height: 28px;">取消</a>
  						</td>
  					</tr>
  					<tr>
  						<td align="right"><span>转班情况说明：</span></td>
  						<td colspan="5">
  							<textarea rows="6" cols="122" id="remark" name="remark" class="easyui-validatebox textbox"></textarea>
  						</td>
  					</tr>
  				</table>
  			</form>
  		</div>
  		
  		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: left;margin-left: 800px;">
	      		<a href="javascript:void(0)" id="applyChangeSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      		&nbsp;<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
  	</body>
</html>
