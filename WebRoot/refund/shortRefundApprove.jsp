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
		<script type="text/javascript" src="<%=path %>/js/refund/shortRefundApprove.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="短期课退费审批">
  			<form id="refundApproveFm">
  				<input type="hidden" id="refundFeeId" value="${obj.refundFeeId }"/>
  				<input type="hidden" id="studentId" value="${obj.refundFeeObj.studentId }"/>
  				<input type="hidden" id="refundImgUrl" value="${obj.refundFeeObj.imgUrl }"/>
  				<input type="hidden" id="nextState" value="${obj.refundFeeObj.nextState }"/>
  				<input type="hidden" id="minusGiftFee" value="${obj.refundFeeObj.minusGiftFee }"/>
  				<input type="hidden" id="refundStageFee" value="${obj.refundFeeObj.refundStageFee }"/>
  				<input type="hidden" id="favorType" value="${obj.refundFeeDetailList[0].favorType }"/>
  				<input type="hidden" id="approveId" name="approveId" value="${sessionScope.StaffT.staffId}"/>
  				<input type="hidden" id="processInstanceId" name="processInstanceId" value="${obj.refundFeeObj.processInstanceId }"/>
  				<table width="100%" cellpadding="5px" class="maintable">
  					<tr>
	  					<td align="right" width="8%"><span>学员姓名：</span></td>
	  					<td width="8%"><span>${obj.refundObj.name }</span></td>
	  					<td align="right" width="8%"><span>在读班级：</span></td>
	  					<td width="10%"><span>${obj.refundObj.className }</span></td>
	  					<td align="right" width="8%"><span>课时进度：</span></td>
	  					<td width="10%"><span>${obj.refundObj.classProgress }</span></td>
	  					<td align="right" width="8%"><span>业绩顾问：</span></td>
	  					<td width="15%">
	  						<span>
	  							<c:choose>
	  								<c:when test="${not empty obj.refundFeeDetailList[0].advisterIdAName &&  empty obj.refundFeeDetailList[0].advisterIdBName}">
	  									${obj.refundFeeDetailList[0].advisterIdAName }
	  								</c:when>
	  								<c:when test="${empty obj.refundFeeDetailList[0].advisterIdAName &&  not empty obj.refundFeeDetailList[0].advisterIdBName}">
	  									${obj.refundFeeDetailList[0].advisterIdBName }
	  								</c:when>
	  								<c:when test="${not empty obj.refundFeeDetailList[0].advisterIdAName &&  not empty obj.refundFeeDetailList[0].advisterIdBName}">
	  									${obj.refundFeeDetailList[0].advisterIdAName }/${obj.refundFeeDetailList[0].advisterIdBName }
	  								</c:when>
	  							</c:choose>
	  						</span>
	  					</td>
	  					<td align="right" width="10%"><span>带班老师：</span></td>
	  					<td width="15%"><span>${obj.refundFeeObj.teacherName }</span></td>
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
		  					<input id="bankCard" name="bankCard" type="text" class="easyui-textbox" style="width: 180px; height: 25px;" value="${obj.refundFeeObj.bankCard }"/>
		  				</td>
		  				<td align="right" width="10%"><span>退费总金额：</span></td>
		  				<td width="15%">
		  					<span id="totalAmountText">${obj.refundFeeObj.amount }</span>
		  					<input type="hidden" id="totalAmount" name="totalAmount" value="${obj.refundFeeObj.amount }"/>
		  				</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="8%"><span>教材扣除：</span></td>
	  					<td width="8%">
	  						<input id="minusTextbookFee" type="text" class="easyui-textbox" style="width: 100px; height: 25px;" readonly="readonly" disabled="disabled" value="${obj.refundFeeDetailList[0].minusTextbookFee }"/>
	  					</td>
	  					<td align="right" width="8%"><span>课程扣除：</span></td>
	  					<td width="10%">
	  						<input id="minusCourseFee" type="text" class="easyui-textbox" style="width: 120px; height: 25px;" readonly="readonly" disabled="disabled" value="${obj.refundFeeDetailList[0].minusCourseFee }"/>
	  					</td>
	  					<td align="right" width="8%"><span>手续费：</span></td>
		  				<td width="10%">
		  					<input id="handlingChange" type="text" class="easyui-textbox" style="width: 120px; height: 25px;" readonly="readonly" disabled="disabled" value="${obj.refundFeeDetailList[0].handlingChange }"/>
		  				</td>
		  				<td align="right" width="8%"><span>其他扣除：</span></td>
		  				<td width="15%">
		  					<input id="minusOtherFee" type="text" class="easyui-textbox" style="width: 180px; height: 25px;" readonly="readonly" disabled="disabled" value="${obj.refundFeeDetailList[0].minusOtherFee }"/>
		  				</td>
		  				<td align="right" width="10%"><span>财务确认金额：</span></td>
	  					<td width="15%">
	  						<input id="realAmount" type="text" class="easyui-textbox" style="width: 120px; height: 25px;" value="${obj.refundFeeObj.realAmount }"/>
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
	  				<c:if test="${not empty obj.refundFeeObj.imgUrl }">
		  				<tr>
		  					<td colspan="10">
		  						<span style="display: inline-block; width: 150px;margin-left: 50px;">查看退费申请单：</span>
		  						<span style="width: 100px; margin-left: 700px;" id="imgUrl">
	  								<a href="#" id="url" class="linkmore">查看退费申请单</a>
	  							</span>
		  					</td>
		  				</tr>
	  				</c:if>
	  				<tr>
	  					<td align="right" width="8%"> <span>退费备注：</span></td>
  						<td colspan="9" width="92%">
  							<textarea rows="4" cols="122" id="remark" name="remark" class="easyui-validatebox textbox" readonly="readonly" disabled="disabled">${obj.refundFeeObj.remark }</textarea>
  						</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="16%" colspan="2"><span>抵扣券使用情况：</span></td>
	  					<td width="84%" colspan="8">${obj.refundFeeDetailList[0].minusRemark }</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="16%" colspan="2"><span>其他优惠使用情况：</span></td>
	  					<td width="84%" colspan="8" id="favorTypeTd"></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="16%" colspan="2"><span>总金额：</span></td>
	  					<td colspan="2" width="18%"><span>${obj.refundFeeDetailList[0].totalAmount }元</span></td>
	  					<td align="right" width="18%" colspan="2"><span>赠券抵扣金额：</span></td>
	  					<td width="8%">
	  						<span>
	  							<c:if test="${not empty obj.refundFeeDetailList[0].minusAmount }">
	  								${obj.refundFeeDetailList[0].minusAmount }元
	  							</c:if>
	  						</span>
	  					</td>
	  					<td align="right" width="15%"><span>实缴金额：</span></td>
	  					<td width="25%" colspan="2"><span>${obj.refundFeeDetailList[0].amount }元</span></td>
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
  				<div style="height: 10px"></div>
  				<div class="easyui-panel" style="min-width:1100px; width:100%;height:auto;" title="审批信息">
  					<div id="financialApproveDiv" style="display: none;">
	  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
	  						<tr>
			  					<td colspan="2"><span>1、总部财务审批信息：</span></td>
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
			  						<textarea rows="4" cols="122" id="approveRemark" name="approveRemark" class="easyui-validatebox textbox"></textarea>
			  					</td>
			  				</tr>
	  					</table>
					</div>
					<div id="financialViewDiv" style="display: none;">
	  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
	  						<tr>
			  					<td colspan="6"><span>1、总部财务审批信息：</span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批结果：</span></td>
			  					<td width="8%"><span id="financialResult"></span></td>
			  					<td align="right" width="8%"><span>审批时间：</span></td>
			  					<td width="10%"><span id="financialDate"></span></td>
			  					<td align="right" width="6%"><span>审批人：</span></td>
			  					<td width="60%"><span id="financialName"></span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批备注：</span></td>
			  					<td width="92%" colspan="5">
			  						<textarea rows="2" cols="122" id="financialRemark" class="easyui-validatebox textbox" readonly="readonly" disabled="disabled"></textarea>
			  					</td>
			  				</tr>
	  					</table>
					</div>
					
					<div id="chiefFinancialOfficerApproveDiv" style="display: none;">
	  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
	  						<tr>
			  					<td colspan="2"><span>2、总部财务总监审批信息：</span></td>
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
			  						<textarea rows="4" cols="122" id="approveRemark" name="approveRemark" class="easyui-validatebox textbox"></textarea>
			  					</td>
			  				</tr>
	  					</table>
					</div>
					<div id="chiefFinancialOfficerViewDiv" style="display: none;">
	  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
	  						<tr>
			  					<td colspan="6"><span>2、总部财务总监审批信息：</span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批结果：</span></td>
			  					<td width="8%"><span id="chiefFinancialOfficerResult"></span></td>
			  					<td align="right" width="8%"><span>审批时间：</span></td>
			  					<td width="10%"><span id="chiefFinancialOfficerDate"></span></td>
			  					<td align="right" width="6%"><span>审批人：</span></td>
			  					<td width="60%"><span id="chiefFinancialOfficerName"></span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>审批备注：</span></td>
			  					<td width="92%" colspan="5">
			  						<textarea rows="2" cols="122" id="chiefFinancialOfficerRemark" class="easyui-validatebox textbox" readonly="readonly" disabled="disabled"></textarea>
			  					</td>
			  				</tr>
	  					</table>
					</div>
					
					<div id="headquartersFinancialApproveDiv" style="display: none;">
	  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
	  						<tr>
			  					<td colspan="2"><span>3、总部财务打款信息：</span></td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>已打款：</span></td>
			  					<td width="92%">
				  					<input type="checkbox" name="isTransfer"/>
			  					</td>
			  				</tr>
			  				<tr>
			  					<td align="right" width="8%"><span>备注：</span></td>
			  					<td width="92%">
			  						<textarea rows="4" cols="122" id="approveRemark" name="approveRemark" class="easyui-validatebox textbox"></textarea>
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
