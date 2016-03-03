<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
  	</head>
  
  	<body>
  		<div style="margin-right:5px;">
  			<form id="qryFm">
	  			<input type="hidden" id="resourceId" value="717">
	  			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId }"/>
	  			<table class="search_tab">
	  				<tr>
	  					<td align="right" style="width: 70px"><span>校区：</span></td>
	  					<td style="width: 100px">
							<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        	</select>
						</td>
	  					<td align="right" style="width: 80px"><span>结课日期：</span></td>
	  					<td style="width: 225px">
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeFinish" name="startTimeFinish" data-options="formatter:myformatter, parser:myparser"/>
							至
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeFinish" name="endTimeFinish" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="left">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1048">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
	  				</tr>
	  			</table>
  			</form>
				<table class="easyui-datagrid" style="height:435px;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th data-options="field:'schoolName',width:100,align:'center'">校区</th>
							<th data-options="field:'inNum',width:100,align:'center'">一定进班人数</th>
							<th data-options="field:'totalNum',width:100,align:'center'">结课后进班总数</th>
							<th data-options="field:'inPercentage',width:100,align:'center'">一定结课进班占比</th>
							<th data-options="field:'avgWaitDays',width:100,align:'center'">一定进班平均等班时间（天）</th>
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
	$(document).ready(function(){
		var curr_time = new Date();
		$('#endTimeFinish').datebox('setValue', myformatter(curr_time));
		curr_time.setMonth(curr_time.getMonth() - 1);
		$('#startTimeFinish').datebox('setValue', myformatter(curr_time));
		$("#qryBtn").click(function() {
			if($('#endTimeFinish').datebox('getValue')==""||$('#startTimeFinish').datebox('getValue')=="")
			{
				showMessage("提示","结课日期起止时间不能为空",null);
				return false;
			}	
			var obj = JSON.stringify($("#qryFm").serializeObject());
		    obj = obj.substring(0, obj.length - 1);
		    var funcNodeId = $("#qryBtn").attr("funcNodeId");
		    obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
		    $("#list_data").datagrid({
		    	url : "/sys/pubData/qryDataListByPage.do",
		    	queryParams:{
		    		param : obj
		    	}
		    }); 
		
	    });
		initReportButton("reset","qryFm","schoolId")
		exportLink("export","list_data");
	})
</script>
