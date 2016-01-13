$(document).ready(function() {
	$("#tt").tabs({
		onSelect: function (title) {
			var src = "";
			if(title == "转班学员管理") {
				$("#qryApplyBtn").click();
			} else if(title == "转班审批管理") {
				$("#qryApproveBtn").click();
			} 
		}
	});
	
//	$("#qryApplyBtn").click(function() {
//		var obj = JSON.stringify($("#qryApplyFm").serializeObject());
//    	obj = obj.substring(0, obj.length - 1);
//    	var funcNodeId = $("#qryApplyBtn").attr("funcNodeId");
//    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
//    	$('#apply_list_data').datagrid({
//    		url : "/sys/pubData/qryDataListByPage.do",
//    		queryParams:{
//    			param : obj
//    		},
//    		onLoadSuccess:function(){
//    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
//    			$('#apply_list_data').datagrid('clearSelections');
//    		}
//    	});
//	});
//	
//	$("#qryApproveBtn").click(function() {
//		var obj = JSON.stringify($("#qryApproveFm").serializeObject());
//    	obj = obj.substring(0, obj.length - 1);
//    	var funcNodeId = $("#qryApproveBtn").attr("funcNodeId");
//    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
//    	$('#approve_list_data').datagrid({
//    		url : "/sys/pubData/qryDataListByPage.do",
//    		queryParams:{
//    			param : obj
//    		},
//    		onLoadSuccess:function(){
//    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
//    			$('#approve_list_data').datagrid('clearSelections');
//    		}
//    	});
//	});
	
	initQryButton("qryApplyBtn", "reset", "qryApplyFm", "apply_list_data");
	initQryButton("qryApproveBtn", "resetApprove", "qryApproveFm", "approve_list_data");
	
	var staffId = $("#handlerId").val();
	var funcNodeId = $("#funcNodeId").val();
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
    			$("#studentId").combobox({
					url : "/sys/pub/paramComboxList.do?staffId="+staffId+"&schoolId="+n+"&funcNodeId="+funcNodeId+"&fieldId=studentId",
					valueField : "studentId",
					textField : "name",
					panelHeight : "auto",
					formatter : function(data) {
						return "<span>" + data.name + "</span>";
					}
				});
    			$("#outClassInstId").combobox({disabled: false});
    			$("#outClassInstId").combobox({
    				url : "/sys/pubData/qryClassInstList.do?schoolId="+n+"&courseType=&stageId=&classType=&classState='003','004','005'&classInstId=",//返回json数据的url
    				valueField : "classInstId",
    				textField : "className",
    				panelHeight : "auto",
    				formatter : function(data) {
    					return "<span>" + data.className + "</span>";
    				}
    			});
    			$("#inClassInstId").combobox({disabled: false});
				$("#inClassInstId").combobox({
	        		url : "/sys/pubData/qryClassInstList.do?schoolId="+n+"&courseType=&stageId=&classType=&classState='001','002','003'&classInstId=",//返回json数据的url
	        		valueField : "classInstId",
	        		textField : "className",
	        		panelHeight : "auto",
	        		formatter : function(data) {
	        			return "<span>" + data.className + "</span>";
	        		}
	        	});
				$("#outTeacherId").combobox({disabled: false});
				$("#outTeacherId").combobox({
	        		url : "/sys/pubData/qryData.do?param={'queryCode':'qryClassTeacherInfo', 'schoolId':'"+n+"'}",//返回json数据的url
	        		valueField : "teacherId",
	        		textField : "byname",
	        		panelHeight : "auto",
	        		formatter : function(data) {
	        			return "<span>" + data.byname + "</span>";
	        		}
	        	});
    		} else {
    			var data = $("#schoolId").combobox("getData");
    			$("#schoolId").combobox("setValue", data[0].schoolId);
				$("#outClassInstId").combobox('clear');
				$("#outClassInstId").combobox("loadData", new Array());
				$("#outClassInstId").combobox({disabled: true});
				$("#inClassInstId").combobox('clear');
				$("#inClassInstId").combobox("loadData", new Array());
				$("#inClassInstId").combobox({disabled: true});
				$("#outTeacherId").combobox('clear');
				$("#outTeacherId").combobox("loadData", new Array());
				$("#outTeacherId").combobox({disabled: true});
			}
    	}
	});
	
	$("#approveSchoolId").combobox({
		url : "/sys/pubData/qrySchoolList.do?schoolId=",//返回json数据的url
    	valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
    	onLoadSuccess : function(data) {
    		if(data.length > 0) {
    			$("#approveSchoolId").combobox("setValue", data[0].schoolId);
    		}
    	},
    	onChange : function(n, o) {
    		if(n != "" && n != null && n != undefined) {
    			$("#approveStudentId").combobox({
					url : "/sys/pub/paramComboxList.do?staffId="+staffId+"&schoolId="+n+"&funcNodeId="+funcNodeId+"&fieldId=studentId",
					valueField : "studentId",
					textField : "name",
					panelHeight : "auto",
					formatter : function(data) {
						return "<span>" + data.name + "</span>";
					}
				});
    		} else {
    			var data = $("#approveSchoolId").combobox("getData");
    			$("#approveSchoolId").combobox("setValue", data[0].schoolId);
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
			$("#outClassInstId").combobox({
        		url : "/sys/pubData/qryClassInstList.do?schoolId="+schoolId+"&courseType=001&stageId="+n+"&classType=&classState=003&classInstId=",//返回json数据的url
        		valueField : "classInstId",
        		textField : "className",
        		panelHeight : "auto",
        		formatter : function(data) {
        			return "<span>" + data.className + "</span>";
        		}
        	});
			$("#inClassInstId").combobox({
        		url : "/sys/pubData/qryClassInstList.do?schoolId="+schoolId+"&courseType=001&stageId="+n+"&classType=&classState='001','002','003'&classInstId=",//返回json数据的url
        		valueField : "classInstId",
        		textField : "className",
        		panelHeight : "auto",
        		formatter : function(data) {
        			return "<span>" + data.className + "</span>";
        		}
        	});
		}
	});
	
	//转班申请
	$("#changeClassBtn").click(function() {
		var funcNodeId = $("#funcNodeId").val();
		window.location.href = "/sys/changeClass/changeStudentList.jsp?funcNodeId="+funcNodeId;
	});
	
	//转出
	$("#changeOutBtn").click(function() {
		var row = $('#apply_list_data').datagrid('getSelected');
		if(row) {
			var changeClassState = row.changeClassState;
			if("001" == changeClassState) {
				$.messager.confirm("确认", "点击确定将执行学员班级转出操作，是否确认？", function (r) {
					if (r) {
						var applyId = row.applyId;
						var studentId = row.studentId;
						var studentCourseId = row.studentCourseId;
						var handlerId = $("#handlerId").val();
						var param = "{\"applyId\":\""+applyId+"\",\"studentId\":\""+studentId+"\",\"studentCourseId\":\""+studentCourseId+"\",\"handlerId\":\""+handlerId+"\"}";
						$.ajax({
							url: "/sys/change/changeOut.do",
							data: "param=" + param,
							dataType: "json",
							async: true,
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
				var changeStateText = row.changeStateText;
				$.messager.alert('提示', "您选择的学员班级的转班状态为"+changeStateText+"，不能转入！");
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
				var changeStateText = row.changeStateText;
				$.messager.alert('提示', "您选择的转班申请已"+changeStateText+"，不能取消转班！");
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
				var changeStateText = row.changeStateText;
				$.messager.alert('提示', "您选择的转班申请已"+changeStateText+"，不能更改转班！");
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

function initStudentId() {
	var data = $("#schoolId").combobox("getData");
	if(data.length > 0) {
		var schoolIds = "";
		for(var i = 0, len = data.length; i < len; i++) {
			schoolIds += data[i].schoolId + ",";
		}
		schoolIds = schoolIds.substring(0, schoolIds.length - 1);
		$("#studentId").combobox({
			url : "/sys/pub/paramComboxList.do?staffId="+staffId+"&schoolId="+schoolIds+"&funcNodeId="+funcNodeId+"&fieldId=studentId",
			valueField : "studentId",
			textField : "name",
			panelHeight : "auto",
			formatter : function(data) {
				return "<span>" + data.name + "</span>";
			}
		});
	}
}