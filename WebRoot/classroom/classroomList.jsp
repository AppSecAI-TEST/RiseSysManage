<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/classroom/roomList.js"></script>
  	</head>
  	<body>
 		<form id="qryFm">
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="15">
  				<tr>
  					<td align="right">校区：</td>
  					<td>
  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:150px;height: 28px;"
  							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
  							url="<%=path%>/pubData/qrySchoolList.do?schoolId=">
  						</select>
  					</td>
  					<td align="right">教室状态：</td>
  					<td>
  						<select class="easyui-combobox" name="roomState" id="roomState" style="width:150px;"
  							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
  							url="<%=path%>/pubData/qryCodeNameList.do?tableName=ROOM_T&codeType=ROOM_STATE">
  						</select>
  					</td>
  					<td>
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qryBtn" funcNodeId="3040">查询</a>
  					</td>
  					<td>
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:150px" id="resetBtn" >重置</a>
  					</td>
  				</tr>
  			</table>
 		</form>
 		
 		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:400" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="schoolName" align="center" width="10%">校区</th>
					<th field="roomCode" align="center" width="15%">教室编号</th>
					<th field="roomName" align="center" width="25%">教室名称</th>
					<th field="stateVal" align="center" width="10%">教室状态</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
   			<a href="javascript:void(0)" id="addClassroom" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">添加</a>
   			<a href="javascript:void(0)" id="updateClassroom" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;">修改</a>
   			<a href="javascript:void(0)" id="deleteClassroom" class="easyui-linkbutton" iconCls="icon-cancel" style="width: 100px;">删除</a>
 		</div>
  	</body>
</html>
