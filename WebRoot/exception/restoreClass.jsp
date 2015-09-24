<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/expManage/restoreClass.js"></script>
  	</head>
  	
  	<body>
  		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<input type="hidden" id="excId">
  		<div id ="baseInfo" class="easyui-panel" title="基本信息" style="width:1100px;">
  			<table width="100%;" class="maintable">
  				<tr>
  					<td width="15%" align="right">学员姓名：</td><td align="left" id="name"></td><td width="15%" align="right">出生日期：</td><td align="left" id="birthday"></td><td width="15%" align="right">性别：</td><td align="left" id="sexVal"></td>
  				</tr>
  				<tr>
  					<td align="right">证件号码：</td><td align="left" id="identityId"></td><td align="right">英文名：</td><td align="left" id="byName"></td><td align="right">联系电话：</td><td align="left" id="phone"></td>
  				</tr>
  				<tr>
  					<td align="right">所属校区：</td><td align="left" id="schoolName"></td><td align="right">异常状态：</td><td align="left" id="excState"></td><td align="right">异常开始时间：</td><td align="left" id="createDate"></td>
  				</tr>
  				<tr>
  					<td align="right">异常时长：</td><td align="left" id="excDays"></td><td align="right">终止时间：</td><td align="left" id="endDate"></td><td align="right">操作人：</td><td align="left" id="excHandler"></td>
  				</tr>
  				<tr>
  					<td align="right">复课时间：</td><td align="left" id="refundDate"></td><td align="right">复课方式：</td><td align="left" id="refundState"></td><td align="right">操作人：</td><td align="left" id="refundHandler"></td>
  				</tr>
  			</table>
  		</div>
  		<div  class="easyui-panel" title="基本信息" style="width:1100px;">
  			<table width="100%;" class="maintable" id ="classInfo">
  				<tr>
  					<td>课程名称</td><td>课程状态</td><td>校区</td><td>缴费时间</td>
  					<td>业绩类型</td><td>班级</td><td>开课日期</td><td>结课日期</td>
  					<td>课程进度</td><td>业绩顾问</td><td>责任顾问</td><td>客户关怀</td>
  				</tr>
  			</table>
  		</div>
  		<div class="easyui-panel" title="复课方式" style="width:1100px;height:70px;text-align:center;padding-top:10px">
  			<input type="radio" resumeType="001" name="resumeType" onclick="changeType(this)"><lable>原班复课</lable>
	      	&nbsp;&nbsp;&nbsp;<input type="radio" resumeType="002" name="resumeType" onclick="changeType(this)"><lable>转班复课</lable>
	      	&nbsp;&nbsp;&nbsp;<input type="radio" resumeType="003" name="resumeType" onclick="changeType(this)"><lable>转校复课</lable>
  		</div>
  		<div style="width:1100px;text-align:center;margin-top:50px;">
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:150px" id="submitBtn">提交</a>
  				&nbsp;&nbsp;&nbsp;&nbsp;
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:150px" id="backBtn" >返回</a>	
  		</div>
  	</body>
</html>
