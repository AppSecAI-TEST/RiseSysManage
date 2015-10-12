<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String studentId = request.getParameter("studentId");
	String studentName = request.getParameter("studentName");
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/pub/js/json.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json2.js"></script>
		<script type="text/javascript" src="<%=path %>/js/giftManage/goodsGiftManage.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/css/style.css">
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="实物&教材赠品赠送">
  		<input type="hidden" id="studentId" name="studentId" value="<%=studentId %>"/>
  		<input type="hidden" id="studentName" name="studentName" value="<%=studentName %>"/>
  		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<table width="100%" cellpadding="5px" class="maintable">
  				<input type="hidden" id="activityId" />
  				<tr id="goodsTr">
  					<td width="25%">&nbsp;<input type="radio" value="ACTIVITY" name="goodsGiftChannel"/><span>活动赠送</span>
	      				&nbsp;<input type="radio" value="OTHER" name="goodsGiftChannel"/><span>其他赠送</span>
						<a href="javascript:void(0)" class="easyui-linkbutton" id="activity" data-options="iconCls:'icon-search'" style="width:90px; height: 20px;display:none;float:right;margin-right:5px" onclick="chooseActivity()">选择活动</a>
					</td>
					<td align="right" width="7%" style="display: none">活动标题：</td>
					<td align="left" id="titleText" width="18%" style="display: none"></td>
					<td align="right" width="7%" style="display: none">活动时间：</td>
					<td align="left" id="activityDate" width="15%" style="display: none"></td>
					<td align="right" width="7%" style="display: none">获奖情况：</td>
					<td align="left" id="awardText" width="25%" style="display: none"></td>
  				</tr>
  			</table>
  			<table width="100%" cellpadding="5px" style="margin-top: 5px;border-top: 1px solid #ccc;" class="maintable" id="giftTab">
	      	   <tr id="giftModelTR">
      	        <td width="8%" align="right"><span>赠品类别：</span></td>
      	        <td width="10%">
      	           <select id="giftType" style="width: 100px;"
   				     data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
   					 url="<%=path %>/pubData/qryCodeNameList.do?tableName=GIFT_TYPE_T&codeType=PARENT_TYPE&codeFlag=GOODS,TEXTBOOK" required="true" >
     	           </select>
     	        </td>
      	        <td width="8%" align="right"><span>赠品名称：</span></td>
      	        <td width="15%">
		      	   <select class="easyui-combobox" id="giftName" style="width: 120px;"></select>
     	            </td>
      	        <td width="8%" align="right"><span>是否领用：</span></td>
      	        <td width="15%" align="left">
      	       		 <input type="radio" value="Y" name="isGet"/><span>已领</span>
      				&nbsp;<input type="radio" value="N" name="isGet"/><span>未领</span>
     	           </td>
      	        <td width="7%" align="right"><span>发放人：</span></td>
      	        <td width="8%"><input id="granter" type="text" class="easyui-textbox validatebox" required="true" style="width: 100px;"/></td>
      	        <td width="7%" align="center"><a href="javascript:void(0)" id="addGoodsGiftBtn" class="easyui-linkbutton" id="addGiftBtn" iconCls="icon-add" style="width: 80px;" onclick="addRow()">添加</a></td>
      	      </tr>
      	      <tr style="display:none;" name="addGift" id="addGift" >
      	        <td align="right"><span>赠品类别：</span></td>
      	        <td align="left" giftType="">&nbsp;</td>
      	        <td align="right"><span>赠品名称：</span></td>
      	        <td align="left" giftName="" giftId="">&nbsp;</td>
      	        <td align="right"><span>是否领用：</span></td>
      	        <td align="left" isGet="">&nbsp;</td>
      	        <td align="right"><span>发放人：</span></td>
      	        <td align="left" granter="">&nbsp;</td>
      	        <td><a href='javascript:void(0)' class='linkmore' onclick='delRow(this)' ><span>删除</span></a></td>
     	       </tr>
     	       <tr>
     	       	<td align="right"><span>说明：</span></td>
     	       	<td colspan="8"><textarea rows="7" cols="100" id="giveRemark" name="giveRemark" class="easyui-validatebox textbox"></textarea></td>
     	       </tr>
      	    </table>
  		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: right;">
	      		<a href="javascript:void(0)" id="addGoodsGiftSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;" onclick="addGoodsGiftSubmit()">提交</a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
	   <iframe id="dlg" class="easyui-dialog" style="width:1000px; height: 450px; padding: 10px 20px" closed="true" modal="true">
	   </iframe>
  	</body>
</html>
