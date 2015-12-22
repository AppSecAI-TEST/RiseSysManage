<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String time=request.getParameter("time");
	String createMonthId=request.getParameter("createMonthId");
	String schoolId=request.getParameter("schoolId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  
  	<body>
		<input type="hidden" id="handlerId" name="handlerId"   value="${sessionScope.StaffT.staffId}"/>
		 
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
			<table  class="easyui-datagrid" title="排课" style="height:435px;" toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false" id="weekDg" url=""></table>
		</div>
	 
 	</body>
</html>
<script type="text/javascript">
init();
function init()
{
	var param={};
//	param.handlerId=$("#handlerId").val();
	//param.schoolId='<%=schoolId%>';
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
        {field:'createDdate',title:'创建时间',width:25,align:'center', 
            formatter: function(Confirmation, row)
            {  
                var btn = '<a class="editcls" onclick="planWeek(\''+row.weekName+'\',\''+row.month+'\',\''+row.createWeekId+'\')"  href="javascript:void(0)">排课</a>';  
                return btn;  
            }  
        }  
    ]],  
    onLoadSuccess:function(data){  
        $('.editcls').linkbutton({text:'排课',plain:true,iconCls:'icon-edit'});  
    }  
});  
}
 
  
function planWeek(weekSeq,month,createWeekId)
{
	window.location.href="/sys/time/planTime.jsp?month="+month+"&weekSeq="+weekSeq+"&createWeekId="+createWeekId;
}
</script>
