<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String studentId = request.getParameter("studentId");
	String name = request.getParameter("name");
	String byName = request.getParameter("byName");
	String birthday = request.getParameter("birthday");
	String sexVal = request.getParameter("sexVal");
	String identityId = request.getParameter("identityId");
	String phone = request.getParameter("phone");
	String schoolName = request.getParameter("schoolName");
	String dutyAdvisterName = request.getParameter("dutyAdvisterName");
	String carerName = request.getParameter("carerName");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/student/student.js"></script>
  	</head>
  	
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="基本信息">
  			<form id="setVipFm">
	  			<table width="100%" cellpadding="5px" class="maintable" id="setVipTd">
	  				<tr>
	  					<td align="right" width="10%"><span>学员姓名：</span></td>
	  					<td width="25%"><span id="nameText"><%=name %></span></td>
	  					<td align="right" width="10%"><span>出生日期：</span></td>
	  					<td width="20%"><span id="birthdayText"><%=birthday %></span></td>
	  					<td align="right" width="10%"><span>性别：</span></td>
	  					<td width="25%"><span id="sexText"><%=sexVal %></span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>证件号码：</span></td>
	  					<td width="25%"><span id="identityIdText"><%=identityId %></span></td>
	  					<td align="right" width="10%"><span>英文名：</span></td>
	  					<td width="20%"><span id="byNameText"><%=byName %></span></td>
	  					<td align="right" width="10%"><span>联系电话：</span></td>
	  					<td width="25%"><span id="phoneText"><%=phone %></span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>校区：</span></td>
	  					<td width="25%"><span id="schoolNameText"><%=schoolName %></span></td>
	  					<td align="right" width="10%"><span>责任顾问：</span></td>
	  					<td width="20%"><span id="dutyAdvisterNameText"><%=dutyAdvisterName %></span></td>
	  					<td align="right" width="10%"><span>客户关怀：</span></td>
	  					<td width="25%"><span id="carerNameText"><%=carerName %></span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>关系：</span></td>
	  					<td width="90%" colspan="5">
	  						<input name="relation" id="relation" type="text" class="easyui-textbox" style="width: 900px; height: 28px;"/>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>折扣：</span></td>
	  					<td width="90%" colspan="5">
	  						<input name="discount" id="discount" type="text" class="easyui-textbox" style="width: 900px; height: 28px;"/>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>职务：</span></td>
	  					<td width="90%" colspan="5">
	  						<input name="post" id="post" type="text" class="easyui-textbox" style="width: 900px; height: 28px;"/>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>相关事项：</span></td>
	  					<td width="90%" colspan="5">
	  						<input name="notice" id="notice" type="text" class="easyui-textbox" style="width: 900px; height: 28px;"/>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>联系方式：</span></td>
	  					<td width="90%" colspan="5">
	  						<input name="contactWay" id="contactWay" type="text" class="easyui-textbox" style="width: 900px; height: 28px;"/>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>备注：</span></td>
	  					<td width="90%" colspan="5">
	  						<textarea rows="3" cols="126" id="remark" name="remark" class="easyui-validatebox textbox"></textarea>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td colspan="6" align="right">
	  						<a href="javascript:void(0)" id="vipRemarkSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
		      				&nbsp;<a href="javascript:void(0)" id="vipRemarkBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
		      				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  					</td>
	  				</tr>
	  			</table>
  			</form>
  		</div>
  	</body>
</html>
