<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String studentId = request.getParameter("studentId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
  		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/student/viewStudent.js"></script>
  	</head>

  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="学员基础信息">
  			<input type="hidden" id="funcNodeId" name="funcNodeId" value="1002"/>
  			<input type="hidden" id="studentId" name="studentId" value="<%=studentId %>"/>
  			<table width="100%" cellpadding="5px" class="maintable" id="studentTd">
  				<tr>
  					<td align="right" width="100px"><span>学员姓名：</span></td>
	      			<td><span id="nameText""></span></td>
	  				<td align="right" width="100px"><span>出生日期：</span></td>
	  				<td colspan="3"><span id="birthdayText"></span></td>
  				</tr>
  				<tr>
  					<td align="right" width="100px"><span>性别：</span></td>
	      			<td><span id="sexText""></span></td>
	  				<td align="right" width="100px"><span>证件号码：</span></td>
	  				<td colspan="3"><span id="identityIdText"></span></td>
  				</tr>
  				<tr>
  					<td align="right" width="100px"><span>英文名：</span></td>
	      			<td><span id="byName""></span></td>
	  				<td align="right" width="100px"><span>家庭地址：</span></td>
	  				<td colspan="3"><span id="address"></span></td>
  				</tr>
  				<tr>
  					<td align="right" width="100px"><span>建档日期：</span></td>
	      			<td><span id="createDate""></span></td>
	  				<td align="right" width="100px"><span>录入时间：</span></td>
	  				<td colspan="3"><span id="createDate"></span></td>
  				</tr>
  				<tr>
  					<td align="right" width="100px"><span>招生顾问A：</span></td>
	      			<td><span id="advisterAText""></span></td>
	  				<td align="right" width="100px"><span>招生顾问B：</span></td>
	  				<td colspan="3"><span id="advisterBText"></span></td>
  				</tr>
  				<tr>
  					<td align="right" width="100px"><span>责任顾问：</span></td>
	      			<td><span id="dutyAdvisterNameText""></span></td>
	  				<td align="right" width="100px"><span>客户关怀：</span></td>
	  				<td colspan="3"><span id="carerNameText"></span></td>
  				</tr>
  				<tr>
	      			<td align="right" width="100px"><span>学员备注：</span></td>
	      			<td colspan="5"><span id="remark"></span></td>
	      		</tr>
  			</table>
  		</div>
  		<div style="height: 5px"></div>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="联系人信息">
  			<table width="100%" cellpadding="5px" class="maintable" id="contactTd">
  				<tr>
					<td align="center" width="100px"><span>关系</span></td>
					<td align="center" width="120px"><span>姓名</span></td>
					<td align="center" width="120px"><span>职业</span></td>
					<td align="center" width="80px"><span>常用联系人</span></td>
					<td align="center" width="310px"><span>证件号码</span></td>
					<td align="center" width="150px"><span>联系电话</span></td>
				</tr>
  			</table>
  		</div>
  		<div style="height: 5px"></div>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="活动信息">
  			<table width="100%" cellpadding="5px" class="maintable" id="activityTd">
  				<tr>
					<td align="center" width="150px"><span>活动标题</span></td>
					<td align="center" width="100px"><span>活动时间</span></td>
					<td align="center" width="150px"><span>获奖情况</span></td>
					<td align="center" width="543px"><span>奖品赠品</span></td>
					<td align="center" width="100px"><span>活动详细</span></td>
				</tr>
  			</table>
  		</div>
  	</body>
</html>
