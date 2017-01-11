$(document).ready(function() {
	$("#changeStudentNumBtn").click(function() {
		if($("baseNumStudentFm").form("validate")) {
			var flag = true;
			/*var studentHigherBaseNum = $("#studentHigherBaseNum").textbox("getValue");
			if(studentHigherBaseNum != "0" && studentHigherBaseNum != "1" 
				&& studentHigherBaseNum != "0.0" && studentHigherBaseNum != "1.0") {
				flag = false;
				$.messager.alert('提示', "升学基数只能调整为0、1！");
			}*/
			if(flag) {
				/*var studentHigherNum = $("#studentHigherNum").textbox("getValue");
				if(studentHigherNum != "0" && studentHigherNum != "1" 
					&& studentHigherNum != "0.0" && studentHigherNum != "1.0") {
					flag = false;
					$.messager.alert('提示', "已升学人数只能调整为0、1！");
				}*/
				if(flag) {
					var handlerId = $("#handlerId").val();
					var classInstId = $("#classInstId").val();
					var object = $("#baseNumStudentFm").serializeObject();
					/*var studentHigherBaseNum = $("#studentHigherBaseNum").textbox("getValue");
					if(studentHigherBaseNum == "1.0" || studentHigherBaseNum == "0.0") {
						object.studentHigherBaseNum = parseInt(studentHigherBaseNum.substring(0, 1));
					}
					var studentHigherNum = $("#studentHigherNum").textbox("getValue");
					if(studentHigherNum == "1.0" || studentHigherNum == "0.0") {
						object.studentHigherNum = parseInt(studentHigherNum.substring(0, 1));
					}*/
					object.handlerId = handlerId;
					object.classInstId = classInstId;
					var obj = JSON.stringify(object);
					obj = encodeURI(obj);
					$.ajax({
						url: "/sys/baseNum/change.do",
						data: "param=" + obj,
						dataType: "json",
						async: false,
						beforeSend: function() {
							$.messager.progress({title : '调整基数', msg : '正在处理中，请稍等……'});
						},
						success: function (data) {
							$.messager.progress('close'); 
							if(data.flag) {
								$.messager.alert('提示', "调整基数成功！", "info", function() {reload();});
							} else {
								$.messager.alert('提示', data.msg);
							}
						} 
					});
				}
			}
		}
	});
});

function reload() {
	$('#dlg').dialog('close');
	var classInstId = $("#classInstId").val();
	window.location.href = "/sys/attendClass/qryAttendClass.do?classInstId=" + classInstId + "&type=numChange&funcNodeId=${funcNodeId}";
}

function changeStudentBaseNum(baseNumStudentId) {
	$("#dlg").dialog('open').dialog('setTitle', '调整班级学员基数');//设定表头  
	$('#baseNumStudentFm').form('clear');//清空窗体数据  
	var rows = $('#list_data').datagrid('getRows');
	if(rows.length > 0) {
		for(var i = 0, n = rows.length; i < n; i++) {
			if(baseNumStudentId == rows[i].baseNumStudentId) {
				$("#name").html(rows[i].name);
				$("#byName").html(rows[i].byName);
				var higherNum = rows[i].higherNum;
				var studyingNum = rows[i].studyingNum;
				var higherBaseNum = rows[i].higherBaseNum;
				$("#studyingNumText").html(studyingNum);
				$("#higherBaseNumText").html(higherBaseNum);
				$("#higherNumText").html(higherNum);
				$("#baseNumId").val(rows[i].baseNumId);
				$("#studentId").val(rows[i].studentId);
				$("#studentCourseId").val(rows[i].studentCourseId);
				$("#baseNumStudentId").val(rows[i].baseNumStudentId);
				$("#originStudentHigherNum").val(higherNum);
				$("#originStudentStudyingNum").val(studyingNum);
				$("#originStudentHigherBaseNum").val(higherBaseNum);
			}
		}
	}
}