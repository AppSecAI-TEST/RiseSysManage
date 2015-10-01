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
		<script type="text/javascript" src="<%=path %>/js/expManage/selectClass.js"></script>
  	</head>
  	<body>
  		<div>
 		<form id="qryFm">
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="15">
  				<tr>
  					<td width="8%" align="right">所属校区：</td>
  					<td width="10%">
  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:150px;">
  							
  						</select>
  					</td>
  					<td width="8%" align="right">学员姓名：</td>
  					<td width="8%">
  						<input class="easyui-textbox"  name="name" id="name" style="width:150px;" />
  					</td>
  					<td width="8%" align="right">联系电话：</td>
  					<td width="8%">
  						<input class="easyui-textbox" name="phone" id="phone" style="width:150px;" />
  					</td>
  				</tr>
  				<tr>
  					<td align="right">课程状态：</td>
  					<td>
  						<select class="easyui-combobox" name="state" id="state" style="width:150px;">
  						
  						</select>
  					</td>
  					<td align="right">带班老师：</td>
  					<td>
  						<input class="easyui-textbox"  name="teacher" id="teacher" style="width:150px;" />
  					</td>
  					<td align="right">  						
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qryBtn" funcNodeId="3002">查询</a>
  					</td>
  					<td align="left">
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:150px" id="resetBtn">重置</a>
  					</td>
  				</tr>
  			</table>
 		</form>
 		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:300" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="name" align="center" width="10%">学员姓名</th>
					<th field="byName" align="center" width="10%">英文名</th>
					<th field="phone" align="center" width="15%">联系电话</th>
					<th field="stageLevel" align="center" width="10%">已升学阶段</th>
					<th field="className" align="center" width="10%">在读班级</th>
					<th field="courseStateVal" align="center" width="10%">课程状态</th>
					<th field="teacherName" align="center" width="12%">带班老师</th>
					<th field="carerName" align="center" width="11%">客户关怀</th>
					<th field="classProgress" align="center" width="11%">在读班级课时</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" id="submitBtn" class="easyui-linkbutton" iconCls="icon-ok" plain="true">提交</a>
   			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" plain="true">返回</a>
 		</div>
  	</body>
</html>
