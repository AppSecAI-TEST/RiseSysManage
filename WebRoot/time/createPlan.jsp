<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
	
  	</head>
  
  	<body>
		<input type="hidden" id="handlerId" name="handlerId"   value="${sessionScope.StaffT.staffId}"/>
		<input type="hidden" id="schoolId" name="schoolId" value="${sessionScope.StaffT.schoolId}"/>
			<table   style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:30px;" cellspacing="2">
				<tr>
					<td  align="left">
						<span>排课月份：</span>
					</td>
					<td   align="left" width="8px">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="time" name="startTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="submit" funcNodeId="1000">创建</a>
					</td>
				</tr>
			</table>
		 
		<div style="padding:5px 0;min-width:1100px; width:100%;">
			<table  class="easyui-datagrid" title="排课" style="height:435px;" id="weekDg" url=""></table>
		</div>
	 
 	</body>
</html>
<script type="text/javascript">

$("#submit").click(function()
{
	var time=$("#time").datebox('getValue');
	var param={};
	param.handlerId=$("#handlerId").val();
	param.schoolId=$("#schoolId").val();
	param.month=time;
	$.ajax(
	{
		type : "POST",
		url: "/sys/time/getWeek.do?",
		data: "param="+JSON.stringify(param),
		async: false,
		dataType:"json",
		beforeSend: function()
    	{
    		$.messager.progress({title : '系统消息', msg : '正在提交数据，请稍等……'});
    	},
    	success: function(data) 
    	{
    		$.messager.progress('close');
    		if(data.flag)
    		{
    			init(data);
    		}else
    		{
    			alert(data.msg);
    		}
    		 
        },
        error:function()
        {
        	$.messager.progress('close'); 
        }
	});
	
});

function init(data)
{
	alert(JSON.stringify(data));
	
$('#weekDg').datagrid({  
	 border:false,  
    fitColumns:true,  
    singleSelect: true,  
    columns:[[  
        {field:'weekName',title:'周',width:80},  
        {field:'date',title:'时间段',width:25},  
        {field:'isPlan',title:'是否排课',width:25},  
        {field:'createDdate',title:'创建时间',width:25, 
            formatter: function(Confirmation, row)
            {  
                var btn = '<a class="editcls" onclick="planWeek(\''+row.weekTime+'\',\''+row.date+'\',\''+row.createWeekId+'\')"  href="javascript:void(0)">排课</a>';  
                return btn;  
            }  
        }  
    ]],  
    onLoadSuccess:function(data){  
        $('.editcls').linkbutton({text:'排课',plain:true,iconCls:'icon-edit'});  
    }  
});  
 $('#weekDg').datagrid("loadData",data);	
}
 
  
function planWeek(weekTime,date,createWeekId)
{
	$.ajax(
	{
		type : "POST",
		url: "/sys/time/updateCreateWeek.do?",
		data: "createWeekId="+createWeekId,
		async: false,
		dataType:"json",
		beforeSend: function()
    	{
    		$.messager.progress({title : '系统消息', msg : '正在提交数据，请稍等……'});
    	},
    	success: function(data) 
    	{
    		$.messager.progress('close');
        },
        error:function()
        {
        	$.messager.progress('close'); 
        }
	});
	window.location.href="/sys/time/planTime.jsp";
}
</script>