<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  	
  	<body>
  		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<div id ="classInfo" class="easyui-panel" title="班级信息" style="width:1100px;">
  			<table width="100%;" class="maintable">
  				<tr>
  					<td align="center" width="5%">校区</td>
  					<td align="center" width="6%">班级名称</td>
  					<td align="center" width="10%">结课日期</td>
  					<td align="center"  width="29%">上课时间段</td>
  					<td align="center" width="7%">在读人数</td>
  					<td align="center" width="7%">已升学人数</td>
  					<td align="center" width="7%">升学率</td>
  					<td align="center" width="11%">可升学人数</td>
  					<td align="center" width="7%">升学缺口</td>
  					<td align="center" width="11%">新招</td>
  				</tr>
  			</table>
  		</div>
  		<div id="mergePlan"  class="easyui-panel" title="合并班计划" style="width:1100px;">
  			<table width="100%;" class="maintable" id ="classInfo">
  				<tr>
  					<td align="center" width="5%">校区</td>
  					<td align="center" width="6%">班级名称</td>
  					<td align="center" width="10%" rowspan="1">开始日期</td>
  					<td align="center" width="5%">开始课时</td>
  					<td align="center" width="5%" rowspan="1">合并时长(周)</td>
  					<td align="center" width="8%">合并形式</td>
  					<td align="center" width="8%">合并后结课日期</td>
  					<td align="center" width="6%" rowspan="1">合并后班级</td>
  					<td align="center" width="4%">定班人数</td>
  					<td align="center" width="4%" rowspan="1">定班率</td>
  					<td align="center" width="16%" rowspan="1">合并后上课时段</td>
  					<td align="center" width="14%" rowspan="1">带班老师</td>
  					<td align="center" width="10%" rowspan="1">开课日期</td>
  				</tr>
  			</table>
  		</div>
  		<div id="courseChangePlan"  class="easyui-panel" title="课程调整计划" style="width:1100px;">
  			<table width="100%;" class="maintable">
  				<tr>
  					
  				</tr>
  			</table>
  		</div>
  		<div class="easyui-panel" title="合并说明" style="width:1100px;height:100px;">
  			
  		</div>
  		<div class="easyui-panel" title="审批意见" style="width:1100px;padding:20px 10px">
  			<input type="radio" name="agree">同意取消合并班&nbsp;&nbsp;&nbsp;
  			<input type="radio" name="agree">不同意取消合并班
  		</div>
  		<div class="easyui-panel" title="取消合并说明" style="width:1100px;height:100px;">
  			<textarea id="cancelRemark" style="border:0;width:100%;height:100%;resize:none;overflow-y:hidden"></textarea>
  		</div>
  		<div style="width:1100px;text-align:center;margin-top:50px;">
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:150px" id="submitBtn">提交</a>
  				&nbsp;&nbsp;&nbsp;&nbsp;
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:150px" id="backBtn" >返回</a>	
  		</div>
  	</body>
</html>
