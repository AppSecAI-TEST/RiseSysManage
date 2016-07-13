<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/teacherLicense.js"></script>
  	</head>
  	<body>
  		<div style="margin-right:5px">
  		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
  		<form id="qryFm">
 			<table class="search_tab">
  				<tr>
  					<td width="8%" align="right"><span>校区：</span></td>
  					<td width="10%" align="left">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width:100px;height: 25px;" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
							onLoadSuccess:function(data){ajaxLoadEnd(); if(data.length > 1) {data.unshift({schoolName:'所有校区',schoolId:''});} $('#schoolId').combobox('setValue',data[0].schoolId);}"
				      		url="<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=515&fieldId=schoolId&headFlag=N">
			        	</select>
					</td>
  					<td width="8%" align="right"><span>课程阶段：</span></td>
  					<td width="10%" align="left">
						 <select name="stageId"  id="stageId"  style="width:100px;height: 25px;" class="easyui-combobox" editable='false'
     						data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'"
     						url="<%=path %>/pubData/qryStage.do">
      					</select>
					</td>
  					<td width="8%" align="right">
						<span>持证率：</span>
					</td>
  					<td width="5%" align="left">
						<input name="rateLowNum" class="easyui-numberbox" precision="1" min="0" max="100" style="width:60px;height: 25px;"/>
					</td>
					<td width="1%" align="center"><span>至</span></td>
					<td width="8%" align="left">
						<input name="rateHighNum" class="easyui-numberbox" precision="1" min="0" max="100" style="width:60px;height: 25px;"/>
					</td>
					<td align="left">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px;" id="qryBtn" funcNodeId="4600"><span>查询</span></a>
						&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px;" id="resetBtn" ><span>重置</span></a
					</td>
					<td></td>
  				</tr>
  			</table>
  		</form>
		<table class="easyui-datagrid" align="center" title="查询结果" style="height: 435px" id="list_data" 
			toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
			<thead>
				<tr>
					<th field="schoolName" align="center" width="8%" ><span>校区</span></th>
					<th field="stageId" align="center" width="6%" ><span>阶段</span></th>
					<th field="classNum" align="center" width="7%" ><span>班级数</span></th>
					<th field="teacherNum" align="center" width="7%" ><span>教师数</span></th>
					<th field="licenseNum" align="center" width="7%" ><span>持证数</span></th>
					<th field="rateText" align="center" width="7%" ><span>持证率</span></th>
					<th field="teacherNum" align="center" width="9%" ><span>目标持证数</span></th>
					<th field="lackLicense" align="center" width="9%" ><span>缺口持证数</span></th>
					<th field="noLicenseTeachers" align="center" width="20%" ><span>带班未持证教师名单</span></th>
					<th field="licenseTeachers" align="center" width="20%" ><span>已持证教师</span></th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" style="width:100px;" iconCls="icon-add" ><span>导出全部</span></a>
 		</div>
 		</div>
  	</body>
</html>
<script>
exportLink("export","list_data");
</script>