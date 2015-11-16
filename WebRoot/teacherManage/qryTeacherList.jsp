<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/pub/js/json.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json2.js"></script>
		<script type="text/javascript" src="<%=path %>/js/teacherManage/teacherManage.js"></script>
  	</head>
  	<body>
 		<form id="qryFm">
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="5">
  				<tr>
  					<td align="right" width="8%">组织：</td>
  					<td align="left" width="10%">
  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width:120px;">
        				</select>
  					</td>
  					<td align="right" width="10%">教师英文名：</td>
  					<td align="left" width="10%">
  						<input name="byName" id="byName" class="easyui-textbox" style="width:120px;" />
  					</td>
  					<td align="right" width="10%">入职时间：</td>
  					<td align="left" width="10%">
  						<input class="easyui-datebox" name="joinStartDate" id="joinStartDate" style="width:120px;" />
  					</td>
  					<td align="center" width="3%">至：</td>
  					<td align="left" width="10%">
  						<input class="easyui-datebox" name="joinEndDate" id="joinEndDate" style="width:120px;" />
  					</td>
  					<td width="25%"></td>
  				</tr>
  				<tr>
  					<td align="right">职务：</td>
  					<td align="left">
  						<select id="post" name="post" class="easyui-combobox" style="width:120px;" editable="false"
						data-options="formatter:formatPost, valueField: 'postId', textField: 'postName', panelHeight: 'auto'"
			      		url="<%=path %>/pubData/qryPostList.do">
        				</select>
  					</td>
  					<td align="right">教师状态：</td>
  					<td align="left">
  						<select id="teacherState" name="teacherState" class="easyui-combobox" style="width:120px;">
        				</select>
  					</td>
  					<td align="right">入职时长：</td>
  					<td align="left">
  						<input class="easyui-numberbox" name="joinStartTime" id="joinStartTime" style="width:120px;" />
  					</td>
  					<td align="center">至：</td>
  					<td align="left">
  						<input class="easyui-numberbox" name="joinEndTime" id="joinEndTime" style="width:120px;" />
  					</td>
  					<td align="center">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:90px; height: 25px;" id="qryBtn" funcNodeId="4100">查询</a>
						&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:90px; height: 25px;" id="reset" >重置</a>
					</td>
  				</tr>
  			</table>
 		</form>
 		
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:570" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="7%">组织</th>
					<th field="teacherName" align="center" width="8%">教师姓名</th>
					<th field="byname" align="center" width="9%">教师英文名</th>
					<th field="stateVal" align="center" width="8%">教师状态</th>
					<th field="phone" align="center" width="9%">联系电话</th>
					<th field="postVal" align="center" width="8%">职务</th>
					<th field="joinDate" align="center" width="10%">入职时间</th>
					<th field="joinTime" align="center" width="10%">入职时长（月）</th>
					<th field="licenses" align="center" width="11%">持证阶段</th>
					<th field="stageIds" align="center" width="19%">在读带班阶段</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" onclick="updateFile()">档案维护</a>
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" onclick="preResign()">预离职</a>
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" onclick="preResignRegain()">预离职复职</a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" onclick="resign()">离职</a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" onclick="resignRegain()">离职复职</a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" onclick="updateOrg()">更换组织</a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" onclick="viewTeacherInfo()">浏览</a>
 		</div>
  	</body>
</html>