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
	  		<input type="hidden" id="higherType" value="allRegion"/>
	  		<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId }"/>
  			<form id="qryFm">
	  			<table class="search_tab">
	  				<tr>
	  					<td align="right" width="50px"><span>片区：</span></td>
	  					<td width="114px">
	  						<select id="regionId" name="regionId" class="easyui-combobox" style="width: 114px; height: 25px;"
	  							data-options="formatter:function(row){return '<span>'+row.regionName+'</span>';}, valueField: 'regionId', textField: 'regionName', panelHeight: 'auto'" 
			      				url="<%=path %>/pubData/qryRegionList.do">
				        	</select>
	  					</td>
	  					<td align="right" width="50px"><span>年度：</span></td>
	  					<td width="114px">
	  						<select class="easyui-combobox" name="year" id="year" style="width:100px;height: 25px;" 
								editable="false" data-options="valueField:'val',textField:'text'">
							</select>
	  					</td>
	  					<td align="right" width="50px"><span>季度：</span></td>
	  					<td width="114px">	
	  						<select id="quarter" name="quarter" class="easyui-combobox" style="width: 114px; height: 25px;">
	  						</select>
	  					</td>
	  					<td align="right" width="50px"><span>月度：</span></td>
	  					<td width="114px">
	  						<select id="month" name="month" class="easyui-combobox" style="width: 114px; height: 25px;"
								data-options="formatter:function(row){return '<span>'+row.monthText+'</span>';}, 
								valueField: 'month', textField: 'monthText', panelHeight: 'auto'"
			      				url="<%=path %>/pubData/qryMonthList.do?quarter=">
	  						</select>
	  					</td>
	  					<td align="left" colspan="2">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1057">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
	  				</tr>
	  			</table>
  			</form>
				<table class="easyui-datagrid" style="height:auto;" id="list_data" data-options="onLoadSuccess: onLoadSuccess"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th data-options="field:'regionName',width:100,align:'center'">片区</th>
							<th data-options="field:'month',width:100,align:'center'">月份</th>
							<th data-options="field:'monthHigherBaseNum',width:100,align:'center'">在读人数</th>
							<th data-options="field:'monthHigherNum',width:100,align:'center'">已升人数</th>
							<th data-options="field:'monthHigherRate',width:100,align:'center'">月度升学率</th>
							<th data-options="field:'quarterHigherRate',width:100,align:'center'">季度升学率</th>
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
					window.location.href="/sys/export/exportRegionGradRate.do?fileName="+fileName+"&param="+JSON.stringify($("#list_data").datagrid("options").queryParams.param);
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
		