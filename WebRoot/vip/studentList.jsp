<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<%@ include file="../common/pub.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/student/student.js"></script>
  	</head>
  
  	<body>
		<input type="hidden" id="funcNodeId" value="${param.funcNodeId}"/>
  		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
		<form id="qryFm">
			<table class="search_tab">
				<tr>
					<td align="right" style="min-width: 80px"><span>校区：</span></td>
					<td style="min-width: 100px">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;">
        				</select>
					</td>
					<td align="right" style="min-width: 80px"><span>学员姓名：</span></td>
					<td style="min-width: 100px">
						<input name="studentId" id="studentId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
					</td>
					<td align="right" style="min-width: 80px"><span>联系电话：</span></td>
					<td style="min-width: 110px">
						<input name="phone" id="phone" type="text" class="easyui-textbox" style="width: 110px; height: 25px;"/>
					</td>
					<td align="right" style="min-width: 80px"><span>VIP学员：</span></td>
					<td style="min-width: 100px">
						<input type="radio" value="Y" name="vip"/><span>是</span>
	      				&nbsp;<input type="radio" value="N" name="vip"/><span>否</span>
					</td>
					<td align="left" colspan="2">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1000">查询</a>
						&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
					</td>
				</tr>
				<tr>
					<td align="right" style="min-width: 80px"><span>招生顾问：</span></td>
					<td style="min-width: 100px">
						<select id="advisterId" name="advisterId" class="easyui-combobox" style="width: 100px; height: 25px;">
        				</select>
					</td>
					<td align="right" style="min-width: 80px"><span>责任顾问：</span></td>
					<td style="min-width: 100px">
						<select id="dutyAdvister" name="dutyAdvister" class="easyui-combobox" style="width: 100px; height: 25px;">
        				</select>
					</td>
					<td align="right" style="min-width: 80px"><span>客户关怀：</span></td>
					<td style="min-width: 110px">
						<select id="carer" name="carer" class="easyui-combobox" style="width: 110px; height: 25px;">
        				</select>
					</td>
					<td align="right" style="min-width: 80px"><span>建档时间：</span></td>
					<td colspan="2">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTime" name="startTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
						至
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTime" name="endTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
				</tr>
			</table>
		</form> 
		<div id="toolbar" style="padding: 2px; height: auto">
    		<a href="javascript:void(0)" id="setVip" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">VIP设置</a>
    		<a href="javascript:void(0)" id="addVipRematk" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;">VIP维护</a>
    		<a href="javascript:void(0)" id="viewVip" class="easyui-linkbutton" iconCls="icon-redo" style="width: 100px;">浏览</a>
  		</div>
			<table class="easyui-datagrid" title="学员列表" style="height:435px;" id="list_data"
				toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'schoolName',width:80,align:'center'">所属校区</th>
						<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
						<th data-options="field:'byName',width:100,align:'center'">英文名</th>
						<th data-options="field:'sexText',width:50,align:'center'">性别</th>
						<th data-options="field:'identityId',width:200,align:'center'">证件号码</th>
						<th data-options="field:'birthday',width:100,align:'center'">出生日期</th>
						<th data-options="field:'phone',width:250,align:'center'">联系电话</th>
						<th data-options="field:'entranceDate',width:100,align:'center'">建档时间</th>
						<th data-options="field:'advisterName',width:150,align:'center'">招生顾问</th>
						<th data-options="field:'dutyAdvisterName',width:120,align:'center'">责任顾问</th>
						<th data-options="field:'carerName',width:120,align:'center'">客户关怀</th>
						<th data-options="field:'vipText',width:80,align:'center'">VIP学员</th>
					</tr>
				</thead>
			</table>
 	</body>
</html>
