

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  	<body>
 		<form id="qryFm">
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="15">
  				<tr>
  					<td align="right"><span>校区：</span></td>
  					<td>
  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:150px;height: 28px;"
  							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
  							url="<%=path%>/pubData/qrySchoolList.do?schoolId=">
  						</select>
  					</td>
  					<td align="right"><span>日期：</span></td>
  					<td>
  						<input class="easyui-datebox" name="startTime" id="startTime"  style="width:150px;" />
  					</td>
  					<td align="center"><span>至：</span></td>
  					<td>
  						<input class="easyui-datebox" name="endTime" id="endTime"  style="width:150px;" />
  					</td>
  					<td>
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:100px" id="qryBtn" funcNodeId ="3500" ><span>查询</span></a>
  						&nbsp;&nbsp;
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:100px" id="resetBtn" ><span>重置</span></a>
  					</td>
  				</tr>
  			</table>
 		</form>
 		
 		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:450" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true">
			<thead>
				<tr>
					<th field="schoolName" align="center" width="7%">校区</th>
					<th field="planNum" align="center" width="6%">计划个数</th>
					<th field="tNum" align="center" width="7%">老师转介绍</th>
					<th field="cNum" align="center" width="6%">CC转介绍</th>
					<th field="aNum" align="center" width="5%">活动邀约</th>
					<th field="tRNum" align="center" width="8%">老师转介绍退费</th>
					<th field="cRNum" align="center" width="8%">CC转介绍退费</th>
					<th field="aRNum" align="center" width="8%">活动邀约退费</th>
					<th field="demoT" align="center" width="11%">老师转介绍实际报名</th>
					<th field="demoTa" align="center" width="11%">CC转介绍实际报名</th>
					<th field="demoTa" align="center" width="11%">活动邀约实际报名</th>
					<th field="realNum" align="center" width="8%">实际完成个数</th>
					<th field="comRate" align="center" width="5%">完成率</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px; height: auto">
	   		<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
		</div>
  	</body>
</html>
<script>
	$(document).ready(function(){
		initQryButton("qryBtn","resetBtn","qryFm","list_data");
		exportLink("export","list_data");
	});	
</script>