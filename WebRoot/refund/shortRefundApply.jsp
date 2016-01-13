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
		<script type="text/javascript" src="<%=path %>/js/refund/shortRefundApply.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="短期课退费申请">
  			<form id="refundApplyFm" method="post" enctype="multipart/form-data">
  				<input type="hidden" id="studentId" name="studentId" value="${obj.refundObj.studentId }"/>
  				<input type="hidden" id="schoolId" name="schoolId" value="${obj.refundObj.schoolId }"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId }"/>
  				<input type="hidden" id="courseType" name="courseType" value="${obj.courseType }"/>
  				<input type="hidden" id="favorType" value="${obj.refundStudentCourseList[0].favorType }"/>
  				<input type="hidden" id="stageId" name="stageId" value="${obj.refundStudentCourseList[0].stageId }"/>
  				<input type="hidden" id="classType" name="classType" value="${obj.refundStudentCourseList[0].classType }"/>
  				<input type="hidden" id="className" name="className" value="${obj.refundStudentCourseList[0].className }"/>
  				<input type="hidden" id="courseState" name="courseState" value="${obj.refundStudentCourseList[0].courseState }"/>
  				<input type="hidden" id="refundHours" name="refundHours" value="${obj.refundStudentCourseList[0].refundHours }"/>
  				<input type="hidden" id="classInstId" name="classInstId" value="${obj.refundStudentCourseList[0].classInstId }"/>
  				<input type="hidden" id="refundStageFee" name="refundStageFee" value="${obj.refundStudentCourseList[0].amount }"/>
  				<input type="hidden" id="studentCourseId" name="studentCourseId" value="${obj.refundStudentCourseList[0].studentCourseId }"/>
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
	  								<c:when test="${not empty obj.refundStudentCourseList[0].advisterIdAName &&  empty obj.refundStudentCourseList[0].advisterIdBName}">
	  									${obj.refundStudentCourseList[0].advisterIdAName }
	  								</c:when>
	  								<c:when test="${empty obj.refundStudentCourseList[0].advisterIdAName &&  not empty obj.refundStudentCourseList[0].advisterIdBName}">
	  									${obj.refundStudentCourseList[0].advisterIdBName }
	  								</c:when>
	  								<c:when test="${not empty obj.refundStudentCourseList[0].advisterIdAName &&  not empty obj.refundStudentCourseList[0].advisterIdBName}">
	  									${obj.refundStudentCourseList[0].advisterIdAName }/${obj.refundStudentCourseList[0].advisterIdBName }
	  								</c:when>
	  							</c:choose>
	  						</span>
	  					</td>
	  					<td align="right" width="10%"><span>业绩老师：</span></td>
	  					<td width="15%"><span>${obj.refundStudentCourseList[0].adviserTeacherName }</span></td>
	  				</tr>
	  				<tr id="refundWayTr">
	  					<td align="right" width="8%"><span>退费形式：</span></td>
	  					<td width="8%">
	  						<select id="refundWay" name="refundWay" class="easyui-combobox" style="width: 100px; height: 25px;" required="true">
		        			</select>
	  					</td>
	  					<td align="right" width="8%"><span>退费银行：</span></td>
		  				<td width="10%">
		  					<input id="bankName" name="bankName" type="text" class="easyui-textbox" style="width: 120px; height: 25px;"/>
		  				</td>
		  				<td align="right" width="8%"><span>账户名：</span></td>
		  				<td width="10%">
		  					<input id="account" name="account" type="text" class="easyui-textbox" style="width: 120px; height: 25px;"/>
		  				</td>
		  				<td align="right" width="8%"><span>账号：</span></td>
		  				<td width="15%">
		  					<input id="bankCard" name="bankCard" type="text" class="easyui-textbox numberbox" validType="length[0,19]" style="width: 180px; height: 25px;"/>
		  				</td>
		  				<td align="right" width="10%"><span>退费总金额：</span></td>
		  				<td width="15%">
		  					<span id="totalAmountText">${obj.refundStudentCourseList[0].amount }</span>
		  					<input type="hidden" id="totalAmount" name="totalAmount" value="${obj.refundStudentCourseList[0].amount }"/>
		  				</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="8%"><span>教材扣除：</span></td>
	  					<td width="8%">
	  						<input id="minusTextbookFee" name="minusTextbookFee" type="text" class="easyui-textbox numberbox" data-options="min:0, max:10000, precision:2" style="width: 100px; height: 25px;" required="true"/>
	  					</td>
	  					<td align="right" width="8%"><span>课程扣除：</span></td>
	  					<td width="10%">
	  						<input id="minusCourseFee" name="minusCourseFee" type="text" class="easyui-textbox numberbox" data-options="min:0, max:10000, precision:2" style="width: 120px; height: 25px;" required="true"/>
	  					</td>
	  					<td align="right" width="8%"><span>手续费：</span></td>
		  				<td width="10%">
		  					<input id="handlingChange" name="handlingChange" type="text" class="easyui-textbox numberbox" data-options="min:0, max:10000, precision:2" style="width: 120px; height: 25px;" required="true"/>
		  				</td>
		  				<td align="right" width="8%"><span>其他扣除：</span></td>
		  				<td width="15%">
		  					<input id="minusOtherFee" name="minusOtherFee" type="text" class="easyui-textbox numberbox" data-options="min:0, max:10000, precision:2" style="width: 180px; height: 25px;" required="true"/>
		  				</td>
		  				<td align="right" width="10%"><span>财务确认金额：</span></td>
	  					<td width="15%">
	  						<input id="confirmRefundFee" name="confirmRefundFee" type="text" class="easyui-textbox numberbox" data-options="min:0, max:10000, precision:2" style="width: 120px; height: 25px;" required="true" value="${obj.refundStudentCourseList[0].amount }"/>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="8%"><span>退费原因：</span></td>
	  					<td colspan="9" width="92%">
	  						<input type="radio" name="refundReason" value="school"/><span>校方原因</span>
	  						<select id="schoolReasonType" name="schoolReasonType" class="easyui-combobox" style="width: 100px; height: 25px;">
		        			</select>
		        			<select id="schoolReason" name="schoolReason" class="easyui-combobox" style="width: 150px; height: 25px;">
		        			</select>
	  						&nbsp;&nbsp;<input type="radio" name="refundReason" value="customer"/><span>客户原因</span>
	  						<select id="customerReason" name="customerReason" class="easyui-combobox" style="width: 120px; height: 25px;">
		        			</select>
	  						&nbsp;&nbsp;<input type="radio" name="refundReason" value="other"/><span>其他原因</span>
	  						<input id="otherReason" name="otherReason" type="text" class="easyui-textbox" style="width: 420px; height: 25px;" />
	  					</td>
	  				</tr>
	  				<tr>
	  					<td colspan="10">
	  						<span>上传退费申请单：</span>
	  						<input type="hidden" name="imgUrl" id="imgUrl"/>
	                        <input style="width: 500px; height: 28px;" class="easyui-filebox" name="fileName" id="fileName" data-options="prompt:''"/>
	                        <a href="javascript:void(0)" class="easyui-linkbutton" id="uploadBtn" iconCls="icon-save" iconCls="icon-save" style="width: 80px; height: 28px;">上传</a>
	                        <a href="javascript:void(0)" class="easyui-linkbutton" id="cancelUploadBtn" iconCls="icon-cancel" iconCls="icon-cancel" style="width: 80px; height: 28px;">取消</a>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="8%"><span>退费备注：</span></td>
  						<td colspan="9" width="92%">
  							<textarea rows="6" cols="122" id="remark" name="remark" class="easyui-validatebox textbox"></textarea>
  						</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="16%" colspan="2"><span>抵扣券使用情况：</span></td>
	  					<td width="84%" colspan="8"><span>${obj.refundStudentCourseList[0].minusRemark }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="16%" colspan="2"><span>其他优惠使用情况：</span></td>
	  					<td width="84%" colspan="8" id="favorTypeTd"></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="16%" colspan="2"><span>总金额：</span></td>
	  					<td colspan="2" width="18%"><span>${obj.refundStudentCourseList[0].totalAmount }元</span></td>
	  					<td align="right" width="18%" colspan="2"><span>赠券抵扣金额：</span></td>
	  					<td width="8%">
	  						<span>
	  							<c:if test="${not empty obj.refundStudentCourseList[0].minusAmount }">
	  								<span>${obj.refundStudentCourseList[0].minusAmount }元</span>
	  							</c:if>
	  						</span>
	  					</td>
	  					<td align="right" width="15%"><span>实缴金额：</span></td>
	  					<td width="25%" colspan="2"><span>${obj.refundStudentCourseList[0].amount }元</span></td>
	  				</tr>
  				</table>
  				<div style="height: 20px; vertical-align: middle; line-height:20px; margin-top: 10px;">
  					&nbsp;&nbsp;<a href='javascript:void(0)' class='linkmore' onclick="viewGiftHist()" id="gift"><span>展开非缴费赠送历史记录</span></a>
  					&nbsp;&nbsp;<a href='javascript:void(0)' class='linkmore' onclick="viewStudentCourseList()"><span>查看所有的课程信息</span></a>
  				</div>
  			</form>
  		</div>
  		<div id="giftDiv">
  			<table class="easyui-datagrid" id="gift_list_data" style="min-width:1100px; height: auto;width: 99%;"
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
  		<div style="margin-top: 25px;min-width:1100px; width:99%;">
	      	<div style="float: left;margin-left: 800px;">
	      		<a href="javascript:void(0)" id="refundApplySubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
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
