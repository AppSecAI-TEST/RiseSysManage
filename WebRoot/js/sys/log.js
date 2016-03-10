$(document).ready(function() {
	$("#qryBtn").click(function() {
		var object = $("#qryFm").serializeObject();
		var funcNodeId = $("#qryBtn").attr("funcNodeId");
		object.funcNodeId = funcNodeId;
    	var obj = JSON.stringify(object);
    	$('#list_data').datagrid({
    		url : "/sys/pubData/qryDataListByPage.do",
    		queryParams:{
    			param : obj
    		},
    		onLoadSuccess:function(){
    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
    			$('#list_data').datagrid('clearSelections');
    		}
    	});
    });
	
	//重置
	$("#reset").click(function() {
		$("#qryFm").form('clear');//清空窗体数据  
	});
	
	//删除
	$("#deleteBtn").click(function() {
		var obj = $("#list_data").datagrid("getSelections");
		if(obj.length > 0) {
			$.messager.confirm('确认','确认要删除您选择的日志吗?',function(row) {
				if(row) {
					var logIds = "";
					for(var i = 0, n = obj.length; i < n; i++) {
						logIds += obj[i].logId + ",";
					}
					logIds = logIds.substring(0, logIds.length - 1);
					$.ajax({
						url: "/sys/log/deleteLog.do",
						data: "logIds=" + logIds,
						dataType: "json",
						async: true,
		    			beforeSend: function() {
		    	    		$.messager.progress({title : "删除日志", msg : "正在删除日志，请稍等……"});
		    	    	},
						success:function(data) {
							$.messager.progress('close'); 
							if (data.flag) {
								$.messager.alert('提示', "删除日志成功！", "info", function() {window.location.reload();});
							} else {
								$.messager.alert('提示', data.msg);
							}
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', "请先选择您要删除的日志！");
		}
	});
	
	//删除全部
	$("#deleteAllBtn").click(function() {
		$.messager.confirm('确认','确认要删除全部的日志吗?',function(row) {
			if(row) {
				$.ajax({
					url: "/sys/log/deleteAllLog.do",
					dataType: "json",
					async: true,
	    			beforeSend: function() {
	    	    		$.messager.progress({title : "删除日志", msg : "正在删除日志，请稍等……"});
	    	    	},
					success:function(data) {
						$.messager.progress('close'); 
						if (data.flag) {
							$.messager.alert('提示', "删除日志成功！", "info", function() {window.location.reload();});
						} else {
							$.messager.alert('提示', data.msg);
						}
					}
				});
			}
		});
	});
});