$(document).ready(function(){
	initDate();
	//首页面查询
    $("#qryBtn").click(function() {
		var obj = JSON.stringify($("#qryFm").serializeObject());
		obj = obj.substring(0, obj.length - 1);
		var funcNodeId = $("#qryBtn").attr("funcNodeId");
		obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
		$('#list_data').datagrid({
			url : "/sys/leaveManage/qryDataListByPage.do",
			queryParams:{
				param : obj
			},
			onLoadSuccess:function(){
				//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
				$('#list_data').datagrid('clearSelections');
			}
		});
    });
    
    //查询可以休学的学员
     $("#qryStuBtn").click(function() {
		var obj = JSON.stringify($("#qryStuFm").serializeObject());
		obj = obj.substring(0, obj.length - 1);
		var funcNodeId = $("#qryStuBtn").attr("funcNodeId");
		obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
		$('#stuList_data').datagrid({
			url : "/sys/pubData/qryDataListByPage.do",
			queryParams:{
				param : obj
			},
			onLoadSuccess:function(){
				//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
				$('#stuList_data').datagrid('clearSelections');
			}
		});
    });
    
});

//跳转到查询可以休学学员页面
function addLeave()
{
	window.location.href = "/sys/leaveManage/qryCanLeaveStu.jsp";
}

//跳转复课页面，有限制条件，已经复课和终止不能复课
function restartClass()
{
	if(validateSelect("list_data")) {
		var row = $('#list_data').datagrid('getSelected');
		var studentId = row.studentId;
		var leaveState = row.leaveState;
		if(leaveState != "001" ){
			$.messager.alert('提示', "该学员不能复课！");
			return;
		}
		var funcNodeId = "";
		var leaveId = row.leaveId;
		window.location.href = "/sys/leaveManage/viewLeaveInfo.do?studentId="+studentId+"&leaveId="+leaveId+"&funcNodeId="+funcNodeId+"&type=restart";
	}
}

//跳转浏览页面
function viewLeaveInfo()
{
	if(validateSelect("list_data")) {
		var row = $('#list_data').datagrid('getSelected');
		var studentId = row.studentId;
		var funcNodeId = "";
		var leaveId = row.leaveId;
		window.location.href = "/sys/leaveManage/viewLeaveInfo.do?studentId="+studentId+"&leaveId="+leaveId+"&funcNodeId="+funcNodeId+"&type=view";
	}
}

//跳转修改休学时长页面
function updateLeaveTime()
{
	if(validateSelect("list_data")) {
		var row = $('#list_data').datagrid('getSelected');
		var studentId = row.studentId;
		var leaveState = row.leaveState;
		if(leaveState == "003" || leaveState == "004"){
			$.messager.alert('提示', "该学员不能修改休学时长！");
			return;
		}
		var funcNodeId = "";
		var leaveId = row.leaveId;
		window.location.href = "/sys/leaveManage/viewLeaveInfo.do?studentId="+studentId+"&leaveId="+leaveId+"&funcNodeId="+funcNodeId+"&type=update";
	}
}

//复课提交 001原班复课 002转班复课 003转校复课
function restartSubmit()
{
	var resumeType = $("input[name='resumeType']:checked").val();
	if(resumeType == undefined || resumeType == ""){
		$.messager.alert('提示', "请先选择复课方式后再提交！");
	}else{
		var handlerId = $("#handlerId").val();
		var studentId = $("#studentId").val();
		var leaveId = $("#leaveId").val();
		var studentCourseId = $("#studentCourseId").val();
		$.ajax({
			type : "POST",
			url: "/sys/leaveManage/restartClass.do",
			data: "studentId="+studentId+"&leaveId="+leaveId+"&resumeType="+resumeType+"&studentCourseId="+studentCourseId+"&handlerId="+handlerId,
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '复课', msg : '正在复课，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			if(resumeType == "001"){
	    				$.messager.alert('提示', "原班复课成功！");
	    				window.location.href = "/sys/leaveManage/qryLeaveInfo.jsp";
	    			}
	    			if(resumeType == "002"){
	    				var studentCourseId = $("#studentCourseId").val();
						var studentId = $("#studentId").val();
						var byName = $("#byName").val();
						var changeClassNum = $("#changeClassNum").val();
						var className = $("#className").val();
						var classProgress = $("#classProgress").val();
						var courseStateText = "休学";
						var name = $("#name").val();
						var phone = $("#phone").val();
						var teacherName = $("#teacherName").val();
						var schoolId = $("#schoolId").val();
						var classInstId = $("#classInstId").val();
						var classType = $("#classType").val();
						var schoolName = $("#schoolName").val();
						var stageId = $("#stageId").val();
	    				window.location.href = "/sys/changeClass/applyChangeClass.jsp?studentCourseId="+studentCourseId+"&studentId="+studentId+"&byName="+byName+"&changeClassNum="+changeClassNum+"&className="+className+"&classProgress="+encodeURIComponent(classProgress)+"&courseStateText="+courseStateText+"&name="+name+"&phone="+phone+"&teacherName="+teacherName+"&schoolId="+schoolId+"&schoolName="+schoolName+"&classInstId="+classInstId+"&classType="+classType+"&stageId="+stageId;
	    			}
	    			if(resumeType == "003"){
	    				var name = $("#name").val();
						var phone = $("#phone").val();
						var byName = $("#byName").val();
						var schoolId = $("#schoolId").val();
						var studentId = $("#studentId").val();
						var schoolName = $("#schoolName").val();
						var classInstId = $("#classInstId").val();
						var studentCourseId = $("#studentCourseId").val();
						var currentClassName = $("#className").val();
						var adviserTeacherName = $("#teacherName").val();
						window.location.href = "/sys/changeSchool/applyChangeSchool.jsp?studentCourseId="+studentCourseId+"&studentId="+studentId+"&schoolId="+schoolId+"&schoolName="+schoolName+"&name="+name+"&byName="+byName+"&phone="+phone+"&currentClassName="+currentClassName+"&adviserTeacherName="+adviserTeacherName+"&classInstId="+classInstId;
	    			}
	    		}else if(flag == "false"){
	    			if(resumeType == "001"){
	    				$.messager.alert('提示', "原班课程已结课，无法原班复课！");
	    			}
	    			if(resumeType == "002"){
	    				$.messager.alert('提示', "有待审批的转班申请单，无法转班复课！");
	    			}
	    			if(resumeType == "003"){
	    				$.messager.alert('提示', "有待审批的转校申请单，无法转班复课！");
	    			}
	    		}
	        } 
		});
	}
}

//修改休学时长
function updateSubmit()
{
	var delayDate = $("#delayDate").datebox("getValue");
	var leaveDate = $("#leaveDate").val();
	if(delayDate <= leaveDate){
		$.messager.alert('提示', "延期的日期不能小于计划休学日期！");
		return;
	}
	var handlerId = $("#handlerId").val();
	var leaveId = $("#leaveId").val();
	var updateRemark = $("#updateRemark").val();
	updateRemark = string2Json(updateRemark);
	updateRemark = encodeURI(updateRemark);
	if(updateRemark == "" || updateRemark == undefined){
		$.messager.alert('提示', "备注信息不能为空！");
		return;
	}
	$.ajax({
		type : "POST",
		url: "/sys/leaveManage/updateLeaveTime.do",
		data: "leaveId="+leaveId+"&delayDate="+delayDate+"&updateRemark="+updateRemark+"&handlerId="+handlerId,
		async: false,
		beforeSend: function()
    	{
    		$.messager.progress({title : '修改休学时长', msg : '正在修改休学时长，请稍等……'});
    	},
    	success: function(flag) {
    		$.messager.progress('close'); 
    		if(flag == "true"){
    			$.messager.alert('提示', "修改休学时长成功！");
    			window.location.href = "/sys/leaveManage/qryLeaveInfo.jsp";
    		}else if(flag == "false"){
    			$.messager.alert('提示', "修改休学时长失败！");
    		}
        } 
	});
}

//跳转新增休学页面
function addLeaveInfo()
{
	if(validateSelect("stuList_data")) {
		var row = $('#stuList_data').datagrid('getSelected');
		var studentId = row.studentId;
		var courseState = row.courseState;
		var studentCourseId = row.studentCourseId;
		var classProgress = row.classProgress;
		var funcNodeId = "";
		window.location.href = "/sys/leaveManage/viewLeaveInfo.do?studentId="+studentId+"&courseState="+courseState+"&studentCourseId="+studentCourseId+"&funcNodeId="+funcNodeId+"&type=add&currentHours="+classProgress;
	}
}

//新增休学提交
function addLeaveSubmit()
{
	if($("#addLeaveForm").form('validate')){
		var planLeaveTime = $("#planLeaveTime").val();
		var addRemark = $("#addRemark").val();
		addRemark = string2Json(addRemark);
		addRemark = encodeURI(addRemark);
		var studentId = $("#studentId").val();
		var courseState = $("#courseState").val();
		var studentCourseId = $("#studentCourseId").val();
		var currentHours = $("#currentHours").val();
		var handlerId = $("#handlerId").val();
//		var createDate = new Date().format("yyyy-MM-dd");
		//计算出 休学到期日期
//		var leaveDate = new Date().dateAdd("m",parseInt(planLeaveTime)).format("yyyy-MM-dd");
		var json = '{"studentId":"'+studentId+'","studentCourseId":"'+studentCourseId+'","leaveState":"001","leaveTime":"'+planLeaveTime+'","orignCourseState":"'+courseState+'","hours":"'+currentHours+'","leaveReason":"'+addRemark+'","handlerId":"'+handlerId+'"}';
		$.ajax({
			type : "POST",
			url: "/sys/leaveManage/addLeaveInfo.do",
			data: "json="+json,
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '提交休学', msg : '正在提交休学，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "休学成功！");
	    			window.location.href = "/sys/leaveManage/qryLeaveInfo.jsp";
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "休学失败！");
	    		}
	        } 
		});
	}
		
}

function validateSelect(object)
{
	var flag = false;
	var obj = $("#"+object+"").datagrid('getSelections');
	if(obj.length > 0) {
		if(obj.length > 1) {
			$.messager.alert('提示', "只能选择一个学员进行操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择您要操作的学员！");
	}
	return flag;
}

function initDate()
{
	var curr_time = new Date();
	$('#createEndTime').datebox('setValue', myformatter(curr_time));
	curr_time.setMonth(curr_time.getMonth() - 1);
	$('#createStartTime').datebox('setValue', myformatter(curr_time));
}