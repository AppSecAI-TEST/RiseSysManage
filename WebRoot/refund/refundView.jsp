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
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="常规课退费浏览">
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
  							<textarea rows="6" cols="122" id="remark" name="remark" required="true" class="easyui-validatebox textbox" readonly="readonly" disabled="disabled">${obj.refundFeeObj.remark }</textarea>
  						</td>
	  				</tr>
  				</table>
  				<div style="height: 20px; vertical-align: middle; line-height:20px; margin-top: 10px;">
  					&nbsp;&nbsp;<a href='javascript:void(0)' class='linkmore' onclick='' id=""><span>展开非缴费赠送历史记录</span></a>
  					&nbsp;&nbsp;<a href='javascript:void(0)' class='linkmore' onclick='' id=""><span>查看所有的课程信息</span></a>
  				</div>
  				<c:forEach items="${obj.refundFeeDetailList }" var="refundFeeDetail" varStatus="status">
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
  							<td width="7%"><span>${refundFeeDetail.refundTypeText }</span></td>
  							<td align="right" width="8%"><span>渠道来源：</span></td>
  							<td width="41%" colspan="3"><span>${refundFeeDetail.refundChannelText }</span></td>
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
  							<td width="10%" align="center"><span>${refundFeeDetail.refundStageFee }</span></td>
  							<td width="8%" align="center"><span>${refundFeeDetail.minusGiftFee }</span></td>
  							<td width="8%" align="center"><span>${refundFeeDetail.minusTextbookFee }</span></td>
  							<td width="8%" align="center"><span>${refundFeeDetail.minusCourseFee }</span></td>
  							<td width="7%" align="center"><span>${refundFeeDetail.handlingChange }</span></td>
  							<td width="8%" align="center"><span>${refundFeeDetail.minusOtherFee }</span></td>
  							<td width="11%" align="center"><span>${refundFeeDetail.confirmRefundFee }</span></td>
  							<td width="15%" align="center"><span>${refundFeeDetail.financialConfirmFee }</span></td>
  							<td width="13%" align="center"><a href='javascript:void(0)' class='linkmore' onclick='' id=""><span>展开/收缩课程</span></a></td>
  						</tr>
  					</table>
  				</c:forEach>
  			</form>
  		</div>
  	</body>
</html>
