<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/expManage/addExp.js"></script>
		<style>
			.maintable {
				border-collapse: collapse;
				border-spacing: 0;
				border:none;
			}
			
			.maintable td {
				border: solid #ccc;
				border-width: 0px 1px 1px 0px;
				padding:2px 1px;
				text-align:center;
				font-size:12px;
			}
			
			.dialog-button{text-align:center;};
			
		</style>
  	</head>
  	
  	<body>
  		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<div id ="baseInfo" class="easyui-panel" title="基本信息" style="width:1100px;">
  			<table width="100%;" class="maintable">
  				<tr>
  					<td width="15%" align="right">学员姓名：</td><td align="left" id="name"></td><td width="15%" align="right">出生日期：</td><td align="left" id="birthday"></td><td width="15%" align="right">性别：</td><td align="left" id="sexVal"></td>
  				</tr>
  				<tr>
  					<td align="right">证件号码：</td><td align="left" id="identityId"></td><td align="right">英文名：</td><td align="left" id="byName"></td><td align="right">联系电话：</td><td align="left" id="phone"></td>
  				</tr>
  				<tr>
  					<td align="right">所属校区：</td><td align="left" id="schoolName"></td><td></td><td></td><td></td><td></td>
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
  		<div class="easyui-panel" title="备注" style="width:1100px;height:150px;">
  			<textarea id="remark" style="border:0;width:100%;height:100%;resize:none;overflow-y:hidden"></textarea>
  		</div>
  		<div style="width:1100px;text-align:center;margin-top:50px;">
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:150px" id="submitBtn">提交</a>
  				&nbsp;&nbsp;&nbsp;&nbsp;
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:150px" id="backBtn" >返回</a>	
  		</div>
  	</body>
</html>
