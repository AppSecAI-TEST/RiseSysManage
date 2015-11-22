<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String byName = request.getParameter("byName");
	String applyId = request.getParameter("applyId");
	String isFinish = request.getParameter("isFinish");
	String studentId = request.getParameter("studentId");
	String approveDate = request.getParameter("approveDate");
	String approveName = request.getParameter("approveName");
	String outClassId = request.getParameter("outClassId");
	String outClassName = request.getParameter("outClassName");
	String inSchoolName = request.getParameter("inSchoolName");
	String outSchoolId = request.getParameter("outSchoolId");
	String outSchoolName = request.getParameter("outSchoolName");
	String approveRemark = request.getParameter("approveRemark");
	String studentCourseId = request.getParameter("studentCourseId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/changeSchool/changeOut.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="转校转出">
  			<form id="changeOutSchoolFm">
  				<input type="hidden" id="applyId" name="applyId" value="<%=applyId %>"/>
  				<input type="hidden" id="isFinish" name="isFinish" value="<%=isFinish %>"/>
  				<input type="hidden" id="studentId" name="studentId" value="<%=studentId %>"/>
  				<input type="hidden" id="outClassId" name="outClassId" value="<%=outClassId %>"/>
  				<input type="hidden" id="outSchoolId" name="outSchoolId" value="<%=outSchoolId %>"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  				<input type="hidden" id="studentCourseId" name="studentCourseId" value="<%=studentCourseId %>"/>
  				<table width="100%" cellpadding="5px" class="maintable">
  					<tr>
  						<td align="right" width="10%"><span>学员姓名：</span></td>
  						<td width="10%"><span id="nameText"><%=name %></span></td>
  						<td align="right" width="10%"><span>英文名：</span></td>
  						<td width="12%"><span id="byNameText"><%=byName %></span></td>
  						<td align="right" width="10%"><span>联系电话：</span></td>
  						<td width="48%"><span id="phoneText"><%=phone %></span></td>
  					</tr>
  					<tr>
  						<td align="right" width="10%"><span>转出校区：</span></td>
  						<td width="10%"><span id="outSchoolNameText"><%=outSchoolName %></span></td>
  						<td align="right" width="10%"><span>原在读班级：</span></td>
  						<td width="12%"><span id="outClassNameText"><%=outClassName %></span></td>
  						<td align="right" width="10%"><span>转入校区：</span></td>
  						<td width="48%"><span id="inSchoolNameText"><%=inSchoolName %></span></td>
  					</tr>
  					<tr>
  						<td align="right" width="10%"><span>审批人：</span></td>
  						<td width="10%"><span id="approveNameText"><%=approveName %></span></td>
  						<td align="right" width="10%"><span>审批时间：</span></td>
  						<td width="12%"><span id="approveDateText"><%=approveDate %></span></td>
  						<td align="right" width="10%"><span>审批描述：</span></td>
  						<td width="48%"><span id="approveRemarkText"><%=approveRemark %></span></td>
  					</tr>
  					<tr>
  						<td align="right" width="10%"><span>备注：</span></td>
	  					<td width="90%" colspan="5">
		  					<textarea rows="6" cols="122" id="remark" name="remark" class="easyui-validatebox textbox"></textarea>
		  				</td>
  					</tr>
  					<tr>
  						<td colspan="6" align="right">
	  						<a href="javascript:void(0)" id="changeOutSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
		      				&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
		      				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  					</td>
  					</tr>
  				</table>
  			</form>
  		</div>
  		<div style="padding:5px 0;min-width:1101px; width:100%;">
  			<table class="easyui-datagrid" title="常规课信息" style="height:auto;" id="course_list_data" 
				url="<%=path %>/pubData/qryDataListByPage.do?param={funcNodeId:'1016',studentId:'<%=studentId %>'}" 
				pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'stageId',width:100,align:'center'">课程阶段</th>
						<th data-options="field:'courseStateText',width:100,align:'center'">课程状态</th>
						<th data-options="field:'paySchoolName',width:100,align:'center'">校区</th>
						<th data-options="field:'payDate',width:120,align:'center'">缴费日期</th>
						<th data-options="field:'feeTypeText',width:100,align:'center'">业绩类型</th>
						<th data-options="field:'className',width:100,align:'center'">班级</th>
						<th data-options="field:'startDate',width:120,align:'center'">开课日期</th>
						<th data-options="field:'finishDate',width:120,align:'center'">结课日期</th>
						<th data-options="field:'classProgress',width:100,align:'center'">课时进度</th>
						<th data-options="field:'classTeacherName',width:100,align:'center'">带班老师</th>
						<th data-options="field:'adviserName',width:100,align:'center'">业绩顾问</th>
						<th data-options="field:'adviserTeacherName',width:100,align:'center'">业绩老师</th>
						<th data-options="field:'dutyAdvisterName',width:100,align:'center'">责任顾问</th>
						<th data-options="field:'carerName',width:100,align:'center'">客户关怀</th>
					</tr>
				</thead>
			</table>
  		</div>
  	</body>
</html>
