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
  		<input id="staffId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<input type="hidden" id="resourceId" value="729">
  		<div style="margin-right:5px;">
  			<form id="qryFm">
	  			<table class="search_tab">
	  				<tr>
	  					<td align="right" width="80px"><span>校区：</span></td>
	  					<td align="left"  width="110px">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
					      		
				        	</select>
	  					</td>
	  					<td width="60px" align="right"><span>日期：</span></td>
						<td width="260px">
							<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="startTime" name="startTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
								至
							<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="endTime" name="endTime"  editable="false" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="left">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="3700">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
	  				</tr>	
	  			</table>
  			</form>
				<table class="easyui-datagrid" style="height:435px;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th field="schoolName" align="center" width="5%">校区</th>
							<th field="payDate" align="center" width="8%">缴费日期</th>
							<th field="stageId" align="center" width="8%">缴费阶段</th>
							<th field="studentName" align="center" width="8%">学员姓名</th>
							<th field="amount" align="center" width="8%">缴费金额</th>
							<th field=channelName align="center" width="10%">来源渠道</th>
							<th field="actType" align="center" width="10%">活动类型</th>
							<th field="activityDate" align="center" width="10%">活动时间</th>
							<th field="activityName" align="center" width="10%">活动名称</th>
							<th field="teacherName" align="center" width="15%">老师</th>
							<th field="stuName" align="center" width="10%">转介绍学员</th>
							<th field="studentNbr" align="center" width="15%">转介绍学员身份证</th>
							<th field="className" align="center" width="10%">班级</th>
							<th field="cc1" align="center" width="10%">CC1</th>
							<th field="cc2" align="center" width="10%">CC2</th>
							<th field="giftName" align="center" width="15%">赠品</th>
						</tr>
					</thead>
				</table>
			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export"  class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
			</div>
  		</div>
  		<div id="dlg" class="easyui-dialog" style="width: 900px; height: auto;" closed="true" data-options="modal:true">
  			<form id="studentFm">
				<table class="easyui-datagrid" style="width: 100%;height: auto; overflow: auto;" id="list_data"  
					pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th data-options="field:'payDate',width:100,align:'center'">缴费日期</th>
							<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
							<th data-options="field:'studentChannelType',width:100,align:'center'">学员来源</th>
							<th data-options="field:'identityId',width:150,align:'center'">本人身份证号</th>
							<th data-options="field:'phone',width:150,align:'center'">联系方式</th>
							<th data-options="field:'adviserName',width:150,align:'center'">业绩顾问</th>
							<th data-options="field:'adviserTeacherName',width:150,align:'center'">业绩老师</th>
						</tr>
					</thead>
				</table>
  			</form>
		</div>
  	</body>
</html>
<script>
		initReportButton("reset","qryFm","schoolId");
	 	$("#qryBtn").click(function() {
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
</script>
