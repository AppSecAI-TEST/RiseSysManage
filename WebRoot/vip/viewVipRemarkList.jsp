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
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="VIP维护信息">
  			<form id="setVipFm">
	  			<table width="100%" cellpadding="5px" class="maintable" id="setVipTd">
	  				<tr>
	  					<td align="right" width="10%"><span>关系：</span></td>
	  					<td width="90%" colspan="5"><span>${obj.studentVipObj.relation }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>折扣：</span></td>
	  					<td width="90%" colspan="5"><span>${obj.studentVipObj.discount }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>职务：</span></td>
	  					<td width="90%" colspan="5"><span>${obj.studentVipObj.post }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>相关事项：</span></td>
	  					<td width="90%" colspan="5"><span>${obj.studentVipObj.notice }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>联系方式：</span></td>
	  					<td width="90%" colspan="5"><span>${obj.studentVipObj.contactWay }</span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>备注：</span></td>
	  					<td width="90%" colspan="5"><span>${obj.studentVipObj.vipRemark }</span></td>
	  				</tr>
	  			</table>
  			</form>
  		</div>
  		
  		<div style="padding:5px 0;min-width:1100px; width:100%;">
			<table class="easyui-datagrid" title="VIP维护历史" style="height:auto;" id="list_data" 
				url="<%=path %>/student/qryVipRemarkList.do?studentId=${obj.studentObj.studentId }"  
				pagination="false" rownumbers="false" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'userName',width:100,align:'center'">操作人</th>
						<th data-options="field:'createDate',width:150,align:'center'">操作时间</th>
						<th data-options="field:'content',width:800,align:'center'">维护内容</th>
					</tr>
				</thead>
			</table>
		</div>
  	</body>
</html>
