$(document).ready(function() {
	ajaxLoading("正在处理，请稍待。。。");
	$("#qryBtn").click(function() {
		initPageNumber("list_data");
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
	
	$("#reset").click(function() {
		$("#qryFm").form('clear');//清空窗体数据  
		var data = $("#schoolId").combobox("getData");
		if(data.length > 0) {
			$("#schoolId").combobox("setValue", data[0].schoolId);
		}
	});
	
	var staffId = $("#staffId").val();
	$("#schoolId").combobox({
		valueField : "schoolId",
		textField : "schoolName",
		panelHeight : "auto",
		loader: function(param,success,error) {
    		$.ajax({  
    			url : "/sys/pub/pageCategory.do?staffId=" + staffId + "&resourceId=503&fieldId=schoolId",
				dataType: 'json',  
				success: function(data) {
			    	if(data.length == schoolData.length) {
			    		data.unshift({schoolName:"全部校区", schoolId:""});  
			    	}
					success(data);  
				}
			});  
    	},
		formatter : function(data) {
			return "<span>" + data.schoolName + "</span>";
		},
		onLoadSuccess : function(data) {
			ajaxLoadEnd();
			if(data.length > 0) {
				$("#schoolId").combobox("setValue", data[0].schoolId);
			}
		},
		onChange : function(n, o) {
			$("#teacherId").combobox('clear');
			$("#teacherId").combobox("loadData", new Array());
			if(n != "" && n != null && n != undefined) {
				$("#teacherId").combobox({disabled: false});
				$("#teacherId").combobox({
					url : "/sys/pubData/qryTeacherList.do?schoolId="+n+"&stageId=",//返回json数据的url
					valueField : "teacherId",
					textField : "byname",
					panelHeight : "auto",
					formatter : function(data) {
						return "<span>" + data.byname + "</span>";
					}
				});
			} else {
				var data = $("#schoolId").combobox("getData");
				if(data.length > 0) {
					$("#schoolId").combobox("setValue", data[0].schoolId);
				}
 				$("#teacherId").combobox({disabled: true});
 			}
		}
	});
	
	$("#stageId").combobox({
		url : "/sys/pubData/qryStage.do",//返回json数据的url
    	valueField : "stageId",
    	textField : "stageId",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.stageId + "</span>";
    	}
	});
	
	//班级维护
	$("#maintenanceBtn").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var classInstId = row.classInstId;
			window.location.href = "/sys/attendClass/qryAttendClass.do?classInstId="+classInstId+"&type=maintenance&funcNodeId="+$("#funcNodeId").val();
		} else {
			$.messager.alert('提示', "请先选择您要维护的班级！");
		}
	});
	
	//班级解散
	$("#disbandBtn").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var classInstId = row.classInstId;
			window.location.href = "/sys/attendClass/qryAttendClass.do?classInstId="+classInstId+"&type=disband&funcNodeId="+$("#funcNodeId").val();
		} else {
			$.messager.alert('提示', "请先选择您要解散的班级！");
		}
	});
	
	//修改结课时间
	$("#finishDateBtn").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var classInstId = row.classInstId;
			window.location.href = "/sys/attendClass/qryAttendClass.do?classInstId="+classInstId+"&type=updateFinishDate&funcNodeId="+$("#funcNodeId").val();
		} else {
			$.messager.alert('提示', "请先选择您要修改结课时间的班级！");
		}
	});
	
	//浏览
	$("#view").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var classInstId = row.classInstId;
			window.location.href = "/sys/attendClass/qryAttendClass.do?classInstId="+classInstId+"&type=view&funcNodeId="+$("#funcNodeId").val();
		} else {
			$.messager.alert('提示', "请先选择您要浏览的班级！");
		}
	});
});