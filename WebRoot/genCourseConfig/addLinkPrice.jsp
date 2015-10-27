<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/pub/js/json.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json2.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/css/style.css">
		<script type="text/javascript" src="<%=path %>/js/genCourseConfig/linkPriceConfig.js"></script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="添加新优惠">
  			<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<input type="hidden" id="schoolIds" value="" />
	 		<table width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="right" width="11%">联报优惠体系名称：</td>
  					<td align="left" width="69%"><input id="priceName" name="priceName" style="width:300px" class="easyui-textbox" required="true" /></td>
  				</tr>
  				<tr>
  					<td align="right">状态：</td>
  					<td align="left"><input type="radio" value="Y" name="isOpen" checked="checked"/><span>开启</span>&nbsp;<input type="radio" value="N" name="isOpen"/><span>关闭</span></td>
  				</tr>
  				<tr>
  					<td align="right"><a href="javascript:void(0)" id="" class="easyui-linkbutton" iconCls="icon-search" style="width: 110px; height: 25px;" onclick="addSchools()">添加适用校区</a></td>
  					<td align="left" id="schoolTd"></td>
  				</tr>
	 		</table>
	 		<table id="linkTab" width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="center" width="30%">联报名称</td>
  					<td align="center" width="20%">年数</td>
  					<td align="center" width="30%">现金优惠额度</td>
  					<td align="center" width="20%">操作</td>
  				</tr>
  				<tr id="linkModelTR">
	      	        <td align="center"><input id="linkName" name="linkName" style="width:300px" class="easyui-textbox" required="true" /></td>
	      	        <td align="center"><input id="linkNum" name="linkNum" style="width:200px"  class="easyui-numberbox" required="true" /></td>
	      	        <td align="center"><input id="favorPrice" name="favorPrice" style="width:200px"  class="easyui-numberbox" required="true" /></td>
	      	        <td align="center"><a href="javascript:void(0)" id="addGoodsGiftBtn" class="easyui-linkbutton" id="addGiftBtn" iconCls="icon-add" style="width: 80px;" onclick="addRow()">添加</a></td>
      	     	</tr>
      	     	<tr style="display:none;" name="addLinkPrice" id="addLinkPrice" >
	      	        <td align="center"></td>
	      	        <td align="center"></td>
	      	        <td align="center"></td>
	      	        <td align="center"><a href='javascript:void(0)' class='linkmore' onclick='delRow(this)' ><span>删除</span></a></td>
     	       </tr>
	 		</table>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: right;">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;" onclick="addLinkPriceSubmit()">提交</a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
 		<iframe id="dlg" class="easyui-dialog" style="width:450px; height: 500px; padding: 10px 20px" closed="true" modal="true"></iframe>
  	</body>
</html>
