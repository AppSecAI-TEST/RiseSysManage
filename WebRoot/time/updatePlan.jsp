<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String time=request.getParameter("time");
	String createMonthId=request.getParameter("createMonthId");
	String schoolId=request.getParameter("schoolId");
	String flag=request.getParameter("flag");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  	<style>
		.table-c table{border-right:1px solid  #9370DB ;border-bottom:1px solid  #9370DB }
		.table-c table td{border-left:1px solid  #9370DB ;border-top:1px solid  #9370DB }
	</style>
  	<body>
		<input type="hidden" id="handlerId" name="handlerId"   value="${sessionScope.StaffT.staffId}"/>
		<input type="hidden" id="schoolId" name="schoolId"   value="<%=schoolId%>"/> 
		<div style="margin-right:5px;">
			<table class="search_tab">
				<tr>
					<td width="80px" align="right">
						<span>排课月份：</span>
					</td>
					<td width="80px" align="left">
						 <%=time%>
					</td>
					<td  align="left">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="width:100px; height: 25px;" id="refreshPlan" funcNodeId="1001">刷新排课</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px" onclick="javascript:window.history.back()">返回</a>
					</td>
				</tr>
			</table>
		<div style="padding:5px 0;min-width:1100px; width:100%;">
			<table class="easyui-datagrid" title="排课" style="height:250px;" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false" id="weekDg" url="">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'schoolName',width:25,align:'center'">周</th>
						<th data-options="field:'month',width:25,align:'center'">时间段</th>
						<th data-options="field:'staffName',width:25,align:'center'">是否排课</th>
						<th data-options="field:'createDate',width:25,align:'center'">操作</th>
					</tr>
				</thead>
			</table>
			<table id="hoursPlanTab" class="easyui-datagrid" title="排课信息" style="height:auto;min-max:1100px;" pagination="false" rownumbers="true" fitColumns="true" >
			 <thead>
			 	<tr align="center">
				    <th data-options="field:'className',width:78,align:'center'" rowspan="2"><span>班级</span></td>
				    <th data-options="field:'byname',width:90,align:'center'" rowspan="2"><span>带班老师</span></td>
				    <th data-options="field:'dateRange',width:240,align:'center'" rowspan="2"><span>上课时段</span></td>
				    <th data-options="field:'startDate',width:86,align:'center'" rowspan="2"><span>开课日期</span></td>
				    <th data-options="field:'finishDate',width:86,align:'center'" rowspan="2"><span>结课日期</span></td>
				    <th data-options="field:'realHour',width:60,align:'center'" rowspan="2"><span>上月已上<br>课时</span></td>
				    <th data-options="field:'diffNum',width:60,align:'center'" rowspan="2"><span>上月剩余<br>课时数</span></td>
				    <th data-options="field:'monthDiffNum',width:60,align:'center'" rowspan="2"><span>上月课时<br>差异</span></td>
				    <th data-options="field:'week1',width:62,align:'center'" colspan="2"><span>第一周</span></td>
				    <th data-options="field:'week2',width:62,align:'center'" colspan="2"><span>第二周</span></td>
				    <th data-options="field:'week3',width:62,align:'center'" colspan="2"><span>第三周</span></td>
				    <th data-options="field:'week4',width:62,align:'center'" colspan="2"><span>第四周</span></td>
				    <th data-options="field:'week5',width:62,align:'center'" colspan="2"><span>第五周</span></td>
				    <th data-options="field:'monthPlanHours',width:48,align:'center'" rowspan="2"><span>本月计<br>划课时</span></td>
				    <th data-options="field:'monthHandNum',width:48,align:'center'" rowspan="2"><span>本月已<br>排课时</span></td>
				    <th data-options="field:'mDiffNum',width:48,align:'center'" rowspan="2"><span>课时<br>差异</span></td>
				 </tr>
				 <tr align="center">
				    <th data-options="field:'weekPlan1',width:35,align:'center'"><span>计划<br>课时</span></td>
				    <th data-options="field:'weekHand1',width:35,align:'center'"><span>已排<br>课时</span></td>
				    <th data-options="field:'weekPlan2',width:35,align:'center'"><span>计划<br>课时</span></td>
				    <th data-options="field:'weekHand2',width:35,align:'center'"><span>已排<br>课时</span></td>
				    <th data-options="field:'weekPlan3',width:35,align:'center'"><span>计划<br>课时</span></td>
				    <th data-options="field:'weekHand3',width:35,align:'center'"><span>已排<br>课时</span></td>
				    <th data-options="field:'weekPlan4',width:35,align:'center'"><span>计划<br>课时</span></td>
				    <th data-options="field:'weekHand4',width:35,align:'center'"><span>已排<br>课时</span></td>
				    <th data-options="field:'weekPlan5',width:35,align:'center'"><span>计划<br>课时</span></td>
				    <th data-options="field:'weekHand5',width:35,align:'center'"><span>已排<br>课时</span></td>
				 </tr>
			  <thead>
		</table>
		</div>
		</div>
 	</body>
</html>
<script type="text/javascript">

$("#refreshPlan").click(function()
{
	var param={};
	param.handlerId=$("#handlerId").val();
	param.schoolId=$("#schoolId").val();
	param.month='<%=time%>';
	$.ajax(
	{
		type : "POST",
		url: "/sys/time/refreshPlan.do?",
		data: "param="+JSON.stringify(param),
		async: true,
		dataType:"json",
		beforeSend: function()
    	{
    		$.messager.progress({text:'排课中，请稍候...'});
    	},
    	success: function(data) 
    	{
    		$.messager.progress('close');
    		showMessage('提示', "刷新排课成功", null);
         },
        error:function()
        {
        	$.messager.progress('close');
        }
	});


});

init();
function init()
{
	var param={};
	param.createMonthId='<%=createMonthId%>';
	param.funcNodeId='50015';
   
	$('#weekDg').datagrid({
    fitColumns:true,  
    singleSelect: true,  
    url: "/sys/pubData/qryDataListByPage.do?param="+JSON.stringify(param),
    columns:[[  
        {field:'weekName',title:'周',width:25,align:'center'},  
        {field:'dateRange',title:'时间段',width:25,align:'center'},  
        {field:'isPlan',title:'是否排课',width:25,align:'center'},  
        {field:'createDdate',title:'操作',width:25,align:'center', 
            formatter: function(Confirmation, row)
            {  
                var btn = '<a class="editcls" onclick="planWeek(\''+row.weekName+'\',\''+row.dateRange+'\',\''+row.month+'\',\''+row.createWeekId+'\',\''+row.schoolId+'\')"  href="javascript:void(0)">排课</a>';  
                return btn;  
            }  
        }  
    ]],  
    onLoadSuccess:function(data){  
        $('.editcls').linkbutton({text:'排课',plain:true,iconCls:'icon-edit'});  
    }  
}); 
	plan();
}
 
function plan()
{
	$.ajax(
	{
		type : "POST",
		url: "/sys/time/hoursPlan.do?schoolId="+'<%=schoolId%>'+"&month="+'<%=time %>',
		async: true,
		dataType:"json",
		beforeSend: function()
    	{
    		//$.messager.progress({text:'排课中，请稍候...'});
    	},
    	success: function(data) 
    	{
    		$.messager.progress('close');
    		var dataobj ={
			   rows:data,
			   total:data.length
			}
			$("#hoursPlanTab").datagrid("loadData",dataobj);
         },
        error:function()
        {
        	$.messager.progress('close');
        }
	});
}
  
function planWeek(weekSeq,dateRange,month,createWeekId,schoolId)
{
	$.ajax(
	{
		type : "POST",
		url: "/sys/time/updateCreateWeek.do?",
		data: "createWeekId="+createWeekId,
		async: true,
		dataType:"json",
		beforeSend: function()
    	{
    		$.messager.progress({title : '系统消息', msg : '处理中，请稍待……'});
    	},
    	success: function(data) 
    	{
    		$.messager.progress('close');
    			window.location.href="/sys/time/planTime.jsp?month="+month+"&weekSeq="+weekSeq+"&createWeekId="+createWeekId+"&dateRange="+dateRange+"&schoolId="+schoolId+"&flag="+'<%=flag%>';
        },
        error:function()
        {
        	$.messager.progress('close'); 
        }
	});

}
</script>
