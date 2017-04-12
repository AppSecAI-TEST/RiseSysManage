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
  		<div style="margin-right:5px;">
  			<input type="hidden" id="sFlag" value="1"/>
  			<input type="hidden" id="resourceId" value="749"/>	
  			<input type="hidden" id="higherType" value="teacherHigherRate"/>
  			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId }"/>
  			<form id="qryFm">
	  			<table class="search_tab">
	  				<tr>
	  					<td align="right" style="width:100px"><span>校区：</span></td>
	  					<td style="min-width: 114px">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        	</select>
						</td>
						<td align="right" style="width: 120px"><span>带班老师：</span></td>
	  					<td style="min-width: 114px">
	  						<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 114px; height: 25px;">
	  						</select>
	  					</td>
	  					<td align="right" style="width: 90px"><span>年度：</span></td>
						<td style="min-width: 114px">
							<select class="easyui-combobox" name="year" id="year" style="width:114px;height: 25px;" editable="false" data-options="valueField:'val',textField:'text'">
							</select>
						</td>
						<td>&nbsp;</td>
	  				</tr>	
	  				<tr>
	  					<td align="right"><span>未结课升学率：</span></td>
	  					<td align="left">
	  						<input name="minAttendHigherRate" id="minAttendHigherRate" type="text" style="width:39px;height:25px;" class="easyui-numberbox" data-options="precision:1,min:0,max:100"/>%
	  						至
	  						<input name="maxAttendHigherRate" id="maxAttendHigherRate" type="text" style="width:39px;height:25px;" class="easyui-numberbox" data-options="precision:1,min:0,max:100"/>%
	  					</td>
	  					<td align="right"><span>已结课升学率：</span></td>
	  					<td align="left">
	  						<input name="minFinishHigherRate" id="minFinishHigherRate" type="text" style="width:39px;height:25px;" class="easyui-numberbox" data-options="precision:1,min:0,max:100"/>%
	  						至
	  						<input name="maxFinishHigherRate" id="maxFinishHigherRate" type="text" style="width:39px;height:25px;" class="easyui-numberbox" data-options="precision:1,min:0,max:100"/>%
						</td>
						<td align="right" style="width: 90px"><span>课时进度比：</span></td>
	  					<td align="left">
	  						<input name="minAttendRate" id="minAttendRate" type="text" style="width:39px;height:25px;" class="easyui-numberbox" data-options="precision:0,min:0,max:100"/>%
	  						至
	  						<input name="maxAttendRate" id="maxAttendRate" type="text" style="width:39px;height:25px;" class="easyui-numberbox" data-options="precision:0,min:0,max:100"/>%
	  					</td>
						<td align="left">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1107">查询</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
	  				</tr>
	  			</table>
  			</form>
  				<table class="easyui-datagrid" style="height:435px;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th data-options="field:'byname',width:120,align:'center',rowspan:2">带班老师</th>
							<th data-options="field:'stageTeam',width:120,align:'center',rowspan:2">阶段</th>
							<th data-options="field:'finish',width:400,align:'center',colspan:4">已结课</th>
							<th data-options="field:'attend',width:400,align:'center',colspan:4"><div id="classProgress">未结课</div></th>
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
				window.location.href = "/sys/export/exportTeacherHigherRate.do?fileName=" + fileName + "&param=" + param + "&funcNodeId=" + funcNodeId;
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