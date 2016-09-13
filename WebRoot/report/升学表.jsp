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
		<script type="text/javascript">
			$(document).ready(function() {
				$("#year").datebox({
					onShowPanel: settingYearMonthPanel
				});
			});
			function myformatter(date){
            	var y = date.getFullYear();
            	var m = date.getMonth()+1;
            	var d = date.getDate();
            	return y+'-'+(m<10?('0'+m):m);
        	}

  			function myparser(s){
	            if (!s) return new Date();
	            var ss = (s.split('-'));
	            var y = parseInt(ss[0],10);
	            var m = parseInt(ss[1],10);
	            var d = parseInt(ss[2],10);
	            if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
	                return new Date(y,m-1,d);
	            } else {
	                return new Date();
	            }
        	}
		</script>
  	</head>
  
  	<body>
  		<div style="margin-right:5px;">
  			<input id="staffId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<input type="hidden" id="resourceId" value="731">
  			<form id="qryFm">
  				<table align="center" class="search_tab">
  					<tr>
  						<td align="right" style="min-width: 50px"><span>校区：</span></td>
	  					<td style="min-width: 100px">
							<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;">
				        	</select>
						</td>
						<td align="right" style="min-width: 50px"><span>月份：</span></td>
						<td style="min-width: 100px">
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="year" name="year" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="left" colspan="2" width="400px">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1061">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
  					</tr>
  				</table>
  			</form>
  				<table class="easyui-datagrid" style="height:435px;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th data-options="field:'schoolName',width:100,align:'center'">校区</th>
							<th data-options="field:'payDate',width:100,align:'center'">全费日期</th>
							<th data-options="field:'stageId',width:100,align:'center'">缴费阶段</th>
							<th data-options="field:'courseStateText',width:100,align:'center'">课程状态</th>
							<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
							<th data-options="field:'amount',width:150,align:'center'">缴费金额</th>
							<th data-options="field:'className',width:100,align:'center'">班级</th>
							<th data-options="field:'adviserTeacherName',width:150,align:'center'">业绩老师</th>
							<th data-options="field:'giftName',width:300,align:'center'">赠品</th>
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
	exportLink("export","list_data");
	var staffId = $("#staffId").val();
	var resourceId = $("#resourceId").val();
	$("#schoolId").combobox({
		url : "/sys/pub/pageCategory.do?staffId=" + staffId + "&resourceId=" + resourceId + "&fieldId=schoolId",//返回json数据的url
    	valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
    	onLoadSuccess:function(data) {
    		if(data.length == 1) {
				$('#schoolId').combobox('setValue', data[0].schoolId);
			}
    	}
	});
</script>