<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>RunJS</title>
			<%@ include file="common/head.jsp" %>
		<%@ include file="common/formvalidator.jsp" %>
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
    
		<table id="tt"></table>
	</body>
</html>


<script type="text/javascript">
$(document).ready(function(){
	
  $('#tt').datagrid({
    url: 'datagrid_data2.json',
    title: 'DataGrid - ContextMenu',
    width: 600,
    height: 'auto',
    fitColumns: true,
    selectOnCheck:false,
    columns:[[
      {field:'itemid',title:'Item ID',width:80},
      {field:'productid',title:'Product ID',width:120},
      {field:'listprice',title:'List Price',width:80,align:'right',styler:cellStyler},
      {field:'unitcost',title:'Unit Cost',width:80,align:'right'},
      {field:'attr1',title:'Attribute',width:250},
      {field:'status',title:'Status',width:60,align:'center'}
    ]],
    onLoadSuccess:function(){
       
      $(this).datagrid("autoMergeCells",['itemid','productid']);
    }
  });
});

	$('#tt').datagrid({
		rowStyler:function(index,row)
		{	 
				return 'background-color:white;color:black;font-weight:black;';	 
		}
	});
	
		function cellStyler (value,row,index)
		{	 
			return 'background-color:#ffee00;color:red;';
		}
	 
		
 
</script>