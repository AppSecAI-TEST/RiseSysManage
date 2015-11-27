<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
		  					<input id="account" name="bankCard" type="text" class="easyui-textbox" style="width: 180px; height: 25px;"/>
		  				</td>
		  				<td align="right" width="10%"><span>退费总金额：</span></td>
		  				<td width="15%">
		  					<span id="totalAmountText"></span>
		  					<input type="hidden" id="totalAmount" name="totalAmount"/>
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
		  					<input id="handlingChange" name="handlingChange" type="text" class="easyui-textbox numberbox" data-options="min:0, max:10000, precision:2" style="width: 180px; height: 25px;" required="true"/>
		  				</td>
		  				<td align="right" width="10%"><span>财务确认金额：</span></td>
	  					<td width="15%">
	  						<input id="realAmount" name="realAmount" type="text" class="easyui-textbox numberbox" data-options="min:0, max:10000, precision:2" style="width: 120px; height: 25px;" required="true"/>
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
  		</div>
  		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: left;margin-left: 800px;">
	      		<a href="javascript:void(0)" id="refundApplySubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      		&nbsp;<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
  	</body>
</html>
