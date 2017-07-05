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
		<script type="text/javascript" src="<%=path %>/js/refund/refundApply.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="常规课退费重新申请">
  			<form id="refundApplyFm" method="post" enctype="multipart/form-data">
  				<input type="hidden" id="optionType" value="applyAgain"/>
	  			<input type="hidden" id="oldRefundWay" value="${obj.refundFeeObj.refundWay }"/>
	  			<input type="hidden" id="schoolId" name="schoolId" value="${obj.refundFeeObj.schoolId }"/>
  				<input type="hidden" id="studentId" name="studentId" value="${obj.refundFeeObj.studentId }"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId }"/>
  				<input type="hidden" id="courseType" name="courseType" value="${obj.refundFeeObj.courseType }"/>
  				<table width="100%" cellpadding="5px" class="maintable">
  					<tr>
	  					<td align="right" width="8%"><span>学员姓名：</span></td>
	  					<td width="8%"><span>${obj.refundFeeObj.name }</span></td>
	  					<td align="right" width="8%"><span>在读班级：</span></td>
	  					<td width="10%"><span>${obj.refundFeeObj.className }</span></td>
	  					<td align="right" width="8%"><span>课时进度：</span></td>
	  					<td width="10%"><span>${obj.refundFeeObj.classProgress }</span></td>
	  					<td align="right" width="8%"><span>带班老师：</span></td>
	  					<td width="20%"><span>${obj.refundFeeObj.teacherName }</span></td>
	  					<td align="right" width="8%"><span>联系电话：</span></td>
	  					<td width="10%"><span id="phoneText">${obj.refundFeeObj.phone }</span></td>
	  				</tr>
	  				<tr id="refundWayTr">
	  					<td align="right" width="8%"><span>退费形式：</span></td>
	  					<td width="8%">
	  						<select id="refundWay" name="refundWay" class="easyui-combobox" style="width: 90px; height: 25px;" required="true">
		        			</select>
	  					</td>
	  					<td align="right" width="8%"><span>退费银行：</span></td>
		  				<td width="10%">
		  					<input id="bankName" name="bankName" type="text" class="easyui-textbox" validType="length[0,10]" style="width: 120px; height: 25px;" value="${obj.refundFeeObj.bankName }"/>
		  				</td>
		  				<td align="right" width="8%"><span>账户名：</span></td>
		  				<td width="10%">
		  					<input id="account" name="account" type="text" class="easyui-textbox" validType="length[0,10]" style="width: 120px; height: 25px;" value="${obj.refundFeeObj.account }"/>
		  				</td>
		  				<td align="right" width="8%"><span>账号：</span></td>
		  				<td width="20%">
		  					<input id="bankCard" name="bankCard" type="text" class="easyui-textbox numberbox" validType="length[0,19]" style="width: 200px; height: 25px;" value="${obj.refundFeeObj.bankCard }"/>
		  				</td>
		  				<td align="right" width="10%"><span>退费总金额：</span></td>
		  				<td width="10%">
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
	  					<td colspan="2" width="28%">
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
	  					<td width="10%">
	  						<span id="realAmountText">${obj.refundFeeObj.realAmount }</span>
	  						<input type="hidden" id="realAmount" name="realAmount" value="${obj.refundFeeObj.realAmount }"/>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="8%"><span>退费原因：</span></td>
	  					<td colspan="9" width="92%">
	  						<c:if test="${not empty obj.refundFeeObj.schoolReasonType && not empty obj.refundFeeObj.schoolReason }">
	  							<input type="radio" name="refundReason" value="school" checked="checked"/><span>校方原因</span>
		  						<select id="schoolReasonType" name="schoolReasonType" class="easyui-combobox" style="width: 120px; height: 25px;" editable="false"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
				      				onLoadSuccess:function(data){if(data.length > 0) $('#schoolReasonType').combobox('setValue', '${obj.refundFeeObj.schoolReasonType }');}" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_T&codeType=SCHOOL_REASON_TYPE">
			        			</select>
			        			<select id="schoolReason" name="schoolReason" class="easyui-combobox" style="width: 200px; height: 25px;" editable="false"
									data-options="formatter:function(row){return '<span>' + row.param2 + '</span>';}, valueField: 'param1', textField: 'param2', panelHeight: 'auto',
				      				onLoadSuccess:function(data){if(data.length > 0) $('#schoolReason').combobox('setValue', '${obj.refundFeeObj.schoolReason }');}" 
				      				url="<%=path %>/pubData/qryParaConfigList.do?paramType=SCHOOL_REASON&paramValue=${obj.refundFeeObj.schoolReasonType }">
			        			</select>
		  						&nbsp;&nbsp;<input type="radio" name="refundReason" value="customer"/><span>客户原因</span>
		  						<select id="customerReason" name="customerReason" class="easyui-combobox" style="width: 120px; height: 25px;" editable="false">
			        			</select>
			        			<!--  
		  						&nbsp;&nbsp;<input type="radio" name="refundReason" value="other"/><span>其他原因</span>
		  						<input id="otherReason" name="otherReason" type="text" class="easyui-textbox" validType="length[0,50]" style="width: 380px; height: 25px;"/>
	  							-->
	  						</c:if>
	  						<c:if test="${not empty obj.refundFeeObj.customerReason }">
	  							<input type="radio" name="refundReason" value="school"/><span>校方原因</span>
	  							<select id="schoolReasonType" name="schoolReasonType" class="easyui-combobox" style="width: 120px; height: 25px;" editable="false">
	  							</select>
	  							<select id="schoolReason" name="schoolReason" class="easyui-combobox" style="width: 200px; height: 25px;" editable="false">
	  							</select>
	  							&nbsp;&nbsp;<input type="radio" name="refundReason" value="customer" checked="checked"/><span>客户原因</span>
		  						<select id="customerReason" name="customerReason" class="easyui-combobox" style="width: 120px; height: 25px;" editable="false"
									data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
				      				onLoadSuccess:function(data){if(data.length > 0) $('#customerReason').combobox('setValue', '${obj.refundFeeObj.customerReason }');}" 
				      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_T&codeType=CUSTOMER_REASON">
			        			</select>
			        			<!--  
			        			&nbsp;&nbsp;<input type="radio" name="refundReason" value="other"/><span>其他原因</span>
		  						<input id="otherReason" name="otherReason" type="text" class="easyui-textbox" validType="length[0,50]" style="width: 380px; height: 25px;"/>
	  							-->
	  						</c:if>
	  						<c:if test="${not empty obj.refundFeeObj.otherReason }">
	  							<input type="radio" name="refundReason" value="school"/><span>校方原因</span>
	  							<select id="schoolReasonType" name="schoolReasonType" class="easyui-combobox" style="width: 120px; height: 25px;" editable="false">
	  							</select>
	  							<select id="schoolReason" name="schoolReason" class="easyui-combobox" style="width: 200px; height: 25px;" editable="false">
	  							</select>
	  							&nbsp;&nbsp;<input type="radio" name="refundReason" value="customer" checked="checked"/><span>客户原因</span>
		  						<select id="customerReason" name="customerReason" class="easyui-combobox" style="width: 120px; height: 25px;" editable="false">
			        			</select>
			        			<!--  
			        			&nbsp;&nbsp;<input type="radio" name="refundReason" value="other"/><span>其他原因</span>
		  						<input id="otherReason" name="otherReason" type="text" class="easyui-textbox" validType="length[0,50]" style="width: 380px; height: 25px;" value="${obj.refundFeeObj.otherReason }"/>
	  							-->
	  						</c:if>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td colspan="10">
	  						<span>上传退费申请单：</span>
	  						<input type="hidden" name="imgUrl" id="imgUrl" value="${obj.refundFeeObj.imgUrl }"/>
	                        <input style="width: 500px; height: 28px;" class="easyui-filebox" name="fileName" id="fileName" data-options="prompt:'', buttonText: '文件选择', accept: 'image/*'"/>
	                        <a href="javascript:void(0)" class="easyui-linkbutton" id="uploadBtn" iconCls="icon-save" iconCls="icon-save" style="width: 80px; height: 28px;">上传</a>
	                        <a href="javascript:void(0)" class="easyui-linkbutton" id="cancelUploadBtn" iconCls="icon-cancel" iconCls="icon-cancel" style="width: 80px; height: 28px;">取消</a>
	  						<c:if test="${not empty obj.refundFeeObj.url }">
		  						<span id="imgUrl">
		  							<a href="${obj.refundFeeObj.url }" id="refundImg" class="linkmore">查看退费申请单</a>
		  						</span>
	  						</c:if>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="8%"><span>退费备注：</span></td>
  						<td colspan="9" width="92%">
  							<textarea rows="4" cols="122" id="remark" name="remark" class="textarea easyui-validatebox" validType="length[0,120]">${obj.refundFeeObj.remark }</textarea>
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
  					<input type="hidden" id="classInstId${refundFeeDetail.studentCourseId }" name="classInstId" value="${refundFeeDetail.classInstId }"/>
  					<input type="hidden" id="className${refundFeeDetail.studentCourseId }" name="className" value="${refundFeeDetail.className }"/>
  					<input type="hidden" id="classType${refundFeeDetail.studentCourseId }" name="classType" value="${refundFeeDetail.classType }"/>
  					<input type="hidden" id="courseState${refundFeeDetail.studentCourseId }" name="courseState" value="${refundFeeDetail.courseState }"/>
  					<input type="hidden" id="stageId${refundFeeDetail.studentCourseId }" name="stageId" value="${refundFeeDetail.stageId }"/>
  					<input type="hidden" id="refundHours${refundFeeDetail.studentCourseId }" name="refundHours" value="${refundFeeDetail.refundHours }"/>
  					<table width="100%" cellpadding="5px" class="maintables" style="margin-top: 10px;">
  						<tr>
  							<td width="12%" style="border-right: 0">
  								<span style="font-size: 16px; font-weight: bold;">课程${status.index + 1 }</span>
  							</td>
  							<td colspan="9" align="center">
  								<span style="color: red; font-weight: bold;">退费提示：本课程${refundFeeDetail.courseTypeText }${refundFeeDetail.courseStateText }（${refundFeeDetail.classProgress }）<c:if test="${not empty refundFeeDetail.giftName }">，${refundFeeDetail.giftName }</c:if></span>
  							</td>
  						</tr>
  						<tr>
  							<td align="right" width="12%"><span>课程阶段：</span></td>
  							<td width="10%"><span>${refundFeeDetail.stageId }</span></td>
  							<td align="right" width="8%"><span>班级类型：</span></td>
  							<td width="8%"><span>${refundFeeDetail.classType }</span></td>
  							<td align="right" width="8%"><span>退费类型：</span></td>
  							<c:choose>
  								<c:when test="${refundFeeDetail.courseState == '001' || refundFeeDetail.courseState == '002' }">
		  							<td width="7%">
		  								<select id="refundType${refundFeeDetail.studentCourseId }" name="refundType" class="easyui-combobox" style="width: 100px; height: 25px;" required="true" editable="false"
											data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
			      							onLoadSuccess:function(data){if(data.length > 0) $('#refundType${refundFeeDetail.studentCourseId }').combobox('setValue', '${refundFeeDetail.refundType }');}" 
			      							url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_DETAIL_T&codeType=REFUND_TYPE">
				        				</select>
		  							</td>
		  							<td align="right" width="8%"><span>渠道来源：</span></td>
		  							<c:choose>
		  								<c:when test="${refundFeeDetail.refundType == 'RTN_NEW' || refundFeeDetail.refundType == 'RTN_READING' }">
		  									<c:choose>
		  										<c:when test="${refundFeeDetail.refundType == 'RTN_NEW' && not empty obj.refundFeeObj.belongSchoolId }">
		  											<td width="11%">
		  												<select id="refundChannel${refundFeeDetail.studentCourseId }" name="refundChannel" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
															data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
					      									onLoadSuccess:function(data){if(data.length > 0) $('#refundChannel${refundFeeDetail.studentCourseId }').combobox('setValue', '${refundFeeDetail.refundChannel }');}" 
					      									url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_DETAIL_T&codeType=REFUND_CHANNEL">
					        							</select>
		  											</td>
		  											<td align="right" width="15%"><span>归属校区：</span></td>
		  											<td width="13%">
				  										<select id="belongSchoolId${refundFeeDetail.studentCourseId }" name="belongSchoolId" class="easyui-combobox" style="width: 100px; height: 25px;"
				  											data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', 
				  											onLoadSuccess:function(data){if(data.length > 0) $('#belongSchoolId${refundFeeDetail.studentCourseId }').combobox('setValue', '${obj.refundFeeObj.belongSchoolId }');}" 
				  											url="<%=path %>/pubData/qrySchoolList.do">
						        						</select>
		  											</td>
		  										</c:when>
		  										<c:otherwise>
		  											<td width="41%" colspan="3">
		  												<select id="refundChannel${refundFeeDetail.studentCourseId }" name="refundChannel" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
															data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
					      									onLoadSuccess:function(data){if(data.length > 0) $('#refundChannel${refundFeeDetail.studentCourseId }').combobox('setValue', '${refundFeeDetail.refundChannel }');}" 
					      									url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_DETAIL_T&codeType=REFUND_CHANNEL">
					        							</select>
		  											</td>
		  										</c:otherwise>
		  									</c:choose>
		  								</c:when>
		  								<c:otherwise>
		  									<td width="41%" colspan="3">
			  									<select id="refundChannel${refundFeeDetail.studentCourseId }" name="refundChannel" class="easyui-combobox" style="width: 100px; height: 25px;">
			  									</select>
		  									</td>
		  								</c:otherwise>
		  							</c:choose>
  								</c:when>
  								<c:otherwise>
  									<c:choose>
  										<c:when test="${refundFeeDetail.refundType == 'RTN_NEW' && not empty obj.refundFeeObj.belongSchoolId }">
  											<td width="7%">
  												<select id="refundType${refundFeeDetail.studentCourseId }" name="refundType" class="easyui-combobox" style="width: 100px; height: 25px;" required="true" editable="false"
													data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
					      							onLoadSuccess:function(data){if(data.length > 0) $('#refundType${refundFeeDetail.studentCourseId }').combobox('setValue', '${refundFeeDetail.refundType }');}" 
					      							url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_DETAIL_T&codeType=REFUND_TYPE">
						        				</select>
  											</td>
  											<td align="right" width="8%"><span>归属校区：</span></td>
  											<td width="39%" colspan="3">
  												<select id="belongSchoolId${refundFeeDetail.studentCourseId }" name="belongSchoolId" class="easyui-combobox" style="width: 100px; height: 25px;"
		  											data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', 
		  											onLoadSuccess:function(data){if(data.length > 0) $('#belongSchoolId${refundFeeDetail.studentCourseId }').combobox('setValue', '${obj.refundFeeObj.belongSchoolId }');}" 
		  											url="<%=path %>/pubData/qrySchoolList.do">
				        						</select>
  											</td>
  										</c:when>
  										<c:otherwise>
		  									<td width="56%" colspan="5">
		  										<select id="refundType${refundFeeDetail.studentCourseId }" name="refundType" class="easyui-combobox" style="width: 100px; height: 25px;" required="true" editable="false"
													data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
					      							onLoadSuccess:function(data){if(data.length > 0) $('#refundType${refundFeeDetail.studentCourseId }').combobox('setValue', '${refundFeeDetail.refundType }');}" 
					      							url="<%=path %>/pubData/qryCodeNameList.do?tableName=REFUND_FEE_DETAIL_T&codeType=REFUND_TYPE">
						        				</select>
		  									</td>
  										</c:otherwise>
  									</c:choose>
  								</c:otherwise>
  							</c:choose>
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
  							<td width="13%" align="center">
  								<c:if test="${not empty refundFeeDetail.imgUrl }">
	  								<a href="${refundFeeDetail.imgUrl }" class="linkmore" id="courseImgUrl"><span>查看缴费单据</span></a>
  								</c:if>
  							</td>
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
  							<td width="15%" align="center">&nbsp;</td>
  							<td width="13%" align="center"><a href='javascript:void(0)' class='linkmore' onclick="viewCourseDetail(${refundFeeDetail.studentCourseId })" id="studentCourseDetail${refundFeeDetail.studentCourseId }"><span>展开课程</span></a></td>
  						</tr>
  					</table>
  					
  					<div id="courseDetail${refundFeeDetail.studentCourseId }" style="display: none;min-width:1100px; width:98.4%;height:auto;padding:0 0;">
  						<div style="height: 10px"></div>
  						<div class="easyui-panel" style="min-width:1100px; width:100%;height:auto;" title="课程信息">
	  						<table width="100%" cellpadding="5px" class="maintables">
	  							<tr>
	  								<td width="10%" align="right"><span>课程阶段：</span></td>
	  								<td width="15%"><span>${refundFeeDetail.stageId }</span></td>
	  								<td width="10%" align="right"><span>班级类型：</span></td>
	  								<td width="15%"><span>${refundFeeDetail.classType }</span></td>
	  								<td width="15%" align="right"><span>缴费时间：</span></td>
	  								<td width="35%" colspan="3"><span>${refundFeeDetail.payDate }</span></td>
	  							</tr>
	  							<tr>
	  								<td width="10%" align="right"><span>业绩类型：</span></td>
	  								<td width="15%"><span>${refundFeeDetail.feeTypeText }</span></td>
	  								<td width="10%" align="right"><span>招生顾问A：</span></td>
	  								<td width="15%"><span>${refundFeeDetail.advisterIdAName }</span></td>
	  								<td width="15%" align="right"><span>招生顾问B：</span></td>
	  								<td width="35%" colspan="3"><span>${refundFeeDetail.advisterIdBName }</span></td>
	  							</tr>
	  							<tr>
	  								<td width="10%" align="right"><span>现金抵扣券：</span></td>
	  								<td width="90%" colspan="7"><span>${refundFeeDetail.minusRemark }</span></td>
	  							</tr>
	  							<tr>
	  								<td width="10%" align="right"><span>总金额：</span></td>
	  								<td width="15%"><span>${refundFeeDetail.totalAmount }元</span></td>
	  								<td width="10%" align="right"><span>抵扣金额：</span></td>
	  								<td width="15%">
	  									<span>
	  										<c:if test="${empty refundFeeDetail.minusAmount }">0元</c:if>
	  										<c:if test="${not empty refundFeeDetail.minusAmount }">${refundFeeDetail.minusAmount }元</c:if>
	  									</span>
	  								</td>
	  								<td width="15%" align="right"><span>连报优惠金额：</span></td>
	  								<td width="10%">
	  									<span>
	  										<c:if test="${empty refundFeeDetail.favorAmount }">0元</c:if>
	  										<c:if test="${not empty refundFeeDetail.favorAmount }">${refundFeeDetail.favorAmount }元</c:if>
	  									</span>
	  								</td>
	  								<td width="10%" align="right"><span>实收金额：</span></td>
	  								<td width="15%"><span>${refundFeeDetail.amount }元</span></td>
	  							</tr>
	  							<tr>
	  								<td width="10%" align="right"><span>课程状态：</span></td>
	  								<td width="15%"><span>${refundFeeDetail.courseStateText }</span></td>
	  								<td width="10%" align="right"><span>课时进度：</span></td>
	  								<td width="15%"><span>${refundFeeDetail.classProgress }</span></td>
	  								<td width="15%" align="right"><span>正常上课课时量：</span></td>
	  								<td width="35%" colspan="3"><span>${refundFeeDetail.normalClassHours }</span></td>
	  							</tr>
	  							<tr>
	  								<td width="10%" align="right"><span>当前班级：</span></td>
	  								<td width="15%"><span>${refundFeeDetail.className }</span></td>
	  								<td width="10%" align="right"><span>带班老师：</span></td>
	  								<td width="65%" colspan="5"><span>${refundFeeDetail.teacherName }</span></td>
	  							</tr>
	  						</table>
  						</div>
  						
  						<div id="goodsDiv${refundFeeDetail.studentCourseId }">
  							<div style="height: 10px"></div>
	  						<table class="easyui-datagrid" title="实物赠品与教材" style="height:auto;" id="goods_list_data${refundFeeDetail.studentCourseId }"
								pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
								<thead>
									<tr>
										<th data-options="field:'giftChannelDesc',width:200,align:'center'">赠品来源</th>
										<th data-options="field:'giftName',width:100,align:'center'">赠品名称</th>
										<th data-options="field:'createDate',width:100,align:'center'">赠送日期</th>
										<th data-options="field:'isGetText',width:80,align:'center'">是否领用</th>
										<th data-options="field:'isRtnText',width:80,align:'center'">是否退回</th>
										<th data-options="field:'getDate',width:150,align:'center'">领取时间</th>
										<th data-options="field:'rtnDate',width:150,align:'center'">退回时间</th>
										<th data-options="field:'granter',width:100,align:'center'">赠品发放人</th>
									</tr>
								</thead>
							</table>
  						</div>
			  			<div id="couponDiv${refundFeeDetail.studentCourseId }">
			  				<div style="height: 10px"></div>
							<table class="easyui-datagrid" title="券类赠品" style="height:auto;" id="coupon_list_data${refundFeeDetail.studentCourseId }"
								pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
								<thead>
									<tr>
										<th data-options="field:'giftChannelDesc',width:200,align:'center'">赠品来源</th>
										<th data-options="field:'typeName',width:80,align:'center'">赠券类型</th>
										<th data-options="field:'amount',width:80,align:'center'">面值</th>
										<th data-options="field:'usableAmount',width:80,align:'center'">剩余金额</th>
										<th data-options="field:'giftCode',width:150,align:'center'">赠券编号</th>
										<th data-options="field:'createDate',width:100,align:'center'">赠送日期</th>
										<th data-options="field:'effDate',width:120,align:'center'">有效期开始日期</th>
										<th data-options="field:'expDate',width:120,align:'center'">有效期结束日期</th>
										<th data-options="field:'isGetText',width:80,align:'center'">是否领用</th>
										<th data-options="field:'giftStateText',width:100,align:'center'">赠券状态</th>
										<th data-options="field:'getDate',width:150,align:'center'">领取时间</th>
										<th data-options="field:'granter',width:100,align:'center'">赠品发放人</th>
									</tr>
								</thead>
							</table>
			  			</div>
				  		<div id="courseDiv${refundFeeDetail.studentCourseId }">
				  			<div style="height: 10px"></div>
							<table class="easyui-datagrid" title="赠课信息" style="height:auto;" id="course_list_data${refundFeeDetail.studentCourseId }"
								pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
								<thead>
									<tr>
										<th data-options="field:'giftChannelDesc',width:100,align:'center'">赠课来源</th>
										<th data-options="field:'giftName',width:100,align:'center'">赠课名称</th>
										<th data-options="field:'createDate',width:100,align:'center'">赠送时间</th>
										<th data-options="field:'giftNum',width:100,align:'center'">赠送课时量</th>
										<th data-options="field:'giftStateText',width:100,align:'center'">课程状态</th>
										<th data-options="field:'effDate',width:100,align:'center'">有效期开始日期</th>
										<th data-options="field:'expDate',width:100,align:'center'">有效期结束日期</th>
										<th data-options="field:'granter',width:100,align:'center'">课时进度</th>
									</tr>
								</thead>
							</table>
				  		</div>
  					</div>
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
		  							<td width="35%">
  										<c:if test="${refundVisit.userType == 'teacher' }">
			  								<input type="radio" name="visitPersonOne" value="teacher" checked="checked"/><span>老师</span>
			  								<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
			  									data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', 
	      										onLoadSuccess:function(data){if(data.length > 0) $('#teacherId').combobox('setValue', ${refundVisit.visitUserId });}" 
	      										url="<%=path %>/pubData/qryStaffList.do?post=4,5,6,7,8&schoolId=${obj.refundFeeObj.schoolId }">
					        				</select>
			  								<input type="radio" name="visitPersonOne" value="adviser"/><span>课程顾问</span>
			  								<select id="careAdviserId" name="careAdviserId" class="easyui-combobox" style="width: 100px; height: 25px;" disabled="disabled" editable="false">
					        				</select>
  										</c:if>
  										<c:if test="${refundVisit.userType == 'adviser' }">
  											<input type="radio" name="visitPersonOne" value="teacher"/><span>老师</span>
			  								<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 100px; height: 25px;" disabled="disabled" editable="false">
					        				</select>
			  								<input type="radio" name="visitPersonOne" value="adviser" checked="checked"/><span>课程顾问</span>
			  								<select id="careAdviserId" name="careAdviserId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
			  									data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', 
	      										onLoadSuccess:function(data){if(data.length > 0) $('#careAdviserId').combobox('setValue', ${refundVisit.visitUserId });}" 
	      										url="<%=path %>/pubData/qryStaffList.do?post=16,17&schoolId=${obj.refundFeeObj.schoolId }">
					        				</select>
  										</c:if>
		  							</td>
		  							<td align="right" width="10%"><span>回访时间：</span></td>
		  							<td width="45%">
		  								<input name="teacherOrAdviserVisitDate" id="teacherOrAdviserVisitDate" type="text" class="easyui-datebox" required="true" style="width: 100px; height: 25px;" value="${refundVisit.visitDate }"/>
		  							</td>
		  						</tr>
		  						<tr>
		  							<td align="right" width="10%"><span>回访记录：</span></td>
		  							<td colspan="3" width="90%">
		  								<textarea rows="4" cols="122" id="teacherOrAdviserVisitRemark" name="teacherOrAdviserVisitRemark" class="textarea easyui-validatebox" required="true" validType="length[0,120]">${refundVisit.remark }</textarea>
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
		  							<td width="35%">
		  								<c:if test="${refundVisit.userType == 'academic' }">
			  								<input type="radio" name="visitPersonTwo" value="academic" checked="checked"/><span>学术主管</span>
			  								<select id="academicId" name="academicId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
				  								data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', 
		      									onLoadSuccess:function(data){if(data.length > 0) $('#academicId').combobox('setValue', ${refundVisit.visitUserId });}" 
		      									url="<%=path %>/pubData/qryStaffList.do?post=7,8&schoolId=${obj.refundFeeObj.schoolId }">
					        				</select>
			  								<input type="radio" name="visitPersonTwo" value="sales"/><span>销售主管</span>
			  								<select id="salesId" name="salesId" class="easyui-combobox" style="width: 100px; height: 25px;" disabled="disabled" editable="false">
		        							</select>
		  								</c:if>
		  								<c:if test="${refundVisit.userType == 'sales' }">
		  									<input type="radio" name="visitPersonTwo" value="academic"/><span>学术主管</span>
		  									<select id="academicId" name="academicId" class="easyui-combobox" style="width: 100px; height: 25px;" disabled="disabled" editable="false">
		        							</select>
			  								<input type="radio" name="visitPersonTwo" value="sales" checked="checked"/><span>销售主管</span>
			  								<select id="salesId" name="salesId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
				  								data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', 
		      									onLoadSuccess:function(data){if(data.length > 0) $('#salesId').combobox('setValue', ${refundVisit.visitUserId });}" 
		      									url="<%=path %>/pubData/qryStaffList.do?post=17&schoolId=${obj.refundFeeObj.schoolId }">
					        				</select>
		  								</c:if>
		  							</td>
		  							<td align="right" width="10%"><span>回访时间：</span></td>
		  							<td width="45%">
		  								<input name="academicOrSalesVisitDate" id="academicOrSalesVisitDate" type="text" class="easyui-datebox" required="true" style="width: 100px; height: 28px;" value="${refundVisit.visitDate }"/>
		  							</td>
		  						</tr>
		  						<tr>
		  							<td align="right" width="10%"><span>回访记录：</span></td>
		  							<td colspan="3" width="90%">
		  								<textarea rows="4" cols="122" id="academicOrSalesVisitRemark" name="academicOrSalesVisitRemark" class="textarea easyui-validatebox" required="true" validType="length[0,120]">${refundVisit.remark }</textarea>
		  							</td>
		  						</tr>
	  						</c:if>
	  					</c:forEach>
  					</table>
  					<!--  
  					<table width="100%" cellpadding="5px" style="border-collapse: collapse; border-spacing:0; border: 1px solid #ccc; height:auto;">
  						<c:forEach items="${obj.refundVisitList }" var="refundVisit">
	  						<c:if test="${refundVisit.visitType == '003' }">
		  						<tr>
		  							<td colspan="4"><span>3、校区校长回访信息：</span></td>
		  						</tr>
		  						<tr>
		  							<td align="right" width="10%"><span>回访人员：</span></td>
		  							<td width="8%">
		  								<select id="headmasterId" name="headmasterId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
											data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', panelHeight: 'auto',
		      						 		onLoadSuccess:function(data){$('#headmasterId').combobox('setValue', ${refundVisit.visitUserId });}"
		      								url="<%=path %>/pubData/qryStaffList.do?post=22,23&schoolId=${obj.refundFeeObj.schoolId }">
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
		  								<textarea rows="4" cols="122" id="headmasterVisitRemark" name="headmasterVisitRemark" class="textarea easyui-validatebox" validType="length[0,120]">${refundVisit.remark }</textarea>
		  							</td>
		  						</tr>
	  						</c:if>
	  					</c:forEach>
  					</table>
  					-->
  				</div>
  			</form>
  		</div>
  		<div style="margin-top: 25px;min-width:1100px; width:99%;text-align: right">
	      	<a href="javascript:void(0)" id="refundApplySubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      	&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
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
