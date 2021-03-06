<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/higherRate.js"></script>
  	</head>    
  	<body>
  		<div style="margin-right:5px;">
  			<input type="hidden" id="higherType" value="stage"/>
  			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId }"/>
  			<input type="hidden" id="sFlag" value="1"/>
   			<input type="hidden" id="resourceId" value="750">	
  			<form id="qryFm">
  				<table class="search_tab">
  					<tr>
  						<td align="right" width="50px"><span>校区：</span></td>
	  					<td width="100px">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        	</select>
						</td>
						<td align="right" width="50px"><span>阶段：</span></td>
	  					<td width="114px">
							<select id="stageId" name="stageId" class="easyui-combobox" style="width: 114px; height: 25px;"
								data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'" 
			      				url="<%=path %>/pubData/qryStage.do">
				        	</select>
						</td>
						<td align="right" width="50px"><span>年度：</span></td>
						<td width="100px">
							<select class="easyui-combobox" name="year" id="year" style="width:100px;height: 25px;" 
								editable="false" data-options="valueField:'val',textField:'text'">
							</select>
						</td>
						<td align="right" width="100px"><span>课时进度比：</span></td>
	  					<td width="130px">
	  						<input name="minAttendRate" id="minAttendRate" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
							<span style="display: inline-block; text-align: center; width: 14px;">至</span>
							<input name="maxAttendRate" id="maxAttendRate" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
	  					</td>
	  					<td align="left">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1054">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
  					</tr>
  				</table>
  			</form>
  				<table class="easyui-datagrid" style="height:auto;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th data-options="field:'stageId',width:120,align:'center',rowspan:2">年级组</th>
							<th data-options="field:'finish',width:400,align:'center',colspan:4">已结课</th>
							<th data-options="field:'attend',width:500,align:'center',colspan:5"><div id="classProgress">未结课</div></th>
						</tr>
						<tr>
							<th data-options="field:'finishClassNum',width:100,align:'center'">班级数</th>
							<th data-options="field:'finishClassHigherBaseNum',width:100,align:'center'">年级组总基数</th>
							<th data-options="field:'finishClassHigherNum',width:100,align:'center'">年级组总升学</th>
							<th data-options="field:'finishClassAvgRate',width:100,align:'center'">平均升学率</th>
							<th data-options="field:'attendClassNum',width:100,align:'center'">班级数</th>
							<th data-options="field:'attendClassStudentNum',width:100,align:'center'">在读人数</th>
							<th data-options="field:'attendClassHigherBaseNum',width:100,align:'center'">年级组总基数</th>
							<th data-options="field:'attendClassHigherNum',width:100,align:'center'">年级组总升学</th>
							<th data-options="field:'attendClassAvgRate',width:100,align:'center'">平均升学率</th>
						</tr>
					</thead>
				</table>
  			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
			</div>
  		</div>
 	</body>
</html>
<script>
	exportLink("export", "list_data");
</script>