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
			<table   style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:30px;" cellspacing="2">
				<tr>
					<td width="80px" align="right">
						<span>排课月份：</span>
					</td>
					<td  align="left">
						 <%=time %>
					</td>
					
				</tr>
			</table>
		 
 
		<div style="padding:5px 0;min-width:1100px; width:100%;">
			<table class="easyui-datagrid" title="排课" style="height:250px;" toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false" id="weekDg" url="">
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
		</div>
		
	 <div style="min-width:1100px;width:99%;margin:0 auto;">
		<div class="easyui-panel" title="排课信息" style="width:100%;overflow:auto;">
		<table class="maintable" id="hoursPlanTab" style="width:1500px;"  cellspacing="0" cellpadding="0">
		  <tr align="center">
		    <td align="center" width="40px;" rowspan="2"><span>序号</span></td>
		    <td align="center" width="78px;" rowspan="2"><span>班级</span></td>
		    <td align="center" width="96px;" rowspan="2"><span>带班老师</span></td>
		    <td align="center" width="160px;"rowspan="2"><span>上课时段</span></td>
		    <td align="center" width="86px;" rowspan="2"><span>开课日期</span></td>
		    <td align="center" width="86px;" rowspan="2"><span>结课日期</span></td>
		    <td align="center" width="42px;" rowspan="2"><span>上月已上课时</span></td>
		    <td align="center" width="42px;" rowspan="2"><span>上月剩余课时数</span></td>
		    <td align="center" width="42px;" rowspan="2"><span>上月课时差异</span></td>
		    <td align="center" width="62px;" colspan="2"><span>第一周</span></td>
		    <td align="center" width="62px;" colspan="2"><span>第二周</span></td>
		    <td align="center" width="62px;" colspan="2"><span>第三周</span></td>
		    <td align="center" width="62px;" colspan="2"><span>第四周</span></td>
		    <td align="center" width="62px;" colspan="2"><span>第五周</span></td>
		    <td align="center" width="48px;" rowspan="2"><span>本月计划课时</span></td>
		    <td align="center" width="48px;" rowspan="2"><span>本月已排课时</span></td>
		    <td align="center" width="48px;" rowspan="2"><span>课时差异</span></td>
		  </tr>
		  <tr align="center">
		    <td align="center" width="40px;"><span>计划课时</span></td>
		    <td align="center" width="40px;"><span>已排课时</span></td>
		    <td align="center" width="40px;"><span>计划课时</span></td>
		    <td align="center" width="40px;"><span>已排课时</span></td>
		    <td align="center" width="40px;"><span>计划课时</span></td>
		    <td align="center" width="40px;"><span>已排课时</span></td>
		    <td align="center" width="40px;"><span>计划课时</span></td>
		    <td align="center" width="40px;"><span>已排课时</span></td>
		    <td align="center" width="40px;"><span>计划课时</span></td>
		    <td align="center" width="40px;"><span>已排课时</span></td>

		  </tr>
		</table>
		</div>
		</div>
 	</body>
</html>
<script type="text/javascript">
init();
function init()
{
	var param={};
	param.createMonthId='<%=createMonthId%>';
	param.funcNodeId='50015';
   
	$('#weekDg').datagrid({
	border:false,  
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
    		var html="<tr>"+$("#hoursPlanTab").find("tr:eq(0)").html()+"</tr><tr>"+$("#hoursPlanTab").find("tr:eq(1)").html()+"</tr>";
    		for(var i=0;i<data.length;i++)
    		{
    			var obj=data[i];
    			 html+="<tr>";
    			html+="<td align='center'>"+(i+1)+"</td>";
    			html+="<td align='center'><span>"+obj.className+"</span></td>";
    			html+="<td align='center'><span>"+obj.byname+"</span></td>";
    			html+="<td align='center'><span>"+obj.dateRange+"</span></td>";
    			html+="<td align='center'><span>"+obj.startDate+"</span></td>";
    			html+="<td align='center'><span>"+obj.finishDate+"</span></td>";
    			html+="<td align='center'><span>"+obj.realHour+"</span></td>";
    			html+="<td align='center'><span>"+obj.diffNum+"</span></td>";
    			html+="<td align='center'><span>"+obj.monthDiffNum+"</span></td>";
    			html+="<td align='center'><span>"+obj.weekPlan1+"</span></td>";
    			html+="<td align='center'><span>"+obj.weekHand1+"</span></td>";
    			html+="<td align='center'><span>"+obj.weekPlan2+"</span></td>";
    			html+="<td align='center'><span>"+obj.weekHand2+"</span></td>";
    			html+="<td align='center'><span>"+obj.weekPlan3+"</span></td>";
    			html+="<td align='center'><span>"+obj.weekHand3+"</span></td>";
    			html+="<td align='center'><span>"+obj.weekPlan4+"</span></td>";
    			html+="<td align='center'><span>"+obj.weekHand4+"</span></td>";
    			html+="<td align='center'><span>"+obj.weekPlan5+"</span></td>";
    			html+="<td align='center'><span>"+obj.weekHand5+"</span></td>";
    			html+="<td align='center'><span>"+obj.monthPlanHours+"</span></td>";
    			html+="<td align='center'><span>"+obj.monthHandHours+"</span></td>";
    			html+="<td align='center'><span>"+obj.mDiffNum+"</span></td>";
    			html+="</tr>";
    		}
			
			$("#hoursPlanTab").html(html);
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
