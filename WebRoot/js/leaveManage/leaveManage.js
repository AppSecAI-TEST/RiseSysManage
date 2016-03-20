$(document).ready(function(){
//	initDate();
	//首页面查询
    $("#qryBtn").click(function() {
    	var schoolId = $("#schoolId").combobox("getValue");
    	if(schoolId != ""){
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
    	}else{
			showMessage("提示","没有有效的校区可供查询",null);
		}
    });
    
    //首页面重置
     $("#resetBtn").click(function() 
    {
    	$("#qryFm").form('clear');//清空窗体数据  
    	//校区赋默认值
    	if($("#schoolId").combobox("getData").length>0){
    		$("#schoolId").combobox("select",$("#schoolId").combobox("getData")[0].schoolId);
    	}
    });
    
    //查询可以休学的学员
     $("#qryStuBtn").click(function() {
    	var schoolId = $("#stuSchoolId").combobox("getValue");
    	if(schoolId != ""){
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
    	}else{
			showMessage("提示","没有有效的校区可供查询",null);
		}
    });
    
    //定位学员页面重置
     $("#stuResetBtn").click(function() 
    {
    	$("#qryStuFm").form('clear');//清空窗体数据  
    	//校区赋默认值
    	if($("#stuSchoolId").combobox("getData").length>0){
    		$("#stuSchoolId").combobox("select",$("#stuSchoolId").combobox("getData")[0].schoolId);
    	}
    });
     
    //上传
    $("#uploadBtn").click(function() {
    	var fileName = $("#fileName").filebox("getValue");
    	if(fileName != "" && fileName != null && fileName != undefined) {
    		var schoolId = $("#schoolId").val();
    		var handlerId = $("#handlerId").val();
    		$("#addLeaveForm").form("submit", {
    			url: "/sys/fileUpload?type=leave&schoolId="+schoolId+"&handlerId="+handlerId,
    			onSubmit: function () {
    				
    			},
    			success: function (result) {
    				var data = JSON.parse(result);
    				if(data.flag)
    				{
    					$("#imgUrl").val(data.fileId);
    					$.messager.alert('提示', "文件上传成功！", "info", function() {$("#cancelUploadBtn").linkbutton('disable');});
    				}
    				else
    				{
    					$.messager.alert('提示', data.msg);
    				}
    			}
    		});
    	} else {
    		$.messager.alert('提示', "请您先选择一个文件！");
    	}
    });
    
    //取消上传
    $("#cancelUploadBtn").click(function() {
    	var fileName = $("#fileName").filebox("setValue", "");
    });
     
});

//跳转到查询可以休学学员页面
function addLeave()
{
	window.location.href = "/sys/leaveManage/qryCanLeaveStu.jsp";
}

//跳转复课页面，有限制条件，超期、已经复课和终止不能复课
function restartClass()
{
	if(validateSelect("list_data")) {
		var row = $('#list_data').datagrid('getSelected');
		var studentId = row.studentId;
		var leaveState = row.leaveState;
		var resumeType = row.resumeType;
		if(leaveState != "001" || (leaveState == '001' && resumeType != "")){
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
		var resumeType = row.resumeType;
		if(leaveState == "003" || leaveState == "004" || resumeType != ""){
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
	    		if(flag == "true") {
	    			var studentCourseId = $("#studentCourseId").val();
	    			if(resumeType == "001") {
	    				$.messager.alert('提示', "原班复课成功！","info",function(){
	    				window.location.href = "/sys/leaveManage/qryLeaveInfo.jsp";
					});
	    			} else if(resumeType == "002") {
	    				window.location.href = "/sys/changeClass/applyChangeClass.jsp?studentCourseId="+studentCourseId+"&changeSource=leave";
	    			} else if(resumeType == "003") {
						window.location.href = "/sys/changeSchool/applyChangeSchool.jsp?studentId="+studentId+"&changeSource=leave";
	    			}
	    		} else if(flag == "false") {
	    			if(resumeType == "001") {
	    				$.messager.alert('提示', "原班课程已结课，无法原班复课！");
	    			} else if(resumeType == "002") {
	    				$.messager.alert('提示', "有待审批的转班申请单，无法转班复课！");
	    			} else if(resumeType == "003") {
	    				$.messager.alert('提示', "有待审批的转校申请单，无法转校复课！");
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
	var leaveStartDate = $("#leaveStartDate").html();
	var leaveMaxDate = new Date(leaveStartDate).dateAdd("m",parseInt(24)).format("yyyy-MM-dd");
	var date = new Date().format("yyyy-MM-dd");
	if(delayDate <= leaveDate){
		$.messager.alert('提示', "延期的日期不能小于计划休学日期！");
		return;
	}
	if(delayDate < date){
		$.messager.alert('提示', "延期的日期不能小于当前日期！");
		return;
	}
	if(leaveMaxDate < delayDate){
		$.messager.alert('提示', "延期的日期不能大于"+leaveMaxDate+"！");
		return;
	}
	var handlerId = $("#handlerId").val();
	var leaveId = $("#leaveId").val();
	var updateRemark = $("#updateRemark").val();
	updateRemark = string2Json(updateRemark);
	updateRemark = encodeURI(updateRemark);
//	if(updateRemark == "" || updateRemark == undefined){
//		$.messager.alert('提示', "备注信息不能为空！");
//		return;
//	}
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
    			$.messager.alert('提示', "修改休学时长成功！","info",function(){
	    			window.location.href = "/sys/leaveManage/qryLeaveInfo.jsp";
				});
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
		var schoolId = row.schoolId;
		var courseState = row.courseState;
		var studentCourseId = row.studentCourseId;
		var stageLevel = row.stageLevel;
		var classInstId = row.classInstId;
		var className = row.className;
		var teacherName = row.teacherName;
		var classProgress = encodeURIComponent(row.classProgress);
		var funcNodeId = "";
		window.location.href = "/sys/leaveManage/viewLeaveInfo.do?studentId="+studentId+"&schoolId="+schoolId+"&courseState="+courseState+"&studentCourseId="+studentCourseId+"&funcNodeId="+funcNodeId+"&type=add&currentHours="+classProgress+"&stageLevel="+stageLevel+"&classInstId="+classInstId+"&className="+className+"&teacherName="+teacherName;
	}
}

//新增休学提交
function addLeaveSubmit()
{
	if($("#addLeaveForm").form('validate')){
		var flag = true;
		var fileName = $("#fileName").filebox("getValue");
		if(fileName != "" && fileName != null && fileName != undefined) {
			var imgUrl = $("#imgUrl").val();
			if(imgUrl == "" || imgUrl == null || imgUrl == undefined) {
				flag = false;
			}
		}
		if(flag) {
			var planLeaveTime = $("#planLeaveTime").val();
			var addRemark = $("#addRemark").val();
			addRemark = string2Json(addRemark);
			addRemark = encodeURI(addRemark);
			var studentId = $("#studentId").val();
			var courseState = $("#courseState").val();
			var studentCourseId = $("#studentCourseId").val();
			var stageLevel = $("#stageLevel").val();
			var classInstId = $("#classInstId").val();
			var className = $("#className").val();
			var teacherName = $("#teacherName").val();
			var currentHours = $("#currentHours").val();
			var handlerId = $("#handlerId").val();
			var imgUrl = $("#imgUrl").val();
	//		var createDate = new Date().format("yyyy-MM-dd");
			//计算出 休学到期日期
	//		var leaveDate = new Date().dateAdd("m",parseInt(planLeaveTime)).format("yyyy-MM-dd");
			var json = '{"studentId":"'+studentId+'","studentCourseId":"'+studentCourseId+'","leaveState":"001","leaveTime":"'+planLeaveTime+'","stageLevel":"'+stageLevel+'","orignClassId":"'+classInstId+'","orignClassName":"'+className+'","orignCourseState":"'+courseState+'","teacherNames":"'+teacherName+'","hours":"'+encodeURIComponent(currentHours)+'","imgUrl":"'+imgUrl+'","leaveReason":"'+addRemark+'","handlerId":"'+handlerId+'"}';
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
		    		if(flag == "true") {
		    			$.messager.alert('提示', "休学成功！", "info", function() {back();});
		    		} else if(flag == "false") {
		    			$.messager.alert('提示', "休学失败！");
		    		}
		        } 
			});
		}else {
			$.messager.alert('提示', "请您先上传文件！");
		}
	}
}

function back() {
	var channel = $("#channel").val();
	if("attend" == channel) {
		var funcNodeId = $("#funcNodeId").val();
		var classInstId = $("#classInstId").val();
		window.location.href = "/sys/attendClass/qryAttendClass.do?classInstId="+classInstId+"&type=maintenance&funcNodeId="+funcNodeId;
	} else {
		window.location.href = "/sys/leaveManage/qryLeaveInfo.jsp"
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