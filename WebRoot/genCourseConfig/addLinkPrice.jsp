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
		<script type="text/javascript" src="<%=path %>/js/genCourseConfig/linkPriceConfig.js"></script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="添加新优惠">
  			<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<input type="hidden" id="schoolIds" value="" />
	 		<table width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="right" width="11%"><span>连报优惠体系名称：</span></td>
  					<td align="left" width="69%"><input id="priceName" name="priceName" style="width:300px" class="easyui-textbox" required="true" /></td>
  				</tr>
  				<tr>
  					<td align="right"><a href="javascript:void(0)" id="" class="easyui-linkbutton" iconCls="icon-search" style="width: 110px; height: 25px;" onclick="addSchools()">添加适用校区</a></td>
  					<td align="left" id="schoolTd"></td>
  				</tr>
  				<tr>
  					<td align="right"><span>开始时间：</span></td>
  					<td align="left"><input class="easyui-datebox" id="effDate" name="effDate" style="width:300px;" required="true"/></td>
  				</tr>
  				<tr>
  					<td align="right"><span>结束时间：</span></td>
  					<td align="left"><input class="easyui-datebox" id="expDate" name="expDate" style="width:300px;" required="true"/></td>
  				</tr>
	 		</table>
	 		<table id="linkTab" width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="center" width="30%"><span>连报名称</span></td>
  					<td align="center" width="20%"><span>年数</span></td>
  					<td align="center" width="30%"><span>现金优惠额度</span></td>
  					<td align="center" width="20%"><span>操作</span></td>
  				</tr>
  				<tr id="linkModelTR">
	      	        <td align="center"><input id="linkName" name="linkName" style="width:300px" class="easyui-textbox" required="true" /></td>
	      	        <td align="center"><input id="linkNum" name="linkNum" style="width:200px"  class="easyui-numberbox" required="true" /></td>
	      	        <td align="center"><input id="favorPrice" name="favorPrice" style="width:200px"  class="easyui-numberbox" required="true" /></td>
	      	        <td align="center"><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px;" onclick="addRow()">添加</a></td>
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
	      	<div style="text-align:center">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="addLinkPriceSubmit()"><span>提交</span></a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
 		<iframe id="dlg" class="easyui-dialog" style="width:450px; height: 500px; padding: 10px 20px" closed="true" modal="true"></iframe>
  	</body>
</html>
