<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String studentId = request.getParameter("studentId");
	String classInstId = request.getParameter("classInstId");
	String stageId = request.getParameter("stageId");
	String classType = request.getParameter("classType");
	String studentCourseId = request.getParameter("studentCourseId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/applyClass/changeClass.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:100%;height:auto;" title="选班基础信息">
  			<form id="">
  				<input type="hidden" id="studentId" name="studentId" value="<%=studentId %>"/>
  				<input type="hidden" id="classInstId" name="classInstId" value="<%=classInstId %>"/>
  				<input type="hidden" id="stageId" name="stageId" value="<%=stageId %>"/>
  				<input type="hidden" id="classType" name="classType" value="<%=classType %>"/>
  				<input type="hidden" id="studentCourseId" name="studentCourseId" value="<%=studentCourseId %>"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  				<input type="hidden" id="oldClassName" name="oldClassName"/>
  				<table width="99.99%" cellpadding="5px" class="maintable">
  					<tr>
  						<td align="right" width="10%"><span>学员姓名：</span></td>
	  					<td width="20%"><span id="name"></span></td>
	  					<td align="right" width="10%"><span>出生日期：</span></td>
	  					<td width="20%"><span id="birthday"></span></td>
	  					<td align="right" width="10%"><span>业绩类型：</span></td>
	  					<td width="30%"><span id="feeTypeText"></span></td>
  					</tr>
  					<tr>
  						<td align="right" width="10%"><span>性别：</span></td>
	  					<td width="20%"><span id="sexText"></span></td>
	  					<td align="right" width="10%"><span>证件号码：</span></td>
	  					<td width="20%"><span id="identityId"></span></td>
	  					<td align="right" width="10%"><span>联系电话：</span></td>
	  					<td width="30%"><span id="phone"></span></td>
  					</tr>
  					<tr>
  						<td align="right" width="10%"><span>缴费时间：</span></td>
	  					<td width="20%"><span id="payDate"></span></td>
	  					<td align="right" width="10%"><span>班级类型：</span></td>
	  					<td width="20%"><span id="classType"><%=classType %></span></td>
	  					<td align="right" width="10%"><span>责任顾问：</span></td>
	  					<td width="30%"><span id="dutyAdvisterName"></span></td>
  					</tr>
  					<tr>
  						<td align="right" width="10%"><span>业绩老师：</span></td>
	  					<td width="20%"><span id="adviserTeacherName"></span></td>
	  					<td align="right" width="10%"><span>业绩顾问：</span></td>
	  					<td width="60%" colspan="3"><span id="adviserName"></span></td>
  					</tr>
  					<tr>
  						<td align="right" width="10%"><span>当前选班班级：</span></td>
	  					<td width="20%"><span id="selectClassName"></span></td>
	  					<td align="right" width="10%"><span>当前选班时间：</span></td>
	  					<td width="20%"><span id="selectClassDate"></span></td>
	  					<td align="right" width="10%"><span>选班次数：</span></td>
	  					<td width="30%"><span id="selectClassNum"></span></td>
  					</tr>
  					<tr>
  						<td align="right" width="10%"><span>更换选班：</span></td>
  						<td width="90%" colspan="5">
  							<select id="changeClassInstId" name="changeClassInstId" class="easyui-combobox" style="width: 150px; height: 25px;"
  							data-options="formatter:formatClassInst, valueField: 'classInstId', textField: 'className', panelHeight: 'auto',
  							onLoadSuccess:function(data){$('#changeClassInstId').combobox('setValue',data[0].classInstId);}"
  							url="<%=path %>/pubData/qryClassInstList.do?schoolId=${sessionScope.StaffT.schoolId}&courseType=001&stageId=<%=stageId %>&classType=<%=classType %>&classState='001','002'&classInstId=<%=classInstId %>">
		        			</select>
  						</td>
  					</tr>
  				</table>
  			</form>
  		</div>
  		<div style="height: 10px;"></div>
  		<div style="display: none;" id="changeDiv">
	  		<div class="easyui-panel" style="min-width:1100px; width:100%;height:auto;" title="选择班级情况">
	  			<form id="">
	  				<table width="99.99%" cellpadding="5px" class="maintable">
	  					<tr>
	  						<td align="right" width="10%"><span>班级名称：</span></td>
		  					<td width="15%"><span id="className"></span></td>
		  					<td align="right" width="10%"><span>放班时间：</span></td>
		  					<td width="15%"><span id="applyDate"></span></td>
		  					<td align="right" width="10%"><span>开班时间：</span></td>
		  					<td width="15%"><span id=effectDate></span></td>
		  					<td align="right" width="10%"><span>带班老师：</span></td>
		  					<td width="15%"><span id="teacherName"></span></td>
	  					</tr>
	  					<tr>
	  						<td align="right" width="10%"><span>定班人数：</span></td>
		  					<td width="20%"><span id="classStudentNum"></span></td>
		  					<td align="right" width="10%"><span>课程进度：</span></td>
		  					<td width="20%"><span id="classProgress"></span></td>
		  					<td align="right" width="10%"><span>上课时段：</span></td>
		  					<td width="30%" colspan="3"><span id="schooltimeName"></span></td>
	  					</tr>
	  				</table>
	  			</form>
	  		</div>
  		</div>
  		
  		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: left;margin-left: 900px;">
	      		<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      		&nbsp;<a href="javascript:void(0)" id="activityBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	    </div>
  	</body>
</html>
