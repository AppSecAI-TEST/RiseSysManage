<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String funcNodeId = request.getParameter("funcNodeId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/changeSchool/changeStudent.js"></script>
  	</head>
  
  	<body style="padding-top:5px">
  		<input type="hidden" id="menuFuncNodeId" value="<%=funcNodeId %>" />
  		<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  		<form id="qryFm">
  			<table class="search_tab">
  				<tr>
  					<td align="right" style="min-width: 70px"><span>学员姓名：</span></td>
					<td style="min-width: 100px">
						<input name="studentId" id="studentId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
					</td>
					<td align="right" style="min-width: 70px"><span>联系电话：</span></td>
					<td style="min-width: 100px">
						<input name="phone" id="phone" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
					</td>
					<td align="right" style="min-width: 70px"><span>证件号码：</span></td>
					<td colspan="3" style="min-width: 100px">
						<input name="identityId" id="identityId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
					</td>
  				</tr>
  				<tr>
  					<td align="right" style="min-width: 70px"><span>校区：</span></td>
					<td style="min-width: 100px">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;">
				        </select>
					</td>
					<td align="right" style="min-width: 70px"><span>带班老师：</span></td>
					<td style="min-width: 100px">
						<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 100px; height: 25px;" disabled="disabled">
				        </select>
					</td>
					<td align="right" style="min-width: 70px"><span>在读班级：</span></td>
					<td style="min-width: 100px">
						<input name="className" id="className" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
					</td>
					<td style="min-width: 220px">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1015">查询</a>
						&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
					</td>
					<td style="min-width: 250px">&nbsp;</td>
  				</tr>
  			</table>
  		</form>
  		<div style="padding:5px 0;min-width:1100px; width:100%;">
		  	<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="list_data"
		  		toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
						<th data-options="field:'byName',width:100,align:'center'">英文名</th>
						<th data-options="field:'phone',width:200,align:'center'">联系电话</th>
						<th data-options="field:'stageId',width:100,align:'center'">当前课程</th>
						<th data-options="field:'feeTypeText',width:100,align:'center'">业绩类型</th>
						<th data-options="field:'adviserName',width:100,align:'center'">业绩顾问</th>
						<th data-options="field:'className',width:100,align:'center'">在读班</th>
						<th data-options="field:'teacherName',width:100,align:'center'">带班老师</th>
						<th data-options="field:'courseStateText',width:100,align:'center'">在读课程状态</th>
					</tr>
				</thead>
			</table>
	  	</div>
	  	<div id="toolbar" style="padding: 2px; height: auto">
		   	<a href="javascript:void(0)" id="applyChangeSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
		</div>
  	</body>
</html>
