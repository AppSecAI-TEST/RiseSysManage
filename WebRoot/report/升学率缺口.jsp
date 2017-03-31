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
  			<input type="hidden" id="resourceId" value="711"/>
	  		<input type="hidden" id="higherType" value="gap"/>
	  		<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId}"/>
  			<input type="hidden" id="staffSchoolId" value="${sessionScope.StaffT.schoolId }"/>
  			<input type="hidden" id="staffPost" value="${sessionScope.StaffT.post }"/>
  			<form id="qryFm">
	  			<table class="search_tab">
	  				<tr>
	  					<td align="right" width="50px"><span>校区：</span></td>
	  					<td width="100px">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        	</select>
						</td>
	  					<td align="right" width="50px"><span>年度：</span></td>
						<td width="100px">
							<select class="easyui-combobox" name="year" id="year" style="width:100px;height: 25px;" 
								editable="false" data-options="valueField:'val',textField:'text'">
							</select>
						</td>
						<td align="right" width="50px"><span>季度：</span></td>
						<td width="114px">
							<select id="quarter" name="quarter" class="easyui-combobox" style="width: 114px; height: 25px;" editable="false">
	  						</select>
						</td>
	  					<td align="left" colspan="2" width="400px">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1094">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
	  				</tr>
	  			</table>
  			</form>
			<table class="easyui-datagrid" style="height:auto;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th data-options="field:'schoolName',width:100,align:'center'">校区</th>
							<th data-options="field:'quarterGoalHigherBaseNum',width:100,align:'center'"><div id="goal"></div></th>
							<th data-options="field:'1MonthHigherRate',width:100,align:'center'"><div id="1_month"></div></th>
							<th data-options="field:'1MonthGoalHigherBaseNum',width:100,align:'center'"><div id="1_month_goal"></div></th>
							<th data-options="field:'2MonthHigherRate',width:100,align:'center'"><div id="2_month"></div></th>
							<th data-options="field:'2MonthGoalHigherBaseNum',width:100,align:'center'"><div id="2_month_goal"></div></th>
							<th data-options="field:'3MonthHigherRate',width:100,align:'center'"><div id="3_month"></div></th>
							<th data-options="field:'3MonthGoalHigherBaseNum',width:100,align:'center'"><div id="3_month_goal"></div></th>
							<th data-options="field:'quarterHigherBaseNum',width:100,align:'center'">升学基数</th>
							<th data-options="field:'quarterHigherRate',width:100,align:'center'"><div id="rate"></div></th>
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
			if($("#list_data").datagrid("getData").total>0)
			{
				var fileName =parent.$("li.tabs-selected").find("span.tabs-title").html();
				try
				{
					window.location.href="/sys/export/exportLackOfGradRate.do?fileName="+fileName+"&year="+$("#year").datebox("getValue")+"&quarter="+$("#quarter").combobox("getValue")+"&param="+JSON.stringify($("#list_data").datagrid("options").queryParams.param);
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
		});
</script>