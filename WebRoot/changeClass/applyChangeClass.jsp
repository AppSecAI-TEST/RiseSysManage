<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String byName = request.getParameter("byName");
	String stageId = request.getParameter("stageId");
	String schoolId = request.getParameter("schoolId");
	String classType = request.getParameter("classType");
	String className = request.getParameter("className");
	String studentId = request.getParameter("studentId");
	String schoolName = request.getParameter("schoolName");
	String teacherName = request.getParameter("teacherName");
	String classInstId = request.getParameter("classInstId");
	String classProgress = request.getParameter("classProgress");
	String changeClassNum = request.getParameter("changeClassNum");
	String studentCourseId = request.getParameter("studentCourseId");
	String courseStateText = request.getParameter("courseStateText");
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
  			<form id="applyChangeClassFm">
  				<input type="hidden" id="schoolId" name="schoolId" value="<%=schoolId %>"/>
  				<input type="hidden" id="studentId" name="studentId" value="<%=studentId %>"/>
  				<input type="hidden" id="outClassId" name="outClassId" value="<%=classInstId %>"/>
  				<input type="hidden" id="applyType" name="applyType" value="001"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  				<input type="hidden" id="studentCourseId" name="studentCourseId" value="<%=studentCourseId %>"/>
  				<table width="100%" cellpadding="5px" class="maintable" id="applyChangeClassTd">
  					<tr>
  						<td align="right"><span>校区：</span></td>
  						<td><span id="schoolNameText"><%=schoolName %></span></td>
  						<td align="right"><span>学员姓名：</span></td>
  						<td><span id="nameText"><%=name %></span></td>
  						<td align="right"><span>英文名：</span></td>
  						<td><span id="byNameText"><%=byName %></span></td>
  					</tr>
  					<tr>
  						<td align="right"><span>联系电话：</span></td>
  						<td><span id="phoneText"><%=phone %></span></td>
  						<td align="right"><span>在读班级：</span></td>
  						<td><span id="classNameText"><%=className %></span></td>
  						<td align="right"><span>课时进度：</span></td>
  						<td><span id="classProgressText"><%=classProgress %></span></td>
  					</tr>
  					<tr>
  						<td align="right"><span>带班老师：</span></td>
  						<td><span id="teacherNameText"><%=teacherName %></span></td>
  						<td align="right"><span>课程状态：</span></td>
  						<td><span id="courseStateText"><%=courseStateText %></span></td>
  						<td align="right"><span>本课程转班次数：</span></td>
  						<td><span id="changeClassNumText"><%=changeClassNum %></span></td>
  					</tr>
  					<tr>
  						<td align="right"><span>计划转入班级：</span></td>
  						<td colspan="5">
  							<select id="planInClassId" name="planInClassId" class="easyui-combobox" style="width: 200px; height: 25px;" required="true" 
								data-options="formatter:formatClassInst, valueField: 'classInstId', textField: 'className', panelHeight: 'auto',
				      			onLoadSuccess:function(data){$('#inClassId').combobox('setValue',data[0].classInstId);}" 
				      			url="<%=path %>/pubData/qryClassInstList.do?schoolId=<%=schoolId %>&courseType=001&stageId=<%=stageId %>&classType=<%=classType %>&classState='001','002','003'&classInstId=<%=classInstId %>">
				        	</select>
  						</td>
  					</tr>
  					<tr>
  						<td align="right"><span>上传转班单据：</span></td>
  						<td colspan="5"><input style="width: 500px; height: 28px;" class="easyui-filebox" name="imgUrl" id="imgUrl" data-options="prompt:''" ></td>
  					</tr>
  					<tr>
  						<td align="right"><span>转班情况说明：</span></td>
  						<td colspan="5">
  							<textarea rows="6" cols="122" id="remark" name="remark" required="true" class="easyui-validatebox textbox"></textarea>
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
