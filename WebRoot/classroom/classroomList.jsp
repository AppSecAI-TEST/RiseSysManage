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
  		<div style="margin-right:5px;">
 		<form id="qryFm">
  			<table class="search_tab">
  				<tr>
  					<td width="100px" align="right">校区：</td>
  					<td width="120px">
  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:100px;height: 25px;"
  							data-options="formatter:formatSchool,valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
  							url="<%=path%>/pubData/qrySchoolList.do?schoolId=">
  						</select>
  					</td>
  					<td width="80px" align="right">教室状态：</td>
  					<td width="100px">
  						<select class="easyui-combobox" name="roomState" id="roomState" style="width:80px;height: 25px;"
  							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
  							url="<%=path%>/pubData/qryCodeNameList.do?tableName=ROOM_T&codeType=ROOM_STATE">
  						</select>
  					</td>
  					<td>
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:80px" id="qryBtn" funcNodeId="3040">查询</a>
  						&nbsp;&nbsp;
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:80px" id="resetBtn" >重置</a>
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
 	</div>	
  	</body>
</html>