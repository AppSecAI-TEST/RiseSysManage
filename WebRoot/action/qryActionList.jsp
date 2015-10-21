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
 		<form id="qryFm">
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="15">
  				<tr>
  					<td align="right">校区：</td>
  					<td>
  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:150px;">
  							
  						</select>
  					</td>
  					<td align="right">活动状态：</td>
  					<td>
  						<select class="easyui-combobox" name="state" id="state" style="width:150px;">
  							
  						</select>
  					</td>
  					<td align="right">活动日期：</td>
  					<td>
  						<input class="easyui-datebox" name="startTime" id="startTime"  style="width:150px;" />
  					</td>
  					<td align="center">至：</td>
  					<td>
  						<input class="easyui-datebox" name="endTime" id="endTime"  style="width:150px;" />
  					</td>
  				</tr>
  				<tr>
  					<td align="right">活动名称：</td>
  					<td>
  						<input class="easyui-textbox" name="title" id="title" style="width:150px;" />
  					</td>
  					<td align="right">实际参与老师：</td>
  					<td><input class="easyui-textbox" name="teacherName" id="teacherName" style="width:150px;" /></td>
  					<td></td>
  					<td>
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qryBtn" funcNodeId="3030">查询</a>
  					</td>
  					<td>&nbsp;</td>
  					<td>
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:150px" id="resetBtn" >重置</a>
  					</td>
  				</tr>
  			</table>
 		</form>
 		
 		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:300" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="schoolName" align="center" width="5%">创建校区</th>
					<th field="stateVal" align="center" width="5%">活动状态</th>
					<th field="title" align="center" width="20%">活动名称</th>
					<th field="actionTime" align="center" width="12%">活动日期</th>
					<th field="timeRange" align="center" width="15%">活动时间</th>
					<th field="planTeacher" align="center" width="15%">计划参与老师</th>
					<th field="planHours" align="center" width="10%">计划课时量</th>
					<th field="replyTeacher" align="center" width="15%">实际参与老师</th>
					<th field="realHours" align="center" width="10%">实际课时量</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" id="addAction" class="easyui-linkbutton" iconCls="icon-add" plain="true">创建活动</a>
   			<a href="javascript:void(0)" id="cancelAction" class="easyui-linkbutton" iconCls="icon-cancel" plain="true">取消活动</a>
   			<a href="javascript:void(0)" id="replyAction" class="easyui-linkbutton" iconCls="icon-edit" plain="true">活动反馈</a>
   			<a href="javascript:void(0)" id="updateReply" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改反馈</a>
   			<a href="javascript:void(0)" id="viewAction" class="easyui-linkbutton" iconCls="icon-redo" plain="true">浏览</a>
 		</div>
  	</body>
</html>
