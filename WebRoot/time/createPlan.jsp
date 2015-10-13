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
		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
		<form id="qryFm" style="margin:0 auto;">
			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:30px;" cellspacing="2">
				<tr>
					 
					<td align="right">
						<span>排课月份：</span>
					</td>
					<td width="8px">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTime" name="startTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center" colspan="2">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1000">查询</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
					</td>
				</tr>
			</table>
		</form>
		<div style="padding:5px 0;min-width:1100px; width:100%;">
			<table  class="easyui-datagrid" title="排课" style="height:435px;" id="weekDg" url=""></table>
		</div>
	 
 	</body>
</html>
<script type="text/javascript">
init();
function init()
{
$('#weekDg').datagrid({  
	 border:false,  
    fitColumns:true,  
    singleSelect: true,  
   url: "/sys/time/getWeek.do?param={'month':'10','week':'1'}",
    columns:[[  
        {field:'weekName',title:'周',width:80},  
        {field:'date',title:'时间段',width:25},  
        {field:'isPlan',title:'是否排课',width:25},  
         {field:'createDdate',title:'创建时间',width:25, 
            formatter: function(Confirmation, row)
            {  
                var btn = '<a class="editcls" onclick="planWeek(\''+row.weekTime+'\',\''+row.date+'\')"  href="javascript:void(0)">排课</a>';  
                return btn;  
            }  
        }  
    ]],  
    onLoadSuccess:function(data){  
        $('.editcls').linkbutton({text:'排课',plain:true,iconCls:'icon-edit'});  
    }  
});  
}
 
  
function planWeek(weekTime,date)
{
			window.location.href="/sys/time/planTime.jsp";
}
</script>