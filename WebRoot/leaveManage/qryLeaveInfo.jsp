<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/leaveManage/leaveManage.js"></script>
  	</head>
  	<body>
  		<div style="margin-right:5px">
  		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId }"/>
 		<form id="qryFm">
  			<table class="search_tab">
  				<tr>
  					<td align="right" style="min-width: 100px"><span>所属校区：</span></td>
  					<td align="left" style="min-width: 100px">
  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width:100px;height: 25px;" editable="false">
        				</select>
  					</td>
  					<td align="right" style="min-width: 120px"><span>学员姓名：</span></td>
  					<td align="left" style="min-width: 100px">
  						<input class="easyui-textbox" name="studentName" id="studentName" style="width:100px;height:25px;" />
  					</td>
  					<td align="right" style="min-width: 100px"><span>联系电话：</span></td>
  					<td align="left" style="min-width: 100px">
  						<input class="easyui-numberbox" name="phone" id="phone" style="width:100px;height:25px;" />
  					</td>
  					<td align="right" style="min-width: 120px"><span>休学开始时间：</span></td>
  					<td style="min-width: 230px">
  						<input class="easyui-datebox"  name="startTimeCreate" id="startTimeCreate" style="width:100px;height: 25px;" />
  						至
  						<input class="easyui-datebox"  name="endTimeCreate" id="endTimeCreate" style="width:100px;height: 25px;" />
  					</td>
  				</tr>
  				<tr>
  					<td align="right" style="min-width: 100px"><span>已休时长：</span></td>
  					<td align="left" style="min-width: 100px">
  						<input class="easyui-numberbox"  name="leavedStartTime" id="leavedStartTime" style="width:39px;height: 25px;" />
  						至
  						<input class="easyui-numberbox"  name="leavedEndTime" id="leavedEndTime" style="width:39px;height: 25px;" />
  					</td>
  					<td align="right" style="min-width: 120px"><span>申请休学时长：</span></td>
  					<td align="left" style="min-width: 100px">
  						<input class="easyui-numberbox"  name="leaveStartTime" id="leaveStartTime" style="width:39px;height: 25px;" />
  						至
  						<input class="easyui-numberbox"  name="leaveEndTime" id="leaveEndTime" style="width:39px;height: 25px;" />
  					</td>
  					<td align="right" style="min-width: 100px"><span>休学状态：</span></td>
  					<td align="left" style="min-width: 100px" colspan="2">
  						<select class="easyui-combobox" name="leaveState" id="leaveState" style="width:100px;height: 25px;"
  						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_LEAVE_T&codeType=LEAVE_STATE">
  						</select>
  					</td>
  					<td>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px" id="qryBtn" funcNodeId="4000"><span>查询</span></a>
						&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" id="resetBtn" style="width:100px" id="reset" ><span>重置</span></a>
					</td>
  				</tr>
  			</table>
 		</form>
		<table class="easyui-datagrid" align="center" title="查询结果"  id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="4%"><span>校区</span></th>
					<th field="name" align="center" width="6%"><span>学员姓名</span></th>
					<th field="byName" align="center" width="6%"><span>英文名</span></th>
					<th field="phone" align="center" width="9%"><span>联系电话</span></th>
					<th field="createDate" align="center" width="7%"><span>休学开始时间</span></th>
					<th field="leaveStateVal" align="center" width="5%"><span>休学状态</span></th>
					<th field="leavedTime" align="center" width="7%"><span>已休时长（天）</span></th>
					<th field="leaveTime" align="center" width="9%"><span>申请休学时长（月）</span></th>
					<th field="stageLevel" align="center" width="9%"><span>已升学阶段</span></th>
					<th field="orignClassName" align="center" width="7%"><span>原在读班级</span></th>
					<th field="orignCourseState" align="center" width="8%"><span>原在读课程状态</span></th>
					<th field="teacherNames" align="center" width="8%"><span>带班老师</span></th>
					<th field="carerName" align="center" width="5%"><span>客户关怀</span></th>
					<th field="hours" align="center" width="8%"><span>原在读班级课时</span></th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
   			<a href="javascript:void(0)" id="addLeaveInfo" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;" onclick="addLeave()">新增休学</a>
   			<a href="javascript:void(0)" id="restartClass" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;" onclick="restartClass()">复课</a>
   			<a href="javascript:void(0)" id="viewLeaveInfo" class="easyui-linkbutton" iconCls="icon-redo" style="width: 100px;" onclick="viewLeaveInfo()">浏览</a>
 			<a href="javascript:void(0)" id="updateLeaveTime" class="easyui-linkbutton" iconCls="icon-edit" style="width: 120px;" onclick="updateLeaveTime()">修改休学时长</a>
 			<a href="javascript:void(0)" id="leaveProlongBtn" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;">休学延长</a>
 		</div>
 		</div>
  	</body>
</html>
