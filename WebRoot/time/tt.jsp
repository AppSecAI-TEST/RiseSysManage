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
      {field:'001',title:'8:30',width:80,align:'center'},
      {field:'002',title:'10:30',width:80,align:'center'},
      {field:'003',title:'14:00',width:80,align:'center'},
      {field:'004',title:'16:00',width:80,align:'center'},
      {field:'005',title:'18:30',width:80,align:'center'} 
    ]],
    onLoadSuccess:function()
    {
      MergeCells();
    }
  });
  

  
  
});


function MergeCells()
{
		var merges = [{
			index: 1,
			colspan: 2
		},{
			index: 5,
			colspan: 2
		},{
			index: 7,
			colspan: 2
		}];
		
	    var s=  $('#tt1').datagrid('getData');
	    var datas =s.rows;
	 
		for(var i=0; i<datas.length; i++)
		{
			var index=i;
			var field;
			var colspanNum=0;
			alert(JSON.stringify(datas[i]));
			/*
			if(colspanNum==0)
			{
				continue;
			}
			$("#tt1").datagrid('mergeCells',
			{
				index: merges[i].index,
				field: '001',
				colspan: merges[i].colspan
			});*/
		}
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