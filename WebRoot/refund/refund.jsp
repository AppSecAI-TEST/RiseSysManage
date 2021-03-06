<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/refund/refund.js"></script>
  	</head>
  
  	<body>
  		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId }"/>
  		<input type="hidden" id="post" name="post" value="${sessionScope.StaffT.post }">
    	<div id="tt" class="easyui-tabs">
    			<div title="退费课程查询" style="padding:5px;display:block;">
    			<form id="qryRefundCourseFm">
    				<table class="search_tab" id="apply_search_tab">
    					<tr>
    						<td align="right" style="min-width: 60px;"><span>校区：</span></td>
			  				<td style="min-width: 100px;">
								<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
				        		</select>
							</td>
							<td align="right" style="min-width: 60px;"><span>学员姓名：</span></td>
							<td style="min-width: 100px;">
								<input name="studentId" id="studentId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
							</td>
							<td align="right" style="min-width: 60px;"><span>联系电话：</span></td>
							<td style="min-width: 205px;">
								<input name="phone" id="phone" type="text" class="easyui-textbox" style="width: 205px; height: 25px;"/>
							</td>
							<td align="right" style="min-width: 60px;"><span>缴费日期：</span></td>
			  				<td style="min-width: 210px;">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimePay" name="startTimePay" data-options="formatter:myformatter, parser:myparser"/>
								至
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimePay" name="endTimePay" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td style="min-width: 20px;"></td>
    					</tr>
    					<tr>
    						<td align="right"><span>业绩顾问：</span></td>
			  				<td>
								<select id="adviserId" name="adviserId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
				        		</select>
							</td>
							<td align="right"><span>业绩类型：</span></td>
			  				<td>
								<select id="feeType" name="feeType" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=FEE_TYPE">
				        		</select>
							</td>
							<td align="right"><span>课程类型：</span></td>
							<td>
								<select id="courseType" name="courseType" class="easyui-combobox" style="width: 100px; height: 25px;">
				        		</select>
				        		<select id="stageId" name="stageId" class="easyui-combobox" style="width: 100px; height: 25px;">
		        				</select>
		        			</td>
		        			<td align="right"><span>退费申请日期：</span></td>
			  				<td>
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeApply" name="startTimeApply" data-options="formatter:myformatter, parser:myparser"/>
								至
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeApply" name="endTimeApply" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td style="min-width: 20px;"></td>
    					</tr>
    					<tr>
    						<td align="right"><span>班级老师：</span></td>
			  				<td>
								<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
				        		</select>
							</td>
							<td align="right"><span>退费类型：</span></td>
			  				<td>
								<select id="refundType" name="refundType" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_DETAIL_T&codeType=REFUND_TYPE">
				        		</select>
							</td>
							<td align="right"><span>口碑类型：</span></td>
							<td>
								<select id="womType" name="womType" class="easyui-combobox" style="width: 100px; height: 25px;">
				        		</select>
				        		<select id="womChannel" name="womChannel" class="easyui-combobox" style="width: 100px; height: 25px;">
		        				</select>
		        			</td>
		        			<td align="right"><span>退费成功日期：</span></td>
			  				<td width="230px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeFinish" name="startTimeFinish" data-options="formatter:myformatter, parser:myparser"/>
								至
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeFinish" name="endTimeFinish" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td style="min-width: 20px;"></td>
    					</tr>
    					<tr>
    						<td align="right"><span>渠道来源：</span></td>
			  				<td>
								<select id="refundChannel" name="refundChannel" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_DETAIL_T&codeType=REFUND_CHANNEL">
				        		</select>
							</td>
							<td align="right"><span>退费规则：</span></td>
			  				<td width="100px" colspan="3">
								<select id="refundRule" name="refundRule" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_T&codeType=REFUND_RULE">
				        		</select>
							</td>
							<td align="right"><span>退费归属日期：</span></td>
							<td width="230px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeBelong" name="startTimeBelong" data-options="formatter:myformatter, parser:myparser"/>
								至
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeBelong" name="endTimeBelong" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td style="min-width: 20px;"></td>
    					</tr>
    					<tr>
    						<td align="right"><span>退费状态：</span></td>
    						<td colspan="6">
								<input type="checkbox" name="refundState" value="'001'"/><span>已申请</span>
								<input type="checkbox" name="refundState" value="'002'"/><span>审批中</span>
								<input type="checkbox" name="refundState" value="'003'"/><span>打款中</span>
								<input type="checkbox" name="refundState" value="'004'"/><span>审批未通过</span>
								<input type="checkbox" name="refundState" value="'005'"/><span>成功退费</span>
								<input type="checkbox" name="refundState" value="'006'"/><span>取消</span>
							</td>
							<td>
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1023">查询</a>
								&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>&nbsp;&nbsp;&nbsp;
							</td>
							<td style="min-width: 20px;"></td>
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
								<th field="feeTypeText" align="center" width="5%">业绩类型</th>
								<th field="classType" align="center" width="7%">班级类型</th>
								<th field="payDate" align="center" width="8%">缴费日期</th>
								<th field="adviserName" align="center" width="8%">业绩顾问</th>
								<th field="adviserTeacherName" align="center" width="8%">业绩老师</th>
								<th field="courseStateText" align="center" width="6%">原课程状态</th>
								<th field="className" align="center" width="6%">班级</th>
								<th field="teacherName" align="center" width="8%">带班老师</th>
								<th field="classProgress" align="center" width="7%">课时进度</th>
								<th field="refundTypeText" align="center" width="6%">退费类型</th>
								<th field="refundState" align="center" width="8%">退费状态</th>
								<th field="applyDate" align="center" width="8%">申请时间</th>
								<th field="belongDate" align="center" width="8%">归属时间</th>
								<th field="finishDate" align="center" width="8%">成功时间</th>
							</tr>
						</thead>
					</table>
			  	<div id="toolbarApply" style="padding: 2px; height: auto">
		   			<a href="javascript:void(0)" id="view" class="easyui-linkbutton" iconCls="icon-redo" style="width: 80px;">浏览</a>
				</div>
    		</div>
    		<div title="退费审批管理" style="padding:5px;display:block;">
    			<form id="qryRefundApproveFm">
    				<table class="search_tab" id="approve_search_tab">
    					<tr>
    						<td align="right" style="min-width: 60px"><span>校区：</span></td>
			  				<td width="110px">
								<select id="approveSchoolId" name="approveSchoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
				        		</select>
							</td>
							<td align="right" style="min-width: 60px"><span>联系电话：</span></td>
							<td width="160px">
								<input name="approvePhone" id="approvePhone" type="text" class="easyui-textbox" style="width: 150px; height: 25px;"/>
							</td>
							<td align="right" style="min-width: 60px"><span>申请日期：</span></td>
			  				<td style="min-width: 210px">
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeApprove" name="startTimeApprove" data-options="formatter:myformatter, parser:myparser"/>
								至
								<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeApprove" name="endTimeApprove" data-options="formatter:myformatter, parser:myparser"/>
							</td>
							<td align="right" style="min-width: 60px"><span>课程类型：</span></td>
							<td style="min-width: 210px">
								<select id="approveCourseType" name="approveCourseType" class="easyui-combobox" style="width: 100px; height: 25px;">
				        		</select>
				        		<select id="approveStageId" name="approveStageId" class="easyui-combobox" style="width: 100px; height: 25px;">
		        				</select>
		        			</td>
						</tr>
						<tr>
							<td align="right" style="min-width: 60px"><span>学员姓名：</span></td>
							<td>
								<input name="approveStudentId" id="approveStudentId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
							</td>
		        			<td align="right" style="min-width: 60px"><span>退费状态：</span></td>
							<td colspan="4">
								<input type="checkbox" name="approveRefundState" value="'001'"/><span>已申请</span>
								<input type="checkbox" name="approveRefundState" value="'002'"/><span>审批中</span>
								<input type="checkbox" name="approveRefundState" value="'003'"/><span>打款中</span>
								<input type="checkbox" name="approveRefundState" value="'004'"/><span>审批未通过</span>
								<input type="checkbox" name="approveRefundState" value="'005'"/><span>成功退费</span>
								<input type="checkbox" name="approveRefundState" value="'006'"/><span>取消</span>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>本人待审批：</span>&nbsp;&nbsp;<input type="checkbox" id="pending" name="pending"/>
							</td>
							<td style="min-width: 210px">
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryApproveBtn" funcNodeId="1025">查询</a>
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="resetApprove">重置</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
						</tr>
    				</table>
    			</form>
				  	<table class="easyui-datagrid" title="查询结果" id="approve_list_data"
				  		toolbar="#toolbarApprove" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
						<thead>
							<tr>
								<th field="ck" align="center" checkbox="true" width="1%"></th>
								<th field="refundFeeId" align="center" width="6%">申请编号</th>
								<th field="schoolName" align="center" width="6%">校区</th>
								<th field="name" align="center" width="6%">学员姓名</th>
								<th field="byName" align="center" width="6%">英文名</th>
								<th field="refundClassType" align="center" width="12%">退费课程（班级类型）</th>
								<th field="applyName" align="center" width="6%">申请人</th>
								<th field="approveName" align="center" width="8%">当前节点审批人</th>
								<th field="refundState" align="center" width="8%">退费状态</th>
								<th field="tacheName" align="center" width="8%">当前环节</th>
								<th field="nextTacheName" align="center" width="8%">下一环节</th>
								<th field="applyDate" align="center" width="8%">申请日期</th>
								<th field="approveDate" align="center" width="10%">审批通过日期</th>
								<th field="finishDate" align="center" width="8%">成功时间</th>
							</tr>
						</thead>
					</table>
			  	<div id="toolbarApprove" style="padding: 2px; height: auto">
			  		<a href="javascript:void(0)" id="refundApply" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">退费申请</a>
			  		<a href="javascript:void(0)" id="refundApprove" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;">退费审批</a>
		   			<a href="javascript:void(0)" id="refundView" class="easyui-linkbutton" iconCls="icon-redo" style="width: 80px;">浏览</a>
		   			<a href="javascript:void(0)" id="refundCancel" class="easyui-linkbutton" iconCls="icon-cancel" style="width: 80px;">取消</a>
		   			<a href="javascript:void(0)" id="refundApplyAgain" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">重新申请</a>
				</div>
    		</div>
    	</div>
  	</body>
</html>
<script type="text/javascript">

//恢复查询条件
function init()
{
	if($("ul.tabs").find("li").length>0)
	{
		var titleLab=$.cookie("refund-title");
		$("ul.tabs").find("li").each(function()
		{
			if($(this).find("span.tabs-title").text()==titleLab)
			{
				$(this).trigger("click");
			}	
		});
		if(titleLab=='退费审批管理')
		{
			var params=$.cookie("refund-qry-params");
			var param=JSON.parse(params);
			$("#approveSchoolId").combobox('setValue',param.approveSchoolId);
			$("#approveCourseType").combobox('setValue',param.approveCourseType); 
			$("#approveStageId").combobox('setValue',param.approveStageId); 
			$("#startTimeApprove").datebox('setValue',param.startTimeApprove);
			$("#endTimeApprove").datebox('setValue',param.endTimeApprove);
			$("#approvePhone").textbox('setValue',param.approvePhone);
			$("#approveStudentId").textbox('setValue',param.approveStudentId);
			if(param.post!=undefined)
			{
				$('#pending').attr('checked','checked');
			}
			if(param.approveRefundState!=undefined)
			{
				 $("input[name='approveRefundState']").each(function()
				{
				   if (param.approveRefundState == $(this).attr("value"))
				   {
					    $(this).attr("checked","checked"); 
				   }
				});
			}
			
			$('#approve_list_data').datagrid({
    		url : "/sys/pubData/qryDataListByPage.do",
    		queryParams:{
    			param : params
    		},
    		onLoadSuccess:function(){
    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
    			$.cookie("refund-title","退费审批管理",{path: '/sys'});
    			$.cookie("refund-qry-params",obj,{path: '/sys'});
    			$('#approve_list_data').datagrid('clearSelections');
    		}
    	});
		}
	}
}
</script>