<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/pub/js/json.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json2.js"></script>
		<script type="text/javascript" src="<%=path %>/js/teacherManage.js"></script>
  	</head>
  	<body>
 		<form id="qryFm">
  			<table  align="center"   style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:5px;font-family:'微软雅黑'" cellspacing="15">
  				<tr>
  					<td align="right" width="75px">校　　区：</td>
  					<td>
  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width:120px;height:25px"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
				      		url="<%=path %>/pubData/qrySchoolList.do">
        				</select>
  					</td>
  						<td align="right">
						<span>日期：</span>
					</td>
					<td align="right" >
						<input class="easyui-datebox" type="text" required="true" style="width:100px; height: 25px;" id="startTime" name="startTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center">
						<span>至</span>
					</td>
					<td >
						<input class="easyui-datebox" required="true" type="text" style="width:100px; height: 25px;" id="endTime" name="endTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
  				 
  				<td align="center" colspan="10">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1000">查询</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
					</td>
  				</tr>
  			</table>
 		</form>
 		 
		<table   align="center" title="查询结果" data-options="height:500" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			 
		</table>
  		</div>
  		
  	</body>
</html>
<script type="text/javascript">


$("#qryBtn").click(function(){
	
	var startDate=$("#startTime").datebox("getValue");
	var endDate=$("#endTime").datebox("getValue");
	if(startDate=='' || endDate=='')
	{
		$.messager.alert('提示', "请您选择查询开始时间和结束时间");
		return;
	}
	var date=AddDays(startDate,6);
	startDate=AddDays(startDate,0);
	endDate=AddDays(endDate,0);
	if(endDate>date)
	{
		$.messager.alert('提示', "开始、结束时间间隔大于7天,请重新选择");
		return;
	}
	var obj = JSON.stringify($("#qryFm").serializeObject());
	$('#list_data').datagrid({  
		border:false,  
	    fitColumns:true,  
	    singleSelect: true,  
	    url: "/sys/time/getRoomPlan.do?param="+obj,
	    columns:[[  
	        {field:'schoolName',title:'校区',align:'center',width:40},
	        {field:'roomName',title:'教室',align:'center',width:40},
	        {field:'day0',title:startDate,align:'center',width:80},  
	        {field:'day1',title:AddDays(startDate,1),align:'center',width:80},  
	        {field:'day2',title:AddDays(startDate,2),align:'center',width:80},  
	        {field:'day3',title:AddDays(startDate,3),align:'center',width:80},  
	        {field:'day4',title:AddDays(startDate,4),align:'center',width:80},  
	        {field:'day5',title:AddDays(startDate,5),align:'center',width:80},
	        {field:'day6',title:AddDays(startDate,6),align:'center',width:80} 
	    ]],  
	    onLoadSuccess:function(data)
	    {  
	         
	    }  
	});  
	
});


</script>