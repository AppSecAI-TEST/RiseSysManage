<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% 
	String month=request.getParameter("month");
	String weekSeq=request.getParameter("weekSeq");

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
datagrid-row-selected
#wrap{  
    width:700px;  
    margin:0 auto;  
}  
#header{  
    margin:0px;  
    height:80px;  
    border:solid 1px #00C9FF;  
}  
#container{  
    position:relative;  
    margin:0px;  
    height:400px;  
}  
#left_side{  
    position:absolute;  
    top:0px;  
    left:0px;  
    width:100px;  
    height:100%;  
}  
#content{  
    margin:0px 10px 0px 100px;  
      
    height:100%;  
}  
#right_side{  
    position:absolute;  
    top:0px;  
    right:0px;  
    border:solid 1px #00C9FF;  
    width:170px;  
    height:100%;  
}  
#footer{  
    margin:20px;  
    height:80px;  
    border:solid 1px #00C9FF;  
}  

</style>
	</head>
	<body>
		<input type="hidden" id="schoolId" name="schoolId" value="${sessionScope.StaffT.schoolId}"/>
		<div id="wrap">  
        <!--  <div id="header">header</div> --> 
	        <div id="container">  
	            <div id="left_side"> 
		    		<table  id="t0"></table>
		    	</div>  
	            <div id="content">
		            
				    	<table width="700"  cellpadding="0" border="0" style="border-collapse:collapse;overflow:scroll;" >
				    	<tr>
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
    	</div>  
	
		 <div id="dlg" class="easyui-dialog" style="width: 600px; height: 550px; padding: 10px 20px" closed="true" modal="true" buttons="#dlgBtn">
 				<iframe id="frame2" name="frame2"   src=""  marginwidth=0 marginheight=0 frameborder=0 scrolling="auto" height="445px" width="100%"></iframe>
  	    </div>
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
		url: "/sys/time//roomPlan.do?schoolId=1001",
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
    title: "教室",
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