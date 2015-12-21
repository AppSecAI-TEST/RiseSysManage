<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/teacherLicense.js"></script>
  	</head>
  	<body>
  		<div style="padding:5px 0px;">
  			<form id="qryFm" style="margin:0 auto;">
  				<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="5">
	  				<tr>
	  					<td width="10%" align="right"><span>校区：</span></td>
	  					<td width="10%" align="left">
							<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 120px" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
								onLoadSuccess:function(data){$('#schoolId').combobox('setValue',data[0].schoolId);}"
					      		url="<%=path %>/pubData/qrySchoolList.do">
				        	</select>
						</td>
	  					<td width="10%" align="right"><span>课程阶段：</span></td>
	  					<td width="10%" align="left">
							 <select name="stageId"  id="stageId"  style="width:120px" class="easyui-combobox" editable='false'
	     						data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'"
	     						url="<%=path %>/pubData/qryStage.do">
	      					</select>
						</td>
	  					<td width="10%" align="right">
							<span>持证率：</span>
						</td>
	  					<td width="5%" align="left">
							<input name="rateLowNum" class="easyui-numberbox" precision="1" min="0" max="100" style="width:60px"/>
						</td>
						<td width="3%" align="center"><span>至</span></td>
						<td width="5%" align="left">
							<input name="rateHighNum" class="easyui-numberbox" precision="1" min="0" max="100" style="width:60px"/>
						</td>
						<td align="center">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:90px; height: 25px;" id="qryBtn" funcNodeId="4600">查询</a>
							&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:90px; height: 25px;" id="reset" >重置</a
						</td>
						<td></td>
	  				</tr>
	  			</table>
  			</form>
			<div style="padding:5px 0;">
				<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:580" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th field="schoolName" align="center" width="8%" >校区</th>
							<th field="stageId" align="center" width="6%" >阶段</th>
							<th field="classNum" align="center" width="7%" >班级数</th>
							<th field="teacherNum" align="center" width="7%" >教师数</th>
							<th field="licenseNum" align="center" width="7%" >持证数</th>
							<th field="rate" align="center" width="7%" >持证率</th>
							<th field="teacherNum" align="center" width="9%" >目标持证数</th>
							<th field="lackLicense" align="center" width="9%" >缺口持证数</th>
							<th field="noLicenseTeachers" align="center" width="20%" >带班未持证教师名单</th>
							<th field="licenseTeachers" align="center" width="20%" >已持证教师</th>
						</tr>
					</thead>
				</table>
				<div id="toolbar">
		   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" >导出</a>
		 		</div>
			</div>
  		</div>
  	</body>
</html>
