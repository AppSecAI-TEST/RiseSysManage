<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="短期课退费浏览">
  			<form id="refundApplyFm">
  				<input type="hidden" id="minusGiftFee" name="minusGiftFee" value="0"/>
  				<input type="hidden" id="refundStageFee" name="refundStageFee" value=""/>
  				<table width="100%" cellpadding="5px" class="maintable">
  					<tr>
	  					<td align="right" width="8%"><span>学员姓名：</span></td>
	  					<td width="8%"><span>${obj.refundObj.name }</span></td>
	  					<td align="right" width="8%"><span>在读班级：</span></td>
	  					<td width="10%"><span>${obj.refundObj.className }</span></td>
	  					<td align="right" width="8%"><span>课时进度：</span></td>
	  					<td width="10%"><span>${obj.refundObj.classProgress }</span></td>
	  					<td align="right" width="8%"><span>业绩顾问：</span></td>
	  					<td width="15%"><span>${obj.refundObj.teacherName }</span></td>
	  					<td align="right" width="10%"><span>业绩老师：</span></td>
	  					<td width="15%"><span>${obj.refundObj.teacherName }</span></td>
	  				</tr>
	  				<tr id="refundWayTr">
	  					<td align="right" width="8%"><span>退费形式：</span></td>
	  					<td width="8%"><span id="refundWay"></span></td>
	  					<td align="right" width="8%"><span>退费银行：</span></td>
		  				<td width="10%"><span id="bankName"></span></td>
		  				<td align="right" width="8%"><span>账户名：</span></td>
		  				<td width="10%"><span id="account"></span></td>
		  				<td align="right" width="8%"><span>账号：</span></td>
		  				<td width="15%"><span id="bankCard"></span></td>
		  				<td align="right" width="10%"><span>退费总金额：</span></td>
		  				<td width="15%"><span id="totalAmountText"></span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="8%"><span>教材扣除：</span></td>
	  					<td width="8%"><span id="minusTextbookFee"></span></td>
	  					<td align="right" width="8%"><span>课程扣除：</span></td>
	  					<td width="10%"><span id="minusCourseFee"></span></td>
	  					<td align="right" width="8%"><span>手续费：</span></td>
		  				<td width="10%"><span id="handlingChange"></span></td>
		  				<td align="right" width="8%"><span>其他扣除：</span></td>
		  				<td width="15%"><span id="minusOtherFee"></span></td>
		  				<td align="right" width="10%"><span>财务确认金额：</span></td>
	  					<td width="15%"><span id="realAmount"></span></td>
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
	  						<input style="width: 500px; height: 28px;" class="easyui-filebox" name="imgUrl" id="imgUrl" data-options="prompt:''" >
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="8%"><span>退费备注：</span></td>
  						<td colspan="9" width="92%">
  							<textarea rows="6" cols="122" id="remark" name="remark" required="true" class="easyui-validatebox textbox"></textarea>
  						</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="16%" colspan="2"><span>抵扣券使用情况：</span></td>
	  					<td width="84%" colspan="8"></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="16%" colspan="2"><span>其他优惠使用情况：</span></td>
	  					<td width="84%" colspan="8">
	  						&nbsp;<input type="checkbox"/><span>同班同学减现</span>
	  						&nbsp;&nbsp;<input type="checkbox"/><span>短期班和游学同时报名减现</span>
	  						&nbsp;&nbsp;<input type="checkbox"/><span>有签证未过期</span>
	  						&nbsp;&nbsp;<input type="checkbox"/><span>有签证已过期</span>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="16%" colspan="2"><span>总金额：</span></td>
	  					<td colspan="2" width="18%"></td>
	  					<td align="right" width="18%" colspan="2"><span>赠券抵扣金额：</span></td>
	  					<td width="8%"></td>
	  					<td align="right" width="15%"><span>实缴金额：</span></td>
	  					<td width="25%" colspan="2"></td>
	  				</tr>
  				</table>
  				<div style="height: 20px; vertical-align: middle; line-height:20px; margin-top: 10px;">
  					&nbsp;&nbsp;<a href='javascript:void(0)' class='linkmore' onclick='' id=""><span>展开非缴费赠送历史记录</span></a>
  					&nbsp;&nbsp;<a href='javascript:void(0)' class='linkmore' onclick='' id=""><span>查看所有的课程信息</span></a>
  				</div>
  			</form>
	  		<div style="min-width:1100px; width:100%;">
				<table class="easyui-datagrid" title="审批记录" style="height:auto;width: 100%" id="approve_list_data" 
					pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
							<th data-options="field:'approveName',width:100,align:'center'">审批人</th>
							<th data-options="field:'post',width:120,align:'center'">职务</th>
							<th data-options="field:'approveDate',width:100,align:'center'">审批时间</th>
							<th data-options="field:'approveTypeText',width:120,align:'center'">审批结果</th>
							<th data-options="field:'approveRemark',width:400,align:'center'">审批备注</th>
						</tr>
					</thead>
				</table>
			</div>
			<div style="height: 15px"></div>
  		</div>
  	</body>
</html>
