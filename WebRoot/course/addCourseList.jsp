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
		<script type="text/javascript" src="<%=path %>/js/course/courseList.js"></script>
  	</head>
  
  	<body>
		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
		<input type="hidden" id="funcNodeId" value="<%=funcNodeId %>"/>
		<div style="margin-right:5px">
		<form id="qryFm">
			<table class="search_tab">
				<tr>
					<td align="right" style="min-width: 80px;"><span>所属校区：</span></td>
					<td style="min-width: 100px;">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;">
     					</select>
					</td>
					<td align="right" style="min-width: 80px;"><span>学员姓名：</span></td>
					<td style="min-width: 100px;">
						<input id="studentId" name="studentId" class="easyui-textbox" style="width: 100px; height: 25px;"/>
					</td>
					<td align="right" style="min-width: 80px;"><span>联系电话：</span></td>
					<td style="min-width: 100px;">
						<input name="phone" id="phone" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
					</td>
					<td align="right" style="min-width: 80px;"><span>证件号码：</span></td>
					<td colspan="2" style="min-width: 220px;">
						<input name="identityId" id="identityId" type="text" class="easyui-textbox" style="width: 220px; height: 25px;"/>
					</td>
					<td></td>
				</tr>
				<tr>
					<td align="right" style="min-width: 80px;"><span>业绩顾问：</span></td>
					<td style="min-width: 100px;">
						<select id="adviserId" name="adviserId" class="easyui-combobox" style="width: 100px; height: 25px;"
							data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', panelHeight: 'auto'"
      						url="<%=path %>/pubData/qryStaffList.do?post=16,17&schoolId=${sessionScope.StaffT.schoolId}">
      					</select>
					</td>
					<td align="right" style="min-width: 80px;"><span>责任顾问：</span></td>
					<td style="min-width: 100px;">
						<select id="dutyAdvister" name="dutyAdvister" class="easyui-combobox" style="width: 100px; height: 25px;"
							data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', panelHeight: 'auto'"
      						url="<%=path %>/pubData/qryStaffList.do?post=16,17&schoolId=${sessionScope.StaffT.schoolId}">
      					</select>
					</td>
					<td align="right" style="min-width: 80px;"><span>客户关怀：</span></td>
					<td style="min-width: 100px;">
						<select id="carer" name="carer" class="easyui-combobox" style="width: 100px; height: 25px;"
							data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', panelHeight: 'auto'"
      						url="<%=path %>/pubData/qryStaffList.do?post=31,32,33&schoolId=${sessionScope.StaffT.schoolId}">
    					</select>
					</td>
					<td align="right" style="min-width: 80px;"><span>建档时间：</span></td>
					<td style="min-width: 210px;">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTime" name="startTime" data-options="formatter:myformatter, parser:myparser"/>
						<span>至</span>
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTime" name="endTime" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="left" style="min-width: 170px;">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px; height: 25px;" id="qryBtn" funcNodeId="1000">查询</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:80px; height: 25px;" id="reset">重置</a>
					</td>
				</tr>
			</table>
		</form>
		<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="list_data"
				toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'schoolName',width:80,align:'center'">校区</th>
						<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
						<th data-options="field:'byName',width:80,align:'center'">英文名</th>
						<th data-options="field:'sexText',width:50,align:'center'">性别</th>
						<th data-options="field:'identityId',width:200,align:'center'">证件号码</th>
						<th data-options="field:'birthday',width:100,align:'center'">出生日期</th>
						<th data-options="field:'phone',width:250,align:'center'">联系电话</th>
						<th data-options="field:'entranceDate',width:100,align:'center'">建档时间</th>
						<th data-options="field:'advisterName',width:100,align:'center'">招生顾问</th>
						<th data-options="field:'dutyAdvisterName',width:100,align:'center'">责任顾问</th>
						<th data-options="field:'carerName',width:100,align:'center'">客户关怀</th>
						<th data-options="field:'parentName',width:150,align:'center'">家长</th>
					</tr>
				</thead>
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" id="single" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">单报</a>
   			<a href="javascript:void(0)" id="multiple" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">连报</a>
			<a href="javascript:void(0)" id="backBt" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;">返回</a>
		</div>
	</div>	
 	</body>
</html>
