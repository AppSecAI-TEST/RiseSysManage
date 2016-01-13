$(document).ready(function() {
//	$("#qryBtn").click(function() {
//		var obj = JSON.stringify($("#qryFm").serializeObject());
//    	obj = obj.substring(0, obj.length - 1);
//    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
//    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
//    	$('#list_data').datagrid({
//    		url : "/sys/pubData/qryDataListByPage.do",
//    		queryParams:{
//    			param : obj
//    		},
//    		onLoadSuccess:function(){
//    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
//    			$('#list_data').datagrid('clearSelections');
//    		}
//    	});
//	});
	
	initQryButton("qryBtn", "reset", "qryFm", "list_data");
	
	$("#schoolId").combobox({
		url : "/sys/pubData/qrySchoolList.do?schoolId=",//返回json数据的url
		valueField : "schoolId",
		textField : "schoolName",
		panelHeight : "auto",
		formatter : function(data) {
			return "<span>" + data.schoolName + "</span>";
		},
		onLoadSuccess : function(data) {
			if(data.length > 0) {
				$("#schoolId").combobox("setValue", data[0].schoolId);
			}
		},
		onChange : function(n, o) {
			if(n != "" && n != null && n != undefined) {
				$("#classInstId").combobox({disabled: false});
				$("#classInstId").combobox({
					url : "/sys/pubData/qryClassInstList.do?schoolId="+n+"&courseType=&stageId=&classType=&classState='001','002','003','004','005'&classInstId=",//返回json数据的url
					valueField : "classInstId",
					textField : "className",
					panelHeight : "auto",
					formatter : function(data) {
						return "<span>" + data.className + "</span>";
					}
				});
				$("#teacherId").combobox({disabled: false});
				$("#teacherId").combobox({
					url : "/sys/pubData/qryTeacherList.do?schoolId="+n+"&classType=",//返回json数据的url
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
 				$("#classInstId").combobox('clear');
 				$("#classInstId").combobox("loadData", new Array());
 				$("#classInstId").combobox({disabled: true});
 				$("#teacherId").combobox('clear');
 				$("#teacherId").combobox("loadData", new Array());
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
	
	//班级维护
	$("#maintenanceBtn").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var classInstId = row.classInstId;
			window.location.href = "/sys/attendClass/qryAttendClass.do?classInstId="+classInstId+"&type=maintenance";
		} else {
			$.messager.alert('提示', "请先选择您要维护的班级！");
		}
	});
	
	//班级解散
	$("#disbandBtn").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var classInstId = row.classInstId;
			window.location.href = "/sys/attendClass/qryAttendClass.do?classInstId="+classInstId+"&type=disband";
		} else {
			$.messager.alert('提示', "请先选择您要解散的班级！");
		}
	});
	
	//浏览
	$("#view").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var classInstId = row.classInstId;
			window.location.href = "/sys/attendClass/qryAttendClass.do?classInstId="+classInstId+"&type=view";
		} else {
			$.messager.alert('提示', "请先选择您要浏览的班级！");
		}
	});
});