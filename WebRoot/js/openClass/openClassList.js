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
	
	//正常开班申请
	$("#normalOpenClass").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var openClassType = row.openClassType;
			if(openClassType == "" || openClassType == null || openClassType == undefined) {
				var classStudentNum = row.classStudentNum;
				var minNum = row.minNum;
				if(classStudentNum >= minNum) {
					var classInstId = row.classInstId;
					window.location.href = "/sys/openClass/qryCreateClass.do?classInstId="+classInstId+"&type=normal&applyType=001";
				} else {
					$.messager.alert('提示', "您选择的班级正常开班的最少人数为"+minNum+"人，定班人数至少要达到最少人数才能申请正常开班！");
				}
			} else {
				var openClassState = row.openClassState;
				if(openClassState == '001') {
					$.messager.alert('提示', "您选择的班级开班申请正在审批中，不能申请正常开班！");
				} else if(openClassState == '002') {
					$.messager.alert('提示', "您选择的班级开班申请审批已通过，不能申请正常开班！");
				} else if(openClassState == '003') {
					$.messager.alert('提示', "您选择的班级开班申请审批未通过，不能再次申请正常开班！");
				} else if(openClassState == '004') {
					$.messager.alert('提示', "您选择的班级已经取消开班，不能申请正常开班！");
				}
			}
		} else {
			$.messager.alert('提示', "请先选择您要申请正常开班的班级！");
		}
	});
	
	//异常开班申请
	$("#exceptionOpenClass").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var openClassType = row.openClassType;
			if(openClassType == "" || openClassType == null || openClassType == undefined) {
				var classInstId = row.classInstId;
				window.location.href = "/sys/openClass/qryCreateClass.do?classInstId="+classInstId+"&type=exception&applyType=001";
			} else {
				var openClassState = row.openClassState;
				if(openClassState == '001') {
					$.messager.alert('提示', "您选择的班级开班申请正在审批中，不能申请异常开班！");
				} else if(openClassState == '002') {
					$.messager.alert('提示', "您选择的班级开班申请审批已通过，不能申请异常开班！");
				} else if(openClassState == '003') {
					$.messager.alert('提示', "您选择的班级开班申请审批未通过，不能再次申请异常开班！");
				} else if(openClassState == '004') {
					$.messager.alert('提示', "您选择的班级已经取消开班，不能申请异常开班！");
				}
			}
		} else {
			$.messager.alert('提示', "请先选择您要申请异常开班的班级！");
		}
	});
	
	//修改开课时间
	$("#updateStartDate").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var applyType = "002";
			var openClassType = row.openClassType;
			if(openClassType == "" || openClassType == null || openClassType == undefined) {
				applyType = "001";
			}
			var classInstId = row.classInstId;
			window.location.href = "/sys/openClass/qryCreateClass.do?classInstId="+classInstId+"&type=update&applyType="+applyType;
		} else {
			$.messager.alert('提示', "请先选择您要修改开课时间的班级！");
		}
	});
	
	//取消开班
	$("#cancelOpenClass").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var openClassState = row.openClassState;
			if(openClassState != null && openClassState != "" && openClassState != undefined) {
				if(openClassState == '002') {
					var classStudentNum = row.classStudentNum;
					if(classStudentNum == 0) {
						var classInstId = row.classInstId;
						window.location.href = "/sys/openClass/qryCreateClass.do?classInstId="+classInstId+"&type=cancel&applyType=002";
					} else {
						$.messager.alert('提示', "您选择的班级还有学员，请将所有的学员移除之后，再取消放班！");
					}
				} else {
					if(openClassState == '001') {
						$.messager.alert('提示', "您选择的班级开班申请正在审批中，不能取消开班！");
					} else if(openClassState == '003') {
						$.messager.alert('提示', "您选择的班级开班申请审批未通过，不能取消开班！");
					} else if(openClassState == '004') {
						$.messager.alert('提示', "您选择的班级已经取消开班！");
					}
				}
			} else {
				$.messager.alert('提示', "您选择的班级还未申请开班，不能取消开班！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要取消开班的班级！");
		}
	});
	
	//浏览
	$("#view").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var classInstId = row.classInstId;
			var applyType = "002";
			var openClassType = row.openClassType;
			if(openClassType == "" || openClassType == null || openClassType == undefined) {
				applyType = "001";
			}
			window.location.href = "/sys/openClass/qryCreateClass.do?classInstId="+classInstId+"&type=view&applyType="+applyType;
		} else {
			$.messager.alert('提示', "请先选择您要浏览的班级！");
		}
	});
});