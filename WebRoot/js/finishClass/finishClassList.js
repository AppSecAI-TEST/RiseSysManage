$(document).ready(function() {
	$("#qryBtn").click(function() {
		var obj = JSON.stringify($("#qryFm").serializeObject());
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
	});
	
	$("#stageId").combobox({
		url : "/sys/pubData/qryStage.do",//返回json数据的url
    	valueField : "stageId",
    	textField : "stageId",
    	panelHeight : "auto",
    	onLoadSuccess : function () { //数据加载完毕事件
            var data = $('#stageId').combobox('getData');
            if (data.length > 0) {
                $("#stageId").combobox('select', data[0].stageId);
            }
        },
		onChange : function(n, o) {
			var schoolId = $("#schoolId").combobox("getValue");
			//转出班级
			$("#classInstId").combobox({
        		url : "/sys/pubData/qryClassInstList.do?schoolId="+schoolId+"&courseType=&stageId="+n+"&classType=&classState=&classInstId=",//返回json数据的url
        		valueField : "classInstId",
        		textField : "className",
        		panelHeight : "auto",
        		onLoadSuccess : function () { //数据加载完毕事件
                    var data = $('#classInstId').combobox('getData');
                    if (data.length > 0) {
                        $("#classInstId").combobox('select', data[0].classInstId);
                    }
                }
        	});
		}
	});
	
	//班级结课
	$("#finishClassBtn").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var classState = row.classState;
			if("003" == classState) {
				var classInstId = row.classInstId;
				window.location.href = "/sys/attendClass/qryAttendClass.do?classInstId="+classInstId+"&type=finish";
			} else {
				var classStateText = "已结课";
				if("005" == classState) {
					classStateText = "已解散";
				}
				$.messager.alert('提示', "您选择要班级"+classStateText+"！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要结课的班级！");
		}
	});
	
	//浏览
	$("#view").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var classInstId = row.classInstId;
			window.location.href = "/sys/attendClass/qryAttendClass.do?classInstId="+classInstId+"&type=viewFinish";
		} else {
			$.messager.alert('提示', "请先选择您要浏览的班级！");
		}
	});
	
	//结课
	$("#finishClassSubmit").click(function() {
		if($("#finishClassFm").form('validate')) {
			var obj = JSON.stringify($("#finishClassFm").serializeObject());
			alert(obj)
			$.ajax({
				url: "/sys/attendClass/finishClass.do",
				data: "param=" + obj,
				dataType: "json",
				async: false,
				beforeSend: function()
				{
					$.messager.progress({title : '班级结课', msg : '正在班级结课，请稍等……'});
				},
				success: function (data) {
					$.messager.progress('close'); 
					var flag = data.flag;
					if(flag) {
						$.messager.alert('提示', "班级结课成功！", "info", function() {window.history.back();});
					} else {
						$.messager.alert('提示', data.msg);
					}
				} 
			});
		}
	});
});