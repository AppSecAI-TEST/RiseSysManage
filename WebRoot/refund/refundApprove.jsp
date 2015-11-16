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
			  						<input type="radio" name="refundRule" value="REFUND_COMMON" checked="checked" disabled="disabled"/><span>常规退费</span>
			  						&nbsp;&nbsp;<input type="radio" name="refundRule" value="REFUND_PERIOD" disabled="disabled"/><span>按课时退费</span>
			  						&nbsp;&nbsp;<input type="radio" name="refundRule" value="SPECIAL_ADJUST" disabled="disabled"/><span>特殊调整</span>
	  							</c:if>
	  							<c:if test="${obj.refundFeeObj.refundRule == 'REFUND_PERIOD' }">
			  						<input type="radio" name="refundRule" value="REFUND_COMMON" disabled="disabled"/><span>常规退费</span>
			  						&nbsp;&nbsp;<input type="radio" name="refundRule" value="REFUND_PERIOD" checked="checked" disabled="disabled"/><span>按课时退费</span>
			  						&nbsp;&nbsp;<input type="radio" name="refundRule" value="SPECIAL_ADJUST" disabled="disabled"/><span>特殊调整</span>
	  							</c:if>
	  							<c:if test="${obj.refundFeeObj.refundRule == 'SPECIAL_ADJUST' }">
			  						<input type="radio" name="refundRule" value="REFUND_COMMON" disabled="disabled"/><span>常规退费</span>
			  						&nbsp;&nbsp;<input type="radio" name="refundRule" value="REFUND_PERIOD" disabled="disabled"/><span>按课时退费</span>
			  						&nbsp;&nbsp;<input type="radio" name="refundRule" value="SPECIAL_ADJUST" checked="checked" disabled="disabled"/><span>特殊调整</span>
	  							</c:if>
	  						</c:if>
	  					</td>
	  					<td align="right" width="10%"><span>是否学术退费：</span></td>
	  					<td colspan="2" width="23%">
	  						<c:if test="${not empty obj.refundFeeObj.isAcademic }">
	  							<c:if test="${obj.refundFeeObj.isAcademic == 'Y' }">
			  						<input type="radio" name="isAcademic" value="Y" checked="checked" disabled="disabled"/><span>学术退费</span>
			  						&nbsp;&nbsp;<input type="radio" name="isAcademic" value="N"/><span>非学术退费</span>
	  							</c:if>
	  							<c:if test="${obj.refundFeeObj.isAcademic == 'N' }">
	  								<input type="radio" name="isAcademic" value="Y"/><span>学术退费</span>
			  						&nbsp;&nbsp;<input type="radio" name="isAcademic" value="N" checked="checked" disabled="disabled"/><span>非学术退费</span>
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
	  							<input type="radio" name="refundReason" value="school" checked="checked" disabled="disabled"/><span>校方原因</span>
		  						<select id="schoolReasonType" name="schoolReasonType" class="easyui-combobox" style="width: 100px; height: 25px;" disabled="disabled"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
				      				onLoadSuccess:function(data){if(data.length > 0) $('#schoolReasonType').combobox('setValue', '${obj.refundFeeObj.schoolReasonType }');}" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_T&codeType=SCHOOL_REASON_TYPE">
			        			</select>
			        			<select id="schoolReason" name="schoolReason" class="easyui-combobox" style="width: 150px; height: 25px;" disabled="disabled"
									data-options="formatter:formatItem, valueField: 'param1', textField: 'param2', panelHeight: 'auto',
				      				onLoadSuccess:function(data){if(data.length > 0) $('#schoolReason').combobox('setValue', '${obj.refundFeeObj.schoolReason }');}" 
				      				url="<%=path %>/pubData/qryParaConfigList.do?paramType=SCHOOL_REASON&paramValue=${obj.refundFeeObj.schoolReasonType }">
			        			</select>
		  						&nbsp;&nbsp;<input type="radio" name="refundReason" value="customer" disabled="disabled"/><span>客户原因</span>
		  						<select id="customerReason" name="customerReason" class="easyui-combobox" style="width: 120px; height: 25px;" disabled="disabled">
			        			</select>
		  						&nbsp;&nbsp;<input type="radio" name="refundReason" value="other" disabled="disabled"/><span>其他原因</span>
		  						<input id="otherReason" name="otherReason" type="text" class="easyui-textbox" style="width: 420px; height: 25px;" readonly="readonly" disabled="disabled"/>
	  						</c:if>
	  						<c:if test="${not empty obj.refundFeeObj.customerReason }">
	  							<input type="radio" name="refundReason" value="school" disabled="disabled"/><span>校方原因</span>
	  							<select id="schoolReasonType" name="schoolReasonType" class="easyui-combobox" style="width: 100px; height: 25px;" disabled="disabled">
	  							</select>
	  							<select id="schoolReason" name="schoolReason" class="easyui-combobox" style="width: 150px; height: 25px;" disabled="disabled">
	  							</select>
	  							&nbsp;&nbsp;<input type="radio" name="refundReason" value="customer" checked="checked" disabled="disabled"/><span>客户原因</span>
		  						<select id="customerReason" name="customerReason" class="easyui-combobox" style="width: 120px; height: 25px;" disabled="disabled"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
				      				onLoadSuccess:function(data){if(data.length > 0) $('#customerReason').combobox('setValue', '${obj.refundFeeObj.customerReason }');}" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_T&codeType=CUSTOMER_REASON">
			        			</select>
			        			&nbsp;&nbsp;<input type="radio" name="refundReason" value="other" disabled="disabled"/><span>其他原因</span>
		  						<input id="otherReason" name="otherReason" type="text" class="easyui-textbox" style="width: 420px; height: 25px;" readonly="readonly" disabled="disabled"/>
	  						</c:if>
	  						<c:if test="${not empty obj.refundFeeObj.otherReason }">
	  							<input type="radio" name="refundReason" value="school" disabled="disabled"/><span>校方原因</span>
	  							<select id="schoolReasonType" name="schoolReasonType" class="easyui-combobox" style="width: 100px; height: 25px;" disabled="disabled">
	  							</select>
	  							<select id="schoolReason" name="schoolReason" class="easyui-combobox" style="width: 150px; height: 25px;" disabled="disabled">
	  							</select>
	  							&nbsp;&nbsp;<input type="radio" name="refundReason" value="customer" checked="checked" disabled="disabled"/><span>客户原因</span>
		  						<select id="customerReason" name="customerReason" class="easyui-combobox" style="width: 120px; height: 25px;" disabled="disabled">
			        			</select>
			        			&nbsp;&nbsp;<input type="radio" name="refundReason" value="other" disabled="disabled"/><span>其他原因</span>
		  						<input id="otherReason" name="otherReason" type="text" class="easyui-textbox" style="width: 420px; height: 25px;" value="${obj.refundFeeObj.otherReason }" readonly="readonly" disabled="disabled"/>
	  						</c:if>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="8%"><span>退费备注：</span></td>
  						<td colspan="9" width="92%">
  							<textarea rows="4" cols="122" id="remark" name="remark" required="true" class="easyui-validatebox textbox" readonly="readonly" disabled="disabled">${obj.refundFeeObj.remark }</textarea>
  						</td>
	  				</tr>
  				</table>
  				<div style="height: 20px; vertical-align: middle; line-height:20px; margin-top: 10px;">
  					&nbsp;&nbsp;<a href='javascript:void(0)' class='linkmore' onclick='' id=""><span>展开非缴费赠送历史记录</span></a>
  					&nbsp;&nbsp;<a href='javascript:void(0)' class='linkmore' onclick='' id=""><span>查看所有的课程信息</span></a>
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
  								<select id="refundType${refundFeeDetail.studentCourseId }" name="refundType" class="easyui-combobox" style="width: 100px; height: 25px;" required="true" disabled="disabled"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      							onLoadSuccess:function(data){if(data.length > 0) $('#refundType${refundFeeDetail.studentCourseId }').combobox('setValue', '${refundFeeDetail.refundType }');}" 
	      							url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_DETAIL_T&codeType=REFUND_TYPE">
		        				</select>
  							</td>
  							<td align="right" width="8%"><span>渠道来源：</span></td>
  							<td width="41%" colspan="3">
  								<select id="refundChannel${refundFeeDetail.studentCourseId }" name="refundChannel" class="easyui-combobox" style="width: 100px; height: 25px;" required="true" disabled="disabled"
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
			  								<input type="radio" name="visitPersonOne" value="teacher" checked="checked" disabled="disabled"/><span>老师</span>
			  								<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 100px; height: 25px;" disabled="disabled"
			  									data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', panelHeight: 'auto',
	      										onLoadSuccess:function(data){if(data.length > 0) $('#teacherId').combobox('setValue', ${refundVisit.visitUserId });}" 
	      										url="<%=path %>/pubData/qryStaffList.do?schoolId=${obj.refundFeeObj.schoolId }">
					        				</select>
			  								<input type="radio" name="visitPersonOne" value="adviser" disabled="disabled"/><span>课程顾问</span>
			  								<select id="careAdviserId" name="careAdviserId" class="easyui-combobox" style="width: 100px; height: 25px;">
					        				</select>
  										</c:if>
  										<c:if test="${refundVisit.userType == 'adviser' }">
  											<input type="radio" name="visitPersonOne" value="teacher" disabled="disabled"/><span>老师</span>
			  								<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 100px; height: 25px;">
					        				</select>
			  								<input type="radio" name="visitPersonOne" value="adviser" checked="checked" disabled="disabled"/><span>课程顾问</span>
			  								<select id="careAdviserId" name="careAdviserId" class="easyui-combobox" style="width: 100px; height: 25px;" disabled="disabled"
			  									data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', panelHeight: 'auto',
	      										onLoadSuccess:function(data){if(data.length > 0) $('#careAdviserId').combobox('setValue', ${refundVisit.visitUserId });}" 
	      										url="<%=path %>/pubData/qryStaffList.do?schoolId=${obj.refundFeeObj.schoolId }">
					        				</select>
  										</c:if>
		  							</td>
		  							<td align="right" width="8%"><span>回访时间：</span></td>
		  							<td width="50%">
		  								<input name="teacherOrAdviserVisitDate" id="teacherOrAdviserVisitDate" type="text" class="easyui-datebox" required="true" style="width: 100px; height: 25px;" value="${refundVisit.visitDate }" disabled="disabled"/>
		  							</td>
		  						</tr>
		  						<tr>
		  							<td align="right" width="10%"><span>回访记录：</span></td>
		  							<td colspan="3" width="90%">
		  								<textarea rows="4" cols="122" id="teacherOrAdviserVisitRemark" name="teacherOrAdviserVisitRemark" required="true" class="easyui-validatebox textbox" readonly="readonly" disabled="disabled">${refundVisit.remark }</textarea>
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
			  								<input type="radio" name="visitPersonTwo" value="academic" checked="checked" disabled="disabled"/><span>学术主管</span>
			  								<input type="radio" name="visitPersonTwo" value="sales" disabled="disabled"/><span>销售主管</span>
		  								</c:if>
		  								<c:if test="${refundVisit.userType == 'sales' }">
		  									<input type="radio" name="visitPersonTwo" value="academic" disabled="disabled"/><span>学术主管</span>
			  								<input type="radio" name="visitPersonTwo" value="sales" checked="checked" disabled="disabled"/><span>销售主管</span>
		  								</c:if>
		  								<select id="academicOrSalesId" name="academicOrSalesId" class="easyui-combobox" style="width: 100px; height: 25px;" disabled="disabled"
			  								data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', panelHeight: 'auto',
	      									onLoadSuccess:function(data){if(data.length > 0) $('#academicOrSalesId').combobox('setValue', ${refundVisit.visitUserId });}" 
	      									url="<%=path %>/pubData/qryStaffList.do?schoolId=${obj.refundFeeObj.schoolId }">
				        				</select>
		  							</td>
		  							<td align="right" width="8%"><span>回访时间：</span></td>
		  							<td width="57%">
		  								<input name="academicOrSalesVisitDate" id="academicOrSalesVisitDate" type="text" class="easyui-datebox" required="true" style="width: 100px; height: 28px;" disabled="disabled" value="${refundVisit.visitDate }"/>
		  							</td>
		  						</tr>
		  						<tr>
		  							<td align="right" width="10%"><span>回访记录：</span></td>
		  							<td colspan="3" width="90%">
		  								<textarea rows="4" cols="122" id="academicOrSalesVisitRemark" name="academicOrSalesVisitRemark" required="true" class="easyui-validatebox textbox" readonly="readonly" disabled="disabled">${refundVisit.remark }</textarea>
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
		  								<input name="headmasterVisitDate" id="headmasterVisitDate" type="text" class="easyui-datebox" required="true" style="width: 100px; height: 28px;" disabled="disabled" value="${refundVisit.visitDate }"/>
		  							</td>
		  						</tr>
		  						<tr>
		  							<td align="right" width="10%"><span>回访记录：</span></td>
		  							<td colspan="3" width="90%">
		  								<textarea rows="4" cols="122" id="headmasterVisitRemark" name="headmasterVisitRemark" required="true" class="easyui-validatebox textbox" readonly="readonly" disabled="disabled">${refundVisit.remark }</textarea>
		  							</td>
		  						</tr>
	  						</c:if>
	  					</c:forEach>
  					</table>
  				</div>
  				
  				<div style="height: 10px"></div>
  				<div class="easyui-panel" style="min-width:1100px; width:100%;height:auto;" title="审批信息">
  					<div id="headmasterApproveDiv">
	  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
	  						<tr>
			  					<td colspan="2"><span>1、校长审批信息：</span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批：</span></td>
			  					<td width="92%">
				  					<input type="radio" value="Y" name="approveType"/><span>同意</span>
			      					&nbsp;<input type="radio" value="N" name="approveType"/><span>不同意</span>
			  					</td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批备注：</span></td>
			  					<td width="92%">
			  						<textarea rows="4" cols="122" id="headmasterApproveRemark" name="headmasterApproveRemark" required="true" class="easyui-validatebox textbox"></textarea>
			  					</td>
			  				</tr>
	  					</table>
					</div>
					<div id="headmasterViewDiv">
	  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
	  						<tr>
			  					<td colspan="6"><span>1、校长审批信息：</span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批结果：</span></td>
			  					<td width="8%"><span></span></td>
			  					<td align="right" width="8%"><span>审批时间：</span></td>
			  					<td width="10%"><span></span></td>
			  					<td align="right" width="6%"><span>审批人：</span></td>
			  					<td width="60%"><span></span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批备注：</span></td>
			  					<td width="92%" colspan="5">
			  						<textarea rows="2" cols="122" required="true" class="easyui-validatebox textbox" readonly="readonly" disabled="disabled"></textarea>
			  					</td>
			  				</tr>
	  					</table>
					</div>
					
					<div id="financialApproveDiv">
	  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
	  						<tr>
			  					<td colspan="2"><span>2、总部财务审批信息：</span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批：</span></td>
			  					<td width="92%">
				  					<input type="radio" value="Y" name="approveType"/><span>同意</span>
			      					&nbsp;<input type="radio" value="N" name="approveType"/><span>不同意</span>
			  					</td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批备注：</span></td>
			  					<td width="92%">
			  						<textarea rows="4" cols="122" id="financialApproveRemark" name="financialApproveRemark" required="true" class="easyui-validatebox textbox"></textarea>
			  					</td>
			  				</tr>
	  					</table>
					</div>
					<div id="financialViewDiv">
	  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
	  						<tr>
			  					<td colspan="6"><span>2、总部财务审批信息：</span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批结果：</span></td>
			  					<td width="8%"><span></span></td>
			  					<td align="right" width="8%"><span>审批时间：</span></td>
			  					<td width="10%"><span></span></td>
			  					<td align="right" width="6%"><span>审批人：</span></td>
			  					<td width="60%"><span></span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批备注：</span></td>
			  					<td width="92%" colspan="5">
			  						<textarea rows="2" cols="122" required="true" class="easyui-validatebox textbox" readonly="readonly" disabled="disabled"></textarea>
			  					</td>
			  				</tr>
	  					</table>
					</div>
					
					<div id="chiefFinancialOfficerApproveDiv">
	  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
	  						<tr>
			  					<td colspan="2"><span>3、总部财务总监审批信息：</span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批：</span></td>
			  					<td width="92%">
				  					<input type="radio" value="Y" name="approveType"/><span>同意</span>
			      					&nbsp;<input type="radio" value="N" name="approveType"/><span>不同意</span>
			  					</td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批备注：</span></td>
			  					<td width="92%">
			  						<textarea rows="4" cols="122" id="chiefFinancialOfficerApproveRemark" name="chiefFinancialOfficerApproveRemark" required="true" class="easyui-validatebox textbox"></textarea>
			  					</td>
			  				</tr>
	  					</table>
					</div>
					<div id="chiefFinancialOfficerViewDiv">
	  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
	  						<tr>
			  					<td colspan="6"><span>3、总部财务总监审批信息：</span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批结果：</span></td>
			  					<td width="8%"><span></span></td>
			  					<td align="right" width="8%"><span>审批时间：</span></td>
			  					<td width="10%"><span></span></td>
			  					<td align="right" width="6%"><span>审批人：</span></td>
			  					<td width="60%"><span></span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批备注：</span></td>
			  					<td width="92%" colspan="5">
			  						<textarea rows="2" cols="122" required="true" class="easyui-validatebox textbox" readonly="readonly" disabled="disabled"></textarea>
			  					</td>
			  				</tr>
	  					</table>
					</div>
					
					<div id="academicOrSalesApproveDiv">
	  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
	  						<tr>
			  					<td colspan="2"><span>4、学术总监/销售经理审批信息：</span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批：</span></td>
			  					<td width="92%">
				  					<input type="radio" value="Y" name="approveType"/><span>同意</span>
			      					&nbsp;<input type="radio" value="N" name="approveType"/><span>不同意</span>
			  					</td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批备注：</span></td>
			  					<td width="92%">
			  						<textarea rows="4" cols="122" id="academicOrSalesApproveRemark" name="academicOrSalesApproveRemark" required="true" class="easyui-validatebox textbox"></textarea>
			  					</td>
			  				</tr>
	  					</table>
					</div>
					<div id="academicOrSalesViewDiv">
	  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
	  						<tr>
			  					<td colspan="6"><span>4、学术总监/销售经理审批信息：</span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批结果：</span></td>
			  					<td width="8%"><span></span></td>
			  					<td align="right" width="8%"><span>审批时间：</span></td>
			  					<td width="10%"><span></span></td>
			  					<td align="right" width="6%"><span>审批人：</span></td>
			  					<td width="60%"><span></span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批备注：</span></td>
			  					<td width="92%" colspan="5">
			  						<textarea rows="2" cols="122" required="true" class="easyui-validatebox textbox" readonly="readonly" disabled="disabled"></textarea>
			  					</td>
			  				</tr>
	  					</table>
					</div>
					
					<div id="regionalPresidentApproveDiv">
	  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
	  						<tr>
			  					<td colspan="2"><span>5、区域校长审批信息：</span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批：</span></td>
			  					<td width="92%">
				  					<input type="radio" value="Y" name="approveType"/><span>同意</span>
			      					&nbsp;<input type="radio" value="N" name="approveType"/><span>不同意</span>
			  					</td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批备注：</span></td>
			  					<td width="92%">
			  						<textarea rows="4" cols="122" id="regionalPresidentApproveRemark" name="regionalPresidentApproveRemark" required="true" class="easyui-validatebox textbox"></textarea>
			  					</td>
			  				</tr>
	  					</table>
					</div>
					<div id="regionalPresidentViewDiv">
	  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
	  						<tr>
			  					<td colspan="6"><span>5、区域校长审批信息：</span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批结果：</span></td>
			  					<td width="8%"><span></span></td>
			  					<td align="right" width="8%"><span>审批时间：</span></td>
			  					<td width="10%"><span></span></td>
			  					<td align="right" width="6%"><span>审批人：</span></td>
			  					<td width="60%"><span></span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批备注：</span></td>
			  					<td width="92%" colspan="5">
			  						<textarea rows="2" cols="122" required="true" class="easyui-validatebox textbox" readonly="readonly" disabled="disabled"></textarea>
			  					</td>
			  				</tr>
	  					</table>
					</div>
					
					<div id="principalApproveDiv">
	  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
	  						<tr>
			  					<td colspan="2"><span>6、总校长审批信息：</span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批：</span></td>
			  					<td width="92%">
				  					<input type="radio" value="Y" name="approveType"/><span>同意</span>
			      					&nbsp;<input type="radio" value="N" name="approveType"/><span>不同意</span>
			  					</td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批备注：</span></td>
			  					<td width="92%">
			  						<textarea rows="4" cols="122" id="principalApproveRemark" name="principalApproveRemark" required="true" class="easyui-validatebox textbox"></textarea>
			  					</td>
			  				</tr>
	  					</table>
					</div>
					<div id="principalViewDiv">
	  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
	  						<tr>
			  					<td colspan="6"><span>6、总校长审批信息：</span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批结果：</span></td>
			  					<td width="8%"><span></span></td>
			  					<td align="right" width="8%"><span>审批时间：</span></td>
			  					<td width="10%"><span></span></td>
			  					<td align="right" width="6%"><span>审批人：</span></td>
			  					<td width="60%"><span></span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批备注：</span></td>
			  					<td width="92%" colspan="5">
			  						<textarea rows="2" cols="122" required="true" class="easyui-validatebox textbox" readonly="readonly" disabled="disabled"></textarea>
			  					</td>
			  				</tr>
	  					</table>
					</div>
					
					<div id="headquartersFinancialApproveDiv">
	  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
	  						<tr>
			  					<td colspan="2"><span>7、总部财务打款信息：</span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>已打款：</span></td>
			  					<td width="92%">
				  					<input type="checkbox"/>
			  					</td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>备注：</span></td>
			  					<td width="92%">
			  						<textarea rows="4" cols="122" id="headquartersFinancialApproveRemark" name="headquartersFinancialApproveRemark" required="true" class="easyui-validatebox textbox"></textarea>
			  					</td>
			  				</tr>
	  					</table>
					</div>					
  				</div>
  			</form>
  		</div>
  		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: left;margin-left: 800px;">
	      		<a href="javascript:void(0)" id="refundApproveSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      		&nbsp;<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
  	</body>
</html>
