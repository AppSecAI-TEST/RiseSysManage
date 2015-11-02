<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
		<script type="text/javascript" src="<%=path %>/js/genCourseConfig/comPriceConfig.js"></script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="修改课程价格配置">
  			<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<input type="hidden" id="schoolIds" value="${obj.schoolIds}" />
  			<input type="hidden" id="setPriceId" value="${obj.setPriceId}"/>
	 		<table width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="right" width="11%">价格体系名称：</td>
  					<td align="left" width="69%"><input id="priceName" name="priceName" style="width:300px" class="easyui-textbox" required="true" /></td>
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
  					<td align="right">状态：</td>
  					<td align="left">${obj.isUseVal}</td>
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
	 		<table width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="center" width="11%">课程阶段</td>
  					<td align="center" width="7%">年级</td>
  					<td align="center" width="9%">班级类型</td>
  					<td align="center" width="9%">学费</td>
  					<td align="center" width="9%">材料费</td>
  					<td align="center" width="9%">保育费和餐费</td>
  					<td align="center" width="9%">总部提成</td>
  					<td align="center" width="9%">其他费用</td>
  					<td align="center" width="8%">总费用</td>
  				</tr>
  				<c:forEach items="${retObj.result}" var="result" varStatus="status">
  					<input type="hidden" id="setClassId${status.index}" value="${result.setClassId}"/>
  					<input type="hidden" id="setPriceId${status.index}" value="${result.setPriceId}"/>
  					<tr>
  						<td align="center" id="stageId${status.index}">${result.stageId}</td>
  						<td align="center" id="seqOrder${status.index}">${result.seqOrder}</td>
  						<td align="center" id="classType${status.index}">${result.classType}</td>
  						<td align="center"><input fee="${result.feeA}" id="feeA${status.index}" name="feeA" style="width:100px" data-options="events:{blur: function(){sumFee(${status.index})}}" class="easyui-numberbox" /></td>
  						<td align="center"><input fee="${result.feeB}" id="feeB${status.index}" name="feeB" style="width:100px" data-options="events:{blur: function(){sumFee(${status.index})}}" class="easyui-numberbox" /></td>
  						<td align="center"><input fee="${result.feeC}" id="feeC${status.index}" name="feeC" style="width:100px" data-options="events:{blur: function(){sumFee(${status.index})}}" class="easyui-numberbox" /></td>
  						<td align="center"><input fee="${result.feeD}" id="feeD${status.index}" name="feeD" style="width:100px" data-options="events:{blur: function(){sumFee(${status.index})}}" class="easyui-numberbox" /></td>
  						<td align="center"><input fee="${result.feeE}" id="feeE${status.index}" name="feeE" style="width:100px" data-options="events:{blur: function(){sumFee(${status.index})}}" class="easyui-numberbox" /></td>
  						<td align="center" id="totalFee${status.index}">${result.amount}</td>
  					</tr>
  				</c:forEach>
	 		</table>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: right;">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:80px; height: 28px;" onclick="updateComPriceSubmit()">提交</a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
	   <iframe id="dlg" class="easyui-dialog" style="width:450px; height: 500px; padding: 10px 20px" closed="true" modal="true"></iframe>
	   <script type="text/javascript">
	   		$(document).ready(function(){
	   			//初始化页面值
	   			$("#priceName").textbox('setValue',"${obj.priceName}");
	   			$("#effDate").datebox('setValue',"${obj.effDate}");
	   			for(var i = 0;i < ${fn:length(retObj.result)};i++){
	   				$("#feeA"+i+"").numberbox('setValue',$("#feeA"+i+"").attr('fee'));
	   				$("#feeB"+i+"").numberbox('setValue',$("#feeB"+i+"").attr('fee'));
	   				$("#feeC"+i+"").numberbox('setValue',$("#feeC"+i+"").attr('fee'));
	   				$("#feeD"+i+"").numberbox('setValue',$("#feeD"+i+"").attr('fee'));
	   				$("#feeE"+i+"").numberbox('setValue',$("#feeE"+i+"").attr('fee'));
	   			}
	   		});
	   </script>
  	</body>
</html>
