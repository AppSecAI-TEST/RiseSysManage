<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<%@ include file="../common/head.jsp" %>
	<%@ include file="../common/formvalidator.jsp" %>

	</head>

	<body>
	<div id="base">
  			<div id="u0">
        		<div id="u1">
          			<p><span></span></p>
        		</div>
      		</div>
			<div class="easyui-panel" style="width:99%;height:auto;" title="学员基础信息">
	      		<form id="studentFm">
	      			<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
	      			<input type="hidden" id="schoolId" name="schoolId" value="${sessionScope.StaffT.schoolId}"/>
	      			<table width="100%" cellpadding="5px" class="maintable" id="addStudentTd">
	      				<tr>
	      					<td width="13%" align="right">
	      						<span style="color: red;">*</span>
	      						<span>学员姓名：</span>
	      					</td>
	      					<td width="25%">
	      						<input name="name" id="name" type="text" class="easyui-textbox validatebox" required="true" style="width: 200px; height: 28px;"/>
	      					</td>
	      					<td width="13%" align="right">
	      						<span style="color: red;">*</span>
	      						<span>出生日期：</span>
	      					</td>
	      					<td width="15%">
	      						2010-10-10
	      					</td>
	      					<td align="right"><span>证件号码：</span></td>
	      					<td>1234567890</td>
      					</tr>
	      				<tr>
	      					<td align="right">
	      						<span style="color: red;">*</span>
	      						<span>性别：</span>
	      					</td>
	      					<td><span>男</span></td>
	      					<td align="right"><span>缴费时间：</span></td>
	      					<td><input name="byName" id="byName" type="text" class="easyui-textbox" style="width: 200px; height: 28px;"/></td>
	      					<td align="right"><span>课程类型：</span></td>
	      					<td><select name="advisterBSchoolId" class="easyui-combobox" id="advisterBSchoolId" style="width: 96px; height: 28px;"
	      						data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#advisterBSchoolId').combobox('setValue',data[0].schoolId);}"
	      						url="<%=path %>/pubData/qrySchoolList.do?schoolId=">
	      					  </select></td>
      					</tr>
	      			</table>
	      			<p>&nbsp;</p>
                </form>
	      	</div>
	      		 
		<iframe title="123123" id="frame1" name="frame1" src="/sys/course/linkcourse.jsp"  marginwidth=0 marginheight=0 frameborder=0 scrolling="auto" width="100%"></iframe>
		
		<iframe id="frame2" src="/sys/course/linkcourse.jsp"  marginwidth=0 marginheight=0 frameborder=0 scrolling="auto" width="100%"></iframe>
	
		<div style="margin-top: 50px;">
	      		<div style="float: left;margin-left: 900px;">
	      			<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      			&nbsp;<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onClick="javascript:window.history.back()">返回</a>
	      		</div>
	     </div>
	     </div>
	</body>

</html>
<script type="text/javascript">
	//提交课程
	$("#submit").click(function()
	{
		var l=frame1.window.build();
		alert((JSON.stringify(l)));
	});
	</script>