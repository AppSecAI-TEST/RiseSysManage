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
		<script type="text/javascript" src="<%=path %>/js/genCourseConfig/discountPriceConfig.js"></script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="修改复读折扣配置">
  			<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<input type="hidden" id="schoolIds" value="${obj.schoolIds}" />
  			<input type="hidden" id="setPriceId" value="${obj.setPriceId}"/>
	 		<table width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="right" width="11%"><span>复读折扣名称：</span></td>
  					<td align="left" width="69%"><input id="priceName" name="priceName" style="width:300px" class="easyui-textbox" required="true" /></td>
  				</tr>
  				<tr>
  					<td align="right"><span>状态：</span></td>
  					<td align="left">${obj.isUseVal}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>折扣率：</span></td>
  					<td align="left"><input id="countRate" name="countRate" style="width:300px" class="easyui-textbox" required="true" /></td>
  				</tr>
  				<tr>
  					<td align="right"><span>生效时间：</span></td>
  					<td align="left"><input class="easyui-datebox" id="effDate" name="effDate" style="width:300px;" required="true"/></td>
  				</tr>
  				<tr>
  					<td align="right"><a href="javascript:void(0)" id="" class="easyui-linkbutton" iconCls="icon-search" style="width: 110px; height: 25px;" onclick="addSchools()">添加适用校区</a></td>
  					<td align="left" id="schoolTd"><span style="font-size:14px;font-family:'微软雅黑'">&nbsp;${obj.applySchools}<a style='font-size:12px' class='linkmore' onclick="removeSchool(this)">删除</a></span></td>
  				</tr>
  				<tr>
  					<td align="right"><span>创建人：</span></td>
  					<td align="left">${obj.handerName}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>创建时间：</span></td>
  					<td align="left">${obj.createDate}</td>
  				</tr>
	 		</table>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:right">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="updateDisPriceSubmit()"><span>提交</span></a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
	   <iframe id="dlg" class="easyui-dialog" style="width:450px; height: 500px; padding: 10px 20px" closed="true" modal="true"></iframe>
	   <script type="text/javascript">
	   		$(document).ready(function(){
	   			//初始化页面值
	   			$("#priceName").textbox('setValue',"${obj.priceName}");
	   			$("#countRate").textbox('setValue',"${obj.countRate}");
	   			$("#effDate").datebox('setValue',"${obj.effDate}");
	   		});
	   </script>
  	</body>
</html>
