<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
datagrid-row-selected
</style>
	</head>
	<body>
    	<table  id="tt1"></table>
		 <div id="dlg" class="easyui-dialog" style="width: 600px; height: 550px; padding: 10px 20px" closed="true" modal="true" buttons="#dlgBtn">
 				<iframe id="frame2" name="frame2"   src=""  marginwidth=0 marginheight=0 frameborder=0 scrolling="auto" height="445px" width="100%"></iframe>
  	    </div>
	</body>
</html>


<script type="text/javascript">

function closeDlg()
	{
		$('#dlg').dialog('close');
	}
	
	function linkCourse()
	{
		$('#dlg').dialog('open').dialog('setTitle', '排课');
		$('#fm').form('clear');
	
	}

$(document).ready(function(){
	
  $('#tt1').datagrid({
    url: "/sys/time/getTimeByWeek.do?param={'month':'10','week':'1'}",
    title: '10月',
    width: 600,
    height: 'auto',
    fitColumns: true,
    singleSelect:true,
    onClickCell:onClickCell, 
    columns:[[
      {field:'teacherName',title:'老师',width:80,align:'center'},
      {field:'H001',title:'8:30',width:80,align:'center'},
      {field:'H002',title:'10:30',width:80,align:'center'},
      {field:'H003',title:'14:00',width:80,align:'center'},
      {field:'H004',title:'16:00',width:80,align:'center'},
      {field:'H005',title:'18:30',width:80,align:'center'} 
    ]],
    onLoadSuccess:function()
    {
      MergeCells();
    }
  });
  

  
  
});


function MergeCells()
{
	    var s=  $('#tt1').datagrid('getData');
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
                	$("#tt1").datagrid('mergeCells',
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

		/*
		$("table tr").each(function(k,v)
		{//遍历所有行
			$("td",v).eq(3).css("background-color","#ECE9D8");//把每行的同一位置变色
		});*/
 }

	function randomcolor()
	{
		var str=Math.ceil(Math.random()*16777215).toString(16);   
		if(str.length<6){   
		 str="0"+str;   
		}   
		return "#"+str;
	}

 function onClickCell(rowIndex, field, value)
 { 
	
	// $('#tt1').datagrid('beginEdit', rowIndex);
	 var s=  $('#tt1').datagrid('getData');
	 var rows =s.rows;
	 alert(JSON.stringify(rows[rowIndex]));
	 $("#frame2").attr('src',"/sys/time/editTime.jsp?time="+JSON.stringify(rows[rowIndex]));
	 $('#dlg').dialog('open').dialog('setTitle', '排课');
 } 


 
</script>