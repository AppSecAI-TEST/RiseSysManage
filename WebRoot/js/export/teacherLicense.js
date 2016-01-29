$(document).ready(function() {
	$("#qryBtn").click(function() {
		var schoolId = $("#schoolId").combobox("getValue");
    	if(schoolId != ""){
			var object = $("#qryFm").serializeObject();
	    	var obj = JSON.stringify(object);
	    	obj = obj.substring(0, obj.length - 1);
	    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
	    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
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
    	}else{
			showMessage("提示","没有有效的校区可供查询",null);
		}
    });
	
	//页面重置
     $("#resetBtn").click(function() 
    {
    	$("#qryFm").form('clear');//清空窗体数据  
    	//校区赋默认值
    	if($("#schoolId").combobox("getData").length>0){
    		$("#schoolId").combobox("select",$("#schoolId").combobox("getData")[0].schoolId);
    	}
    });
	
});