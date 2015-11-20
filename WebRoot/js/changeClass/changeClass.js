$(document).ready(function() {
	$("#qryApplyBtn").click(function() {
		var obj = JSON.stringify($("#qryApplyFm").serializeObject());
    	obj = obj.substring(0, obj.length - 1);
    	var funcNodeId = $("#qryApplyBtn").attr("funcNodeId");
    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
    	$('#apply_list_data').datagrid({
    		url : "/sys/pubData/qryDataListByPage.do",
    		queryParams:{
    			param : obj
    		},
    		onLoadSuccess:function(){
    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
    			$('#apply_list_data').datagrid('clearSelections');
    		}
    	});
	});
	
	$("#qryApproveBtn").click(function() {
		var obj = JSON.stringify($("#qryApproveFm").serializeObject());
    	obj = obj.substring(0, obj.length - 1);
    	var funcNodeId = $("#qryApproveBtn").attr("funcNodeId");
    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
    	$('#approve_list_data').datagrid({
    		url : "/sys/pubData/qryDataListByPage.do",
    		queryParams:{
    			param : obj
    		},
    		onLoadSuccess:function(){
    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
    			$('#approve_list_data').datagrid('clearSelections');
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
			$("#outClassInstId").combobox({
        		url : "/sys/pubData/qryClassInstList.do?schoolId="+schoolId+"&courseType=001&stageId="+n+"&classType=&classState=003&classInstId=",//返回json数据的url
        		valueField : "classInstId",
        		textField : "className",
        		panelHeight : "auto",
        		onLoadSuccess : function () { //数据加载完毕事件
                    var data = $('#outClassInstId').combobox('getData');
                    if (data.length > 0) {
                        $("#outClassInstId").combobox('select', data[0].classInstId);
                    }
                }
        	});
			$("#inClassInstId").combobox({
        		url : "/sys/pubData/qryClassInstList.do?schoolId="+schoolId+"&courseType=001&stageId="+n+"&classType=&classState='001','002','003'&classInstId=",//返回json数据的url
        		valueField : "classInstId",
        		textField : "className",
        		panelHeight : "auto",
        		onLoadSuccess : function () { //数据加载完毕事件
                    var data = $('#inClassInstId').combobox('getData');
                    if (data.length > 0) {
                        $("#inClassInstId").combobox('select', data[0].classInstId);
                    }
                }
        	});
		}
	});
	
	//转班申请
	$("#changeClassBtn").click(function() {
		window.location.href = "/sys/changeClass/changeStudentList.jsp";
	});
	
	//转出
	$("#changeOutBtn").click(function() {
		var row = $('#apply_list_data').datagrid('getSelected');
		if(row) {
			var changeClassState = row.changeClassState;
			if("001" == changeClassState) {
				$.messager.confirm("确认", "点击确定将执行学员班级转出操作，是否确认？", function (r) {
					if (r) {
						var studentId = row.studentId;
						var studentCourseId = row.studentCourseId;
						var handlerId = $("#handlerId").val();
						var param = "{\"studentId\":\""+studentId+"\",\"studentCourseId\":\""+studentCourseId+"\",\"handlerId\":\""+handlerId+"\"}";
						$.ajax({
							url: "/sys/change/changeOut.do",
							data: "param=" + param,
							dataType: "json",
							async: false,
							beforeSend: function()
							{
								$.messager.progress({title : '转出班级', msg : '正在转出班级，请稍等……'});
							},
							success: function (data) {
								$.messager.progress('close'); 
								var flag = data.flag;
								if(flag) {
									$.messager.alert('提示', "转出班级成功！", "info", function() {window.location.reload();});
								} else {
									$.messager.alert('提示', data.msg);
								}
							} 
						});
					}
				});
			} else {
				var changeClassStateText = row.changeClassStateText;
				$.messager.alert('提示', "您选择的学员班级的转班状态为"+changeClassStateText+"，不能转出！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要转出的转班申请！");
		}
	});
	
	//转入
	$("#changeInBtn").click(function() {
		var row = $('#apply_list_data').datagrid('getSelected');
		if(row) {
			var changeClassState = row.changeClassState;
			if("003" == changeClassState) {
				var applyId = row.applyId;
				var schoolId = row.schoolId;
				var studentId = row.studentId;
				var studentCourseId = row.studentCourseId;
				window.location.href = "/sys/changeClass/changeInClass.jsp?studentId="+studentId+"&studentCourseId="+studentCourseId+"&applyId="+applyId+"&schoolId="+schoolId;
			} else {
				var changeClassStateText = row.changeClassStateText;
				$.messager.alert('提示', "您选择的学员班级的转班状态为"+changeClassStateText+"，不能转入！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要转入的转班申请！");
		}
	});
	
	//取消转班
	$("#cancelChangeBtn").click(function() {
		var row = $('#apply_list_data').datagrid('getSelected');
		if(row) {
			var changeClassState = row.changeClassState;
			if("007" != changeClassState && "006" != changeClassState) {
				var applyId = row.applyId;
				var schoolId = row.schoolId;
				var studentId = row.studentId;
				var studentCourseId = row.studentCourseId;
				window.location.href = "/sys/changeClass/cancelChangeClass.jsp?studentId="+studentId+"&studentCourseId="+studentCourseId+"&applyId="+applyId+"&schoolId="+schoolId;
			} else {
				var changeClassStateText = row.changeClassStateText;
				$.messager.alert('提示', "您选择的转班申请已"+changeClassStateText+"，不能取消转班！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要取消的转班申请！");
		}
	});
	
	//更改转班
	$("#updateChangeBtn").click(function() {
		var row = $('#apply_list_data').datagrid('getSelected');
		if(row) {
			var changeClassState = row.changeClassState;
			if("007" != changeClassState && "006" != changeClassState) {
				var applyId = row.applyId;
				var schoolId = row.schoolId;
				var studentId = row.studentId;
				var studentCourseId = row.studentCourseId;
				window.location.href = "/sys/changeClass/updateChangeClass.jsp?studentId="+studentId+"&studentCourseId="+studentCourseId+"&applyId="+applyId+"&schoolId="+schoolId;
			} else {
				var changeClassStateText = row.changeClassStateText;
				$.messager.alert('提示', "您选择的转班申请已"+changeClassStateText+"，不能更改转班！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要更改转班的转班申请！");
		}
	});
	
	//申请浏览
	$("#view").click(function() {
		var row = $('#apply_list_data').datagrid('getSelected');
		if(row) {
			var applyId = row.applyId;
			window.location.href = "/sys/changeClass/viewChangeClass.jsp?applyId="+applyId;
		} else {
			$.messager.alert('提示', "请先选择您要浏览的转班申请！");
		}
	});
	
	//审批
	$("#approveBtn").click(function() {
		var row = $('#approve_list_data').datagrid('getSelected');
		if(row) {
			var approveState = row.approveState;
			if("000" == approveState) {
				var applyId = row.applyId;
				var studentId = row.studentId;
				var studentCourseId = row.studentCourseId;
				window.location.href = "/sys/changeClass/approveChangeClass.jsp?applyId="+applyId+"&studentId="+studentId+"&studentCourseId="+studentCourseId;
			} else {
				$.messager.alert('提示', "您选择的转班审批已经审批，不能再次审批！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要审批的转班申请！");
		}
	});
	
	//浏览审批
	$("#viewApprove").click(function() {
		var row = $('#approve_list_data').datagrid('getSelected');
		if(row) {
			var applyId = row.applyId;
			window.location.href = "/sys/changeClass/viewChangeClass.jsp?applyId="+applyId;
		} else {
			$.messager.alert('提示', "请先选择您要浏览的转班申请！");
		}
	});
});