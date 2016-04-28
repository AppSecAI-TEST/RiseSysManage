

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
 		<input id="staffId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<input type="hidden" id="resourceId" value="725">
  		<div style="margin-right:5px;">
  			<form id="qryFm">
	  			<table class="search_tab">
  				<tr>
  					<td align="right" width="80px"><span>DemoT：</span></td>
  					<td width="110px">
  						<select class="easyui-combobox" name="DemoT" id="DemoT" style="width:100px;height:25px;" editable="false"
  							data-options="formatter:formatTeacher, valueField: 'teacherId',textField: 'byname', panelHeight: 'auto'"
  							url ="<%=path %>/pubData/qryData.do?param={'queryCode':'qryDemoTeacherInfo','teacherType':'T'}">
  						</select>
  					</td>
  					<td align="right" width="90px"><span>DemoTa：</span></td>
  					<td width="250px">
  						<select class="easyui-combobox" name="DemoTA" id="DemoTA" style="width:100px;height:25px;"  editable="false"
  							data-options="formatter:formatTeacher, valueField: 'teacherId',textField: 'byname', panelHeight: 'auto'"
  							url ="<%=path %>/pubData/qryData.do?param={'queryCode':'qryDemoTeacherInfo','teacherType':'TA'}">
  						</select>
  					</td>
  					<td align="left">
  						<span>DEMO转化率：</span>
  						<input class="easyui-numberbox" name="min" id="min"  style="width:36px;height:25px" data-options="min:0,max:99,precision:0" />%
  						至
  						<input class="easyui-numberbox" name="max" id="max"  style="width:36px;height:25px" data-options="min:1,max:100,precision:0"/>%
  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>校区：</span></td>
  					<td>
  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false" 
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        </select>
  					</td>
  					<td align="right"><span>Demo课日期：</span></td>
  					<td>
  						<input class="easyui-datebox" name="startTime" id="startTime"  style="width:100px;height:25px;"  editable="false"/>
  						至
  						<input class="easyui-datebox" name="endTime" id="endTime"  style="width:100px;height:25px;"  editable="false" />
  					</td>
  					<td align="left">
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
					<th field="schoolTime" align="center" width="19%">上课时间</th>
					<th field="stuNum" align="center" width="9%">参与Demo人数</th>
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
		initReportButton("resetBtn","qryFm","schoolId");
		$("#qryBtn").click(function() {
			initPageNumber("list_data");
			var object = $("#qryFm").serializeObject();
	    	var obj = JSON.stringify(object);
	    	obj = obj.substring(0, obj.length - 1);
	    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
	    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
	    	$('#list_data').datagrid({
	    		url : "/sys/pubData/qryDataListByPage.do",
	    		queryParams:{
	    			param : obj
	    		}
	    	});
    	});
		exportLink("export","list_data");
	});	
</script>