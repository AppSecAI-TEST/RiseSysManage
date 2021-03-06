<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String type=request.getParameter("type");
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/student/student.js"></script>
		<script type="text/javascript" src="<%=path %>/js/giftManage/goodsGiftManage.js"></script>
  	</head>
  
  	<body>
		<input type="hidden" id="funcNodeId" value="1000"/>
		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
		<div style="margin-right:5px">
		<form id="qryFm" style="margin:0 auto;">
			<table class="search_tab">
				<tr>
					<td align="right" style="min-width: 80px;"><span>校区：</span></td>
					<td width="100px">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
     					</select>
					</td>
					<td align="right" style="min-width: 80px;"><span>班级：</span></td>
					<td width="100px">
						<input name="classInstId" id="classInstId" type="text" class="easyui-textbox" style="width: 120px; height: 25px;"/>
					</td>
					<td align="right" style="min-width: 80px;"><span>学员姓名：</span></td>
					<td width="100px">
						<input name="studentId" id="studentId" type="text" class="easyui-textbox" style="width: 120px; height: 25px;"/>
					</td>
					<td align="right" style="min-width: 80px;"><span>联系电话：</span></td>
					<td width="100px" colspan="2">
						<input name="phone" id="phone" type="text" class="easyui-textbox" style="width: 120px; height: 25px;"/>
					</td>
					<td align="right" style="min-width: 80px;"><span>证件号码：</span></td>
					<td colspan="2" width="180px">
						<input name="identityId" id="identityId" type="text" class="easyui-textbox" style="width: 180px; height: 25px;"/>
					</td>
				</tr>
				<tr>
					<td align="right" style="min-width: 80px;"><span>招生顾问：</span></td>
					<td width="100px">
						<select id="advisterId" name="advisterId" class="easyui-combobox" style="width: 100px; height: 25px;">
     					</select>
					</td>
					<td align="right" style="min-width: 80px;"><span>责任顾问：</span></td>
					<td width="100px">
						<select id="dutyAdvister" name="dutyAdvister" class="easyui-combobox" style="width: 120px; height: 25px;">
      					</select>
					</td>
					<td align="right" style="min-width: 80px;"><span>客户关怀：</span></td>
					<td width="100px">
						<select id="carer" name="carer" class="easyui-combobox" style="width: 120px; height: 25px;">
     					</select>
					</td>
					<td align="right" style="min-width: 80px;"><span>建档时间：</span></td>
					<td width="90px">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTime" name="startTime" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center"><span>至</span></td>
					<td width="90px">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTime" name="endTime" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center" colspan="2" width="180px">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px; height: 25px;" id="qryBtn" funcNodeId="1000">查询</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:80px; height: 25px;" id="reset">重置</a>
					</td>
				</tr>
			</table>
		</form>
			<table class="easyui-datagrid" title="学员列表" style="height:435px;" id="list_data" 
				toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'schoolName',width:80,align:'center'">校区</th>
						<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
						<th data-options="field:'byName',width:100,align:'center'">英文名</th>
						<th data-options="field:'sexText',width:50,align:'center'">性别</th>
						<th data-options="field:'identityId',width:200,align:'center'">证件号码</th>
						<th data-options="field:'birthday',width:100,align:'center'">出生日期</th>
						<th data-options="field:'phone',width:250,align:'center'">联系电话</th>
						<th data-options="field:'entranceDate',width:100,align:'center'">建档时间</th>
						<th data-options="field:'advisterName',width:150,align:'center'">招生顾问</th>
						<th data-options="field:'dutyAdvisterName',width:100,align:'center'">责任顾问</th>
						<th data-options="field:'carerName',width:100,align:'center'">客户关怀</th>
						<th data-options="field:'parentName',width:150,align:'center'">家长</th>
					</tr>
				</thead>
			</table>
		<div id="toolbar" style="padding: 2px; height: auto">
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width: 100px;" onclick="addGift('<%=type %>')"><span>提交</span></a> 
    		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
    	</div>
		</div>	
 	</body>
</html>
