<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/action/cancelAction.js"></script>
	</head>
	<body>
		<div id ="baseInfo" class="easyui-panel" title="基本信息" style="width:1100px;">
		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<table id ="infoTab" width="100%;" class="maintable">
  				<tr>
  					<td width="15%" align="right"><span>校区：</span></td>
  					<td align="left" >
  					</td>
  				</tr>
  				<tr>
  					<td width="15%" align="right"><span>活动时间：</span></td>
  					<td align="left" >
  					</td>
  				</tr>
  				<tr>
  					<td align="right" ><span>活动名称：</span></td>
  					<td align="left">
  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>课时：</span></td>
  					<td align="left">
  				
  					</td>
  				</tr>
  				<tr id="teacherTr" style="display:none">
  					<td align="right"><span>老师：</span></td>
  					<td align="left">
  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>备注：</span></td>
  					<td align="left">
  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>取消备注：</span></td>
  					<td align="left">
  						<textarea id="cancelRemark" style="border:0;width:98%;height:80px;resize:none;overflow-y:hidden"></textarea>
  					</td>
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