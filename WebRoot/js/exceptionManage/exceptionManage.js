$(document).ready(function(){
	//首页面查询
    $("#qryBtn").click(function() {
    	var object = $("#qryFm").serializeObject();
    	var funcNodeId = "";
    	var expType = $("#expType").combobox("getValue");
    	if("new_not_in_class" == expType) { //新招未进班
    		funcNodeId = "1077";
    	} else if("higher_not_in_class" == expType) { //升学未进班
    		funcNodeId = "1077";
    	} else if("reread_not_in_class" == expType) { //复读未进班
    		funcNodeId = "1077";
    	} else if("new_not_in_change_school" == expType) { //新招未进班转校
    		funcNodeId = "1078";
    	} else if("higher_not_in_change_school" == expType) { //升学未进班转校
    		funcNodeId = "1078";
    	} else if("reread_not_in_change_school" == expType) { //复读未进班转校
    		funcNodeId = "1078";
    	} else if("study_change_school" == expType) { //在读转校
    		funcNodeId = "1078";
    	} else if("study_change_class" == expType) { //转班
    		funcNodeId = "1079";
    	} else if("exception" == expType) { //异常
    		funcNodeId = "1080";
    	} else if("leave" == expType) { //休学
    		funcNodeId = "1081";
    	}
    	object.expType = expType;
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
    
    //重置
	$("#reset").click(function() {
		$("#qryFm").form('clear');//清空窗体数据  
		var data = $("#schoolId").combobox("getData");
		if(data.length > 0) {
			$("#schoolId").combobox("setValue", data[0].schoolId);
		}
		data = $("#expType").combobox("getData");
		if(data.length > 0) {
			$("#expType").combobox("setValue", data[0].codeFlag);
		}
	});
	
	//校区
	var staffId = $("#staffId").val();
	$("#schoolId").combobox({
    	url : "/sys/pub/pageCategory.do?staffId=" + staffId + "&resourceId=711&fieldId=schoolId",
    	valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
    	onLoadSuccess : function() {
    		var data = $("#schoolId").combobox("getData");
    		if(data.length == 1) {
    			$("#schoolId").combobox("setValue", data[0].schoolId);
    		}
    	},
    	onChange : function(n, o) {
    		$("#dutyAdvister").combobox({
    			url : "/sys/pubData/qryStaffList.do?post=16,17&schoolId=" + n,
    			valueField : "staffId",
    	    	textField : "userName",
    	    	panelHeight : "auto",
    	    	formatter : function(data) {
    	    		return "<span>" + data.userName + "</span>";
    	    	}
    		});
    		$("#carer").combobox({
    			url : "/sys/pubData/qryStaffList.do?post=31,32,33&schoolId=" + n,
    			valueField : "staffId",
    	    	textField : "userName",
    	    	panelHeight : "auto",
    	    	formatter : function(data) {
    	    		return "<span>" + data.userName + "</span>";
    	    	}
    		});
    		$("#teacherId").combobox({
				url : "/sys/pubData/qryTeacherList.do?schoolId="+n+"&stageId=",//返回json数据的url
				valueField : "teacherId",
				textField : "byname",
				panelHeight : "auto",
				formatter : function(data) {
					return "<span>" + data.byname + "</span>";
				}
			});
    	}
    });
});

//跳转客户维护页面
function updateExp()
{
	if(validateSelect("list_data")) {
		var row = $('#list_data').datagrid('getSelected');
		var studentId = row.studentId;
		var studentCourseId = row.studentCourseId;
		var expType = row.exceptionType;
		var expInfo = {};
		expInfo.expTypeVal = row.exceptionTypeText;
		expInfo.expDate = row.exceptionBeginDate;
		expInfo.followCount = row.careNum;
		expInfo.expedTime = row.exceptionDays;
		window.location.href = "/sys/expManage/viewExpStuInfo.do?studentId="+studentId+"&studentCourseId="+studentCourseId+"&expType="+expType+"&json="+JSON.stringify(expInfo);
	}
}

//跳转异动浏览页面
function viewExpInfo()
{
	if(validateSelect("list_data")) {
		var row = $('#list_data').datagrid('getSelected');
		var studentId = row.studentId;
		var studentCourseId = row.studentCourseId;
		var expType = row.exceptionType;
		window.location.href = "/sys/expManage/qryExpStuDetailInfo.do?studentId="+studentId+"&studentCourseId="+studentCourseId+"&expType="+expType;
	}
}

//打开异动跟进历史页面
function viewFollowHis(studentId,expType,studentCourseId)
{
	$('#dlg').dialog({
		title:"查看跟进历史",
	});
	$('#dlg').attr("src","/sys/exceptionManage/followHistory.jsp?studentId="+studentId+"&expType="+expType+"&studentCourseId="+studentCourseId);
	$('#dlg').dialog("open");
}

//新增异动跟进信息
function addStuExpFollowInfo()
{
	var studentId = $("#studentId").val();
	var studentCourseId = $("#studentCourseId").val();
	var exceptionType = $("#expType").val();
	var handlerId = $("#handlerId").val();
	var createDate = $("#createDate").datebox('getValue');
	if(createDate == "" || createDate == undefined){
		$.messager.alert('提示', "请选择跟进时间！");
		return;
	}
	var remark = $("#remark").val();
	remark = string2Json(remark);
	remark = encodeURI(remark);
	var care = {};
	care.studentId = studentId;
	care.studentCourseId = studentCourseId;
	care.exceptionType = exceptionType;
	care.handlerId = handlerId;
	care.createDate = createDate;
	care.remark = remark;
	$.ajax({
		type : "POST",
		url: "/sys/expManage/addStuExpFollowInfo.do",
		data: "json="+JSON.stringify(care),
		async: false,
		beforeSend: function()
    	{
    		$.messager.progress({title : '新增异动跟进记录', msg : '新增异动跟进记录中，请稍等……'});
    	},
    	success: function(flag) {
    		$.messager.progress('close'); 
    		if(flag == "true"){
    			$.messager.alert('提示', "新增异动跟进记录成功！","info",function(){
    				window.location.href = "/sys/exceptionManage/exceptionManage.jsp";
				});
    		}else if(flag == "false"){
    			$.messager.alert('提示', "新增异动跟进记录失败！");
    		}
        } 
	});
}

function validateSelect(object)
{
	var flag = false;
	var obj = $("#"+object+"").datagrid('getSelections');
	if(obj.length > 0) {
		if(obj.length > 1) {
			$.messager.alert('提示', "只能选择一个异动学员进行操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择您要操作的异动学员！");
	}
	return flag;
}