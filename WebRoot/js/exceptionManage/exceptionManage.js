$(document).ready(function(){
	//首页面查询
    $("#qryBtn").click(function() {
		var obj = JSON.stringify($("#qryFm").serializeObject());
		obj = obj.substring(0, obj.length - 1);
		var funcNodeId = $("#qryBtn").attr("funcNodeId");
		obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
		$('#list_data').datagrid({
			url : "/sys/expManage/qryDataListByPage.do",
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

//跳转客户维护页面
function updateExp()
{
	if(validateSelect("list_data")) {
		var row = $('#list_data').datagrid('getSelected');
		var studentId = row.studentId;
		var studentCourseId = row.studentCourseId;
		var expType = row.expType;
		var expInfo = {};
		expInfo.expTypeVal = row.exceptionTypeVal;
		expInfo.expDate = row.expDate;
		expInfo.followCount = row.followCount;
		expInfo.expedTime = row.expedTime;
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
		var expType = row.expType;
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