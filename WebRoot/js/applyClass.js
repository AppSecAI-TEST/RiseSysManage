$(document).ready(function(){
	//datagrid初始化
	$("#list_data").datagrid({
		title : "放班列表",
		iconCls : "icon-edit",//图标 
		width : "100%", 
		height : "auto", 
		nowrap : false, 
		striped : true, 
		border : true, 
		collapsible : false,//是否可折叠的 
		fit : true,//自动大小
		remoteSort : false,  
		idField : 'fldId', 
		singleSelect : false,//是否单选 
		pagination : true,//分页控件 
		rownumbers : true,//行号 
		frozenColumns:[[ 
		    {field:'ck',checkbox:true} 
		]], 
		toolbar: '#tb',
	});
	
	//设置分页控件 
    var p = $('#list_data').datagrid('getPager'); 
    $(p).pagination({ 
        pageSize: 10,//每页显示的记录条数，默认为10 
        pageList: [5,10,15],//可以设置每页记录条数的列表 
        beforePageText: '第',//页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页', 
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
        /*onBeforeRefresh:function(){
            $(this).pagination('loading');
            alert('before refresh');
            $(this).pagination('loaded');
        }*/ 
        onSelectPage: function (pageNum, pageSize) { 
			alert('onSelectPage pageNumber:' + pageNum + ',pageSize:' + pageSize); 
			getData(pageNum, pageSize); 
		}
    }); 
    
    $("#qryBtn").click(function(){
//    	var p = $('#list_data').datagrid('getPager');
//    	$(p).pagination({ 
//    		onSelectPage: function (pageNumber, pageSize) { 
//    			alert('onSelectPage pageNumber:' + pageNumber + ',pageSize:' + pageSize); 
//    			getData(pageNumber, pageSize); 
//    		} 
//    	});
    	getData(1, 10);
    });
    
    $("#addApply").click(function(){
    	$("#dlg").dialog('open').dialog('setTitle', '新增放班');//设定表头  
        $('#fm').form('clear');//清空窗体数据  
    });
});


var getData = function (page, rows) {
	var obj = JSON.stringify($("#qryFm").serializeObject());
	obj = obj.substring(0, obj.length - 1);
	obj += ",\"pageNum\":\""+page+"\",\"pageSize\":\""+rows+"\"}";
    $.ajax({
    	type: "POST",             
    	url: "/sys/applyClass.htm?method=qryApplyClassList",             
    	data: "param=" + obj,
    	dataType: "json",
    	async: false,
    	beforeSend : function()
    	{
    		$.messager.progress({title : 'Please waiting', msg : 'Loading data...'});
    	},
    	error: function (XMLHttpRequest, textStatus, errorThrown) 
    	{                 
    		alert(XMLHttpRequest.responseText);
    		$.messager.progress('close'); 
        }, 
        success: function (data) { 
            $('#list_data').datagrid('loadData', data);
            $.messager.progress('close'); 
        } 
    }); 
};

function updateApplyClass()
{
	$('#fm').form('clear');  
	var row = $('#tt').datagrid('getSelected');  
    if (row) {  
        $('#dlg').dialog('open').dialog('setTitle', '修改放班');  
        //绑定数据列表  
        $('#firstname').val(row.ScoreStyleName);  
        $('#lastname').val(row.Score);  
        $('#unit').val(row.ScoreItem);  
        $('#message').val(row.ScoreStyleState);  
        $('#ID').val(row.ScoreStyleID);  
        $('#fm').form('load', row);  
    }  
}

function deleteApplyClass()
{
	
}