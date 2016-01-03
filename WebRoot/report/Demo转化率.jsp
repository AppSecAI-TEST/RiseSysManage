

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
  					<td align="right"><span>DemoT：</span></td>
  					<td>
  						<select class="easyui-combobox" name="DemoT" id="DemoT" style="width:150px;height:28px;"
  							data-options="formatter:formatTeacher, valueField: 'teacherId',textField: 'byname', panelHeight: 'auto'"
  							url ="<%=path %>/pubData/qryData.do?param={'queryCode':'qryDemoTeacherInfo','teacherType':'T'}">
  						</select>
  					</td>
  					<td align="right"><span>DemoTa：</span></td>
  					<td>
  						<select class="easyui-combobox" name="DemoTA" id="DemoTA" style="width:150px;height:28px;"
  							data-options="formatter:formatTeacher, valueField: 'teacherId',textField: 'byname', panelHeight: 'auto'"
  							url ="<%=path %>/pubData/qryData.do?param={'queryCode':'qryDemoTeacherInfo','teacherType':'TA'}">
  						</select>
  					</td>
  					<td align="right"><span>DEMO转化率：</span></td>
  					<td>
  						<input class="easyui-numberbox" name="min" id="min"  style="width:145px;" data-options="min:0,max:99,precision:0" />%
  					</td>
  					<td align="center"><span>至：</span></td>
  					<td>
  						<input class="easyui-numberbox" name="max" id="max"  style="width:145px;" data-options="min:1,max:100,precision:0"/>%
  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>校区：</span></td>
  					<td>
  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:150px;height: 28px;"
  							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
  							url="<%=path%>/pubData/qrySchoolList.do?schoolId=">
  						</select>
  					</td>
  					<td align="right"><span>Demo课日期：</span></td>
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
					<th field="schoolName" align="center" width="6%">校区</th>
					<th field="schoolTime" align="center" width="20%">上课时间</th>
					<th field="stuNum" align="center" width="8%">参与Demo人数</th>
					<th field="orderNum" align="center" width="7%">定金个数</th>
					<th field="allNum" align="center" width="7%">全费个数</th>
					<th field="turnNum" align="center" width="8%">定金转全费</th>
					<th field="repayNum" align="center" width="7%">补缴全费</th>
					<th field="demoRate" align="center" width="8%">Demo转化率</th>
					<th field="demoT" align="center" width="15%">反馈DemoT</th>
					<th field="demoTa" align="center" width="15%">反馈DemoTa</th>
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