<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/license/licenseManage.js"></script>
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
  					<td align="right" width="8%"><span>持证数量：</span></td>
  					<td align="left" width="8%">
  						<input class="easyui-numberbox" name="licenseMinNum" id="licenseMinNum" style="width:100px;height:25px;" />
  					</td>
  					<td align="center" width="2%"><span>至</span></td>
  					<td align="left">
  						<input class="easyui-numberbox" name="licenseMaxNum" id="licenseMaxNum" style="width:100px;height:25px;" />
  					</td>
  					<td></td>
  				</tr>
  				<tr>
  					<td align="right"><span>教师状态：</span></td>
  					<td align="left">
  						<select id="teacherState" name="teacherState" class="easyui-combobox" style="width:100px;height:25px;"
	  						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=TEACHER_T&codeType=T_STATE">
        				</select>
  					</td>
  					<td align="right"><span>持证阶段：</span></td>
  					<td align="left">
  						 <select name="stageId"  id="stageId" style="width:100px;height:25px;" class="easyui-combobox" editable='false'
     						data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'"
     						url="<%=path %>/pubData/qryStage.do">
	      				</select>
  					</td>
  					<td align="right"><span>带班数量：</span></td>
  					<td align="left">
  						<input class="easyui-numberbox" name="classMinNum" id="classMinNum" style="width:100px;height:25px;" />
  					</td>
  					<td align="center"><span>至</span></td>
  					<td align="left">
  						<input class="easyui-numberbox" name="classMaxNum" id="classMaxNum" style="width:100px;height:25px;" />
  					</td>
  					<td align="left">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px;" id="qryBtn" funcNodeId="4200"><span>查询</span></a>
						&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px;" id="resetBtn" ><span>重置</span></a>
					</td>
  				</tr>
  			</table>
 		</form>
 		
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:570" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="10%"><span>组织</span></th>
					<th field="teacherName" align="center" width="8%"><span>教师姓名</span></th>
					<th field="byname" align="center" width="9%"><span>教师英文名</span></th>
					<th field="stateVal" align="center" width="8%"><span>教师状态</span></th>
					<th field="licenses" align="center" width="12%"><span>持证阶段</span></th>
					<th field="licensesNum" align="center" width="7%"><span>持证量</span></th>
					<th field="stageIds" align="center" width="11%"><span>在读带班阶段</span></th>
					<th field="stageNums" align="center" width="11%"><span>在读带班数量</span></th>
					<th field="rate" align="center" width="11%"><span>在读带班持证率</span></th>
					<th field="trainingStageIds" align="center" width="11%"><span>待培训阶段</span></th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
   			<a href="javascript:void(0)" id="toolBtn1" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="locateTeacher()"><span>持证维护</span></a>
 			<a href="javascript:void(0)" id="toolBtn2" class="easyui-linkbutton" iconCls="icon-redo" style="width:100px;" onclick="viewTeacherLicense()"><span>浏览</span></a>
 		</div>
 		</div>
  	</body>
</html>
