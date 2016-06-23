$(document).ready(function() {
	$("#qryBtn").click(function() {
		initPageNumber("list_data");
		var object = $("#qryFm").serializeObject();
		var stageId = $("#stageId").val();
		object.stageId = stageId;
		var classType = $("#classType").val();
		object.classType = classType;
		var schoolId = $("#schoolId").val();
		object.schoolId = schoolId;
		var className = $("#className").val();
		object.className = className;
		var classInstId = $("#classInstId").val();
		object.classInstId = classInstId;
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
	
	$("#reset").click(function() {
		$("#qryFm").form('clear');//清空窗体数据  
	});
	
	//批量选班
	//将学员添加到班级中
	$("#addStudentCourseSubmit").click(function() {
		var obj = $('#list_data').datagrid('getSelections');
		if(obj.length > 0) {
			var param = "[";
			var className = $("#className").val();
			var classInstId = $("#classInstId").val();
			var handlerId = $("#handlerId").val();
			var schoolId = $("#schoolId").val();
			for(var i = 0, n = obj.length; i < n; i++) {
				var studentCourseId = obj[i].studentCourseId;
				var studentId = obj[i].studentId;
				var feeType = obj[i].feeType;
				var studentChannelType = "";
				if("002" == feeType) {
					studentChannelType += obj[i].oldClassName;
				}
				studentChannelType += obj[i].feeTypeText;
				param += "{classInstId:\""+classInstId+"\",className:\""+className+"\",studentId:\""+studentId+"\",studentCourseId:\""+studentCourseId+"\",studentChannelType:\""+studentChannelType+"\",handlerId:\""+handlerId+"\",schoolId:\""+schoolId+"\"},";
			}
			param = param.substring(0, param.length - 1) + "]";
			param = encodeURI(param);
			$.ajax({
				url: "/sys/applyClass/addClassStudent.do",
				data: "param=" + param,
				dataType: "json",
				async: true,
				beforeSend: function()
				{
					$.messager.progress({title : '添加学员', msg : '正在添加学员，请稍等……'});
				},
				success: function (data) {
					$.messager.progress('close'); 
					var flag = data.flag
					if(flag) {
						$.messager.alert('提示', "添加学员成功！", "info", function() {window.history.back();});
					} else {
						$.messager.alert('提示', data.msg);
					}
				}
			});
		} else {
			$.messager.alert('提示', "请先选择您要添加的学员！");
		}
	});
});