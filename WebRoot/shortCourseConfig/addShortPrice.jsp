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
		<script type="text/javascript" src="<%=path %>/js/shortCourseConfig/priceConfig.js"></script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="添加新价格">
  			<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<input id="shortClassId" type="hidden" value="${shortClassId}"/>
  			<input type="hidden" id="schoolIds" value="" />
	 		<table width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="right" width="11%"><span>价格体系名称：</span></td>
  					<td align="left" width="69%"><input id="priceName" name="priceName" style="width:300px" class="easyui-textbox" required="true" /></td>
  				</tr>
  				<tr>
  					<td align="right"><a href="javascript:void(0)" id="" class="easyui-linkbutton" iconCls="icon-search" style="width: 110px; height: 25px;" onclick="addSchools()">添加适用校区</a></td>
  					<td align="left" id="schoolTd"></td>
  				</tr>
  				<tr>
  					<td align="right"><span>生效时间：</span></td>
  					<td align="left"><input class="easyui-datebox" id="effDate" name="effDate" style="width:300px;" required="true"/></td>
  				</tr>
	 		</table>
	 		<table width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="center" width="13%"><span>班级类型</span></td>
  					<td align="center" width="13%"><span>学费</span></td>
  					<td align="center" width="13%"><span>材料费</span></td>
  					<td align="center" width="13%"><span>保育费和餐费</span></td>
  					<td align="center" width="13%"><span>总部提成</span></td>
  					<td align="center" width="13%"><span>其他费用</span></td>
  					<td align="center" width="13%"><span>总费用</span></td>
  				</tr>
  				<c:forEach items="${obj.classType}" var="classTypeObj" varStatus="status">
  					<tr>
  						<td align="center" id="classType${status.index}">${classTypeObj.classType}</td>
  						<td align="center"><input id="feeA${status.index}" name="feeA" style="width:100px" data-options="events:{blur: function(){sumFee(${status.index})}}" class="easyui-numberbox" /></td>
  						<td align="center"><input id="feeB${status.index}" name="feeB" style="width:100px" data-options="events:{blur: function(){sumFee(${status.index})}}" class="easyui-numberbox" /></td>
  						<td align="center"><input id="feeC${status.index}" name="feeC" style="width:100px" data-options="events:{blur: function(){sumFee(${status.index})}}" class="easyui-numberbox" /></td>
  						<td align="center"><input id="feeD${status.index}" name="feeD" style="width:100px" data-options="events:{blur: function(){sumFee(${status.index})}}" class="easyui-numberbox" /></td>
  						<td align="center"><input id="feeE${status.index}" name="feeE" style="width:100px" data-options="events:{blur: function(){sumFee(${status.index})}}" class="easyui-numberbox" /></td>
  						<td align="center" id="totalFee${status.index}"></td>
  					</tr>
  				</c:forEach>
	 		</table>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:right">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="addShortPriceSubmit()"><span>提交</span></a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
 		<iframe id="dlg" class="easyui-dialog" style="width:450px; height: 500px; padding: 10px 20px" closed="true" modal="true"></iframe>
  	</body>
</html>
