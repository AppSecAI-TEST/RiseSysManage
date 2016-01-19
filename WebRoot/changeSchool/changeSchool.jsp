<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<%@ include file="../common/pub.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/changeSchool/changeSchool.js"></script>
  	</head>
  
  	<body style="padding-top:5px">
  		<input type="hidden" id="funcNodeId" value="${param.funcNodeId}"/>
  		<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  		<div id="tt" class="easyui-tabs" style="min-width:1110px;width:98%;height:auto;">
  			<div title="转校学员管理" style="padding:5px;display:block;">
  				<form id="qryApplyFm" style="margin:0 auto;">
  					<table align="center" style="min-width:1100px;width:100%;border:1px solid #95B8E7;margin:0 auto;height:80px;">
  						<tr>
							<td align="right"><span>学员姓名：</span></td>
							<td width="100px">
								<input name="studentId" id="studentId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
							</td>
							<td align="right"><span>联系电话：</span></td>
							<td width="100px">
								<input name="phone" id="phone" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
							</td>
							<td align="right"><span>业绩顾问：</span></td>
		  					<td width="100px">
								<select id="adviser" name="adviser" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', panelHeight: 'auto'"
     								url="<%=path %>/pubData/qryStaffList.do?schoolId=">
				        		</select>
							</td>
							<td align="right"><span>转出日期：</span></td>
			  				<td width="100px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeOut" name="startTimeOut" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="center"><span>至</span></td>
							<td width="100px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeOut" name="endTimeOut" data-options="formatter:myformatter, parser:myparser"/>
							</td>
  						</tr>
  						<tr>
  							<td align="right"><span>业绩类型：</span></td>
		  					<td width="100px">
								<select id="feeType" name="feeType" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=FEE_TYPE">
				        		</select>
							</td>
							<td align="right"><span>转校状态：</span></td>
							<td width="100px">
								<select id="changeSchoolState" name="changeSchoolState" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=CHANGE_T&codeType=APPLY_CHANGE_STATE">
				        		</select>
							</td>
							<td align="right"><span>转出班老师：</span></td>
							<td width="100px">
								<select id="outTeacherId" name="outTeacherId" class="easyui-combobox" style="width: 100px; height: 25px;" disabled="disabled">
				        		</select>
							</td>
							<td align="right"><span>转入日期：</span></td>
			  				<td width="100px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeIn" name="startTimeIn" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="center"><span>至</span></td>
							<td width="100px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeIn" name="endTimeIn" data-options="formatter:myformatter, parser:myparser"/>
							</td>
  						</tr>
  						<tr>
  							<td align="right"><span>转出校区：</span></td>
			  				<td width="100px">
								<select id="outSchoolId" name="outSchoolId" class="easyui-combobox" style="width: 100px; height: 25px;">
				        		</select>
							</td>
							<td align="right"><span>转入校区：</span></td>
							<td width="100px">
								<select id="inSchoolId" name="inSchoolId" class="easyui-combobox" style="width: 100px; height: 25px;">
				        		</select>
							</td>
							<td align="right"><span>转出校在读班级：</span></td>
							<td width="100px">
								<input name="outSchoolClassInstId" id="outSchoolClassInstId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
							</td>
							<td align="right"><span>完成日期：</span></td>
			  				<td width="100px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeFinish" name="startTimeFinish" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="center"><span>至</span></td>
							<td width="100px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeFinish" name="endTimeFinish" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="center">
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryApplyBtn" funcNodeId="1019">查询</a>
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
							</td>
		  				</tr>
  					</table>
  				</form>
  				<div style="padding:5px 0;min-width:1100px; width:100%;">
				  	<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="apply_list_data" 
				  		url="<%=path %>/pubData/qryDataListByPage.do?funcNodeId=1019" 
				  		toolbar="#toolbarApply" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
						<thead>
							<tr>
								<th field="ck" align="center" checkbox="true" width="1%"></th>
								<th field="name" align="center" width="5%">学员姓名</th>
								<th field="byName" align="center" width="4%">英文名</th>
								<th data-options="field:'phone',width:200,align:'center'">联系电话</th>
								<th data-options="field:'outSchoolName',width:100,align:'center'">转出校区</th>
								<th data-options="field:'inSchoolName',width:100,align:'center'">转入校区</th>
								<th data-options="field:'changeStateText',width:100,align:'center'">转校状态</th>
								<th data-options="field:'higherStageId',width:120,align:'center'">已升学阶段</th>
								<th data-options="field:'stageIdText',width:120,align:'center'">当前课程</th>
								<th data-options="field:'feeTypeText',width:200,align:'center'">当前课程业绩类型</th>
								<th data-options="field:'adviserName',width:200,align:'center'">当前课程业绩顾问</th>
								<th data-options="field:'outClassName',width:200,align:'center'">转出校在读班</th>
								<th data-options="field:'outClassTeacherName',width:150,align:'center'">转出班老师</th>
								<th data-options="field:'outClassProgress',width:150,align:'center'">转出班课时</th>
								<th data-options="field:'inClassName',width:100,align:'center'">转入班级</th>
								<th data-options="field:'courseStateText',width:200,align:'center'">原在读课程状态</th>
								<th data-options="field:'outDate',width:120,align:'center'">转出时间</th>
							</tr>
						</thead>
					</table>
			  	</div>
			  	
			  	<div id="toolbarApply" style="padding: 2px; height: auto">
		   			<a href="javascript:void(0)" id="changeSchoolBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">转校申请</a>
		   			<a href="javascript:void(0)" id="changeOutBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px;">转出校区</a>
		   			<a href="javascript:void(0)" id="changeInBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px;">转入班级</a>
		   			<a href="javascript:void(0)" id="cancelChangeBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">取消转校</a>
		   			<a href="javascript:void(0)" id="updateChangeBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">更改选班</a>
		   			<a href="javascript:void(0)" id="view" class="easyui-linkbutton" iconCls="icon-redo" style="width: 80px;">浏览</a>
				</div>
  			</div>
  			<div title="转校审批管理" style="padding:5px;display:block;">
  				<form id="qryApproveFm" style="margin:0 auto;">
  					<table align="center" style="min-width:1100px;width:100%;border:1px solid #95B8E7;margin:0 auto;height:80px;">
  						<tr>
  							<td align="right"><span>学员姓名：</span></td>
							<td width="100px">
								<input name="approveStudentId" id="approveStudentId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
							</td>
							<td align="right"><span>联系电话：</span></td>
							<td width="100px">
								<input name="approvePhone" id="approvePhone" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
							</td>
							<td align="right"><span>申请日期：</span></td>
			  				<td width="100px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeApply" name="startTimeApply" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="center">
								<span>至</span>
							</td>
							<td width="100px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeApply" name="endTimeApply" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="right">
								<input type="checkbox" name=""/>
							</td>
							<td><span>查看我的审批</span></td>
  						</tr>
  						<tr>
  							<td align="right"><span>转出校区：</span></td>
			  				<td width="100px">
								<select id="approveSchoolId" name="approveSchoolId" class="easyui-combobox" style="width: 100px; height: 25px;">
				        		</select>
							</td>
		  					<td align="right"><span>转入校区：</span></td>
							<td width="100px">
								<select id="approveInschoolId" name="approveInschoolId" class="easyui-combobox" style="width: 100px; height: 25px;">
				        		</select>
							</td>
							<td align="right"><span>审批日期：</span></td>
			  				<td width="100px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeApprove" name="startTimeApprove" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="center">
								<span>至</span>
							</td>
							<td width="100px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeApprove" name="endTimeApprove" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="right"><span>审批状态：</span></td>
							<td width="100px">
								<select id="approveState" name="approveState" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=CHANGE_T&codeType=APPROVE_CHANGE_STATE">
				        		</select>
							</td>
							<td colspan="2" align="center">
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryApproveBtn" funcNodeId="1017">查询</a>
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="resetApprove">重置</a>
							</td>
  						</tr>
  					</table>
  				</form>
  				<div style="padding:5px 0;min-width:1100px; width:100%;">
				  	<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="approve_list_data" 
				  		toolbar="#toolbarApprove" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
						<thead>
							<tr>
								<th field="ck" align="center" checkbox="true" width="1%"></th>
								<th field="name" align="center" width="6%">学员姓名</th>
								<th data-options="field:'byName',width:100,align:'center'">英文名</th>
								<th data-options="field:'phone',width:200,align:'center'">联系电话</th>
								<th data-options="field:'applyName',width:100,align:'center'">申请人</th>
								<th data-options="field:'applyDate',width:100,align:'center'">申请时间</th>
								<th data-options="field:'approveName',width:100,align:'center'">审批人</th>
								<th data-options="field:'approveDate',width:100,align:'center'">审批时间</th>
								<th data-options="field:'outSchoolName',width:100,align:'center'">转出校区</th>
								<th data-options="field:'outClassName',width:100,align:'center'">转出班级</th>
								<th data-options="field:'outClassProgress',width:100,align:'center'">原班课时</th>
								<th data-options="field:'courseStateText',width:100,align:'center'">原课程状态</th>
								<th data-options="field:'changeSchoolNum',width:100,align:'center'">转校次数</th>
								<th data-options="field:'approveStateText',width:120,align:'center'">审批状态</th>
								<th data-options="field:'inSchoolName',width:100,align:'center'">转入校区</th>
							</tr>
						</thead>
					</table>
			  	</div>
			  	
			  	<div id="toolbarApprove" style="padding: 2px; height: auto">
		   			<a href="javascript:void(0)" id="approveBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px;">审批</a>
		   			<a href="javascript:void(0)" id="viewApprove" class="easyui-linkbutton" iconCls="icon-redo" style="width: 80px;">浏览</a>
				</div>
  			</div>
  		</div>
  	</body>
</html>
