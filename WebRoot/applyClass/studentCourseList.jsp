<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String stageId = request.getParameter("stageId");
	String classType = request.getParameter("classType");
	String schoolId = request.getParameter("schoolId");
	String className = request.getParameter("className");
	String funcNodeId = request.getParameter("funcNodeId");
	String classInstId = request.getParameter("classInstId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/applyClass/studentCourseList.js"></script>
  	</head>
  
  	<body style="padding-top:5px">
  		<form id="qryFm" style="margin:0 auto;">
  			<input type="hidden" id="stageId" name="stageId" value="<%=stageId %>"/>
  			<input type="hidden" id="classType" name="classType" value="<%=classType %>"/>
  			<input type="hidden" id="schoolId" name="schoolId" value="<%=schoolId %>"/>
  			<input type="hidden" id="className" name="className" value="<%=className %>"/>
  			<input type="hidden" id="classInstId" name="classInstId" value="<%=classInstId %>"/>
  			<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  			<table class="search_tab">
  				<tr>
  					<td align="right" style="min-width: 60px;"><span>班级：</span></td>
  					<td width="100px">
  						<input name="oldClassInstId" id="oldClassInstId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
  					</td>
  					<td align="right" style="min-width: 60px;"><span>学员姓名：</span></td>
  					<td width="100px">
  						<input name="studentId" id="studentId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
  					</td>
  					<td align="right" style="min-width: 60px;"><span>联系电话：</span></td>
  					<td width="100px">
  						<input name="phone" id="phone" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
  					</td>
  					<td align="right" style="min-width: 60px;"><span>缴费日期：</span></td>
	  				<td style="min-width: 220px;">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTime" name="startTime" data-options="formatter:myformatter, parser:myparser"/>
						至
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTime" name="endTime" data-options="formatter:myformatter, parser:myparser"/>
					</td>
  				</tr>
  				<tr>
  					<td align="right" style="min-width: 60px;"><span>业绩类型：</span></td>
			  			<td style="min-width: 100px;">
							<select id="feeType" name="feeType" class="easyui-combobox" style="width: 100px; height: 25px;"
								data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" editable="false"
				      			url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=FEE_TYPE">
				        	</select>
						</td>
  					<td align="right" style="min-width: 60px;"><span>业绩顾问：</span></td>
  					<td width="100px">
  						<select id="adviser" name="adviser" class="easyui-combobox" style="width: 100px; height: 25px;"
  							data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', panelHeight: 'auto'"
     						url="<%=path %>/pubData/qryStaffList.do?post=16,17&schoolId=${sessionScope.StaffT.schoolId}">
		        		</select>
  					</td>
  					<td align="right" style="min-width: 60px;"><span>业绩老师：</span></td>
  					<td width="100px" colspan="2">
  						<select id="adviserTeacher" name="adviserTeacher" class="easyui-combobox" style="width: 100px; height: 25px;"
  							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'"
      						url="<%=path %>/pubData/qryTeacherList.do?schoolId=${sessionScope.StaffT.schoolId}&stageId=">
		        		</select>
  					</td>
  					<td align="left">
  						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1004">查询</a>
						&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
  					</td>
  				</tr>
  			</table>
  		</form>
  		<div style="padding:5px 0;min-width:1100px; width:100%;">
  			<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="list_data" 
				toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
						<th data-options="field:'feeTypeText',width:100,align:'center'">业绩类型</th>
						<th data-options="field:'oldClassName',width:100,align:'center'">原班级</th>
						<th data-options="field:'payDate',width:100,align:'center'">缴费时间</th>
						<th data-options="field:'advisterName',width:100,align:'center'">招生顾问</th>
						<th data-options="field:'dutyAdvisterName',width:100,align:'center'">责任顾问</th>
						<th data-options="field:'phone',width:200,align:'center'">联系电话</th>
						<th data-options="field:'oldTeacherName',width:100,align:'center'">原带班老师</th>
						<th data-options="field:'selectClassNum',width:100,align:'center'">选班次数</th>
					</tr>
				</thead>
			</table>
  		</div>
  		<div id="toolbar" style="padding: 2px; height: auto">
	      	<a href="javascript:void(0)" id="addStudentCourseSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      	<a href="javascript:void(0)" id="activityBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
  		</div>
  	</body>
</html>
