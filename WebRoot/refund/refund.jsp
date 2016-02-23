<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/pub.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/refund/refund.js"></script>
  	</head>
  
  	<body style="padding-top:5px">
  		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
    	<div id="tt" class="easyui-tabs" style="min-width:1110px;width:98%;height:auto;">
    		<div title="退费审批管理" style="padding:5px;display:block;">
    			<form id="qryRefundApproveFm" style="margin:0 auto;">
    				<table align="center" style="min-width:1100px;width:100%;border:1px solid #95B8E7;margin:0 auto;height:80px;">
    					<tr>
    						<td align="right"><span>校区：</span></td>
			  				<td width="100px">
								<select id="approveSchoolId" name="approveSchoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
									data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
					      			onLoadSuccess:function(data)legory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=252&fieldId=schoolId">
				        		</select>
							</td>
							<td align="right"><span>联系电话：</span></td>
							<td width="100px">
								<input name="approvePhone" id="approvePhone" type="text" class="easyui-textbox" style="width: 210px; height: 25px;"/>
							</td>
							<td align="right"><span>申请日期：</span></td>
			  				<td width="100px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeApprove" name="startTimeApprove" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="center"><span>至</span></td>
							<td width="100px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeApprove" name="endTimeApprove" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="right"><span>本人待审批：</span></td>
							<td>
								<input type="checkbox" />
							</td>
							<td align="center">
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryApproveBtn" funcNodeId="1025">查询</a>
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="resetApprove">重置</a>
							</td>
						</tr>
						<tr>
							<td align="right"><span>学员姓名：</span></td>
							<td width="100px">
								<input name="approveStudentId" id="approveStudentId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
							</td>
							<td align="right"><span>课程类型：</span></td>
							<td width="100px">
								<select id="approveCourseType" name="approveCourseType" class="easyui-combobox" style="width: 100px; height: 25px;">
				        		</select>
				        		<select id="approveStageId" name="approveStageId" class="easyui-combobox" style="width: 100px; height: 25px;">
		        				</select>
		        			</td>
		        			<td align="right"><span>退费状态：</span></td>
							<td colspan="6">
								<input type="checkbox" name="approveRefundState" value="'001'"/><span>已申请</span>
								<input type="checkbox" name="approveRefundState" value="'002'"/><span>审批中</span>
								<input type="checkbox" name="approveRefundState" value="'003'"/><span>打款中</span>
								<input type="checkbox" name="approveRefundState" value="'004'"/><span>审批未通过</span>
								<input type="checkbox" name="approveRefundState" value="'005'"/><span>成功退费</span>
								<input type="checkbox" name="approveRefundState" value="'006'"/><span>取消</span>
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
								<th field="refundFeeId" align="center" width="6%">申请编号</th>
								<th field="schoolName" align="center" width="6%">校区</th>
								<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
								<th data-options="field:'byName',width:80,align:'center'">英文名</th>
								<th data-options="field:'refundClassType',width:200,align:'center'">退费课程（班级类型）</th>
								<th data-options="field:'applyName',width:80,align:'center'">申请人</th>
								<th data-options="field:'approveName',width:120,align:'center'">当前节点审批人</th>
								<th data-options="field:'refundState',width:100,align:'center'">退费状态</th>
								<th data-options="field:'tacheName',width:120,align:'center'">当前环节</th>
								<th data-options="field:'nextTacheName',width:120,align:'center'">下一环节</th>
								<th data-options="field:'applyDate',width:100,align:'center'">申请日期</th>
								<th data-options="field:'approveDate',width:120,align:'center'">审批通过日期</th>
								<th data-options="field:'finishDate',width:100,align:'center'">成功时间</th>
							</tr>
						</thead>
					</table>
			  	</div>
			  	<div id="toolbarApprove" style="padding: 2px; height: auto">
			  		<a href="javascript:void(0)" id="refundApply" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">退费申请</a>
			  		<a href="javascript:void(0)" id="refundApprove" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;">退费审批</a>
		   			<a href="javascript:void(0)" id="refundView" class="easyui-linkbutton" iconCls="icon-redo" style="width: 80px;">浏览</a>
		   			<a href="javascript:void(0)" id="refundCancel" class="easyui-linkbutton" iconCls="icon-cancel" style="width: 80px;">取消</a>
		   			<a href="javascript:void(0)" id="refundApplyAgain" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">重新申请</a>
				</div>
    		</div>
    			<div title="退费课程查询" style="padding:5px;display:block;">
    			<form id="qryRefundCourseFm" style="margin:0 auto;">
    				<table align="center" style="min-width:1100px;width:100%;border:1px solid #95B8E7;margin:0 auto;height:80px;">
    					<tr>
    						<td align="right"><span>校区：</span></td>
			  				<td width="100px">
								<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
				        		</select>
							</td>
							<td align="right"><span>学员姓名：</span></td>
							<td width="100px">
								<input name="studentId" id="studentId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
							</td>
							<td align="right"><span>联系电话：</span></td>
							<td width="210px">
								<input name="phone" id="phone" type="text" class="easyui-textbox" style="width: 210px; height: 25px;"/>
							</td>
							<td align="right"><span>缴费日期：</span></td>
			  				<td width="100px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimePay" name="startTimePay" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="center">
								<span>至</span>
							</td>
							<td width="100px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimePay" name="endTimePay" data-options="formatter:myformatter, parser:myparser"/>
							</td>
    					</tr>
    					<tr>
    						<td align="right"><span>业绩顾问：</span></td>
			  				<td width="100px">
								<select id="adviserId" name="adviserId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
				        		</select>
							</td>
							<td align="right"><span>业绩类型：</span></td>
			  				<td width="100px">
								<select id="feeType" name="feeType" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=FEE_TYPE">
				        		</select>
							</td>
							<td align="right"><span>课程类型：</span></td>
							<td width="100px">
								<select id="courseType" name="courseType" class="easyui-combobox" style="width: 100px; height: 25px;">
				        		</select>
				        		<select id="stageId" name="stageId" class="easyui-combobox" style="width: 100px; height: 25px;">
		        				</select>
		        			</td>
		        			<td align="right"><span>退费申请日期：</span></td>
			  				<td width="100px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeApply" name="startTimeApply" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="center">
								<span>至</span>
							</td>
							<td width="100px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeApply" name="endTimeApply" data-options="formatter:myformatter, parser:myparser"/>
							</td>
    					</tr>
    					<tr>
    						<td align="right"><span>班级老师：</span></td>
			  				<td width="100px">
								<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
				        		</select>
							</td>
							<td align="right"><span>退费类型：</span></td>
			  				<td width="100px">
								<select id="refundType" name="refundType" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_DETAIL_T&codeType=REFUND_TYPE">
				        		</select>
							</td>
							<td align="right"><span>口碑类型：</span></td>
							<td width="100px">
								<select id="womType" name="womType" class="easyui-combobox" style="width: 100px; height: 25px;">
				        		</select>
				        		<select id="womChannel" name="womChannel" class="easyui-combobox" style="width: 100px; height: 25px;">
		        				</select>
		        			</td>
		        			<td align="right"><span>成功退费日期：</span></td>
			  				<td width="100px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeFinish" name="startTimeFinish" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="center">
								<span>至</span>
							</td>
							<td width="100px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeFinish" name="endTimeFinish" data-options="formatter:myformatter, parser:myparser"/>
							</td>
    					</tr>
    					<tr>
    						<td align="right"><span>渠道来源：</span></td>
			  				<td width="100px">
								<select id="refundChannel" name="refundChannel" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_DETAIL_T&codeType=REFUND_CHANNEL">
				        		</select>
							</td>
							<td align="right"><span>退费规则：</span></td>
			  				<td width="100px">
								<select id="refundRule" name="refundRule" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_T&codeType=REFUND_RULE">
				        		</select>
							</td>
							<td align="right"><span>退费状态：</span></td>
							<td colspan="4">
								<input type="checkbox" name="refundState" value="'001'"/><span>已申请</span>
								<input type="checkbox" name="refundState" value="'002'"/><span>审批中</span>
								<input type="checkbox" name="refundState" value="'003'"/><span>打款中</span>
								<input type="checkbox" name="refundState" value="'004'"/><span>审批未通过</span>
								<input type="checkbox" name="refundState" value="'005'"/><span>成功退费</span>
								<input type="checkbox" name="refundState" value="'006'"/><span>取消</span>
							</td>
							<td align="center">
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1023">查询</a>
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
							</td>
    					</tr>
    				</table>
    			</form>
    			<div style="padding:5px 0;min-width:1100px; width:100%;">
				  	<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="apply_list_data"
				  		toolbar="#toolbarApply" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
						<thead>
							<tr>
								<th field="ck" align="center" checkbox="true" width="1%"></th>
								<th field="schoolName" align="center" width="6%">校区</th>
								<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
								<th data-options="field:'byName',width:80,align:'center'">英文名</th>
								<th data-options="field:'feeTypeText',width:80,align:'center'">业绩类型</th>
								<th data-options="field:'classType',width:80,align:'center'">班级类型</th>
								<th data-options="field:'payDate',width:100,align:'center'">缴费日期</th>
								<th data-options="field:'adviserName',width:100,align:'center'">业绩顾问</th>
								<th data-options="field:'adviserTeacherName',width:100,align:'center'">业绩老师</th>
								<th data-options="field:'courseStateText',width:120,align:'center'">原课程状态</th>
								<th data-options="field:'className',width:100,align:'center'">班级</th>
								<th data-options="field:'teacherName',width:100,align:'center'">带班老师</th>
								<th data-options="field:'classProgress',width:100,align:'center'">课时进度</th>
								<th data-options="field:'refundTypeText',width:100,align:'center'">退费类型</th>
								<th data-options="field:'refundState',width:100,align:'center'">退费状态</th>
								<th data-options="field:'applyDate',width:100,align:'center'">申请时间</th>
								<th data-options="field:'finishDate',width:100,align:'center'">成功时间</th>
							</tr>
						</thead>
					</table>
			  	</div>
			  	<div id="toolbarApply" style="padding: 2px; height: auto">
		   			<a href="javascript:void(0)" id="view" class="easyui-linkbutton" iconCls="icon-redo" style="width: 80px;">浏览</a>
				</div>
    		</div>
    	</div>
  	</body>
</html>
