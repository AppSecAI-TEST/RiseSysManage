<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String schoolId = request.getParameter("schoolId");
	String funcNodeId = request.getParameter("funcNodeId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/changeClass/changeStudent.js"></script>
  	</head>
  
  	<body>
  		<input type="hidden" id="menuFuncNodeId" value="<%=funcNodeId %>"/>
  		<input type="hidden" id="schoolId" name="schoolId" value="<%=schoolId %>"/>
  		<form id="qryFm">
  			<table class="search_tab">
  				<tr>
  					<td align="right"><span>学员姓名：</span></td>
					<td width="100px">
						<input name="studentId" id="studentId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
					</td>
					<td align="right"><span>联系电话：</span></td>
					<td width="100px">
						<input name="phone" id="phone" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
					</td>
					<td align="right"><span>转出班老师：</span></td>
					<td width="100px">
						<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 100px; height: 25px;"
							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'" 
	      					url="<%=path %>/pubData/qryTeacherList.do?schoolId=<%=schoolId %>&stageId=">
				        </select>
					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>课程阶段：</span></td>
					<td width="100px">
						<select id="stageId" name="stageId" class="easyui-combobox" style="width: 100px; height: 25px;">
				       	</select>
					</td>
					<td align="right"><span>选择班级：</span></td>
					<td width="100px">
						<input name="classInstId" id="classInstId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
					</td>
					<td align="right"><span>课程状态：</span></td>
					<td width="100px">
						<select id="courseState" name="courseState" class="easyui-combobox" style="width: 100px; height: 25px;"
							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=COURSE_STATE&codeFlag=003,004,005">
				       	</select>
					</td>
					<td align="center">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1013">查询</a>
						&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
					</td>
  				</tr>
  			</table>
  		</form>
  		
  		<div style="padding:5px 0;min-width:1100px; width:100%;">
		  	<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="list_data"
		  		toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
						<th data-options="field:'byName',width:100,align:'center'">英文名</th>
						<th data-options="field:'phone',width:200,align:'center'">联系电话</th>
						<th data-options="field:'className',width:120,align:'center'">在读班级</th>
						<th data-options="field:'teacherName',width:100,align:'center'">带班老师</th>
						<th data-options="field:'classProgress',width:100,align:'center'">课时进度</th>
						<th data-options="field:'courseStateText',width:100,align:'center'">课程状态</th>
						<th data-options="field:'changeClassNum',width:100,align:'center'">本课程转班次数</th>
					</tr>
				</thead>
			</table>
	  	</div>
	  	
	  	<div id="toolbar" style="padding: 2px; height: auto">
		   	<a href="javascript:void(0)" id="applyChangeSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
			<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
		</div>
  	</body>
</html>
