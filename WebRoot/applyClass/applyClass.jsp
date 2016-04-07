<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/applyClass/applyClass.js"></script>
  	</head>
  
  	<body>
  		<input type="hidden" id="funcNodeId" value="${param.funcNodeId}"/>
		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
  		<div id="tt" class="easyui-tabs" style="min-width:1110px; width:98%; height:auto;">
  			<div title="放班班级管理" style="padding:5px;display:block;">
  				<form id="qryFm">
			  		<table class="search_tab" id="apply_search_tab">
			  			<tr>
			  				<td align="right" style="min-width: 60px;"><span>校区：</span></td>
			  				<td style="min-width: 100px;">
								<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;">
				        		</select>
							</td>
							<td align="right" style="min-width: 60px;"><span>课程阶段：</span></td>
							<td style="min-width: 100px;">
								<select id="stageId" name="stageId" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'" 
				      				url="<%=path %>/pubData/qryStage.do">
				        		</select>
							</td>
							<td align="right" style="min-width:60px;"><span>班级：</span></td>
							<td style="min-width: 100px;">
								<input id="classInstId" name="classInstId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
							</td>
							<td align="right" style="min-width: 90px;"><span>放班申请时间：</span></td>
			  				<td style="min-width: 225px;">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeApply" name="startTimeApply" data-options="formatter:myformatter, parser:myparser"/>
								至
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeApply" name="endTimeApply" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td></td>
			  			</tr>
			  			<tr>
			  				<td align="right"><span>班级状态：</span></td>
							<td>
								<select id="classState" name="classState" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
			      			 		url="<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=CLASS_STATE">
				        		</select>
							</td>
			  				<td align="right"><span>放班状态：</span></td>
			  				<td>
			  					<select id="tacheState" name="tacheState" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=CREATE_CLASS_T&codeType=CREATE_CLASS_STATE">
				        		</select>
			  				</td>
			  				<td align="right"><span>带班老师：</span></td>
			  				<td>
			  					<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 100px; height: 25px;">
				        		</select>
			  				</td>
							<td align="right"><span>放班审批时间：</span></td>
			  				<td>
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeApprove" name="startTimeApprove" data-options="formatter:myformatter, parser:myparser"/>
								至
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeApprove" name="endTimeApprove" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="left" style="min-width: 220px;">
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1006">查询</a>
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
							</td>
			  			</tr>
			  		</table>
			  	</form>
				  	<table class="easyui-datagrid" title="查询结果" id="list_data" 
				  		toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
						<thead>
							<tr>
								<th field="ck" align="center" checkbox="true" width="1%"></th>
								<th field="schoolName" align="center" width="6%">校区</th>
								<th data-options="field:'className',width:100,align:'center'">班级名称</th>
								<th data-options="field:'applyDate',width:150,align:'center'">放班审批时间</th>
								<th data-options="field:'latestApplyClassState',width:100,align:'center'">最新放班状态</th>
								<th data-options="field:'cancelApplyClassStateText',width:120,align:'center'">取消放班审批状态</th>
								<th data-options="field:'openClassStateText',width:100,align:'center'">开班状态</th>
								<th data-options="field:'classStateText',width:100,align:'center'">班级状态</th>
								<th data-options="field:'startDate',width:100,align:'center'">开课时间</th>
								<th data-options="field:'schooltimeName',width:180,align:'center'">上课时段与教室</th>
								<th data-options="field:'classStudentNum',width:80,align:'center'">定班人数</th>
								<th data-options="field:'minSubNum',width:80,align:'center'">距最低人数</th>
								<th data-options="field:'teacherName',width:120,align:'center'">带班老师</th>
								<th data-options="field:'studentChannelTypeText',width:100,align:'center'">学员来源</th>
								<th data-options="field:'higherSchoolName',width:100,align:'center'">来源班级</th>
							</tr>
						</thead>
					</table>
				<div id="toolbar" style="padding: 2px; height: auto">
		   			<a href="javascript:void(0)" id="applyClass" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">放班申请</a>
		   			<a href="javascript:void(0)" id="cancelApplyClass" class="easyui-linkbutton" iconCls="icon-cancel" style="width: 120px;">取消放班申请</a>
		   			<a href="javascript:void(0)" id="updateApplyClass" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;">班级维护</a>
		   			<a href="javascript:void(0)" id="view" class="easyui-linkbutton" iconCls="icon-redo" style="width: 80px;">浏览</a>
				</div>
  			</div>
  			
  			<div title="放班审批管理" style="padding:5px;display:block;">
  				<form id="qryApproveFm">
  					<table class="search_tab" id="approve_search_tab">
		  				<tr>
		  					<td align="right" style="min-width: 60px"><span>校区：</span></td>
			  				<td style="width: 100px;">
								<select id="approveSchoolId" name="approveSchoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
				        		</select>
							</td>
							<td align="right" style="min-width: 80px"><span>放班审批状态：</span></td>
							<td>
								<select id="approveState" name="approveState" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
			      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=CREATE_CLASS_T&codeType=CREATE_CLASS_APPROVE_STATE">
				        		</select>
							</td>
							<td align="right" style="min-width: 80px;"><span>放班申请时间：</span></td>
			  				<td style="width: 210px;">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeApproveApply" name="startTimeApproveApply" data-options="formatter:myformatter, parser:myparser"/>
								至
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeApproveApply" name="endTimeApproveApply" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="right" style="min-width: 80px;"><span>放班审批时间：</span></td>
			  				<td width="210px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeApplyApprove" name="startTimeApplyApprove" data-options="formatter:myformatter, parser:myparser"/>
								至
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeApplyApprove" name="endTimeApplyApprove" data-options="formatter:myformatter, parser:myparser"/>
							</td>
		  				</tr>
		  				<tr>
		  					<td align="right"><span>课程阶段：</span></td>
							<td style="width: 100px;">
								<select id="approveStageId" name="approveStageId" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'" 
				      				url="<%=path %>/pubData/qryStage.do">
				        		</select>
							</td>
							<td colspan="2">
								&nbsp;&nbsp;<span>查看我的审批：</span>&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name=""/>
							</td>
							<td align="right"><span>取消申请时间：</span></td>
		  					<td>
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeCancel" name="startTimeCancel" data-options="formatter:myformatter, parser:myparser"/>
								至
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeCancel" name="endTimeCancel" data-options="formatter:myformatter, parser:myparser"/>
							</td>
		  					<td align="right"><span>取消审批时间：</span></td>
		  					<td>
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeCancelApprove" name="startTimeCancelApprove" data-options="formatter:myformatter, parser:myparser"/>
								至
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeCancelApprove" name="endTimeCancelApprove" data-options="formatter:myformatter, parser:myparser"/>
							</td>
		  				</tr>
		  				<tr>
		  					<td colspan="7">&nbsp;</td>
		  					<td>
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryApproveBtn" funcNodeId="1007">查询</a>
								&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="resetApprove">重置</a>
							</td>
		  				</tr>
		  			</table>
  				</form>
				  	<table class="easyui-datagrid" title="查询结果" id="approve_list_data" 
				  		toolbar="#toolbarApprove" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
						<thead>
							<tr>
								<th field="ck" align="center" checkbox="true" width="1%"></th>
								<th field="schoolName" align="center" width="6%">校区</th>
								<th data-options="field:'applyContent',width:220,align:'center'">申请内容</th>
								<th data-options="field:'stageId',width:80,align:'center'">课程类型</th>
								<th data-options="field:'className',width:80,align:'center'">班级名称</th>
								<th data-options="field:'startDate',width:100,align:'center'">申请开课时间</th>
								<th data-options="field:'approveStateText',width:100,align:'center'">审批状态</th>
								<th data-options="field:'applyName',width:80,align:'center'">申请人</th>
								<th data-options="field:'createDate',width:120,align:'center'">申请时间</th>
								<th data-options="field:'approveCreateDate',width:120,align:'center'">审批时间</th>
								<th data-options="field:'approveName',width:80,align:'center'">审批人</th>
							</tr>
						</thead>
					</table>
				<div id="toolbarApprove" style="padding: 2px; height: auto">
		   			<a href="javascript:void(0)" id="applyApprove" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">放班审批</a>
		   			<a href="javascript:void(0)" id="cancelApprove" class="easyui-linkbutton" iconCls="icon-cancel" style="width: 120px;">取消放班审批</a>
		   			<a href="javascript:void(0)" id="viewApprove" class="easyui-linkbutton" iconCls="icon-redo" style="width: 80px;">浏览</a>
				</div>
  			</div>
  		</div>
  	</body>
</html>
