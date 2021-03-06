<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/newRecruit.js"></script>
  	</head>
  
  	<body>
  		<div style="margin-right:5px;">
  			<input type="hidden" id="resourceId" value="741">
  			<input type="hidden" id="type" value="inClassDetail"/>
  			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId }"/>
  			<form id="qryFm">
	  			<table class="search_tab">
	  				<tr>
	  					<td align="right" style="width: 80px"><span>校区：</span></td>
	  					<td style="width: 100px">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false" 
									data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
					        </select>
						</td>
	  					<td align="right" style="width: 70px"><span>学员姓名：</span></td>
	  					<td style="width: 100px">
	  						<input name="studentId" id="studentId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
						</td>
	  					<td align="right" style="width: 70px"><span>联系电话：</span></td>
	  					<td style="width: 100px">
							<input name="phone" id="phone" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
						</td>
	  					<td align="right" style="width: 70px"><span>缴费日期：</span></td>
	  					<td style="width: 225px">
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimePay" name="startTimePay" data-options="formatter:myformatter, parser:myparser"/>
							至
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimePay" name="endTimePay" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td></td>
	  				</tr>
	  				<tr>
	  					<td align="right"><span>报名阶段：</span></td>
	  					<td style="min-width: 100px">
							<select id="stageId" name="stageId" class="easyui-combobox" style="width: 100px; height: 25px;"
								data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'" 
			      				url="<%=path %>/pubData/qryStage.do">
				        	</select>
						</td>
	  					<td align="right" ><span>客户关怀：</span></td>
						<td>
							<select id="carer" name="carer" class="easyui-combobox" style="width: 100px; height: 25px;">
	     					</select>
						</td>
	  					<td align="right"><span>是否进班：</span></td>
	  					<td>
	  						<input type="checkbox" name="isAttend" value="'Y'"/><span>&nbsp;是</span>
							&nbsp;&nbsp;<input type="checkbox" name="isAttend" value="'N'"/><span>&nbsp;否</span>
	  					</td>
	  					<td align="right"><span>进班日期：</span></td>
	  					<td>
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeAttend" name="startTimeAttend" ata-options="formatter:myformatter, parser:myparser"/>
							至
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeAttend" name="endTimeAttend" ata-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="left">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px; height: 25px;" id="qryBtn" funcNodeId="1040">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:80px; height: 25px;" id="reset">重置</a>
						</td>
	  				</tr>
	  			</table>
  			</form>
				<table class="easyui-datagrid" style="height:435px;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th data-options="field:'schoolName',width:80,align:'center'">校区</th>
							<th data-options="field:'payDate',width:100,align:'center'">缴费时间</th>
							<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
							<th data-options="field:'byName',width:100,align:'center'">英文名</th>
							<th data-options="field:'sexText',width:50,align:'center'">性别</th>
							<th data-options="field:'parentName',width:150,align:'center'">家长姓名</th>
							<th data-options="field:'phone',width:250,align:'center'">联系电话</th>
							<th data-options="field:'advisterName',width:150,align:'center'">招生顾问</th>
							<th data-options="field:'carerName',width:100,align:'center'">客户关怀</th>
							<th data-options="field:'stageId',width:100,align:'center'">报名阶段</th>
							<th data-options="field:'selectClassNum',width:100,align:'center'">定班次数</th>
							<th data-options="field:'className',width:100,align:'center'">当前定班班级</th>
							<th data-options="field:'attendDate',width:100,align:'center'">进班日期</th>
							<th data-options="field:'waitDays',width:100,align:'center'">等班时长（天）</th>
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
	exportLink("export","list_data");
</script>
