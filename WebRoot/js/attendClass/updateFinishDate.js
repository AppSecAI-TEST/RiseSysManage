$(document).ready(function() {
	//修改结课时间
	$("#updateFinishDateSubmit").click(function() {
		if($("#updateFinishDateFm").form('validate')) {
			var oldFinishDate = $("#oldFinishDate").val();
			var finishDate = $("#finishDate").datebox("getValue");
			if(oldFinishDate != finishDate) {
				var object = $("#updateFinishDateFm").serializeObject();
				object.finishDate = finishDate;
				var obj = JSON.stringify(object);
				obj = encodeURI(obj);
				$.ajax({
					url: "/sys/attendClass/updateFinishDate.do",
					data: "param=" + obj,
					dataType: "json",
					async: true,
					beforeSend: function() {
						$.messager.progress({title : '修改结课时间', msg : '正在修改结课时间，请稍等……'});
					},
					success: function (data) {
						$.messager.progress('close'); 
						var flag = data.flag;
						if(flag) {
							$.messager.alert('提示', "修改结课时间成功！", "info", function() {window.location.href = '/sys/attendClass/attendClassList.jsp?funcNodeId=${funcNodeId}';});
						} else {
							$.messager.alert('提示', data.msg);
						}
					}
				});
			} else {
				$.messager.alert('提示', "请先修改结课时间！");
			}
		}
	});
});

//查看老师变更历史
function viewChangeTeacherHist() {
	$("#histDlg").dialog("open").dialog("setTitle", "老师变更历史");//设定表头  
}

function viewClassAttendInfo(){
	ajaxLoading("正在处理，请稍待。。。");
	window.location.href = "/sys/attend/getAttenceCalendarView.do?funcNodeId=${funcNodeId}&classInstId=${obj.attendClassObj.classInstId}&flag=view";
}