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
  			<table style="width:100%;text-align:center;" class="maintable">
  				<tr>
  					<td width="15%" align="right"><span>学员姓名：</span></td><td align="left" id="name"></td><td width="15%" align="right"><span>出生日期：</span></td><td align="left" id="birthday"></td><td width="15%" align="right"><span>性别：</span></td><td align="left" id="sexVal"></td>
  				</tr>
  				<tr>
  					<td align="right"><span>证件号码：</span></td><td align="left" id="identityId"></td><td align="right"><span>英文名：</span></td><td align="left" id="byName"></td><td align="right"><span>联系电话：</span></td><td align="left" id="phone"></td>
  				</tr>
  				<tr>
  					<td align="right"><span>所属校区：</span></td><td align="left" id="schoolName"></td><td align="right"><span>异常状态：</span></td><td align="left" id="excState"></td><td align="right"><span>异常开始时间：</span></span></td><td align="left" id="createDate"></td>
  				</tr>
  				<tr>
  					<td align="right"><span>异常时长：</span></td><td align="left" id="excDays"></td><td align="right"><span>终止时间：</span></td><td align="left" id="endDate"></td><td align="right"><span>操作人：</span></td><td align="left" id="excHandler"></td>
  				</tr>
  				<tr>
  					<td align="right"><span>复课时间：</span></td><td align="left" id="refundDate"></td><td align="right"><span>复课方式：</span></td><td align="left" id="refundState"></td><td align="right"><span>操作人：</span></td><td align="left" id="refundHandler"></td>
  				</tr>
  			</table>
  		</div>
  		<div style="height:5px;"></div>
  		<div  class="easyui-panel" title="课程信息" style="width:1100px;">
  			<table style="width:100%;text-align:center;" class="maintable" id ="classInfo">
  				<tr>
  					<td><span>课程名称</span></td><td><span>课程状态</span></td><td><span>校区</span></td><td><span>缴费时间</span></td>
  					<td><span>业绩类型</span></td><td><span>班级</span></td><td><span>开课日期</span></td><td><span>结课日期</span></td>
  					<td><span>课程进度</span></td><td><span>业绩顾问</span></td><td><span>责任顾问</span></td><td><span>客户关怀</span></td>
  				</tr>
  			</table>
  		</div>
  		<div style="height:5px;"></div>
  		<div class="easyui-panel" title="复课方式" style="width:1100px;height:70px;text-align:center;padding-top:10px">
  			<input type="radio" resumeType="001" name="resumeType" onclick="changeType(this)"><lable>原班复课</lable>
	      	&nbsp;&nbsp;&nbsp;<input type="radio" resumeType="002" name="resumeType" onclick="changeType(this)"><lable>转班复课</lable>
	      	&nbsp;&nbsp;&nbsp;<input type="radio" resumeType="003" name="resumeType" onclick="changeType(this)"><lable>转校复课</lable>
  		</div>
  		<div style="width:1100px;text-align:right;margin:25px 0;">
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px" id="submitBtn">提交</a>
  				&nbsp;&nbsp;&nbsp;&nbsp;
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px" id="backBtn" >返回</a>	
  		</div>
  	</body>
</html>
