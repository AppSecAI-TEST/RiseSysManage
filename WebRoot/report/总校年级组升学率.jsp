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
    		<form id="qryFm" style="margin:0 auto;">
	    		<input type="hidden" id="higherType" value="allStage"/>
    			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId }"/>
    			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:80px;" cellspacing="2">
  					<tr>
						<td align="right" width="50px"><span>阶段：</span></td>
	  					<td width="114px">
							<select id="stageId" name="stageId" class="easyui-combobox" style="width: 114px; height: 25px;"
								data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'" 
			      				url="<%=path %>/pubData/qryStage.do">
				        	</select>
						</td>
						<td align="right" width="50px"><span>年度：</span></td>
						<td width="114px">
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="year" name="year" data-options="formatter:yearFormatter, parser:yearParser"/>
						</td>
						<td align="right" width="130px"><span>课时进度比：</span></td>
	  					<td width="130px">
	  						<input name="minAttendRate" id="minAttendRate" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
							<span style="display: inline-block; text-align: center; width: 14px;">至</span>
							<input name="maxAttendRate" id="maxAttendRate" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
	  					</td>
	  					<td align="left" width="400px">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1055">查询</a>
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
							<th data-options="field:'schoolName',width:100,align:'center',rowspan:2">校区</th>
							<th data-options="field:'finish',width:500,align:'center',colspan:5">已结课</th>
							<th data-options="field:'attend',width:500,align:'center',colspan:5"><div id="classProgress">未结课</div></th>
						</tr>
						<tr>
							<th data-options="field:'stageId',width:100,align:'center'">阶段</th>
							<th data-options="field:'finishClassNum',width:100,align:'center'">班级数</th>
							<th data-options="field:'finishClassHigherBaseNum',width:100,align:'center'">年级组总基数</th>
							<th data-options="field:'finishClassHigherNum',width:100,align:'center'">年级组总升学</th>
							<th data-options="field:'finishClassAvgRate',width:100,align:'center'">平均升学率</th>
							<th data-options="field:'attendClassNum',width:100,align:'center'">班级数</th>
							<th data-options="field:'attendClassStudentNum',width:100,align:'center'">在读人数</th>
							<th data-options="field:'attendClassHigherBaseNum',width:100,align:'center'">年级组总基数</th>
							<th data-options="field:'attendClassHigherNum',width:100,align:'center'">年级组总升学</th>
							<th data-options="field:'attendClassAvgRate',width:100,align:'center'">平均升学率</th>
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
					window.location.href="/sys/export/exportCenterGradeRate.do?fileName="+fileName+"&param="+JSON.stringify($("#list_data").datagrid("options").queryParams.param);
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