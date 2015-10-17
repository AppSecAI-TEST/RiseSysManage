<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/applyClass/approveClass.js"></script>
  	</head>
  
  	<body style="padding-top:5px">
  		<form id="qryFm" style="margin:0 auto;">
  			<table align="center" style="min-width:1100px;width:100%;border:1px solid #95B8E7;margin:0 auto;height:80px;">
  				<tr>
  					<td align="right"><span>校区：</span></td>
	  				<td width="114px">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;" editable="false"
						data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
			      		onLoadSuccess:function(data){$('#schoolId').combobox('setValue',data[0].schoolId);}"
			      		url="<%=path %>/pubData/qrySchoolList.do?schoolId=${sessionScope.StaffT.schoolId}">
		        		</select>
					</td>
					<td align="right"><span>课程阶段：</span></td>
					<td width="114px">
						<select id="stageId" name="stageId" class="easyui-combobox" style="width: 114px; height: 25px;"
						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      				onLoadSuccess:function(data){$('#stageId').combobox('setValue',data[0].codeFlag);}" 
	      				url="<%=path %>/pubData/qryStage.do">
		        		</select>
					</td>
					<td align="right"><span>放班审批状态：</span></td>
					<td width="114px">
						<select id="approveState" name="approveState" class="easyui-combobox" style="width: 114px; height: 25px;"
						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      				onLoadSuccess:function(data){$('#approveState').combobox('setValue',data[0].codeFlag);}" 
	      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=CREATE_CLASS_T&codeType=CREATE_CLASS_APPROVE_STATE">
		        		</select>
					</td>
					<td align="right">
						<input type="checkbox" name=""/>
					</td>
					<td><span>查看我的审批</span></td>
					<td align="center">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1007">查询</a>
						&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>放班申请时间：</span></td>
	  				<td>
						<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="startTimeApply" name="startTimeApply" ata-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center"><span>至</span></td>
					<td>
						<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="endTimeApply" name="endTimeApply" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="right"><span>放班审批时间：</span></td>
	  				<td>
						<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="startTimeApplyApprove" name="startTimeApplyApprove" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td  align="center"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
					<td colspan="2">
						<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="endTimeApplyApprove" name="endTimeApplyApprove" data-options="formatter:myformatter, parser:myparser"/>
					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>取消申请时间：</span></td>
  					<td>
						<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="startTimeCancel" name="startTimeCancel" ata-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center"><span>至</span></td>
					<td>
						<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="endTimeCancel" name="endTimeCancel" data-options="formatter:myformatter, parser:myparser"/>
					</td>
  					<td align="right"><span>取消审批时间：</span></td>
  					<td>
						<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="startTimeCancelApprove" name="startTimeCancelApprove" ata-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
					<td colspan="2">
						<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="endTimeCancelApprove" name="endTimeCancelApprove" data-options="formatter:myformatter, parser:myparser"/>
					</td>
  				</tr>
  			</table>
  		</form>
  		<div style="padding:5px 0;min-width:1100px; width:100%;">
		  	<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="list_data" url="<%=path %>/pubData/qryDataListByPage.do?funcNodeId=1007" 
		  		toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'schoolName',width:80,align:'center'">校区</th>
						<th data-options="field:'remark',width:200,align:'center'">申请内容</th>
						<th data-options="field:'classType',width:100,align:'center'">课程类型</th>
						<th data-options="field:'className',width:100,align:'center'">班级名称</th>
						<th data-options="field:'startDate',width:100,align:'center'">申请开课时间</th>
						<th data-options="field:'approveStateText',width:100,align:'center'">审批状态</th>
						<th data-options="field:'applyName',width:100,align:'center'">申请人</th>
						<th data-options="field:'createDate',width:100,align:'center'">申请时间</th>
						<th data-options="field:'approveCreateDate',width:100,align:'center'">审批时间</th>
						<th data-options="field:'approveName',width:100,align:'center'">审批人</th>
					</tr>
				</thead>
			</table>
	  	</div>
		<div id="toolbar" style="padding: 2px; height: auto">
   			<a href="javascript:void(0)" id="applyApprove" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">放班审批</a>
   			<a href="javascript:void(0)" id="cancelApprove" class="easyui-linkbutton" iconCls="icon-cancel" style="width: 120px;">取消放班审批</a>
   			<a href="javascript:void(0)" id="view" class="easyui-linkbutton" iconCls="icon-redo" style="width: 80px;">浏览</a>
		</div>
  	</body>
</html>
