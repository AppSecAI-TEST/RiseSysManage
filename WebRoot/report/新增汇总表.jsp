<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/newSummary.js"></script>
  	</head>
  
  	<body>
  		<div style="padding:5px 0;">
  			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId }"/>
  			<form id="qryFm">
  				<table class="search_tab">
  					<tr>
  						<td align="right" style="min-width: 50px"><span>校区：</span></td>
	  					<td style="min-width: 100px">
							<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;">
				        	</select>
						</td>
						<td align="right" style="min-width: 50px"><span>日期：</span></td>
						<td style="min-width: 220px; width: 220px">
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimePay" name="startTimePay" data-options="formatter:myformatter, parser:myparser"/>
							至
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimePay" name="endTimePay" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="center" style="min-width: 210px">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1082">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
						<td width="400px">&nbsp;</td>
  					</tr>
  				</table>
  			</form>
  			<table class="easyui-datagrid" title="查询结果" style="height: 435px" id="list_data" 
				toolbar="#toolbar" pagination="false" rownumbers="false" fitColumns="true">
				<thead>
					<tr>
				  		<th field="schoolName" align="center" width="5%" rowspan="2">校区</th>
				  		<th field="userName" align="center" width="6%" rowspan="2">课程顾问</th>
				  		<th field="planNum" align="center" width="8%" rowspan="2">计划新增个数</th>
				  		<th field="newTotalNum" align="center" width="6%" rowspan="2">新增个数</th>
				  		<th field="stageInfo" align="center" width="5%" colspan="10">报名阶段</th>
				  		<th field="refundCourseNum" align="center" width="6%" rowspan="2">退费个数</th>
						<th field="refundYearNum" align="center" width="6%" rowspan="2">退费年数</th>
						<th field="realityNum" align="center" width="8%" rowspan="2">实际完成个数</th>
						<th field="rate" align="center" width="7%" rowspan="2">个数完成率</th>
				  	</tr>
				  	<tr>
				  		<th field="Pre-K" align="center" width="5%" >Pre-K</th>
						<th field="K" align="center" width="5%" >K</th>
						<th field="PreRISE" align="center" width="8%">PreRISE</th>
						<th field="S1" align="center" width="5%">S1</th>
						<th field="S2" align="center" width="5%">S2</th>
						<th field="S3" align="center" width="5%">S3</th>
						<th field="S4" align="center" width="5%">S4</th>
						<th field="S5" align="center" width="5%">S5</th>
						<th field="PreMiddle" align="center" width="10%">PreMiddle</th>
						<th field="RiseUp" align="center" width="8%">RiseUp</th>
				  	</tr>
				</thead>
			</table>
			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出</a>
			</div>
  		</div>
  	</body>
</html>
<script type="text/javascript">
	$("#export").click(function(){
		if($("#list_data").datagrid("getData").total>0)
		{
			var fileName =parent.$("li.tabs-selected").find("span.tabs-title").html();
			try
			{
				window.location.href="/sys/export/exportDataInModel.do?fileName="+fileName+"&mergeName=schoolId&mergeIndex=0&param="+JSON.stringify($("#list_data").datagrid("getData").rows);
			}
			catch(e)
			{
				$.messager.alert('提示', "模版不存在！",function(){
					window.history.back();
				});
			}
		}
		else
		{
			$.messager.alert('提示', "没有数据可以导出！");
		}	
	})
</script>