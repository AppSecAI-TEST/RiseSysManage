var td = 1;
$(document).ready(function() {
	var classInstId = $("#classInstId").val();
	$.ajax({
		url: "/sys/applyClass/qryCreateClassById.do",
		data: "classInstId=" + classInstId,
		dataType: "json",
		async: false,
		beforeSend: function()
		{
			$.messager.progress({title : '班级维护', msg : '正在查询班级信息，请稍等……'});
		},
		success: function (data) {
    		$.messager.progress('close'); 
    		$("#stageId").html(data.createClassObj.stageId);
    		$("#classType").html(data.createClassObj.classType);
    		$("#className").html(data.createClassObj.className);
    		$("#effectDate").datebox("setValue", data.createClassObj.effectDate);
    		$("#studentChannelTypeVal").html(data.createClassObj.studentChannelTypeVal);
    		$("#higherSchoolName").html(data.createClassObj.higherSchoolName);
    		$("#Applyremark").html(data.createClassObj.remark);
    		$("#schoolId").val(data.createClassObj.schoolId);
    		
    		var schooltimeLength = data.schooltimeObj.total;
    		if(schooltimeLength > 0) {
    			var content = "";
    			$.each(data.schooltimeObj.rows, function(i, obj){
    				content += "<tr><td align='right' width='10%'><span id='schooltimeNameTd'>上课时段 ：</span></td>";
    				content += "<td width='20%'><span id='schooltimeName'>"+ obj.schooltimeName +"</span></td>";
    				content += "<td align='right' width='10%'><span>教室：</span></td>";
    				content += "<td width='20%'><span id='roomName'>"+ obj.roomName +"</span></td>";
    				content += "<td align='right' width='10%'><span>课时：</span></td>";
    				content += "<td width='30%'><span id='lessionHours'>"+ obj.lessionHours +"</span></td></tr>";
    				content += "<tr><td align='right' width='10%'><span>带班老师：</span></td>";
    				content += "<td width='90%' colspan='5'><span id='schoolTeacherName'>"+ obj.schoolTeacherName + " " + obj.lessionHours +"课时</span></td></tr>";
    			});
    			$("#cancelApplyClassTd tr:eq("+td+")").after(content);
    		}
		}
	});
	
	$("#selectClass").click(function() {
		var classType = $("#classType").html();
		var schoolId = $("#schoolId").val();
		var className = $("#className").html();
		var classInstId = $("#classInstId").val();
		window.location.href = "/sys/applyClass/studentCourseList.jsp?classType="+classType+"&schoolId="+schoolId+"&className="+className+"&classInstId="+classInstId;
	});
	
	$("#removeStudent").click(function() {
		var obj = $('#list_data').datagrid('getSelections');
		if(obj.length > 0) {
			$.messager.confirm('提示','您确定要移除当前选中的学员吗?',function(r){
				if(r){
					var classStudentId = "";
					var studentCourseId = "";
					for(var i = 0, n = obj.length; i < n; i++) {
						classStudentId += obj[i].classStudentId + ",";
						studentCourseId += obj[i].studentCourseId + ",";
					}
					classStudentId = classStudentId.substring(0, classStudentId.length - 1);
					studentCourseId = studentCourseId.substring(0, studentCourseId.length - 1);
					var handlerId = $("#handlerId").val();
					var param = "{\"classStudentId\":\""+classStudentId+"\",\"studentCourseId\":\""+studentCourseId+"\",\"handlerId\":\""+handlerId+"\"}";
					$.ajax({
						url: "/sys/applyClass/batchRemoveStudent.do",
						data: "param=" + param,
						dataType: "json",
						async: false,
						beforeSend: function()
						{
							$.messager.progress({title : '学员移除', msg : '正在学员移除，请稍等……'});
						},
						success: function (data) {
							$.messager.progress('close'); 
							var flag = data.flag
							if(flag) {
								$.messager.alert('提示', "学员移除成功！");
								window.location.reload();
							} else {
								$.messager.alert('提示', "学员移除失败！");
							}
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', "请先选择您要移除的学员！");
		}
	});
	
	$("#changeClass").click(function() {
		if(validateSelect()) {
			var row = $('#list_data').datagrid('getSelected');
			var studentId = row.studentId;
			var classInstId = row.classInstId;
			var stageId = $("#stageId").html();
			var classType = $("#classType").html();
			var studentCourseId = row.studentCourseId;
			window.location.href = "/sys/applyClass/changeClass.jsp?studentId="+studentId+"&classInstId="+classInstId+"&stageId="+stageId+"&classType="+classType+"&studentCourseId="+studentCourseId;
		}
	});
	
	//将学员添加到班级中
	$("#addStudentCourseSubmit").click(function() {
		var obj = $('#list_data').datagrid('getSelections');
		if(obj.length > 0) {
			var param = "[";
			var className = $("#className").val();
			var classInstId = $("#classInstId").val();
			var handlerId = $("#handlerId").val();
			for(var i = 0, n = obj.length; i < n; i++) {
				var studentCourseId = obj[i].studentCourseId;
				var studentId = obj[i].studentId;
				var feeType = obj[i].feeType;
				var studentChannelType = "";
				if("002" == feeType) {
					studentChannelType += obj[i].oldClassName;
				}
				studentChannelType += obj[i].feeTypeText;
				param += "{classInstId:\""+classInstId+"\",className:\""+className+"\",studentId:\""+studentId+"\",studentCourseId:\""+studentCourseId+"\",studentChannelType:\""+studentChannelType+"\",handlerId:\""+handlerId+"\"},";
			}
			param = param.substring(0, param.length - 1) + "]";
			$.ajax({
				url: "/sys/applyClass/addClassStudent.do",
				data: "param=" + param,
				dataType: "json",
				async: false,
				beforeSend: function()
				{
					$.messager.progress({title : '添加学员', msg : '正在添加学员，请稍等……'});
				},
				success: function (data) {
					$.messager.progress('close'); 
					var flag = data.flag
					if(flag) {
						$.messager.alert('提示', "添加学员成功！");
						window.location.reload();
					} else {
						$.messager.alert('提示', "添加学员失败！");
					}
				}
			});
		} else {
			$.messager.alert('提示', "请先选择您要添加的学员！");
		}
	});
});

function validateSelect()
{
	var flag = false;
	var obj = $('#list_data').datagrid('getSelections');
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