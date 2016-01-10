<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/refund/refundApprove.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="常规课退费审批">
  			<form id="refundApproveFm">
  				<table width="100%" cellpadding="5px" class="maintable">
  					<tr>
	  					<td align="right" width="8%"><span>学员姓名：</span></td>
	  					<td width="8%"><span>${obj.refundFeeObj.name }</span></td>
	  					<td align="right" width="8%"><span>在读班级：</span></td>
	  					<td width="10%"><span>${obj.refundFeeObj.className }</span></td>
	  					<td align="right" width="8%"><span>课时进度：</span></td>
	  					<td width="10%"><span>${obj.refundFeeObj.classProgress }</span></td>
	  					<td align="right" width="8%"><span>带班老师：</span></td>
	  					<td width="40%" colspan="3"><span>${obj.refundFeeObj.teacherName }</span></td>
	  				</tr>
	  				<tr id="refundWayTr">
	  					<td align="right" width="8%"><span>退费形式：</span></td>
	  					<td width="8%">
	  						<input type="hidden" id="refundWay" name="refundWay" value="${obj.refundFeeObj.refundWay }"/>
	  						<span>${obj.refundFeeObj.refundWayText }</span>
	  					</td>
	  					<td align="right" width="8%"><span>退费银行：</span></td>
		  				<td width="10%">
		  					<input id="bankName" name="bankName" type="text" class="easyui-textbox" style="width: 120px; height: 25px;" value="${obj.refundFeeObj.bankName }"/>
		  				</td>
		  				<td align="right" width="8%"><span>账户名：</span></td>
		  				<td width="10%">
		  					<input id="account" name="account" type="text" class="easyui-textbox" style="width: 120px; height: 25px;" value="${obj.refundFeeObj.account }"/>
		  				</td>
		  				<td align="right" width="8%"><span>账号：</span></td>
		  				<td width="15%">
		  					<input id="account" name="bankCard" type="text" class="easyui-textbox" style="width: 200px; height: 25px;" value="${obj.refundFeeObj.bankCard }"/>
		  				</td>
		  				<td align="right" width="10%"><span>退费总金额：</span></td>
		  				<td width="15%">
		  					<span id="totalAmountText">${obj.refundFeeObj.amount }</span>
		  					<input type="hidden" id="totalAmount" name="totalAmount" value="${obj.refundFeeObj.amount }"/>
		  				</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="8%"><span>退费规则：</span></td>
	  					<td colspan="4" width="34%">
	  						<c:if test="${not empty obj.refundFeeObj.refundRule }">
	  							<c:if test="${obj.refundFeeObj.refundRule == 'REFUND_COMMON' }">
			  						<input type="radio" name="refundRule" value="REFUND_COMMON" checked="checked"/><span>常规退费</span>
			  						&nbsp;&nbsp;<input type="radio" name="refundRule" value="REFUND_PERIOD"/><span>按课时退费</span>
			  						&nbsp;&nbsp;<input type="radio" name="refundRule" value="SPECIAL_ADJUST"/><span>特殊调整</span>
	  							</c:if>
	  							<c:if test="${obj.refundFeeObj.refundRule == 'REFUND_PERIOD' }">
			  						<input type="radio" name="refundRule" value="REFUND_COMMON"/><span>常规退费</span>
			  						&nbsp;&nbsp;<input type="radio" name="refundRule" value="REFUND_PERIOD" checked="checked"/><span>按课时退费</span>
			  						&nbsp;&nbsp;<input type="radio" name="refundRule" value="SPECIAL_ADJUST"/><span>特殊调整</span>
	  							</c:if>
	  							<c:if test="${obj.refundFeeObj.refundRule == 'SPECIAL_ADJUST' }">
			  						<input type="radio" name="refundRule" value="REFUND_COMMON"/><span>常规退费</span>
			  						&nbsp;&nbsp;<input type="radio" name="refundRule" value="REFUND_PERIOD"/><span>按课时退费</span>
			  						&nbsp;&nbsp;<input type="radio" name="refundRule" value="SPECIAL_ADJUST" checked="checked"/><span>特殊调整</span>
	  							</c:if>
	  						</c:if>
	  					</td>
	  					<td align="right" width="10%"><span>是否学术退费：</span></td>
	  					<td colspan="2" width="23%">
	  						<c:if test="${not empty obj.refundFeeObj.isAcademic }">
	  							<c:if test="${obj.refundFeeObj.isAcademic == 'Y' }">
			  						<input type="radio" name="isAcademic" value="Y" checked="checked"/><span>学术退费</span>
			  						&nbsp;&nbsp;<input type="radio" name="isAcademic" value="N"/><span>非学术退费</span>
	  							</c:if>
	  							<c:if test="${obj.refundFeeObj.isAcademic == 'N' }">
	  								<input type="radio" name="isAcademic" value="Y"/><span>学术退费</span>
			  						&nbsp;&nbsp;<input type="radio" name="isAcademic" value="N" checked="checked"/><span>非学术退费</span>
	  							</c:if>
	  						</c:if>
	  					</td>
	  					<td align="right" width="10%"><span>财务确认金额：</span></td>
	  					<td width="15%">
	  						<span id="realAmountText">${obj.refundFeeObj.realAmount }</span>
	  						<input type="hidden" id="realAmount" name="realAmount" value="${obj.refundFeeObj.realAmount }"/>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="8%"><span>退费原因：</span></td>
	  					<td colspan="9" width="92%">
	  						<c:if test="${not empty obj.refundFeeObj.schoolReasonType && not empty obj.refundFeeObj.schoolReason }">
	  							<input type="radio" name="refundReason" value="school" checked="checked"/><span>校方原因</span>
		  						<select id="schoolReasonType" name="schoolReasonType" class="easyui-combobox" style="width: 100px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
				      				onLoadSuccess:function(data){if(data.length > 0) $('#schoolReasonType').combobox('setValue', '${obj.refundFeeObj.schoolReasonType }');}" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_T&codeType=SCHOOL_REASON_TYPE">
			        			</select>
			        			<select id="schoolReason" name="schoolReason" class="easyui-combobox" style="width: 150px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'param1', textField: 'param2', panelHeight: 'auto',
				      				onLoadSuccess:function(data){if(data.length > 0) $('#schoolReason').combobox('setValue', '${obj.refundFeeObj.schoolReason }');}" 
				      				url="<%=path %>/pubData/qryParaConfigList.do?paramType=SCHOOL_REASON&paramValue=${obj.refundFeeObj.schoolReasonType }">
			        			</select>
		  						&nbsp;&nbsp;<input type="radio" name="refundReason" value="customer"/><span>客户原因</span>
		  						<select id="customerReason" name="customerReason" class="easyui-combobox" style="width: 120px; height: 25px;">
			        			</select>
		  						&nbsp;&nbsp;<input type="radio" name="refundReason" value="other"/><span>其他原因</span>
		  						<input id="otherReason" name="otherReason" type="text" class="easyui-textbox" style="width: 420px; height: 25px;"/>
	  						</c:if>
	  						<c:if test="${not empty obj.refundFeeObj.customerReason }">
	  							<input type="radio" name="refundReason" value="school"/><span>校方原因</span>
	  							<select id="schoolReasonType" name="schoolReasonType" class="easyui-combobox" style="width: 100px; height: 25px;">
	  							</select>
	  							<select id="schoolReason" name="schoolReason" class="easyui-combobox" style="width: 150px; height: 25px;">
	  							</select>
	  							&nbsp;&nbsp;<input type="radio" name="refundReason" value="customer" checked="checked"/><span>客户原因</span>
		  						<select id="customerReason" name="customerReason" class="easyui-combobox" style="width: 120px; height: 25px;"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
				      				onLoadSuccess:function(data){if(data.length > 0) $('#customerReason').combobox('setValue', '${obj.refundFeeObj.customerReason }');}" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_T&codeType=CUSTOMER_REASON">
			        			</select>
			        			&nbsp;&nbsp;<input type="radio" name="refundReason" value="other"/><span>其他原因</span>
		  						<input id="otherReason" name="otherReason" type="text" class="easyui-textbox" style="width: 420px; height: 25px;"/>
	  						</c:if>
	  						<c:if test="${not empty obj.refundFeeObj.otherReason }">
	  							<input type="radio" name="refundReason" value="school"/><span>校方原因</span>
	  							<select id="schoolReasonType" name="schoolReasonType" class="easyui-combobox" style="width: 100px; height: 25px;">
	  							</select>
	  							<select id="schoolReason" name="schoolReason" class="easyui-combobox" style="width: 150px; height: 25px;">
	  							</select>
	  							&nbsp;&nbsp;<input type="radio" name="refundReason" value="customer" checked="checked"/><span>客户原因</span>
		  						<select id="customerReason" name="customerReason" class="easyui-combobox" style="width: 120px; height: 25px;">
			        			</select>
			        			&nbsp;&nbsp;<input type="radio" name="refundReason" value="other"/><span>其他原因</span>
		  						<input id="otherReason" name="otherReason" type="text" class="easyui-textbox" style="width: 420px; height: 25px;" value="${obj.refundFeeObj.otherReason }"/>
	  						</c:if>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="8%"><span>退费备注：</span></td>
  						<td colspan="9" width="92%">
  							<textarea rows="4" cols="122" id="remark" name="remark" required="true" class="easyui-validatebox textbox">${obj.refundFeeObj.remark }</textarea>
  						</td>
	  				</tr>
  				</table>
  				<div style="height: 20px; vertical-align: middle; line-height:20px; margin-top: 10px;">
  					&nbsp;&nbsp;<a href='javascript:void(0)' class='linkmore' onclick="viewGiftHist()" id="gift"><span>展开非缴费赠送历史记录</span></a>
  					&nbsp;&nbsp;<a href='javascript:void(0)' class='linkmore' onclick="viewStudentCourseList()"><span>查看所有的课程信息</span></a>
  				</div>
  				<div id="giftDiv">
  					<table class="easyui-datagrid" id="gift_list_data" style="height: auto;"
						pagination="false" rownumbers="false" fitColumns="true" singleSelect="false">
						<thead>
							<tr>
								<th data-options="field:'giftChannelText',width:100,align:'center'">赠送类型</th>
								<th data-options="field:'activityName',width:400,align:'center'">活动内容</th>
								<th data-options="field:'createDate',width:120,align:'center'">赠送时间</th>
								<th data-options="field:'giftTypeText',width:100,align:'center'">赠品类型</th>
								<th data-options="field:'giftName',width:100,align:'center'">赠品</th>
								<th data-options="field:'giftNum',width:100,align:'center'">数量</th>
								<th data-options="field:'isGetText',width:100,align:'center'">是否领用</th>
								<th data-options="field:'getDate',width:100,align:'center'">领用时间</th>
								<th data-options="field:'getUser',width:100,align:'center'">领用人</th>
								<th data-options="field:'granter',width:100,align:'center'">登记人</th>
							</tr>
						</thead>
					</table>
  				</div>
  				<c:forEach items="${obj.refundFeeDetailList }" var="refundFeeDetail" varStatus="status">
  					<input type="hidden" id="studentCourseId${refundFeeDetail.studentCourseId }" name="studentCourseId" value="${refundFeeDetail.studentCourseId }"/>
  					<table width="100%" cellpadding="5px" class="maintables" style="margin-top: 10px;">
  						<tr>
  							<td width="12%" style="border-right: 0">
  								<span style="font-size: 16px; font-weight: bold;">课程${status.index + 1 }</span>
  							</td>
  							<td colspan="9" align="center">
  								<span style="color: red; font-weight: bold;">退费提示：本课程${refundFeeDetail.courseTypeText }${refundFeeDetail.courseStateText }（${refundFeeDetail.classProgress }），赠送课外教课有使用（2/20）</span>
  							</td>
  						</tr>
  						<tr>
  							<td align="right" width="12%"><span>课程阶段：</span></td>
  							<td width="10%"><span>${refundFeeDetail.stageId }</span></td>
  							<td align="right" width="8%"><span>班级类型：</span></td>
  							<td width="8%"><span>${refundFeeDetail.classType }</span></td>
  							<td align="right" width="8%"><span>退费类型：</span></td>
  							<td width="7%">
  								<select id="refundType${refundFeeDetail.studentCourseId }" name="refundType" class="easyui-combobox" style="width: 100px; height: 25px;" required="true"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      							onLoadSuccess:function(data){if(data.length > 0) $('#refundType${refundFeeDetail.studentCourseId }').combobox('setValue', '${refundFeeDetail.refundType }');}" 
	      							url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_DETAIL_T&codeType=REFUND_TYPE">
		        				</select>
  							</td>
  							<td align="right" width="8%"><span>渠道来源：</span></td>
  							<td width="41%" colspan="3">
  								<select id="refundChannel${refundFeeDetail.studentCourseId }" name="refundChannel" class="easyui-combobox" style="width: 100px; height: 25px;" required="true"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      							onLoadSuccess:function(data){if(data.length > 0) $('#refundChannel${refundFeeDetail.studentCourseId }').combobox('setValue', '${refundFeeDetail.refundChannel }');}" 
	      							url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_DETAIL_T&codeType=REFUND_CHANNEL">
		        				</select>
  							</td>
  						</tr>
  						<tr>
  							<td rowspan="2" align="right" width="10%"><span>退费核定金额：</span></td>
  							<td width="10%" align="center"><span>退费阶段金额</span></td>
  							<td width="8%" align="center"><span>赠品扣除</span></td>
  							<td width="8%" align="center"><span>教材扣除</span></td>
  							<td width="8%" align="center"><span>课程扣除</span></td>
  							<td width="7%" align="center"><span>手续费</span></td>
  							<td width="8%" align="center"><span>其他扣除</span></td>
  							<td width="11%" align="center"><span>核定退费金额</span></td>
  							<td width="15%" align="center"><span>总部财务核定金额</span></td>
  							<td width="13%" align="center"><a href='javascript:void(0)' class='linkmore' onclick='' id=""><span>查看缴费单据</span></a></td>
  						</tr>
  						<tr>
  							<td width="10%" align="center">
  								<span id="refundStageFee${refundFeeDetail.studentCourseId }" name="refundStageFee">${refundFeeDetail.refundStageFee }</span>
  							</td>
  							<td width="8%" align="center">
  								<input id="minusGiftFee${refundFeeDetail.studentCourseId }" name="minusGiftFee" type="text" class="easyui-textbox numberbox" data-options="min:0, max:${refundFeeDetail.refundStageFee }, precision:2" style="width: 80px; height: 25px;" required="true" value="${refundFeeDetail.minusGiftFee }"/>
  							</td>
  							<td width="8%" align="center">
  								<input id="minusTextbookFee${refundFeeDetail.studentCourseId }" name="minusTextbookFee" type="text" class="easyui-textbox numberbox" data-options="min:0, max:${refundFeeDetail.refundStageFee }, precision:2" style="width: 100px; height: 25px;" required="true" value="${refundFeeDetail.minusTextbookFee }"/>
  							</td>
  							<td width="8%" align="center">
  								<input id="minusCourseFee${refundFeeDetail.studentCourseId }" name="minusCourseFee" type="text" class="easyui-textbox numberbox" data-options="min:0, max:${refundFeeDetail.refundStageFee }, precision:2" style="width: 100px; height: 25px;" required="true" value="${refundFeeDetail.minusCourseFee }"/>
							</td>
  							<td width="7%" align="center">
  								<input id="handlingChange${refundFeeDetail.studentCourseId }" name="handlingChange" type="text" class="easyui-textbox numberbox" data-options="min:0, max:${refundFeeDetail.refundStageFee }, precision:2" style="width: 100px; height: 25px;" required="true" value="${refundFeeDetail.handlingChange }"/>
  							</td>
  							<td width="8%" align="center">
  								<input id="minusOtherFee${refundFeeDetail.studentCourseId }" name="minusOtherFee" type="text" class="easyui-textbox numberbox" data-options="min:0, max:${refundFeeDetail.refundStageFee }, precision:2" style="width: 100px; height: 25px;" required="true" value="${refundFeeDetail.minusOtherFee }"/>
  							</td>
  							<td width="11%" align="center">
  								<span id="confirmRefundFee${refundFeeDetail.studentCourseId }" name="confirmRefundFee">${refundFeeDetail.confirmRefundFee }</span>
  							</td>
  							<td width="15%" align="center">
  								<input id="financialConfirmRefundFee${refundFeeDetail.studentCourseId }" name="financialConfirmRefundFee" type="text" class="easyui-textbox numberbox" style="width: 100px; height: 25px;" required="true"/>
  							</td>
  							<td width="13%" align="center"><a href='javascript:void(0)' class='linkmore' onclick='' id=""><span>展开/收缩课程</span></a></td>
  						</tr>
  					</table>
  				</c:forEach>
  				
  				<div style="height: 10px"></div>
  				<div class="easyui-panel" style="min-width:1100px; width:100%;height:auto;" title="回访信息">
  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
	  					<c:forEach items="${obj.refundVisitList }" var="refundVisit">
	  						<c:if test="${refundVisit.visitType == '001' }">
		  						<tr>
		  							<td colspan="4"><span>1、老师或CC回访信息：</span></td>
		  						</tr>
		  						<tr>
		  							<td align="right" width="10%"><span>回访人员：</span></td>
		  							<td width="32%">
  										<c:if test="${refundVisit.userType == 'teacher' }">
			  								<input type="radio" name="visitPersonOne" value="teacher" checked="checked"/><span>老师</span>
			  								<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 100px; height: 25px;"
			  									data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', panelHeight: 'auto',
	      										onLoadSuccess:function(data){if(data.length > 0) $('#teacherId').combobox('setValue', ${refundVisit.visitUserId });}" 
	      										url="<%=path %>/pubData/qryStaffList.do?schoolId=${obj.refundFeeObj.schoolId }">
					        				</select>
			  								<input type="radio" name="visitPersonOne" value="adviser"/><span>课程顾问</span>
			  								<select id="careAdviserId" name="careAdviserId" class="easyui-combobox" style="width: 100px; height: 25px;">
					        				</select>
  										</c:if>
  										<c:if test="${refundVisit.userType == 'adviser' }">
  											<input type="radio" name="visitPersonOne" value="teacher"/><span>老师</span>
			  								<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 100px; height: 25px;">
					        				</select>
			  								<input type="radio" name="visitPersonOne" value="adviser" checked="checked"/><span>课程顾问</span>
			  								<select id="careAdviserId" name="careAdviserId" class="easyui-combobox" style="width: 100px; height: 25px;"
			  									data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', panelHeight: 'auto',
	      										onLoadSuccess:function(data){if(data.length > 0) $('#careAdviserId').combobox('setValue', ${refundVisit.visitUserId });}" 
	      										url="<%=path %>/pubData/qryStaffList.do?schoolId=${obj.refundFeeObj.schoolId }">
					        				</select>
  										</c:if>
		  							</td>
		  							<td align="right" width="8%"><span>回访时间：</span></td>
		  							<td width="50%">
		  								<input name="teacherOrAdviserVisitDate" id="teacherOrAdviserVisitDate" type="text" class="easyui-datebox" required="true" style="width: 100px; height: 25px;" value="${refundVisit.visitDate }"/>
		  							</td>
		  						</tr>
		  						<tr>
		  							<td align="right" width="10%"><span>回访记录：</span></td>
		  							<td colspan="3" width="90%">
		  								<textarea rows="4" cols="122" id="teacherOrAdviserVisitRemark" name="teacherOrAdviserVisitRemark" class="easyui-validatebox textbox">${refundVisit.remark }</textarea>
		  							</td>
		  						</tr>
	  						</c:if>
	  					</c:forEach>
  					</table>
  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
  						<c:forEach items="${obj.refundVisitList }" var="refundVisit">
	  						<c:if test="${refundVisit.visitType == '002' }">
		  						<tr>
		  							<td colspan="4"><span>2、学术或销售主管回访信息：</span></td>
		  						</tr>
		  						<tr>
		  							<td align="right" width="10%"><span>回访人员：</span></td>
		  							<td width="25%">
		  								<c:if test="${refundVisit.userType == 'academic' }">
			  								<input type="radio" name="visitPersonTwo" value="academic" checked="checked"/><span>学术主管</span>
			  								<input type="radio" name="visitPersonTwo" value="sales"/><span>销售主管</span>
		  								</c:if>
		  								<c:if test="${refundVisit.userType == 'sales' }">
		  									<input type="radio" name="visitPersonTwo" value="academic"/><span>学术主管</span>
			  								<input type="radio" name="visitPersonTwo" value="sales" checked="checked"/><span>销售主管</span>
		  								</c:if>
		  								<select id="academicOrSalesId" name="academicOrSalesId" class="easyui-combobox" style="width: 100px; height: 25px;"
			  								data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', panelHeight: 'auto',
	      									onLoadSuccess:function(data){if(data.length > 0) $('#academicOrSalesId').combobox('setValue', ${refundVisit.visitUserId });}" 
	      									url="<%=path %>/pubData/qryStaffList.do?schoolId=${obj.refundFeeObj.schoolId }">
				        				</select>
		  							</td>
		  							<td align="right" width="8%"><span>回访时间：</span></td>
		  							<td width="57%">
		  								<input name="academicOrSalesVisitDate" id="academicOrSalesVisitDate" type="text" class="easyui-datebox" required="true" style="width: 100px; height: 28px;" value="${refundVisit.visitDate }"/>
		  							</td>
		  						</tr>
		  						<tr>
		  							<td align="right" width="10%"><span>回访记录：</span></td>
		  							<td colspan="3" width="90%">
		  								<textarea rows="4" cols="122" id="academicOrSalesVisitRemark" name="academicOrSalesVisitRemark" class="easyui-validatebox textbox">${refundVisit.remark }</textarea>
		  							</td>
		  						</tr>
	  						</c:if>
	  					</c:forEach>
  					</table>
  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
  						<c:forEach items="${obj.refundVisitList }" var="refundVisit">
	  						<c:if test="${refundVisit.visitType == '003' }">
		  						<tr>
		  							<td colspan="4"><span>3、校区校长回访信息：</span></td>
		  						</tr>
		  						<tr>
		  							<td align="right" width="10%"><span>回访人员：</span></td>
		  							<td width="8%">
		  								<select id="headmasterId" name="headmasterId" class="easyui-combobox" style="width: 100px; height: 25px;"
											data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', panelHeight: 'auto',
		      						 		onLoadSuccess:function(data){$('#headmasterId').combobox('setValue', ${refundVisit.visitUserId });}"
		      								url="<%=path %>/pubData/qryStaffList.do?schoolId=${obj.refundFeeObj.schoolId }">
				        				</select>
		  							</td>
		  							<td align="right" width="8%"><span>回访时间：</span></td>
		  							<td width="74%">
		  								<input name="headmasterVisitDate" id="headmasterVisitDate" type="text" class="easyui-datebox" required="true" style="width: 100px; height: 28px;" value="${refundVisit.visitDate }"/>
		  							</td>
		  						</tr>
		  						<tr>
		  							<td align="right" width="10%"><span>回访记录：</span></td>
		  							<td colspan="3" width="90%">
		  								<textarea rows="4" cols="122" id="headmasterVisitRemark" name="headmasterVisitRemark" class="easyui-validatebox textbox">${refundVisit.remark }</textarea>
		  							</td>
		  						</tr>
	  						</c:if>
	  					</c:forEach>
  					</table>
  				</div>
  			</form>
  		</div>
  		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: left;margin-left: 800px;">
	      		<a href="javascript:void(0)" id="refundApproveSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      		&nbsp;<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
	   <div id="dlg" class="easyui-dialog" closed="true" modal="true">
  			<div style="height: 10px"></div>
  			<div id="courseDiv">
	  			<table class="easyui-datagrid" title="常规课信息" style="height: auto; width: 1100px;" id="course_list_data"
					pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
							<th data-options="field:'stageId',width:100,align:'center'">课程阶段</th>
							<th data-options="field:'courseStateText',width:100,align:'center'">课程状态</th>
							<th data-options="field:'paySchoolName',width:100,align:'center'">校区</th>
							<th data-options="field:'payDate',width:120,align:'center'">缴费日期</th>
							<th data-options="field:'feeTypeText',width:100,align:'center'">业绩类型</th>
							<th data-options="field:'className',width:100,align:'center'">班级</th>
							<th data-options="field:'startDate',width:120,align:'center'">开课日期</th>
							<th data-options="field:'finishDate',width:120,align:'center'">结课日期</th>
							<th data-options="field:'classProgress',width:100,align:'center'">课时进度</th>
							<th data-options="field:'classTeacherName',width:100,align:'center'">带班老师</th>
							<th data-options="field:'adviserName',width:100,align:'center'">业绩顾问</th>
							<th data-options="field:'adviserTeacherName',width:100,align:'center'">业绩老师</th>
							<th data-options="field:'dutyAdvisterName',width:100,align:'center'">责任顾问</th>
							<th data-options="field:'carerName',width:100,align:'center'">客户关怀</th>
						</tr>
					</thead>
				</table>
  			</div>
  			<div style="height: 10px"></div>
  			<div id="internationalDiv">
				<table class="easyui-datagrid" title="短期课-国际班信息" style="height: auto; width: 1100px;" id="international_list_data"
					pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
							<th data-options="field:'classType',width:100,align:'center'">国际班类型</th>
							<th data-options="field:'paySchoolName',width:100,align:'center'">报名校区</th>
							<th data-options="field:'schoolName',width:100,align:'center'">上课校区</th>
							<th data-options="field:'payDate',width:120,align:'center'">缴费日期</th>
							<th data-options="field:'courseStateText',width:100,align:'center'">课程状态</th>
							<th data-options="field:'className',width:100,align:'center'">班级</th>
							<th data-options="field:'openDate',width:120,align:'center'">开课日期</th>
							<th data-options="field:'finishDate',width:120,align:'center'">结课日期</th>
							<th data-options="field:'classProgress',width:100,align:'center'">课时进度</th>
							<th data-options="field:'adviserTeacherName',width:100,align:'center'">业绩老师</th>
							<th data-options="field:'adviserName',width:100,align:'center'">业绩顾问</th>
						</tr>
					</thead>
				</table>
  			</div>
  			<div style="height: 10px"></div>
  			<div id="travelDiv">
				<table class="easyui-datagrid" title="短期课-游学信息" style="height: auto; width: 1100px;" id="travel_list_data"
					pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
							<th data-options="field:'classType',width:100,align:'center'">游学班类型</th>
							<th data-options="field:'className',width:100,align:'center'">班级</th>
							<th data-options="field:'paySchoolName',width:100,align:'center'">报名校区</th>
							<th data-options="field:'payDate',width:100,align:'center'">缴费日期</th>
							<th data-options="field:'courseStateText',width:120,align:'center'">课程状态</th>
							<th data-options="field:'openDate',width:100,align:'center'">出发日期</th>
							<th data-options="field:'finishDate',width:100,align:'center'">返回日期</th>
							<th data-options="field:'adviserTeacherName',width:120,align:'center'">业绩老师</th>
							<th data-options="field:'adviserName',width:120,align:'center'">业绩顾问</th>
						</tr>
					</thead>
				</table>
  			</div>
  		</div>
  	</body>
</html>
