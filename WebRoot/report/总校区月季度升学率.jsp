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
  		<div style="padding:5px 0;">
  			<input type="hidden" id="higherType" value="allQuarter"/>
  			<form id="qryFm" style="margin:0 auto;">
  				<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:80px;" cellspacing="2">
  					<tr>
						<td align="right" width="50px"><span>年度：</span></td>
						<td width="100px">
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="year" name="year" data-options="formatter:yearFormatter, parser:yearParser"/>
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
						<td align="left" colspan="2" width="400px">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1056">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
  					</tr>
  				</table>
  			</form>
  			<div style="padding:5px 0;min-width:1100px; width:100%;">
  				<table class="easyui-datagrid" style="height:auto;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th data-options="field:'finish',width:600,align:'center',colspan:6"><div id="yearDiv" style="display: inline-block;"></div>月度/季度升学率</th>
						</tr>
						<tr>
							<th data-options="field:'schoolName',width:100,align:'center'">校区</th>
							<th data-options="field:'month',width:100,align:'center'">月份</th>
							<th data-options="field:'monthHigherBaseNum',width:100,align:'center'">升学基数</th>
							<th data-options="field:'monthHigherNum',width:100,align:'center'">已升人数</th>
							<th data-options="field:'monthHigherRate',width:100,align:'center'">月度升学率</th>
							<th data-options="field:'quarterHigherRate',width:100,align:'center'">季度升学率</th>
						</tr>
					</thead>
				</table>
  			</div>
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
					window.location.href="/sys/export/exportCenterMSRate.do?fileName="+fileName+"&year="+$("#yearDiv").html()+"&param="+JSON.stringify($("#list_data").datagrid("options").queryParams.param);
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