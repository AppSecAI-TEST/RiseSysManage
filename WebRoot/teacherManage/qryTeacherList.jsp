<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/teacherManage/teacherManage.js"></script>
  	</head>
  	<body>
  		<div style="margin-right:5px">
  		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
 		<form id="qryFm">
  			<table class="search_tab">
  				<tr>
  					<td align="right" width="8%"><span>组织：</span></td>
  					<td align="left" width="8%">
  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width:100px;height:25px;" editable="false">
        				</select>
  					</td>
  					<td align="right" width="10%"><span>教师英文名：</span></td>
  					<td align="left" width="8%">
  						<select name="byName" id="byName" class="easyui-combobox" style="width:100px;height:25px;">
						</select>
  					</td>
  					<td align="right" width="10%"><span>入职时间：</span></td>
  					<td align="left" width="8%">
  						<input class="easyui-datebox" name="joinStartDate" id="joinStartDate" style="width:100px;height:25px;" />
  					</td>
  					<td align="center" width="2%"><span>至</span></td>
  					<td align="left" width="8%">
  						<input class="easyui-datebox" name="joinEndDate" id="joinEndDate" style="width:100px;height:25px;" />
  					</td>
  					<td align="right" width="10%"><span>工作性质：</span></td>
  					<td align="left" width="15%">
  						<select id="jobProperty" name="jobProperty" class="easyui-combobox" style="width:100px;height:25px;"
	  						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=STAFF_T&codeType=JOB_PROPERTY">
        				</select>
  					</td>
  					<td></td>
  				</tr>
  				<tr>
  					<td align="right"><span>职务：</span></td>
  					<td align="left">
  						<select id="post" name="post" class="easyui-combobox" style="width:100px;height:25px;" editable="false"
							data-options="formatter:formatPost, valueField: 'postId', textField: 'postName', panelHeight: 'auto'"
				      		url="<%=path %>/pubData/qryPostList.do?postType=T">
        				</select>
  					</td>
  					<td align="right"><span>教师状态：</span></td>
  					<td align="left">
  						<select id="teacherState" name="teacherState" class="easyui-combobox" style="width:100px;height:25px;"
	  						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=TEACHER_T&codeType=T_STATE">
        				</select>
  					</td>
  					<td align="right"><span>入职时长：</span></td>
  					<td align="left">
  						<input class="easyui-numberbox" name="joinStartTime" id="joinStartTime" style="width:100px;height:25px;" />
  					</td>
  					<td align="center"><span>至</span></td>
  					<td align="left">
  						<input class="easyui-numberbox" name="joinEndTime" id="joinEndTime" style="width:100px;height:25px;" />
  					</td>
  					<td colspan="2" align="center">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px;" id="qryBtn" funcNodeId="4100"><span>查询</span></a>
						&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px;" id="resetBtn" ><span>重置</span></a>
					</td>
					<td></td>
  				</tr>
  			</table>
 		</form>
 		
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:550" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="7%"><span>组织</span></th>
					<th field="teacherName" align="center" width="8%"><span>教师姓名</span></th>
					<th field="byname" align="center" width="9%"><span>教师英文名</span></th>
					<th field="stateVal" align="center" width="8%"><span>教师状态</span></th>
					<th field="phone" align="center" width="9%"><span>联系电话</span></th>
					<th field="postVal" align="center" width="7%"><span>职务</span></th>
					<th field="gradeTeamVal" align="center" width="8%"><span>年级组</span></th>
					<th field="joinDate" align="center" width="9%"><span>入职时间</span></th>
					<th field="joinTime" align="center" width="9%"><span>入职时长（月）</span></th>
					<th field="licenses" align="center" width="10%"><span>持证阶段</span></th>
					<th field="stageIds" align="center" width="15%"><span>在读带班阶段</span></th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
   			<a href="javascript:void(0)" id="toolBtn1" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="updateFile()"><span>档案维护</span></a>
   			<a href="javascript:void(0)" id="toolBtn2" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="preResign()"><span>预离职</span></a>
   			<a href="javascript:void(0)" id="toolBtn3" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="preResignRegain()"><span>预离职复职</span></a>
 			<a href="javascript:void(0)" id="toolBtn4" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="resign()"><span>离职</span></a>
 			<a href="javascript:void(0)" id="toolBtn5" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="resignRegain()"><span>离职复职</span></a>
 			<a href="javascript:void(0)" id="toolBtn6" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="updateOrg()"><span>更换组织</span></a>
 			<a href="javascript:void(0)" id="toolBtn7" class="easyui-linkbutton" iconCls="icon-redo" style="width:100px;" onclick="viewTeacherInfo()"><span>浏览</span></a>
 		</div>
 		</div>
  	</body>
</html>
