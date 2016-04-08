$(document).ready(function() {
//	$("#tt").tabs({
//		onSelect: function (title) {
//			if(title == "转校审批管理") {
//				var height = $(document).height();
//				var header = $(".panel-header").height();
//				var search = $("#approve_search_tab").height();
//				$('#approve_list_data').datagrid('resize', {// 适配高度
//					height: height - search - header - 60
//				});
//			} 
//		}
//	});
	
	$("#qryApplyBtn").click(function() {
		var object = $("#qryApplyFm").serializeObject();
		var schoolId = $("#schoolId").val();
		object.schoolId = schoolId;
		var funcNodeId = $("#qryApplyBtn").attr("funcNodeId");
		object.funcNodeId = funcNodeId;
		var obj = JSON.stringify(object);
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
	
	$("#reset").click(function() {
		$("#qryApplyFm").form('clear');//清空窗体数据  
	});
	
	$("#qryApproveBtn").click(function() {
		var object = $("#qryApproveFm").serializeObject();
		var schoolId = $("#schoolId").val();
		object.schoolId = schoolId;
		var funcNodeId = $("#qryApproveBtn").attr("funcNodeId");
		object.funcNodeId = funcNodeId;
		var obj = JSON.stringify(object);
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
	
	$("#resetApprove").click(function() {
		$("#qryApproveFm").form('clear');//清空窗体数据  
	});
	
	$("#outSchoolId").combobox({
		url : "/sys/pubData/qrySchoolList.do",
		valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
    	onChange : function(n, o) {
    		if(n != "" && n != null && n != undefined) {
    			$("#outTeacherId").combobox({
    				url : "/sys/pubData/qryTeacherList.do?schoolId="+n+"&stageId=",//返回json数据的url
	        		valueField : "teacherId",
	        		textField : "byname",
	        		panelHeight : "auto",
	        		formatter : function(data) {
	        			return "<span>" + data.byname + "</span>";
	        		}
    			});
    		} else {
    			var data = $("#outSchoolId").combobox("getData");
    			$("#outSchoolId").combobox("setValue", data[0].schoolId);
				$("#outTeacherId").combobox('clear');
				$("#outTeacherId").combobox("loadData", new Array());
    		}
    	}
	});
	
	$("#inSchoolId").combobox({
		url : "/sys/pubData/qrySchoolList.do",
		valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	}
	});
	
	$("#approveSchoolId").combobox({
		url : "/sys/pubData/qrySchoolList.do",
		valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	}
	});
	
	$("#approveInschoolId").combobox({
		url : "/sys/pubData/qrySchoolList.do",
		valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	}
	});

	//转校申请
	$("#changeSchoolBtn").click(function() {
		var funcNodeId = $("#funcNodeId").val();
		window.location.href = "/sys/changeSchool/changeStudentList.jsp?funcNodeId="+funcNodeId;
	});
	
	//转出
	$("#changeOutBtn").click(function() {
		var row = $('#apply_list_data').datagrid('getSelected');
		if(row) {
			var tacheState = row.tacheState;
			if("001" == tacheState) {
				var isFinish = "N";
				var applyId = row.applyId;
				var studentId = row.studentId;
				var courseState = row.courseState;
				var higherStageId = row.higherStageId;
				var lowerCourseState = row.lowerCourseState;
				//没有升学阶段
				if((higherStageId == "" || higherStageId == null || higherStageId == undefined) 
						//没有当前课程
						&& (courseState == "" || courseState == null && courseState == undefined)
						//没有上个阶段
						&& ((lowerCourseState == "" || lowerCourseState == null && lowerCourseState == undefined) 
								//有结课的上个阶段	
								|| (lowerCourseState != "" && lowerCourseState != null && lowerCourseState != undefined && lowerCourseState == "009"))) {
					isFinish = "Y";
				}
				window.location.href = "/sys/changeSchool/changeOutSchool.jsp?applyId="+applyId+"&studentId="+studentId+"&isFinish="+isFinish;
			} else {
				var changeStateText = row.changeStateText;
				$.messager.alert('提示', "您选择的转班申请的转班状态为"+changeStateText+"，不能转出！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要转出的转校申请！");
		}
	});
	
	//转入
	$("#changeInBtn").click(function() {
		var row = $('#apply_list_data').datagrid('getSelected');
		if(row) {
			var courseState = row.courseState;
			if("001" == courseState || "002" == courseState) {
				var courseStateText = row.courseStateText;
				$.messager.alert('提示', "您选择的转校申请的学员课程状态为"+courseStateText+"，不能转入班级，需要走未进班选班流程！");
			} else {
				var tacheState = row.tacheState;
				if("003" == tacheState) {
					var applyId = row.applyId;
					var studentId = row.studentId;
					window.location.href = "/sys/changeSchool/changeInSchool.jsp?applyId="+applyId+"&studentId="+studentId;
				} else {
					var changeStateText = row.changeStateText;
					$.messager.alert('提示', "您选择的转班申请的转班状态为"+changeStateText+"，不能转入！");
				}
			}
		} else {
			$.messager.alert('提示', "请先选择您要转入班级的转校申请！");
		}
	});
	
	//取消转校
	$("#cancelChangeBtn").click(function() {
		var row = $('#apply_list_data').datagrid('getSelected');
		if(row) {
			var tacheState = row.tacheState;
			if("005" != tacheState && "006" != tacheState && "007" != tacheState) {
				var name = row.name;
				var phone = row.phone;
				var byName = row.byName;
				var applyId = row.applyId;
				var studentId = row.studentId;
				var outClassId = row.outClassId;
				var courseState = row.courseState;
				var outClassName = row.outClassName;
				var outSchoolName = row.outSchoolName;
				var oldCourseState = row.oldCourseState;
				var studentCourseId = row.studentCourseId;
				var outClassTeacherName = row.outClassTeacherName;
				var url = "/sys/changeSchool/cancelChangeSchool.jsp?applyId="+applyId+"&studentId="+studentId+"&studentCourseId="+studentCourseId+"&oldCourseState="+oldCourseState+"&outClassId="+outClassId;
				url += "&name="+name+"&phone="+phone+"&byName="+byName+"&outClassName="+outClassName+"&outSchoolName="+outSchoolName+"&outClassTeacherName="+outClassTeacherName+"&courseState="+courseState;
				window.location.href = url;
			} else {
				var changeStateText = row.changeStateText;
				$.messager.alert('提示', "您选择的转班申请的转班状态为"+changeStateText+"，不能取消转校！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要取消转校的转校申请！");
		}
	});
	
	//更改选班
	$("#updateChangeBtn").click(function() {
		var row = $('#apply_list_data').datagrid('getSelected');
		if(row) {
			var tacheState = row.tacheState;
			var courseState = row.courseState;
			if("001" == courseState || "002" == courseState) {
				var courseStateText = row.courseStateText;
				$.messager.alert('提示', "您选择的转校申请的学员课程状态为"+courseStateText+"，不能转入班级，需要走未进班选班流程！");
			} else {
				if("004" == tacheState) {
					var name = row.name;
					var phone = row.phone;
					var byName = row.byName;
					var applyId = row.applyId;
					var studentId = row.studentId;
					var studentCourseId = row.studentCourseId;
					var url = "/sys/changeSchool/updateChangeSchool.jsp?applyId="+applyId+"&studentId="+studentId+"&studentCourseId="+studentCourseId+"&name="+name+"&phone="+phone+"&byName="+byName;
					window.location.href = url;
				} else {
					var changeStateText = row.changeStateText;
					$.messager.alert('提示', "您选择的转班申请的转班状态为"+changeStateText+"，不能更改选班！");
				}
			}
		} else {
			$.messager.alert('提示', "请先选择您要更改选班的转校申请！");
		}
	});
	
	//浏览申请
	$("#view").click(function() {
		var row = $('#apply_list_data').datagrid('getSelected');
		if(row) {
			var applyId = row.applyId;
			window.location.href = "/sys/changeSchool/viewChangeSchool.jsp?applyId="+applyId;
		} else {
			$.messager.alert('提示', "请先选择您要浏览的转校申请！");
		}
	});
	
	//转校审批
	$("#approveBtn").click(function() {
		var row = $('#approve_list_data').datagrid('getSelected');
		if(row) {
			var approveState = row.approveState;
			if("000" == approveState) {
				var applyId = row.applyId;
				var studentId = row.studentId;
				window.location.href = "/sys/changeSchool/approveChangeSchool.jsp?applyId="+applyId+"&studentId="+studentId;
			} else {
				$.messager.alert('提示', "您选择的转校审批已经审批，不能再次审批！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要审批的转校申请！");
		}
	});
	
	//浏览审批
	$("#viewApprove").click(function() {
		var row = $('#approve_list_data').datagrid('getSelected');
		if(row) {
			var applyId = row.applyId;
			window.location.href = "/sys/changeSchool/viewChangeSchool.jsp?applyId="+applyId;
		} else {
			$.messager.alert('提示', "请先选择您要浏览的转校申请！");
		}
	});
});