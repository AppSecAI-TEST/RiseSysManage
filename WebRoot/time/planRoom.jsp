<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% 
	String schoolId=request.getParameter("schoolId");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>RunJS</title>
			<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script class="resources library" src="/sys/pub/js/autoMergeCells.js" type="text/javascript"></script>
	
	<style type="text/css">
.tree-node-hover {
	text-decoration: none;
	color: #555555;
	background: #fae8bd;
}
.datagrid{
	margin:0 auto;
	min-width:50px;
	margin-top:5px;
	width:20%;
}


</style>
	</head>
	<body>
		<input type="hidden" id="schoolId" name="schoolId" value="${sessionScope.StaffT.schoolId}"/>
	            <div id="content" style="margin-left:6px;">
		            
				    	<table width="700"  cellpadding="0" border="0" style="border-collapse:collapse;overflow:scroll;" >
				    	<tr><td colspan="8" style="text-align:center;font-size:20px;color:##0E2D5F;font-weight:bold;">班级情况和教室资源统计表</td></tr>
				    	<tr>
				    		<td><table  id="t0"></table></td>
					    	<td>
					    	<table  id="t1"></table>
					    	</td>
					    	<td>
					    	<table  id="t2"></table>
					    	</td>
					    	<td>
					    	<table  id="t3"></table>
					    	</td>
					    	<td>
					    	<table  id="t4"></table>
					    	</td>
					    	<td>
					    	<table  id="t5"></table>
					    	</td>
					    	<td>
					    	<table  id="t6"></table>
					    	</td>
					    	<td>
					    	<table  id="t7"></table>
					    	</td>
				    	</tr>
				    	</table>
	        </div>  
    	</div>  
    	
    	<iframe id="frame0" name="frame0"  src="/sys/time/planTeacher.jsp?schoolId=<%=schoolId%>"  marginwidth=0 marginheight=0 frameborder=0 style="width:100%"></iframe>
  	
	</body>
</html>


<script type="text/javascript">
var json1;
var json2;
var json3;
var json4;
var json5;
var json6;
var josn7;
function closeDlg()
{
	$('#dlg').dialog('close');
}
	
function linkCourse()
{
	$('#dlg').dialog('open').dialog('setTitle', '排课');
	$('#fm').form('clear');

}

function getWeekTime()
{
	var schoolId=$("#schoolId").val();
	$.ajax(
	{
		type : "POST",
		url: "/sys/time/roomPlan.do?schoolId="+<%=schoolId%>,
		async: false,
		dataType:"json",
		beforeSend: function()
    	{
    		$.messager.progress({title : '系统消息', msg : '正在提交数据，请稍等……'});
    	},
    	success: function(data) {
    		$.messager.progress('close');
    		//alert(JSON.stringify(data));
    		for(var i=0;i<data.length;i++)
    		{
    			if(i==0)
    			{
    				json1=data[i];
    				initTable("t1",json1);
    				initTeacher("t0",json1);
    			}else if(i==1)
    			{
    				json2=data[i];
    				initTable("t2",json2);
    			}else if(i==2)
    			{
    				json3=data[i];
    				initTable("t3",json3);
    			}else if(i==3)
    			{
    				json4=data[i];
    				initTable("t4",json4);
    			}else if(i==4)
    			{
    				json5=data[i];
    				initTable("t5",json5);
    			}else if(i==5)
    			{
    				json6=data[i];
    				initTable("t6",json6);
    			}else if(i==6)
    			{
    				json7=data[i];
    				initTable("t7",json7);
    			} 
    			
    		}
    		 
        },
        error:function(){
        	$.messager.progress('close'); 
        }
    	
	});
	
}

function initTeacher(tabId,data)
{
	var rows=data.rows;
	var time=rows[0].schooltime;
	var weekTime=rows[0].weekTime;
	$('#'+tabId).datagrid({
	title:" ",	
    width: 100,
    height: 'auto',
    fitColumns: true,
    singleSelect:true,
    rowStyler: function(index,row)
    {
		 return 'background-color:#FFFFFF;color:#00000;';
    },
     
    columns:[[
      {field:'roomName',title:'教室',width:100,align:'center'}
      
    ]] 
  });
  $('#'+tabId).datagrid("loadData",data);	
}

function initTable(tabId,data)
{
	var rows=data.rows;
	var time=rows[0].schooltime;
	var weekTime=rows[0].weekTime;
	$('#'+tabId).datagrid({
    title: "周"+weekTime,
    width: 450,
    height: 'auto',
    fitColumns: true,
    singleSelect:true,
    rowStyler: function(index,row)
    {
		 return 'background-color:#FFFFFF;color:#00000;';
    },
    columns:[[
      {field:'H001',title:'上午1', width:120,align:'center', editor:'text'},
      {field:'H002',title:'上午2',width:120,align:'center', editor:'text'},
      {field:'H003',title:'下午1',width:120,align:'center', editor:'text'},
      {field:'H004',title:'下午2',width:120,align:'center', editor:'text'},
      {field:'H005',title:'晚上',width:120,align:'center', editor:'text'} 
    ]],
    onLoadSuccess:function()
    {
      MergeCells(tabId);
    } 
  });
  $('#'+tabId).datagrid("loadData",data);	
}

$(document).ready(function()
{
	getWeekTime();
});


function MergeCells(tabId)
{		 
	var table;
	if(tabId!='')
	{
		table= $('#'+tabId);
	} 
    var s = $(table).datagrid('getData');
    var datas =s.rows;
 
	for(var i=0; i<datas.length; i++)
	{
		var index=i;
		var fieldT;
		var colspanNum=0;
		for(var key in datas[i])
		{  
			
               if(key.indexOf("merge")>-1)
               {
               	var val=datas[i][key];
               	fieldT="H"+key.substring(5,8);
               	$(table).datagrid('mergeCells',
				{
					index: i,
					field: fieldT,
					colspan: val
				});
               }
           }  
	}
	$("table tr td").each(function()
	{
	   var d=$(this).text();
	  if('DPre-K03'==d)
	  {
		     $(this).css("background-color","#EDE1D8");
	  }else if('DPre-K01'==d)
	  {
		  $(this).css("background-color","#ECB1D8");
	  }else if('DPre-K02'==d)
	  {
		  $(this).css("background-color","#EFE1B8");
	  }
	
	});
}
</script>