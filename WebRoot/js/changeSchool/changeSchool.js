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
	
	//转校申请
	$("#changeSchoolBtn").click(function() {
		window.location.href = "/sys/changeSchool/changeStudentList.jsp";
	});
	
	//转出
	$("#changeOutBtn").click(function() {
		var row = $('#apply_list_data').datagrid('getSelected');
		if(row) {
			var tacheState = row.tacheState;
			if("001" == tacheState) {
				var name = row.name;
				var phone = row.phone;
				var byName = row.byName;
				var applyId = row.applyId;
				var studentId = row.studentId;
				var approveDate = row.approveDate;
				var approveName = row.approveName;
				var outClassId = row.outClassId;
				var outClassName = row.outClassName;
				var inSchoolName = row.inSchoolName;
				var outSchoolId = row.outSchoolId;
				var outSchoolName = row.outSchoolName;
				var approveRemark = row.approveRemark;
				var studentCourseId = row.studentCourseId;
				var isFinish = "N";
				var higherStageId = row.higherStageId;
				var oldCourseState = row.oldCourseState;
				if((higherStageId == "" || higherStageId == null || higherStageId == undefined)
						&& (oldCourseState != "" && oldCourseState != null && oldCourseState != undefined && oldCourseState == "009")) {
					isFinish = "Y";
				}
				window.location.href = "/sys/changeSchool/changeOutSchool.jsp?applyId="+applyId+"&studentId="+studentId+"&studentCourseId="+studentCourseId+"&name="+name+"&phone="+phone+"&byName="+byName+"&approveDate="+approveDate+"&approveName="+approveName+"&outClassName="+outClassName+"&inSchoolName="+inSchoolName+"&outSchoolName="+outSchoolName+"&approveRemark="+approveRemark+"&isFinish="+isFinish+"&outSchoolId="+outSchoolId+"&outClassId="+outClassId;
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
					var name = row.name;
					var phone = row.phone;
					var byName = row.byName;
					var applyId = row.applyId;
					var outDate = row.outDate;
					var outName = row.outName;
					var studentId = row.studentId;
					var inSchoolId = row.inSchoolId;
					var approveDate = row.approveDate;
					var approveName = row.approveName;
					var outSchoolName = row.outSchoolName;
					var approveRemark = row.approveRemark;
					var studentCourseId = row.studentCourseId;
					window.location.href = "/sys/changeSchool/changeInSchool.jsp?applyId="+applyId+"&studentId="+studentId+"&studentCourseId="+studentCourseId+"&name="+name+"&phone="+phone+"&byName="+byName+"&approveDate="+approveDate+"&approveName="+approveName+"&outDate="+outDate+"&outName="+outName+"&outSchoolName="+outSchoolName+"&approveRemark="+approveRemark+"&inSchoolId="+inSchoolId;
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
				var outClassName = row.outClassName;
				var outSchoolName = row.outSchoolName;
				var studentCourseId = row.studentCourseId;
				var outClassTeacherName = row.outClassTeacherName;
				var url = "/sys/changeSchool/cancelChangeSchool.jsp?applyId="+applyId+"&studentId="+studentId+"&studentCourseId="+studentCourseId;
				url += "&name="+name+"&phone="+phone+"&byName="+byName+"&outClassName="+outClassName+"&outSchoolName="+outSchoolName+"&outClassTeacherName="+outClassTeacherName;
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
				var name = row.name;
				var phone = row.phone;
				var byName = row.byName;
				var applyId = row.applyId;
				var studentId = row.studentId;
				var schoolName = row.schoolName
				var outClassName = row.outClassName;
				var studentCourseId = row.studentCourseId;
				var outClassTeacherName = row.outClassTeacherName;
				window.location.href = "/sys/changeSchool/approveChangeSchool.jsp?applyId="+applyId+"&studentId="+studentId+"&studentCourseId="+studentCourseId+"&name="+name+"&phone="+phone+"&byName="+byName+"&outClassName="+outClassName+"&schoolName="+schoolName+"&outClassTeacherName="+outClassTeacherName;
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