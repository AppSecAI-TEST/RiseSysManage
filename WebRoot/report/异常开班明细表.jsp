<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/exceptionOpenClass.js"></script>
  	</head>
  
  	<body>
  		<div style="margin-right:5px;">
  			<input type="hidden" id="type" value="detail"/>
  			<input type="hidden" id="resourceId" value="503">
  			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId}"/>
  			<form id="qryFm">
  				<table class="search_tab">
  					<tr>
  						<td align="right"><span>校区：</span></td>
	  					<td>
							<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 90px; height: 25px;" editable="false" 
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        	</select>
						</td>
						<td align="right"><span>阶段：</span></td>
	  					<td>
							<select id="stageId" name="stageId" class="easyui-combobox" style="width: 100px; height: 25px;"
								data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'" 
			      				url="<%=path %>/pubData/qryStage.do">
				        	</select>
						</td>
						<td align="right"><span>异常开班数量：</span></td>
	  					<td>
	  						<input name="minOpenNum" id="minOpenNum" type="text" class="easyui-numberbox" style="width: 40px; height: 25px;"/>
							至
							<input name="maxOpenNum" id="maxOpenNum" type="text" class="easyui-numberbox" style="width: 40px; height: 25px;"/>
	  					</td>
	  					<td align="right"><span>开课日期：</span></td>
	  					<td>
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeOpen" name="startTimeOpen" data-options="formatter:myformatter, parser:myparser"/>
							至
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeOpen" name="endTimeOpen" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="left">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1059">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
  					</tr>
  				</table>
  			</form>
  				<table class="easyui-datagrid" style="height:auto;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th data-options="field:'schoolName',width:80,align:'center',rowspan:2">校区</th>
							<th data-options="field:'stageId',width:80,align:'center',rowspan:2">阶段</th>
							<th data-options="field:'exceptionOpenNum',width:100,align:'center',rowspan:2">异常开班数量</th>
							<th data-options="field:'finish',width:600,align:'center',colspan:5">异常开班明细</th>
							<th data-options="field:'exceptionAvgOpenNum',width:120,align:'center',rowspan:2">异常开班平均班级人数</th>
							<th data-options="field:'exceptionOpenRate',width:120,align:'center',rowspan:2">该阶段异常开班占比</th>
						</tr>
						<tr>
							<th data-options="field:'className',width:100,align:'center'">班级</th>
							<th data-options="field:'openClassNum',width:100,align:'center'">异常开班人数</th>
							<th data-options="field:'subNum',width:150,align:'center'">距最低开班人数差异</th>
							<th data-options="field:'studyingNum',width:100,align:'center'">目前在读人数</th>
							<th data-options="field:'isExcep',width:150,align:'center'">目前是否为异常班级</th>
						</tr>
					</thead>
				</table>
  			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
			</div>
  		</div>
  	</body>
</html>
<script>
	$("#export").click(function(){
		if($("#list_data").datagrid("getData").total > 0) {
			var funcNodeId = $("#qryBtn").attr("funcNodeId");
			var param = $("#list_data").datagrid("options").queryParams.param;
			var fileName = parent.$("li.tabs-selected").find("span.tabs-title").html();
			try {
				window.location.href = "/sys/export/exportExpClassDetai.do?fileName=" + fileName + "&param=" + param + "&funcNodeId=" + funcNodeId;
			} catch(e) {
				$.messager.alert('提示', "模版不存在！",function(){ 
					window.history.back();
				});
			}
		} else {
			$.messager.alert('提示', "没有数据可以导出！");
		}	
	});
</script>	