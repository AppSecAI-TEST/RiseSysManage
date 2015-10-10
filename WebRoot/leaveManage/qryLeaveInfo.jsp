<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/pub/js/json.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json2.js"></script>
		<script type="text/javascript" src="<%=path %>/js/leaveManage/leaveManage.js"></script>
  	</head>
  	<body>
 		<form id="qryFm">
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="5">
  				<tr>
  					<td align="right" width="10%">所属校区：</td>
  					<td align="left" width="5%">
  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width:120px;" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
      						 onLoadSuccess:function(data){$('#schoolId').combobox('setValue',data[0].schoolId);}"
      						url="<%=path %>/pubData/qrySchoolList.do?schoolId=${sessionScope.StaffT.schoolId}">
        				</select>
  					</td>
  					<td align="right" width="10%">学员姓名：</td>
  					<td align="left" width="5%">
  						<select class="easyui-combobox" name="studentId" id="studentId" style="width:120px;">
  							
  						</select>
  					</td>
  					<td align="right" width="10%">联系电话：</td>
  					<td align="left" width="5%">
  						<input class="easyui-textbox"  name="phone" id="phone" style="width:120px;" />
  					</td>
  					<td align="right" width="10%">休学状态：</td>
  					<td align="left" width="20%">
  						<select class="easyui-combobox" name="leaveState" id="leaveState" style="width:120px;"
  						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
      					onLoadSuccess:function(data){$('#leaveState').combobox('setValue',data[0].codeFlag);}"
      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_LEAVE_T&codeType=LEAVE_STATE">
  						</select>
  					</td>
  					<td width="25%"></td>
  				</tr>
  				<tr>
  					<td align="right">已休时长：</td>
  					<td colspan="7">
  						<input class="easyui-textbox"  name="leavedStartTime" id="leavedStartTime" style="width:60px;" />
  						&nbsp;至&nbsp;
  						<input class="easyui-textbox"  name="leavedEndTime" id="leavedEndTime" style="width:60px;" />
  						&nbsp;申请休学时长：
  						<input class="easyui-textbox"  name="leaveStartTime" id="leaveStartTime" style="width:60px;" />
  						&nbsp;至&nbsp;
  						<input class="easyui-textbox"  name="leaveEndTime" id="leaveEndTime" style="width:60px;" />
  						&nbsp;休学开始时间：
  						<input class="easyui-datebox"  name="createStartTime" id="createStartTime" style="width:120px;" />
  						&nbsp;至&nbsp;
  						<input class="easyui-datebox"  name="createEndTime" id="createEndTime" style="width:120px;" />
  					</td>
  					<td align="center">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:90px; height: 25px;" id="qryBtn" funcNodeId="4000">查询</a>
						&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:90px; height: 25px;" id="reset" >重置</a>
					</td>
  				</tr>
  			</table>
 		</form>
 		
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:550" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="4%">校区</th>
					<th field="name" align="center" width="6%">学员姓名</th>
					<th field="byName" align="center" width="6%">英文名</th>
					<th field="phone" align="center" width="9%">联系电话</th>
					<th field="createDate" align="center" width="7%">休学开始时间</th>
					<th field="leaveStateVal" align="center" width="5%">休学状态</th>
					<th field="leavedTime" align="center" width="7%">已休时长（天）</th>
					<th field="leaveTime" align="center" width="9%">申请休学时长（月）</th>
					<th field="stageLevel" align="center" width="9%">已升学阶段</th>
					<th field="className" align="center" width="7%">原在读班级</th>
					<th field="orignCourseState" align="center" width="8%">原在读课程状态</th>
					<th field="teacherName" align="center" width="8%">带班老师</th>
					<th field="carerName" align="center" width="5%">客户关怀</th>
					<th field="hours" align="center" width="8%">原在读班级课时</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" id="addLeaveInfo" class="easyui-linkbutton" iconCls="icon-add" onclick="addLeave()">新增休学</a>
   			<a href="javascript:void(0)" id="restartClass" class="easyui-linkbutton" iconCls="icon-edit" onclick="restartClass()">复课</a>
   			<a href="javascript:void(0)" id="viewLeaveInfo" class="easyui-linkbutton" iconCls="icon-redo" onclick="viewLeaveInfo()">浏览</a>
 			<a href="javascript:void(0)" id="updateLeaveTime" class="easyui-linkbutton" iconCls="icon-edit" onclick="updateLeaveTime()">修改休学时长</a>
 		</div>
  	</body>
</html>
