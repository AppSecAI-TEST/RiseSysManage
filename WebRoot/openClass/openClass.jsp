<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/openClass/openClassList.js"></script>
  	</head>
  
  	<body>
  		<div id="tt" class="easyui-tabs" style="min-width:1110px; width:98%; height:auto;">
  			<div title="开班班级管理" style="padding:5px;display:block;">
  				<form id="qryFm">
  					<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId }"/>
		  			<table class="search_tab">
		  				<tr>
		  					<td align="right"><span>校区：</span></td>
			  				<td width="114px">
								<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;" editable="false">
				        		</select>
							</td>
							<td align="right"><span>课程阶段：</span></td>
							<td width="114px">
								<select id="stageId" name="stageId" class="easyui-combobox" style="width: 114px; height: 25px;"
									data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'" 
			      					url="<%=path %>/pubData/qryStage.do">
				        		</select>
							</td>
							<td align="right"><span>开班申请日期：</span></td>
			  				<td width="114px">
								<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="startTimeApply" name="startTimeApply" ata-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="center" width="14px"><span>至</span></td>
							<td colspan="3">
								<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="endTimeApply" name="endTimeApply" data-options="formatter:myformatter, parser:myparser"/>
							</td>
		  				</tr>
		  				<tr>
		  					<td align="right"><span>开班状态：</span></td>
							<td width="114px" colspan="3">
								<select id="openClassState" name="openClassState" class="easyui-combobox" style="width: 114px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=CREATE_CLASS_T&codeType=OPEN_CLASS_STATE">
				        		</select>
							</td>
							<td align="right"><span>开班审批日期：</span></td>
			  				<td width="114px">
								<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="startTimeApprove" name="startTimeApprove" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="center" width="14px"><span>至</span></td>
							<td width="114px">
								<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="endTimeApprove" name="endTimeApprove" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="center" colspan="2">
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1009">查询</a>
								&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
							</td>
		  				</tr>
		  			</table>
		  		</form>
				  	<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="list_data" 
				  		toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
						<thead>
							<tr>
								<th field="ck" align="center" checkbox="true" width="1%"></th>
								<th field="schoolName" align="center" width="6%">校区</th>
								<th data-options="field:'className',width:80,align:'center'">班级名称</th>
								<th data-options="field:'schooltimeName',width:150,align:'center'">上课时段与教室</th>
								<th data-options="field:'classStudentNum',width:80,align:'center'">定班人数</th>
								<th data-options="field:'studentNewNum',width:80,align:'center'">定班新招数</th>
								<th data-options="field:'studentHigherNum',width:100,align:'center'">定班升学数</th>
								<th data-options="field:'studentChannelTypeText',width:100,align:'center'">学员来源</th>
								<th data-options="field:'startDate',width:80,align:'center'">开课日期</th>
								<th data-options="field:'approveCreateDate',width:150,align:'center'">放班审批时间</th>
								<th data-options="field:'approveOpenDate',width:150,align:'center'">开班审批时间</th>
								<th data-options="field:'openClassTypeText',width:80,align:'center'">开班类型</th>
								<th data-options="field:'openClassStateText',width:100,align:'center'">开班状态</th>
							</tr>
						</thead>
					</table>
				<div id="toolbar" style="padding: 2px; height: auto">
		   			<a href="javascript:void(0)" id="normalOpenClass" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px;">正常开班申请</a>
		   			<a href="javascript:void(0)" id="exceptionOpenClass" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px;">异常开班申请</a>
		   			<a href="javascript:void(0)" id="updateStartDate" class="easyui-linkbutton" iconCls="icon-edit" style="width: 120px;">修改开课时间</a>
		   			<a href="javascript:void(0)" id="cancelOpenClass" class="easyui-linkbutton" iconCls="icon-cancel" style="width: 100px;">取消开班</a>
		   			<a href="javascript:void(0)" id="view" class="easyui-linkbutton" iconCls="icon-redo" style="width: 80px;">浏览</a>
				</div>
  			</div>
  			<div title="开班审批管理" style="padding:5px;display:block;">
  				<form id="qryApproveFm">
  					<table class="search_tab">
		  				<tr>
		  					<td align="right"><span>校区：</span></td>
			  				<td width="114px">
								<select id="approveSchoolId" name="approveSchoolId" class="easyui-combobox" style="width: 114px; height: 25px;" editable="false">
				        		</select>
							</td>
							<td align="right"><span>开班申请日期：</span></td>
			  				<td width="114px">
								<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="startTimeOpenApply" name="startTimeOpenApply" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="center"><span>至</span></td>
							<td>
								<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="endTimeOpenApply" name="endTimeOpenApply" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="right"><span>开班审批状态：</span></td>
							<td width="114px">
								<select id="approveState" name="approveState" class="easyui-combobox" style="width: 114px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
			      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=CREATE_CLASS_T&codeType=APPROVE_OPEN_STATE">
				        		</select>
							</td>
		  				</tr>
		  				<tr>
		  					<td align="right"><span>课程阶段：</span></td>
							<td width="114px">
								<select id="approveStageId" name="approveStageId" class="easyui-combobox" style="width: 114px; height: 25px;"
									data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'" 
			      					url="<%=path %>/pubData/qryStage.do">
				        		</select>
							</td>
							<td align="right"><span>开班审批日期：</span></td>
			  				<td width="114px">
								<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="startTimeOpenApprove" name="startTimeOpenApprove" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td  align="center"><span>至</span></td>
							<td>
								<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="endTimeOpenApprove" name="endTimeOpenApprove" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="right"><span>查看我的审批：</span></td>
							<td><input type="checkbox" name=""/></td>
							<td align="center">
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryApproveBtn" funcNodeId="1010">查询</a>
								&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="resetApprove">重置</a>
							</td>
		  				</tr>
		  			</table>
  				</form>
				  	<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="approve_list_data"
				  		toolbar="#toolbarApprove" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
						<thead>
							<tr>
								<th field="ck" align="center" checkbox="true" width="1%"></th>
								<th field="schoolName" align="center" width="6%">校区</th>
								<th data-options="field:'remark',width:220,align:'center'">申请内容</th>
								<th data-options="field:'className',width:80,align:'center'">班级名称</th>
								<th data-options="field:'openClassTypeText',width:100,align:'center'">开班类型</th>
								<th data-options="field:'startDate',width:100,align:'center'">申请开课时间</th>
								<th data-options="field:'openClassStateText',width:100,align:'center'">开班审批状态</th>
								<th data-options="field:'applyName',width:80,align:'center'">申请人</th>
								<th data-options="field:'applyOpenDate',width:120,align:'center'">申请时间</th>
								<th data-options="field:'approveOpenDate',width:120,align:'center'">审批时间</th>
								<th data-options="field:'approveName',width:80,align:'center'">审批人</th>
							</tr>
						</thead>
					</table>
				<div id="toolbarApprove" style="padding: 2px; height: auto">
		   			<a href="javascript:void(0)" id="approve" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px;">审批</a>
		   			<a href="javascript:void(0)" id="viewApprove" class="easyui-linkbutton" iconCls="icon-redo" style="width: 80px;">浏览</a>
		   		</div>
  			</div>
  		</div>
  	</body>
</html>
