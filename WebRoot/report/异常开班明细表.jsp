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
  	</head>
  
  	<body>
  		<div style="padding:5px 0;">
  			<input type="hidden" id="type" value="detail"/>
  			<form id="qryFm" style="margin:0 auto;">
  				<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:80px;" cellspacing="2">
  					<tr>
  						<td align="right" width="50px"><span>校区：</span></td>
	  					<td width="114px">
							<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
					      		url="<%=path %>/pubData/qrySchoolList.do?schoolId=">
				        	</select>
						</td>
						<td align="right" width="50px"><span>阶段：</span></td>
	  					<td width="114px">
							<select id="stageId" name="stageId" class="easyui-combobox" style="width: 114px; height: 25px;"
								data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'" 
			      				url="<%=path %>/pubData/qryStage.do">
				        	</select>
						</td>
						<td align="right" width="120px"><span>异常开班数量：</span></td>
	  					<td width="130px">
	  						<input name="minOpenNum" id="minOpenNum" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
							<span style="display: inline-block; text-align: center; width: 14px;">至</span>
							<input name="maxOpenNum" id="maxOpenNum" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
	  					</td>
	  					<td align="right" width="100px"><span>开课日期：</span></td>
	  					<td width="100px">
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeOpen" name="startTimeOpen" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="center" width="14px"><span>至</span></td>
						<td width="100px">
							<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeOpen" name="endTimeOpen" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="left" width="250px">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1059">查询</a>
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
							<th data-options="field:'stageId',width:100,align:'center',rowspan:2">阶段</th>
							<th data-options="field:'exceptionOpenNum',width:100,align:'center',rowspan:2">异常开班数量</th>
							<th data-options="field:'finish',width:200,align:'center',colspan:2">异常开班明细</th>
							<th data-options="field:'exceptionAvgOpenNum',width:300,align:'center',rowspan:2">异常开班平均班级人数</th>
							<th data-options="field:'exceptionOpenRate',width:300,align:'center',rowspan:2">该阶段异常开班占比</th>
						</tr>
						<tr>
							<th data-options="field:'className',width:100,align:'center'">班级</th>
							<th data-options="field:'openClassNum',width:100,align:'center'">异常开班人数</th>
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
					window.location.href="/sys/export/exportExpClassDetai.do?fileName="+fileName+"&param="+JSON.stringify($("#list_data").datagrid("options").queryParams.param);
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