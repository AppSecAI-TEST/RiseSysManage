<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
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
      		<form id="updateVipFm">
      			<input type="hidden" id="studentId" name="studentId" value="${obj.studentObj.studentId }"/>
      			<input type="hidden" id="studentVipId" name="studentVipId" value="${obj.studentVipObj.studentVipId }"/>
      			<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
      			<table width="100%" cellpadding="5px" class="maintable" id="setVipTd">
	  				<tr>
	  					<td align="right" width="10%"><span>学员姓名：</span></td>
	  					<td width="25%"><span id="nameText">${obj.studentObj.name }</span></td>
	  					<td align="right" width="10%"><span>出生日期：</span></td>
	  					<td width="20%"><span id="birthdayText">${obj.studentObj.birthday }</span></td>
	  					<td align="right" width="10%"><span>性别：</span></td>
	  					<td width="25%"><span id="sexText">${obj.studentObj.sexVal }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>证件号码：</span></td>
	  					<td width="25%"><span id="identityIdText">${obj.studentObj.identityId }</span></td>
	  					<td align="right" width="10%"><span>英文名：</span></td>
	  					<td width="20%"><span id="byNameText">${obj.studentObj.byName }</span></td>
	  					<td align="right" width="10%"><span>联系电话：</span></td>
	  					<td width="25%"><span id="phoneText">${phone }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>校区：</span></td>
	  					<td width="25%"><span id="schoolNameText">${schoolName }</span></td>
	  					<td align="right" width="10%"><span>责任顾问：</span></td>
	  					<td width="20%"><span id="dutyAdvisterNameText">${obj.studentObj.dutyAdvisterName }</span></td>
	  					<td align="right" width="10%"><span>客户关怀：</span></td>
	  					<td width="25%"><span id="carerNameText">${obj.studentObj.carerName }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>关系：</span></td>
	  					<td width="90%" colspan="5">
	  						<input name="relation" id="relation" type="text" class="easyui-textbox" style="width: 900px; height: 28px;" value="${obj.studentVipObj.relation }"/>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>折扣：</span></td>
	  					<td width="90%" colspan="5">
	  						<input name="discount" id="discount" type="text" class="easyui-textbox" style="width: 900px; height: 28px;" value="${obj.studentVipObj.discount }"/>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>职务：</span></td>
	  					<td width="90%" colspan="5">
	  						<input name="post" id="post" type="text" class="easyui-textbox" style="width: 900px; height: 28px;" value="${obj.studentVipObj.post }"/>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>相关事项：</span></td>
	  					<td width="90%" colspan="5">
	  						<input name="notice" id="notice" type="text" class="easyui-textbox" style="width: 900px; height: 28px;" value="${obj.studentVipObj.notice }"/>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>联系方式：</span></td>
	  					<td width="90%" colspan="5">
	  						<input name="contactWay" id="contactWay" type="text" class="easyui-textbox" style="width: 900px; height: 28px;" value="${obj.studentVipObj.contactWay }"/>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>维护记录：</span></td>
	  					<td width="90%" colspan="5">
	  						<textarea rows="3" cols="126" id="vipRemark" name="vipRemark" class="easyui-validatebox textbox">${obj.studentVipObj.vipRemark }</textarea>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td colspan="6" align="right">
	  						<a href="javascript:void(0)" id="updateVipSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
		      				&nbsp;<a href="javascript:void(0)" id="vipRemarkBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
		      				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  					</td>
	  				</tr>
	  			</table>
      		</form>
      	</div>
  	</body>
</html>
