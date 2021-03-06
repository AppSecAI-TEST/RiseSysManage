<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/changeClass/changeClass.js"></script>
  	</head>
  
  	<body>
  		<input type="hidden" id="funcNodeId" value="${param.funcNodeId}"/>
  		<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  		<div id="tt" class="easyui-tabs">
  			<div title="转班学员管理" style="padding:5px;display:block;">
  				<form id="qryApplyFm">
		  			<table class="search_tab" id="apply_search_tab">
		  				<tr>
		  					<td width="70px" align="right"><span>校区：</span></td>
			  				<td width="100px">
								<select id="schoolId" name="schoolId" class="easyui-combobox"  editable="false" style="width: 100px; height: 25px;">
				        		</select>
							</td>
							<td width="60px" align="right"><span>学员姓名：</span></td>
							<td width="100px">
								<input name="studentId" id="studentId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
							</td>
							<td width="60px" align="right"><span>联系电话：</span></td>
							<td width="100px">
								<input name="phone" id="phone" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
							</td>
							<td width="60px" align="right"><span>转出日期：</span></td>
			  				<td width="220px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeOut" name="startTimeOut" data-options="formatter:myformatter, parser:myparser"/>
								至
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeOut" name="endTimeOut" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td></td>
		  				</tr>
		  				<tr>
		  					<td align="right"><span>转出班老师：</span></td>
							<td>
								<select id="outTeacherId" name="outTeacherId" class="easyui-combobox" style="width: 100px; height: 25px;">
				        		</select>
							</td>
		  					<td align="right"><span>业绩类型：</span></td>
		  					<td>
								<select id="feeType" name="feeType" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=FEE_TYPE">
				        		</select>
							</td>
		  					<td align="right"><span>课程阶段：</span></td>
							<td>
								<select id="stageId" name="stageId" class="easyui-combobox" style="width: 100px; height: 25px;">
				        		</select>
							</td>
							<td align="right"><span>转入日期：</span></td>
			  				<td>
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeIn" name="startTimeIn" data-options="formatter:myformatter, parser:myparser"/>
								至
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeIn" name="endTimeIn" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td></td>
		  				</tr>
		  				<tr>
		  					<td align="right"><span>转班状态：</span></td>
							<td>
								<select id="changeClassState" name="changeClassState" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=CHANGE_T&codeType=APPLY_CHANGE_STATE">
				        		</select>
							</td>
							<td align="right"><span>转出班级：</span></td>
							<td>
								<input name="outClassInstId" id="outClassInstId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
							</td>
							<td align="right"><span>转入班级：</span></td>
							<td>
								<input name="inClassInstId" id="inClassInstId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
							</td>
							<td align="right"><span>完成日期：</span></td>
			  				<td>
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeFinish" name="startTimeFinish" data-options="formatter:myformatter, parser:myparser"/>
								至
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeFinish" name="endTimeFinish" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td>
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryApplyBtn" funcNodeId="1012">查询</a>
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
							</td>
		  				</tr>
		  			</table>
		  		</form>
				  	<table class="easyui-datagrid" title="查询结果" id="apply_list_data" 
				  		toolbar="#toolbarApply" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
						<thead>
							<tr>
								<th field="ck" align="center" checkbox="true" width="1%"></th>
								<th field="schoolName" align="center" width="6%">校区</th>
								<th field="name" align="center" width="6%">学员姓名</th>
								<th field="byName" align="center" width="6%">英文名</th>
								<th field="phone" align="center" width="15%">联系电话</th>
								<th field="payDate" align="center" width="8%">缴费日期</th>
								<th field="feeTypeText" align="center" width="6%">业绩类型</th>
								<th field="outClassName" align="center" width="8%">转出班级</th>
								<th field="outClassTeacherName" align="center" width="10%">转出班老师</th>
								<th field="studentOutProgress" align="center" width="8%">原班课时</th>
								<th field="courseStateText" align="center" width="6%">原课程状态</th>
								<th field="changeStateText" align="center" width="6%">转班状态</th>
								<th field="inClassName" align="center" width="8%">转入班级</th>
								<th field="outDate" align="center" width="12%">转出时间</th>
							</tr>
						</thead>
					</table>
			  	
			  	<div id="toolbarApply" style="padding: 2px; height: auto">
		   			<a href="javascript:void(0)" id="changeClassBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">转班申请</a>
		   			<a href="javascript:void(0)" id="changeOutBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px;">转出</a>
		   			<a href="javascript:void(0)" id="changeInBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px;">转入</a>
		   			<a href="javascript:void(0)" id="cancelChangeBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">取消转班</a>
		   			<a href="javascript:void(0)" id="updateChangeBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">更改转班</a>
		   			<a href="javascript:void(0)" id="view" class="easyui-linkbutton" iconCls="icon-redo" style="width: 80px;">浏览</a>
				</div>
  			</div>
  			
  			<div title="转班审批管理" style="padding:5px;display:block;">
  				<form id="qryApproveFm">
		  			<table class="search_tab" id="approve_search_tab">
		  				<tr>
		  					<td width="70px" align="right"><span>校区：</span></td>
			  				<td width="100px">
								<select id="approveSchoolId" name="approveSchoolId"  editable="false" class="easyui-combobox" style="width: 100px; height: 25px;">
				        		</select>
							</td>
							<td width="70px" align="right"><span>学员姓名：</span></td>
							<td width="100px">
								<input name="approveStudentId" id="approveStudentId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
							</td>
							<td width="70px" align="right"><span>申请日期：</span></td>
			  				<td width="220px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeApply" name="startTimeApply" data-options="formatter:myformatter, parser:myparser"/>
								至
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeApply" name="endTimeApply" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="left" colspan="3"><span>查看我的审批：</span>&nbsp;&nbsp;<input type="checkbox" name=""/></td>
		  				</tr>
		  				<tr>
		  					<td align="right"><span>课程阶段：</span></td>
							<td>
								<select id="approveStageId" name="approveStageId" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'" 
				      				url="<%=path %>/pubData/qryStage.do">
				        		</select>
							</td>
							<td align="right"><span>联系电话：</span></td>
							<td>
								<input name="approvePhone" id="approvePhone" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
							</td>
							<td align="right"><span>审批日期：</span></td>
			  				<td>
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeApprove" name="startTimeApprove" data-options="formatter:myformatter, parser:myparser"/>
								至
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeApprove" name="endTimeApprove" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="right"><span>审批状态：</span></td>
							<td width="100px">
								<select id="approveState" name="approveState" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=CHANGE_T&codeType=APPROVE_CHANGE_STATE">
				        		</select>
							</td>
							<td align="center">
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryApproveBtn" funcNodeId="1014">查询</a>
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="resetApprove">重置</a>
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
								<th field="name" align="center" width="6%">学员姓名</th>
								<th field="byName" align="center" width="6%">英文名</th>
								<th field="phone" align="center" width="15%">联系电话</th>
								<th field="applyName" align="center" width="6%">申请人</th>
								<th field="applyDate" align="center" width="12%">申请时间</th>
								<th field="approveName" align="center" width="6%">审批人</th>
								<th field="approveDate" align="center" width="12%">审批时间</th>
								<th field="outClassName" align="center" width="8%">转出班级</th>
								<th field="studentOutProgress" align="center" width="8%">原班课时</th>
								<th field="courseStateText" align="center" width="6%">原课程状态</th>
								<th field="approveStateText" align="center" width="8%">审批状态</th>
							</tr>
						</thead>
					</table>
			  	
			  	<div id="toolbarApprove" style="padding: 2px; height: auto">
		   			<a href="javascript:void(0)" id="approveBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px;">审批</a>
		   			<a href="javascript:void(0)" id="viewApprove" class="easyui-linkbutton" iconCls="icon-redo" style="width: 80px;">浏览</a>
				</div>
  			</div>
  		</div>
  	</body>
</html>
