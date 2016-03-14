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
    		onLoadSuccess:function() {
    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
    			$('#list_data').datagrid('clearSelections');
    		}
    	});
	});
	
	$("#reset").click(function() {
		$("#qryFm").form('clear');//清空窗体数据  
		var data = $("#schoolId").combobox("getData");
		if(data.length > 0) {
			$("#schoolId").combobox("setValue", data[0].schoolId);
		}
	});
	
	$("#schoolId").combobox({
    	onLoadSuccess:function(data) {
    		if(data.length > 0) {
    			$("#schoolId").combobox("setValue", data[0].schoolId);
    		}
    		$("#qryBtn").click();
    	},
    	onChange : function(n, o) {
    		$("#teacherId").combobox({
				url : "/sys/pubData/qryTeacherList.do?schoolId="+n+"&stageId=",//返回json数据的url
				valueField : "teacherId", 
				textField : "byname",
				panelHeight : "auto",
				formatter : function(data) {
					return "<span>" + data.byname + "</span>";
				}
			});
    	}
	});
	
	$("#stageId").combobox({
		url : "/sys/pubData/qryStage.do",//返回json数据的url
    	valueField : "stageId",
    	textField : "stageId",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.stageId + "</span>";
    	},
		onChange : function(n, o) {
			var schoolId = $("#schoolId").combobox("getValue");
			//转出班级
			$("#classInstId").combobox({
        		url : "/sys/pubData/qryClassInstList.do?schoolId="+schoolId+"&courseType=&stageId="+n+"&classType=&classState=&classInstId=",//返回json数据的url
        		valueField : "classInstId",
        		textField : "className",
        		panelHeight : "auto",
        		formatter : function(data) {
            		return "<span>" + data.className + "</span>";
            	}
        	});
		}
	});
	
	//班级结课
	$("#finishClassBtn").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var classState = row.classState;
			var isGrad=row.isGrad;
			if("004" == classState)
			{
				if(isGrad=='Y')
				{
					$.messager.alert('提示', "该班级毕业典礼已取消");
					return;
				}
				var classInstId = row.classInstId;
				window.location.href = "/sys/attendClass/qryAttendClass.do?classInstId="+classInstId+"&type=finish";
			} else 
			{
				$.messager.alert('提示', "请选择已结课班级");
			}
		} else
		{
			$.messager.alert('提示', "请选择班级");
		}
	});
	
	//浏览
	$("#view").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var classInstId = row.classInstId;
			window.location.href = "/sys/attendClass/qryAttendClass.do?classInstId="+classInstId+"&type=viewFinish";
		} else {
			$.messager.alert('提示', "请先选择您要浏览的班级");
		}
	});
	
	//结课
	$("#finishClassSubmit").click(function() {
		if($("#finishClassFm").form('validate')) {
			var obj = JSON.stringify($("#finishClassFm").serializeObject());
			obj = encodeURI(obj);
			$.ajax({
				url: "/sys/attendClass/finishClass.do",
				data: "param=" + obj,
				dataType: "json",
				async: true,
				beforeSend: function()
				{
					$.messager.progress({title : '班级结课', msg : '处理中，请稍等……'});
				},
				success: function (data) {
					$.messager.progress('close'); 
					var flag = data.flag;
					if(flag) {
						$.messager.alert('提示', "处理成功！", "info", function() {window.history.back();});
					} else {
						$.messager.alert('提示', data.msg);
					}
				} 
			});
		}
	});
});