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
  		<input type="hidden" id="resourceId" value="731">
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
	  					<td align="right" style="min-width: 50px"><span>归属日期：</span></td>
						<td style="min-width: 220px;">
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimePay" name="startTimePay" editable="false" data-options="formatter:myformatter, parser:myparser"/>
							至
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimePay" name="endTimePay" editable="false" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="left">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="3705">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
	  				</tr>	
	  			</table>
  			</form>
				<table class="easyui-datagrid" style="height:550px;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th align="center" colspan="3"><span>学员信息</span></th>
							<th align="center" colspan="6"><span>报名缴费情况</span></th>
							<th align="center" colspan="7"><span>退费申请</span></th>
							<th align="center" align="center" rowspan="2" field="approveDate"><span>审批通过日期</span></th>
							<th align="center" align="center" rowspan="2" field="belongDate"><span>退费归属日期</span></th>
						</tr>
						<tr>
							<th field="schoolName" align="center" width="5%">校区</th>
							<th field="name" align="center" width="7%">学员姓名</th>
							<th field="phone" align="center" width="10%">家长电话</th>
							<th field="payDate" align="center" width="7%">报名日期</th>
							<th field="stageId" align="center" width="5%">报名阶段</th>
							<th field="amount" align="center" width="5%">报名金额</th>
							<th field="className" align="center" width="6%">在读班级</th>
							<th field="adviserName" align="center" width="10%">顾问</th>
							<th field="adviserTeacherName" align="center" width="10%">老师</th>
							<th field="refundType" align="center" width="5%">退费类别</th>
							<th field="stageId" align="center" width="5%">退费阶段</th>
							<th field="refundReason" align="center" width="20%">退费原因</th>
							<th field="applyDate" align="center" width="8%">退费申请日期</th>
							<th field="financialConfirmFee" align="center" width="8%">核定退费金额</th>
							<th field="refundChannel" align="center" width="8%">渠道</th>
							<th field="belongSchoolName" align="center" align="center" width="10%"><span>渠道资源归属校区</span></th>
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

 		initReportButton("reset","qryFm","schoolId");
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
	})

</script>