<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/action/actionList.js"></script>
  	</head>
  	<body>
  		<div style="margin-right:5px">
 		<form id="qryFm">
  			<table class="search_tab">
  				<tr>
  					<td width="80px" align="right"><span>所属校区：</span></td>
  					<td width="110px">
  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:100px;height: 25px;" editable="false"
  							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
  							onLoadSuccess:function(data){$('#schoolId').combobox('setValue',data[0].schoolId);}"
  							url="<%=path%>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=732&fieldId=schoolId&headFlag=N">
  						</select>
  					</td>
  					<td width="100px" align="right"><span>活动状态：</span></td>
  					<td width="110px">
  						<select class="easyui-combobox" name="state" id="state" style="width:100px;height: 25px;" editable="false"
  							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName'"
		  					url="<%=path %>/pubData/qryCodeNameList.do?tableName=ACTION_T&codeType=STATE">
  						</select>
  					</td>
  					<td width="80px" align="right"><span>活动日期：</span></td>
  					<td align="left">
  						<input class="easyui-datebox" name="startTime" id="startTime"  style="width:100px;height: 25px;" editable="false" />
  						至
  						<input class="easyui-datebox" name="endTime" id="endTime"  style="width:100px;height: 25px;" editable="false" />
  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>活动名称：</span></td>
  					<td>
  						<input class="easyui-textbox" name="title" id="title" style="width:100px;height:25px" />
  					</td>
  					<td align="right"><span>实际参与老师：</span></td>
  					<td><input class="easyui-textbox" name="teacherName" id="teacherName" style="width:100px;height:25px" /></td>
  					<td align="left" colspan="2">
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:100px;margin-left:98px;" id="qryBtn" funcNodeId="3030"><span>查询</span></a>
  						&nbsp;&nbsp;
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:100px" id="resetBtn" ><span>重置</span></a>
  					</td>
  				</tr>
  			</table>
 		</form>
 		
 		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:400" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="schoolName" align="center" width="5%"><span>创建校区</span></th>
					<th field="stateVal" align="center" width="5%"><span>活动状态</span></th>
					<th field="title" align="center" width="20%"><span>活动名称</span></th>
					<th field="actionTime" align="center" width="12%"><span>活动日期</span></th>
					<th field="timeRange" align="center" width="15%"><span>活动时间</span></th>
					<th field="planTeacher" align="center" width="15%"><span>计划参与老师</span></th>
					<th field="planHours" align="center" width="10%"><span>计划课时量</span></th>
					<th field="replyTeacher" align="center" width="15%"><span>实际参与老师</span></th>
					<th field="realHours" align="center" width="10%"><span>实际课时量</span></th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
   			<a href="javascript:void(0)" id="addAction" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;"><span>创建活动</span></a>
   			<a href="javascript:void(0)" id="cancelAction" class="easyui-linkbutton" iconCls="icon-cancel" style="width: 100px;"><span>取消活动</span></a>
   			<a href="javascript:void(0)" id="replyAction" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;"><span>活动反馈</span></a>
   			<a href="javascript:void(0)" id="updateReply" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;"><span>修改反馈</span></a>
   			<a href="javascript:void(0)" id="viewAction" class="easyui-linkbutton" iconCls="icon-redo" style="width: 100px;"><span>浏览</span></a>
 		</div>
 		</div>
  	</body>
</html>
