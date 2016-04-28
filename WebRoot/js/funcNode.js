$(document).ready(function() {
	//设置分页控件 
    var p = $('#list_data').datagrid('getPager'); 
    $(p).pagination({ 
        pageSize: 10,//每页显示的记录条数，默认为10 
        pageList: [5, 10, 15],//可以设置每页记录条数的列表 
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
		}
    }); 
    
    $("#qryBtn").click(function() {
    	initPageNumber("list_data");
    	var obj = JSON.stringify($("#qryFm").serializeObject());
    	$('#list_data').datagrid({
    		url : "/sys/funcNode/qryFuncNodeList.do",
    		queryParams : {
    			param : obj
    		},
    		onLoadSuccess:function() {
    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
    			$('#list_data').datagrid('clearSelections');
    		}
    	});
    });
    
    $("#addFuncNode").click(function() {
    	$("#dlg").dialog('open').dialog('setTitle', '新增角色');//设定表头  
        $('#fm').form('clear');//清空窗体数据  
        url = "/sys/funcNode/addFuncNode.do";
    });
    
    $("#updateFuncNode").click(function() {
    	var row = $('#list_data').datagrid('getSelected');
		if (row) {
			$('#dlg').dialog('open').dialog('setTitle','修改角色');
			$('#fm').form('clear');
			$('#fm').form('load', row);
			url = "/sys/funcNode/updateFuncNode.do";
		}
    });
    
    $("#deleteFuncNode").click(function(){
    	var row = $('#list_data').datagrid('getSelected');
		if (row) {
			$.messager.confirm('提示','您确定要删除当前选中的权限吗？',function(r){
				if(r) {
					$.post('/sys/funcNode/deleteFuncNode.do', {funcNodeId : row.funcNodeId}, function(result) {
						var obj = JSON.parse(result);
						if(obj.flag) {
							window.location.reload();
						} else {
							$.messager.alert('提示', obj.msg);
						}
					});
				}
			});
		}
    });
    
    $("#submit").click(function() {
    	var obj = JSON.stringify($("#fm").serializeObject());
		$.post(url, {param : obj}, function(result) {
			var obj = JSON.parse(result);
			if(obj.flag) {
				window.location.reload();
			} else {
				$.messager.alert('提示', obj.msg);
			}
		});
    });
});