<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
    	 
			<table id="tt1"></table>
		 
		 
	</body>
</html>


<script type="text/javascript">



$(document).ready(function(){
	
  $('#tt1').datagrid({
    url: 'datagrid_data1.json',
    title: '10月',
    width: 600,
    height: 'auto',
    fitColumns: true,
    selectOnCheck:false,
    columns:[[
      {field:'teacherId',title:'老师',width:80,align:'center'},
      {field:'001',title:'8:30',width:80,align:'center'},
      {field:'002',title:'10:30',width:80,align:'center'},
      {field:'003',title:'14:00',width:80,align:'center'},
      {field:'004',title:'16:00',width:80,align:'center'},
      {field:'005',title:'18:30',width:80,align:'center'} 
    ]],
    onLoadSuccess:function(){
    //  MergeCells("tt1","itemid,productid")
    }
  });
  
  	
  
  
});


 
</script>