<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>RunJS</title>
			<%@ include file="common/head.jsp" %>
		<%@ include file="common/formvalidator.jsp" %>
		<script class="resources library" src="http://sandbox.runjs.cn/uploads/rs/233/bkf2ntm7/autoMergeCells.js" type="text/javascript"></script>
	</head>
	<body>
    <h1>
      jQuery Easyui Datagrid<a href='http://sandbox.runjs.cn/uploads/rs/233/bkf2ntm7/autoMergeCells.js'>autoMergeCells.js</a>
    </h1>
		<table id="tt"></table>
	</body>
</html>
<script type="text/javascript">
$(document).ready(function(){
	alert("1");
  $('#tt').datagrid({
    url: 'datagrid_data2.json',
    title: 'DataGrid - ContextMenu',
    width: 600,
    height: 'auto',
    fitColumns: true,
    columns:[[
      {field:'itemid',title:'Item ID',width:80},
      {field:'productid',title:'Product ID',width:120},
      {field:'listprice',title:'List Price',width:80,align:'right'},
      {field:'unitcost',title:'Unit Cost',width:80,align:'right'},
      {field:'attr1',title:'Attribute',width:250},
      {field:'status',title:'Status',width:60,align:'center'}
    ]],
    onLoadSuccess:function(){
       
      $(this).datagrid("autoMergeCells",['itemid','productid']);
    }
  });
});
</script>