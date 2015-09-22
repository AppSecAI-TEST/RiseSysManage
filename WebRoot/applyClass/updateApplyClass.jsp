<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String classInstId = request.getParameter("classInstId");
	String applyId = request.getParameter("applyId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/applyClass/updateApplyClass.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:100%;height:auto;" title="放班信息">
  			<form id="updateApplyClassFm">
  				<input type="hidden" id="applyId" name="applyId" value="<%=applyId %>"/>
  				<input type="hidden" id="classInstId" name="classInstId" value="<%=classInstId %>"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
	  			<table width="99.99%" cellpadding="5px" class="maintable" id="cancelApplyClassTd">
	  				<tr>
	  					<td align="right" width="10%"><span>课程阶段：</span></td>
	  					<td width="20%"><span id="stageId"></span></td>
	  					<td align="right" width="10%"><span>班级类型：</span></td>
	  					<td width="20%"><span id="classType"></span></td>
	  					<td align="right" width="10%"><span>班级名称：</span></td>
	  					<td width="30%"><span id="className"></span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>开课时间：</span></td>
	  					<td width="20%">
	  						<input name="effectDate" id="effectDate" type="text" class="easyui-datebox" required="true" style="width: 100px; height: 28px;"/>
	  					</td>
	  					<td align="right" width="10%"><span>学员来源：</span></td>
	  					<td width="20%"><span id="studentChannelTypeVal"></span></td>
	  					<td align="right" width="10%"><span>升学班级：</span></td>
	  					<td width="30%"><span id="higherSchoolName"></span></td>
	  				</tr>
	  				<tr>
	  					<td align="right" width="10%"><span>备注：</span></td>
	  					<td width="90%" colspan="5"><span id="Applyremark"></span></td>
	  				</tr>
	  				<tr>
	  					<td colspan="8" align="right">
	  						<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
		      				&nbsp;<a href="javascript:void(0)" id="activityBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
		      				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  					</td>
	  				</tr>
	  			</table>
  			</form>
  		</div>
  		<div style="padding:5px 0;min-width:1100px; width:100%;">
	  		<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="list_data" url="<%=path %>/pubData/qryDataListByPage.do?funcNodeId=1005&param={'classInstId':'<%=classInstId %>'}" 
		  		toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
						<th data-options="field:'byName',width:100,align:'center'">英文名</th>
						<th data-options="field:'payDate',width:100,align:'center'">缴费时间</th>
						<th data-options="field:'studentChannelType',width:100,align:'center'">学员来源</th>
						<th data-options="field:'identityId',width:200,align:'center'">身份证号</th>
						<th data-options="field:'phone',width:100,align:'center'">联系方式</th>
						<th data-options="field:'selectClassNum',width:100,align:'center'">定班次数</th>
						<th data-options="field:'waitClassDays',width:100,align:'center'">等班时长</th>
						<th data-options="field:'dutyAdvisterName',width:100,align:'center'">责任顾问</th>
						<th data-options="field:'adviserTeacherName',width:100,align:'center'">业绩老师</th>
					</tr>
				</thead>
			</table>
  		</div>
		<div id="toolbar">
   			<a href="javascript:void(0)" id="selectClass" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">选班</a>
   			<a href="javascript:void(0)" id="removeStudent" class="easyui-linkbutton" iconCls="icon-remove" style="width: 100px;">移除</a>
   			<a href="javascript:void(0)" id="changeClass" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;">更换班级</a>
   			<a href="javascript:void(0)" id="view" class="easyui-linkbutton" iconCls="icon-redo" style="width: 100px;">浏览</a>
		</div>
  	</body>
</html>
