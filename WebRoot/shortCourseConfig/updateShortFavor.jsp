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
		<script type="text/javascript" src="<%=path %>/js/shortCourseConfig/favorConfig.js"></script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="修改短期课优惠配置">
  			<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<input type="hidden" id="schoolIds" value="${obj.schoolIds}" />
  			<input type="hidden" id="setPriceId" value="${obj.setPriceId}" />
  			<input type="hidden" id="shortClassId" value="${obj.shortClassId}" />
	 		<table width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="right" width="11%">优惠体系名称：</td>
  					<td align="left" width="69%"><input id="priceName" name="priceName" style="width:300px" class="easyui-textbox" required="true" /></td>
  				</tr>
  				<tr>
  					<td align="right">状态：</td>
  					<td align="left">${obj.isUseVal}</td>
  				</tr>
  				<tr>
  					<td align="right"><a href="javascript:void(0)" id="" class="easyui-linkbutton" iconCls="icon-search" style="width: 110px; height: 25px;" onclick="addSchools()">添加适用校区</a></td>
  					<td align="left" id="schoolTd"><span style="font-size:14px;font-family:'微软雅黑'">&nbsp;${obj.applySchools}<a style='font-size:12px' class='linkmore' onclick="removeSchool(this)">删除</a></span></td>
  				</tr>
  				<tr>
  					<td align="right">生效时间：</td>
  					<td align="left"><input class="easyui-datebox" id="effDate" name="effDate" style="width:300px;" required="true"/></td>
  				</tr>
  				<tr>
  					<td align="right">创建人：</td>
  					<td align="left">${obj.handerName}</td>
  				</tr>
  				<tr>
  					<td align="right">创建时间：</td>
  					<td align="left">${obj.createDate}</td>
  				</tr>
	 		</table>
	 		<table id="favorTab" width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="center" width="35%">优惠名称</td>
  					<td align="center" width="35%">现金优惠额度</td>
  					<td align="center" width="20%">操作</td>
  				</tr>
  				<tr id="favorModelTR">
	      	        <td align="center"><input id="favorName" name="favorName" style="width:300px" class="easyui-textbox" required="true" /></td>
	      	        <td align="center"><input id="favorPrice" name="favorPrice" style="width:200px"  class="easyui-numberbox" required="true" /></td>
	      	        <td align="center"><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px;" onclick="addRow()">添加</a></td>
      	     	</tr>
      	     	<tr style="display:none;" name="addShortFavor" id="addShortFavor" >
	      	        <td align="center"></td>
	      	        <td align="center"></td>
	      	        <td align="center"><a href='javascript:void(0)' class='linkmore' onclick='delRow(this)' ><span>删除</span></a></td>
     	       </tr>
  				<c:forEach items="${retObj.result}" var="result">
  					<tr val="favor" favorId="${result.favorId}">
  						<td align="center">${result.favorName}</td>
  						<td align="center">${result.favorPrice}</td>
  						<td align="center"><a href='javascript:void(0)' class='linkmore' onclick='delRow(this)' ><span>删除</span></a></td>
  					</tr>
  				</c:forEach>
	 		</table>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: right;">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:80px; height:28px;" onclick="updateFavorPriceSubmit()">提交</a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:80px; height:28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
	   <iframe id="dlg" class="easyui-dialog" style="width:450px; height: 500px; padding: 10px 20px" closed="true" modal="true"></iframe>
	   <script type="text/javascript">
	   		$(document).ready(function(){
	   			//初始化页面值
	   			$("#priceName").textbox('setValue',"${obj.priceName}");
	   			$("#effDate").datebox('setValue',"${obj.effDate}");
	   		});
	   </script>
  	</body>
</html>
