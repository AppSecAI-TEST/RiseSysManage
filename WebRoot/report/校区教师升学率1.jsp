<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/higherRate.js"></script>
  	</head>
  
  	<body>
  		<div style="padding:5px 0;">
  			<form id="qryFm" style="margin:0 auto;">
	  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:80px;" cellspacing="2">
	  				<tr>
	  					<td align="right"><span>校区：</span></td>
	  					<td width="130px">
							<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;">
				        	</select>
						</td>
						<td align="right"><span>带班老师：</span></td>
	  					<td width="130px">
	  						<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 114px; height: 25px;">
	  						</select>
	  					</td>
	  					<td align="right"><span>课时进度比：</span></td>
	  					<td width="130px">
	  						<input name="minAttendRate" id="minAttendRate" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
							<span style="display: inline-block; text-align: center; width: 14px;">至</span>
							<input name="maxAttendRate" id="maxAttendRate" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
	  					</td>
	  					<td width="400px;">&nbsp;</td>
	  				</tr>	
	  				<tr>
	  					<td align="right"><span>未结课升学率：</span></td>
	  					<td width="130px">
	  						<input name="minAttendHigherRate" id="minAttendHigherRate" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
							<span style="display: inline-block; text-align: center; width: 14px;">至</span>
							<input name="maxAttendHigherRate" id="maxAttendHigherRate" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
	  					</td>
	  					<td align="right"><span>已结课升学率：</span></td>
	  					<td width="130px">
	  						<input name="minFinishHigherRate" id="minFinishHigherRate" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
							<span style="display: inline-block; text-align: center; width: 14px;">至</span>
							<input name="maxFinishHigherRate" id="maxFinishHigherRate" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
						</td>
						<td align="center" colspan="2">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1052">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
						<td width="400px;">&nbsp;</td>
	  				</tr>
	  			</table>
  			</form>
  			<div style="padding:5px 0;min-width:1100px; width:100%;">
  				<table class="easyui-datagrid" style="height:435px;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th data-options="field:'byName',width:120,align:'center',rowspan:2">带班老师</th>
							<th data-options="field:'finish',width:400,align:'center',colspan:4">已结课</th>
							<th data-options="field:'attend',width:400,align:'center',colspan:4">课时进度＜50%</th>
						</tr>
						<tr>
							<th data-options="field:'finishClassNum',width:100,align:'center'">班级数</th>
							<th data-options="field:'finishClassHigherBaseNum',width:100,align:'center'">班级总基数</th>
							<th data-options="field:'finishClassHigherNum',width:100,align:'center'">班级总升学</th>
							<th data-options="field:'finishClassAvgRate',width:100,align:'center'">平均升学率</th>
							<th data-options="field:'attendClassNum',width:100,align:'center'">班级数</th>
							<th data-options="field:'attendClassHigherBaseNum',width:100,align:'center'">班级总基数</th>
							<th data-options="field:'attendClassHigherNum',width:100,align:'center'">班级总升学</th>
							<th data-options="field:'attendClassAvgRate',width:100,align:'center'">平均升学率</th>
						</tr>
					</thead>
				</table>
  			</div>
  			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
			</div>
  		</div>
  	</body>
</html>
