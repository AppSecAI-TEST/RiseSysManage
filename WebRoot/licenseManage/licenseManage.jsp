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
		<script type="text/javascript" src="<%=path %>/js/license/licenseManage.js"></script>
  	</head>
  	<body>
 		<form id="qryFm">
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="5">
  				<tr>
  					<td align="right" width="8%">组织：</td>
  					<td align="left" width="10%">
  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width:120px;"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
				      		url="<%=path %>/pubData/qrySchoolList.do">
        				</select>
  					</td>
  					<td align="right" width="10%">教师英文名：</td>
  					<td align="left" width="10%">
  						<select name="byName" id="byName" class="easyui-combobox" style="width:120px"
							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'"
		      				url="<%=path %>/pubData/qryTeacherList.do">
						</select>
  					</td>
  					<td align="right" width="10%">持证数量：</td>
  					<td align="left" width="10%">
  						<input class="easyui-numberbox" name="licenseMinNum" id="licenseMinNum" style="width:120px;" />
  					</td>
  					<td align="center" width="3%">至：</td>
  					<td align="left">
  						<input class="easyui-numberbox" name="licenseMaxNum" id="licenseMaxNum" style="width:120px;" />
  					</td>
  					<td></td>
  				</tr>
  				<tr>
  					<td align="right">教师状态：</td>
  					<td align="left">
  						<select id="teacherState" name="teacherState" class="easyui-combobox" style="width:120px;"
	  						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=TEACHER_T&codeType=T_STATE">
        				</select>
  					</td>
  					<td align="right">持证阶段：</td>
  					<td align="left">
  						 <select name="stageId"  id="stageId"  style="width:120px" class="easyui-combobox" editable='false'
     						data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'"
     						url="<%=path %>/pubData/qryStage.do">
	      				</select>
  					</td>
  					<td align="right">带班数量：</td>
  					<td align="left">
  						<input class="easyui-numberbox" name="classMinNum" id="classMinNum" style="width:120px;" />
  					</td>
  					<td align="center">至：</td>
  					<td align="left">
  						<input class="easyui-numberbox" name="classMaxNum" id="classMaxNum" style="width:120px;" />
  					</td>
  					<td align="center">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:90px; height: 25px;" id="qryBtn" funcNodeId="4200">查询</a>
						&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:90px; height: 25px;" id="reset" >重置</a>
					</td>
  				</tr>
  			</table>
 		</form>
 		
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:570" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="10%">组织</th>
					<th field="teacherName" align="center" width="8%">教师姓名</th>
					<th field="byname" align="center" width="9%">教师英文名</th>
					<th field="stateVal" align="center" width="8%">教师状态</th>
					<th field="licenses" align="center" width="12%">持证阶段</th>
					<th field="licensesNum" align="center" width="7%">持证量</th>
					<th field="stageIds" align="center" width="11%">在读带班阶段</th>
					<th field="stageNums" align="center" width="11%">在读带班数量</th>
					<th field="rate" align="center" width="11%">在读带班持证率</th>
					<th field="trainingStageIds" align="center" width="11%">待培训阶段</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" onclick="locateTeacher()">持证维护</a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" onclick="viewTeacherLicense()">浏览</a>
 		</div>
  	</body>
</html>
