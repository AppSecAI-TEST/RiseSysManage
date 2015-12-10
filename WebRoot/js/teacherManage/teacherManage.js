$(document).ready(function(){
	initDate();
	//首页面查询
    $("#qryBtn").click(function() {
    	var json = $("#qryFm").serializeObject();
    	json.byName = $("#byName").combobox('getText');
		var obj = JSON.stringify(json);
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
    
});

//跳转档案维页面
function updateFile()
{
	if(validateSelect("list_data")) {
		var row = $("#list_data").datagrid('getSelected');
		var state = row.tState;
		if(state == "P"){
			getTeacherInfo("list_data","update");
		}else{
			$.messager.alert('提示', "只有在职状态的教师才能维护档案！");
		}
	}
}

//跳转预离职页面
function preResign()
{
	if(validateSelect("list_data")) {
		var row = $("#list_data").datagrid('getSelected');
		var state = row.tState;
		if(state == "P"){
			getTeacherInfo("list_data","rl");
		}else{
			$.messager.alert('提示', "只有在职状态的教师才能预离职！");
		}
	}
}

//跳转预离职复职页面
function preResignRegain()
{
	if(validateSelect("list_data")) {
		var row = $("#list_data").datagrid('getSelected');
		var state = row.tState;
		if(state == "R_L"){
			getTeacherInfo("list_data","rlp");
		}else{
			$.messager.alert('提示', "只有预离职状态的教师才能预离职复职！");
		}
	}
}

//跳转离职页面
function resign()
{
	if(validateSelect("list_data")) {
		var row = $("#list_data").datagrid('getSelected');
		var state = row.tState;
		if(state == "R_L"){
			getTeacherInfo("list_data","l");
		}else{
			$.messager.alert('提示', "只有预离职状态的教师才能离职！");
		}
	}
}

//跳转离职复职页面
function resignRegain()
{
	if(validateSelect("list_data")) {
		var row = $("#list_data").datagrid('getSelected');
		var state = row.tState;
		if(state == "L"){
			getTeacherInfo("list_data","lp");
		}else{
			$.messager.alert('提示', "只有离职状态的教师才能离职复职！");
		}
	}
}

//跳转更改组织页面
function updateOrg()
{
	if(validateSelect("list_data")) {
		var row = $("#list_data").datagrid('getSelected');
		var state = row.tState;
		if(state == "P"){
			getTeacherInfo("list_data","org");
		}else{
			$.messager.alert('提示', "只有在职状态的教师才能更换组织！");
		}
	}
}

//跳转浏览页面
function viewTeacherInfo()
{
	if(validateSelect("list_data")) {
		getTeacherInfo("list_data","view");
	}
}

//修改档案提交
function updateFileSubmit()
{
	if($("#updateFm").form('validate')){
		var obj = {};
		obj.teacherId = $("#teacherId").val();
		obj.phone = $("#phone").numberbox('getValue');
		obj.byName = $("#byName").textbox('getValue');
		obj.post = $("#post").combobox('getValue');
		obj.gradeTeam = $("#gradeTeam").combobox('getValue');
		var a = JSON.stringify(obj);
		$.ajax({
			type : "POST",
			url: "/sys/teacherManage/updateTeacherInfo.do",
			data: "json="+JSON.stringify(obj)+"&type=update",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '教师档案维护', msg : '教师档案维护中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "教师档案维护成功！","info",function(){
						goToIndex();
					});
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "教师档案维护失败！");
	    		}
	        } 
		});
	}
}

//预离职提交
function preResignSubmit()
{
	var rlRemark= $("#rlRemark").val();
	rlRemark = string2Json(rlRemark);
	rlRemark = encodeURI(rlRemark);
	var change = {};
	change.teacherId = $("#teacherId").val();
	change.operType = "RL";
	change.operName = "预离职";
	change.description = rlRemark;
	change.handlerId = $("#handlerId").val();
	$.ajax({
		type : "POST",
		url: "/sys/teacherManage/updateTeacherInfo.do",
		data: "json="+JSON.stringify(change)+"&type=R_L",
		async: false,
		beforeSend: function()
    	{
    		$.messager.progress({title : '教师预离职', msg : '教师预离职中，请稍等……'});
    	},
    	success: function(flag) {
    		$.messager.progress('close'); 
    		if(flag == "true"){
    			$.messager.alert('提示', "教师预离职成功！","info",function(){
					goToIndex();
				});
    		}else if(flag == "false"){
    			$.messager.alert('提示', "教师预离职失败！");
    		}
        } 
	});
}

//预离职复职提交
function preResignRegainSubmit()
{
	var rlpRemark= $("#rlpRemark").val();
	rlpRemark = string2Json(rlpRemark);
	rlpRemark = encodeURI(rlpRemark);
	var change = {};
	change.teacherId = $("#teacherId").val();
	change.operType = "RLP";
	change.operName = "预离职复职";
	change.description = rlpRemark;
	change.handlerId = $("#handlerId").val();
	$.ajax({
		type : "POST",
		url: "/sys/teacherManage/updateTeacherInfo.do",
		data: "json="+JSON.stringify(change)+"&type=R_L_P",
		async: false,
		beforeSend: function()
    	{
    		$.messager.progress({title : '教师预离职复职', msg : '教师预离职复职中，请稍等……'});
    	},
    	success: function(flag) {
    		$.messager.progress('close'); 
    		if(flag == "true"){
    			$.messager.alert('提示', "教师预离职复职成功！","info",function(){
					goToIndex();
				});
    		}else if(flag == "false"){
    			$.messager.alert('提示', "教师预离职复职失败！");
    		}
        } 
	});
}

//离职提交
function resignSubmit()
{
	var rRemark= $("#rRemark").val();
	rRemark = string2Json(rRemark);
	rRemark = encodeURI(rRemark);
	var change = {};
	change.teacherId = $("#teacherId").val();
	change.operType = "L";
	change.operName = "离职";
	change.description = rRemark;
	change.handlerId = $("#handlerId").val();
	$.ajax({
		type : "POST",
		url: "/sys/teacherManage/updateTeacherInfo.do",
		data: "json="+JSON.stringify(change)+"&type=L",
		async: false,
		beforeSend: function()
    	{
    		$.messager.progress({title : '教师离职', msg : '教师离职中，请稍等……'});
    	},
    	success: function(flag) {
    		$.messager.progress('close'); 
    		if(flag == "true"){
    			$.messager.alert('提示', "教师离职成功！","info",function(){
					goToIndex();
				});
    		}else if(flag == "false"){
    			$.messager.alert('提示', "教师离职失败！");
    		}
        } 
	});
}

//离职复职提交
function resignRegainSubmit()
{
	var lpRemark= $("#lpRemark").val();
	lpRemark = string2Json(lpRemark);
	lpRemark = encodeURI(lpRemark);
	var change = {};
	change.teacherId = $("#teacherId").val();
	change.operType = "LP";
	change.operName = "离职复职";
	change.description = lpRemark;
	change.handlerId = $("#handlerId").val();
	$.ajax({
		type : "POST",
		url: "/sys/teacherManage/updateTeacherInfo.do",
		data: "json="+JSON.stringify(change)+"&type=L_P",
		async: false,
		beforeSend: function()
    	{
    		$.messager.progress({title : '教师离职复职', msg : '教师离职复职中，请稍等……'});
    	},
    	success: function(flag) {
    		$.messager.progress('close'); 
    		if(flag == "true"){
    			$.messager.alert('提示', "教师离职复职成功！","info",function(){
					goToIndex();
				});
    		}else if(flag == "false"){
    			$.messager.alert('提示', "教师离职复职失败！");
    		}
        } 
	});
}

//更换组织提交
function updateOrgSubmit(){
	var oldSchoolId = $("#oldSchoolId").val();
	var schoolId = $("#schoolST").combobox('getValue');
	if(oldSchoolId == schoolId){
		$.messager.alert('提示', "组织没有发生改变！");
		return;
	}
	if(schoolId == ""){
		$.messager.alert('提示', "请选择一个组织！");
		return;
	}
	var schoolName = $("#schoolST").combobox('getText');
	var remark= $("#remark").val();
	remark = string2Json(remark);
	remark = encodeURI(remark);
	var change = {};
	change.teacherId = $("#teacherId").val();
	change.schoolId = schoolId;
	change.operType = "ORG";
	change.operName = "转校至"+schoolName;
	change.description = remark;
	change.handlerId = $("#handlerId").val();
	$.ajax({
		type : "POST",
		url: "/sys/teacherManage/updateTeacherInfo.do",
		data: "json="+JSON.stringify(change)+"&type=ORG",
		async: false,
		beforeSend: function()
    	{
    		$.messager.progress({title : '教师更换组织', msg : '教师更换组织中，请稍等……'});
    	},
    	success: function(flag) {
    		$.messager.progress('close'); 
    		if(flag == "true"){
    			$.messager.alert('提示', "教师更换组织成功！","info",function(){
					goToIndex();
				});
    		}else if(flag == "false"){
    			$.messager.alert('提示', "教师更换组织失败！");
    		}
        } 
	});
}

//获取教师信息
function getTeacherInfo(obj,type)
{
	var row = $("#"+obj+"").datagrid('getSelected');
	var teacher = {};
	teacher.teacherId = row.teacherId;
	teacher.schoolId = row.schoolId;
	teacher.schoolName = row.schoolName;
	teacher.teacherName = row.teacherName;
	teacher.byname = row.byname;
	teacher.stateVal = row.stateVal;
	teacher.phone = row.phone;
	teacher.post = row.post;
	teacher.postVal = row.postVal;
	teacher.joinDate = row.joinDate;
	teacher.joinTime = row.joinTime;
	teacher.nationality = row.nationality;
	teacher.stageIds = row.stageIds;
	teacher.classNames = row.classNames;
	teacher.licenses = row.licenses;
	teacher.gradeTeam = row.gradeTeam;
	teacher.gradeTeamVal = row.gradeTeamVal;
	teacher.trainingStageIds = row.trainingStageIds;
	window.location.href = "/sys/teacherManage/viewTeacherInfo.do?json="+JSON.stringify(teacher)+"&type="+type;
}

function goToIndex()
{
	window.location.href = "/sys/teacherManage/qryTeacherList.jsp";
}

function validateSelect(object)
{
	var flag = false;
	var obj = $("#"+object+"").datagrid('getSelections');
	if(obj.length > 0) {
		if(obj.length > 1) {
			$.messager.alert('提示', "只能选择一个教师进行操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择您要操作的教师！");
	}
	return flag;
}

function initDate()
{
	var curr_time = new Date();
	$('#joinEndDate').datebox('setValue', myformatter(curr_time));
	curr_time.setMonth(curr_time.getMonth() - 1);
	$('#joinStartDate').datebox('setValue', myformatter(curr_time));
}