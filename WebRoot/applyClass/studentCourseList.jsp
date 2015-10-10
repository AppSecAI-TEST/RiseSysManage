<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String classType = request.getParameter("classType");
	String schoolId = request.getParameter("schoolId");
	String className = request.getParameter("className");
	String classInstId = request.getParameter("classInstId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/applyClass/updateApplyClass.js"></script>
  	</head>
  
  	<body style="padding-top:5px">
  		<form id="qryFm" style="margin:0 auto;">
  			<input type="hidden" id="classType" name="classType" value="<%=classType %>"/>
  			<input type="hidden" id="schoolId" name="schoolId" value="<%=schoolId %>"/>
  			<input type="hidden" id="className" name="className" value="<%=className %>"/>
  			<input type="hidden" id="classInstId" name="classInstId" value="<%=classInstId %>"/>
  			<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin:0 auto;height:80px;">
  				<tr>
  					<td align="right"><span>班级：</span></td>
  					<td width="114px">
  						<select id="classInstId" name="classInstId" class="easyui-combobox" style="width: 114px; height: 25px;" editable="false">
		        		</select>
  					</td>
  					<td align="right"><span>学员姓名：</span></td>
  					<td width="114px">
  						<select id="studentId" name="studentId" class="easyui-combobox" style="width: 114px; height: 25px;" editable="false">
		        		</select>
  					</td>
  					<td align="right"><span>联系电话：</span></td>
  					<td width="114px">
  						<input name="phone" id="phone" type="text" class="easyui-textbox" style="width: 114px; height: 25px;"/>
  					</td>
  					<td colspan="2" align="center">
  						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1004">查询</a>
						&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>业绩顾问：</span></td>
  					<td width="114px">
  						<select id="adviser" name="adviser" class="easyui-combobox" style="width: 114px; height: 25px;" editable="false">
		        		</select>
  					</td>
  					<td align="right"><span>业绩老师：</span></td>
  					<td width="114px">
  						<select id="adviserTeacher" name="adviserTeacher" class="easyui-combobox" style="width: 114px; height: 25px;" editable="false">
		        		</select>
  					</td>
  					<td align="right"><span>缴费日期：</span></td>
	  				<td>
						<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="startTime" name="startTime" ata-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center"><span>至</span></td>
					<td>
						<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="endTime" name="endTime" data-options="formatter:myformatter, parser:myparser"/>
					</td>
  				</tr>
  			</table>
  		</form>
  		<div style="padding:5px 0;min-width:1100px; width:100%;">
  			<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="list_data" url="<%=path %>/pubData/qryDataListByPage.do?funcNodeId=1004&param={'classType':'<%=classType %>','schoolId':'<%=schoolId %>'}" 
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
  		
  		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: left;margin-left: 800px;">
	      		<a href="javascript:void(0)" id="addStudentCourseSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      		&nbsp;<a href="javascript:void(0)" id="activityBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	    </div>
  	</body>
</html>
