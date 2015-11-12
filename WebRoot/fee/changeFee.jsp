<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String studentCourseId =request.getParameter("studentCourseId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/courseFee/changeFee.js"></script>
  	</head>
  	
  	<body>
  		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<input id="studentCourseId" type="hidden" value="<%=studentCourseId %>"/>
  		<input id="beforeAmount" type="hidden" value=""/>
  		<div class="easyui-panel" title="学员档案" style="width:1100px;">
  			<table width="100%;" class="maintable">
  				<tr>
  					<td width="15%" align="right"><span>学员姓名：</span></td><td width="10%" align="left" id="name"><span></span></td><td width="10%" align="right"><span>出生日期：</span></td><td width="10%" align="left" id="birthday"><span></span></td><td width="10%" align="right"><span>证件号码：</span></td><td colspan="3" align="left" id="identityId"><span></span></td>
  				</tr>
  				<tr>
  					<td align="right"><span>性别：</span></td><td align="left" id="sexVal"><span></span></td><td align="right"><span>英文名：</span></td><td align="left" id="byName"><span></span></td><td align="right"><span>联系电话：</span></td><td align="left" colspan="3" id="phone"><span></span></td>
  				</tr>
  			</table>
  		</div>
  		<div  class="easyui-panel" title="课程信息" style="width:1100px;">
  			<table width="100%;" class="maintable">
  				<tr>
  					<td width="15%" align="right"><span>课程阶段：</span></td><td width="10%" align="left" id="stageId"><span></span></td><td width="10%" align="right"><span>班级类型：</span></td><td width="10%" align="left" id="classType"><span></span></td><td width="10%" align="right"><span>缴费时间：</span></td><td colspan="3" align="left" id="payTime"><span></span></td>
  				</tr>
  				<tr>
  					<td align="right"><span>业绩类型：</span></td><td align="left" id="feeType"><span></span></td><td align="right"><span>业务顾问：</span></td><td align="left" id="adviserName"><span></span></td><td align="right"><span>抵扣券：</span></td><td align="left" colspan="3"><span></span></td>
  				</tr>
  				<tr>
  					<td align="right"><span>总金额：</span></td><td align="left" id="totalAmount"><span></span></td><td align="right"><span>抵扣金额：</span></td><td align="left" id="minusAmount"><span></span></td><td align="right"><span>优惠金额：</span></td><td width="15%" align="left" id="favorAmount"><span></span></td><td width="15%" align="right"><span>实收金额：</span></td><td width="15%" align="left" id="amount"><span></span></td>
  				</tr>
  				<tr>
  					<td align="right"><span>实收金额调整为：</span></td><td align="left" colspan="7"><input type="text" class="easyui-numberbox" id="afterAmount" name="afterAmount" data-options="min:0,precision:0"  style="width:150px;height: 28px;"></td>
  				</tr>
  				<tr style="height:150px;">
  					<td align="right"><span>备注：</span></td><td align="left" colspan="7"><textarea id="remark" style="border:0;width:100%;height:100%;resize:none;overflow-y:hidden"></textarea></td>
  				</tr>
  			</table>
  		</div>
  		<div class="easyui-panel" id="changeInfo" title="调整记录" style="width:1100px;">
  			<table id="changeTab" width="100%;" class="maintable">
  				<tr>
  					<td align="center" width="10%"><span>调整人</span></td><td align="center"  width="20%"><span>调整时间</span></td><td align="center" width="10%"><span>调整前金额</span></td><td width="10%" align="center"><span>调整后金额</span> </td><td align="center" width="50%"><span>备注</span></td>
  				</tr>
  				<tr id="modelTr" style="display:none">
  					<td align="center"><span></span></td><td align="center"><span></span></td><td align="center"><span></span></td><td align="center"><span></span></td><td align="center"><span></span></td>
  				</tr>
  			</table>
  		</div>
  		<div style="width:1100px;text-align:center;margin-top:50px;">
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:150px" id="submitBtn">提交</a>
  				&nbsp;&nbsp;&nbsp;&nbsp;
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:150px" id="backBtn" >返回</a>	
  		</div>
  	</body>
</html>
