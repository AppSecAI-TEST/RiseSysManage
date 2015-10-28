<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
  		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/applyClass/applyClass.js"></script>
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
					<td align="right"><span>班级：</span></td>
					<td width="114px">
						<select id="classInstId" name="classInstId" class="easyui-combobox" style="width: 114px; height: 25px;">
		        		</select>
					</td>
					<td align="right"><span>放班申请时间：</span></td>
	  				<td width="114px">
						<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="startTimeApply" name="startTimeApply" ata-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center"><span>至</span></td>
					<td width="114px">
						<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="endTimeApply" name="endTimeApply" data-options="formatter:myformatter, parser:myparser"/>
					</td>
	  			</tr>
	  			<tr>
	  				<td align="right"><span>班级状态：</span></td>
					<td width="114px">
						<select id="classState" name="classState" class="easyui-combobox" style="width: 114px; height: 25px;"
						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      			 	onLoadSuccess:function(data){$('#classState').combobox('setValue',data[0].codeFlag);}" 
	      			 	url="<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=CLASS_STATE">
		        		</select>
					</td>
	  				<td align="right"><span>放班状态：</span></td>
	  				<td colspan="3">
	  					<select id="tacheState" name="tacheState" class="easyui-combobox" style="width: 114px; height: 25px;"
							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
		      				onLoadSuccess:function(data){$('#tacheState').combobox('setValue',data[0].codeFlag);}" 
		      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=CREATE_CLASS_T&codeType=CREATE_CLASS_STATE">
		        		</select>
	  				</td>
					<td align="right"><span>放班审批时间：</span></td>
	  				<td width="114px">
						<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="startTimeApprove" name="startTimeApprove" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td  align="center"><span>至</span></td>
					<td width="114px">
						<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="endTimeApprove" name="endTimeApprove" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center" colspan="2">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1006">查询</a>
						&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
					</td>
	  			</tr>
	  		</table>
	  	</form>
	  	<div style="padding:5px 0;min-width:1100px; width:100%;">
		  	<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="list_data" url="<%=path %>/pubData/qryDataListByPage.do?funcNodeId=1006" 
		  		toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'schoolName',width:80,align:'center'">校区</th>
						<th data-options="field:'className',width:100,align:'center'">班级名称</th>
						<th data-options="field:'applyDate',width:130,align:'center'">放班审批时间</th>
						<th data-options="field:'latestApplyClassState',width:100,align:'center'">最新放班状态</th>
						<th data-options="field:'cancelApplyClassStateText',width:150,align:'center'">取消放班审批状态</th>
						<th data-options="field:'openClassStateText',width:100,align:'center'">开班状态</th>
						<th data-options="field:'classStateText',width:100,align:'center'">班级状态</th>
						<th data-options="field:'startDate',width:100,align:'center'">开课时间</th>
						<th data-options="field:'schooltimeName',width:200,align:'center'">上课时段与教室</th>
						<th data-options="field:'classStudentNum',width:80,align:'center'">定班人数</th>
						<th data-options="field:'minSubNum',width:100,align:'center'">距最低人数</th>
						<th data-options="field:'teacherName',width:80,align:'center'">带班老师</th>
						<th data-options="field:'studentChannelTypeText',width:100,align:'center'">学员来源</th>
						<th data-options="field:'higherSchoolName',width:100,align:'center'">来源班级</th>
					</tr>
				</thead>
			</table>
	  	</div>
		<div id="toolbar" style="padding: 2px; height: auto">
   			<a href="javascript:void(0)" id="applyClass" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">放班申请</a>
   			<a href="javascript:void(0)" id="cancelApplyClass" class="easyui-linkbutton" iconCls="icon-cancel" style="width: 120px;">取消放班申请</a>
   			<a href="javascript:void(0)" id="updateApplyClass" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;">班级维护</a>
   			<a href="javascript:void(0)" id="view" class="easyui-linkbutton" iconCls="icon-redo" style="width: 80px;">浏览</a>
		</div>
  	</body>
</html>
