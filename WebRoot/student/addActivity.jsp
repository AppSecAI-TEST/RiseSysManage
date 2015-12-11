<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String name = request.getParameter("name");
	String studentId = request.getParameter("studentId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/student/activity.js"></script>
  	</head>
  
  	<body>
      	<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="活动信息">
      		<form id="activityFm">
      			<input type="hidden" id="name" name="name" value="<%=name %>"/>
      			<input type="hidden" id="studentId" name="studentId" value="<%=studentId %>"/>
      			<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
      			<table width="100%" cellpadding="5px" class="maintable" id="addActivityTd">
      				<tr>
      					<td align="right" width="8%"><span style="color: red;">*</span><span>活动标题：</span></td>
	      				<td width="92%" colspan="9">
	      					<input name="title" id="title" type="text" class="easyui-textbox validatebox" required="true" style="width: 400px; height: 28px;"/>
	      				</td>
      				</tr>
      				<tr>
      					<td align="right" width="8%"><span style="color: red;">*</span><span>活动时间：</span></td>
	      				<td width="92%" colspan="9">
	      					<input name="activityDate" id="activityDate" type="text" class="easyui-datebox" required="true" style="width: 200px; height: 28px;"/>
	      				</td>
      				</tr>
      				<tr>
      					<td align="right" width="8%"><span>获奖情况：</span></td>
	      				<td width="92%" colspan="9">
	      					<input name="award" id="award" type="text" class="easyui-textbox validatebox" required="true" style="width: 400px; height: 28px;"/>
	      				</td>
      				</tr>
      				<tr id="giftModelTR">
      					<td align="right" width="90px"><span>赠品类别：</span></td>
      					<td align="center" width="100px">
      						<select id="giftType" class="easyui-combobox" style="width: 100px; height: 28px;">
        					</select>
      					</td>
      					<td align="right" width="80px"><span>赠品名称：</span></td>
      					<td width="410px" align="left" id="otherTd" colspan="2">
      						<select id="giftName" class="easyui-combobox" style="width: 100px; height: 28px;"></select>
      					</td>
      					<td width="410px" align="left" id="couponTd" style="display: none;">
      						<select id="couponType" class="easyui-combobox" style="width: 100px; height: 28px;"></select>
      						<select id="amount" class="easyui-combobox" style="width: 100px; height: 28px;"></select>
      					</td>
      					<td width="210px" align="left" id="getCouponTd" style="display: none;">
	      					<input id="giftCode" type="text" class="easyui-numberbox" style="width: 100px; height: 28px;"/>
		        			<input id="effDate" type="text" class="easyui-datebox" style="width: 100px; height: 28px;"/>
      					</td>
      					<td align="right" width="80px"><span>是否领取：</span></td>
      					<td width="100px" align="left">
      	       		 		<input type="radio" value="Y" name="isGet"/><span>已领</span>
      						&nbsp;<input type="radio" value="N" name="isGet"/><span>未领</span>
     	           		</td>
     	           		<td align="right" width="60px"><span>发放人：</span></td>
      	        		<td width="90px">
      	        			<input id="granter" type="text" class="easyui-textbox validatebox" style="width: 100px; height: 28px;" disabled="disabled"/>
      	        		</td>
      	        		<td width="90px" align="center">
      	        			<a href="javascript:void(0)" id="addGoodsGiftBtn" class="easyui-linkbutton" id="addGiftBtn" iconCls="icon-add" style="width: 80px;" onclick="addRow()">添加</a>
      	        		</td>
      				</tr>
      				<tr style="display:none;" id="addGift" >
      	        		<td align="right"><span>赠品类别：</span></td>
      	        		<td align="left" giftType="">&nbsp;</td>
      	        		<td align="right"><span>赠品名称：</span></td>
      	        		<td align="left" giftName="" giftId="" colspan="2">&nbsp;</td>
      	        		<td align="right"><span>是否领用：</span></td>
      	        		<td align="left" isGet="">&nbsp;</td>
      	        		<td align="right"><span>发放人：</span></td>
      	        		<td align="left" granter="">&nbsp;</td>
      	        		<td align="center"><a href='javascript:void(0)' class='linkmore' onclick="delRow(this)"><span>删除</span></a></td>
     	       		</tr>
      				<tr>
      					<td align="right" width="8%"><span>活动详细：</span></td>
	      				<td width="92%" colspan="9">
	      					<textarea rows="4" cols="122" id="remark" name="remark" class="easyui-validatebox textbox"></textarea>
	      				</td>
      				</tr>
      			</table>
      		</form>
      	</div>
      		
      	<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: left;margin-left: 800px;">
	      		<a href="javascript:void(0)" id="activitySubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      		&nbsp;<a href="javascript:void(0)" id="activityBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	    </div>
  	</body>
</html>
