var td = 2;
$(document).ready(function() {
	var classInstId = $("#classInstId").val();
	$.ajax({
		url: "/sys/applyClass/qryCreateClassById.do",
		data: "classInstId=" + classInstId + "&applyType=001",
		dataType: "json",
		async: false,
		beforeSend: function()
		{
			$.messager.progress({title : '取消放班申请', msg : '正在查询取消放班信息，请稍等……'});
		},
		success: function (data) {
    		$.messager.progress('close'); 
    		$("#stageId").html(data.createClassObj.stageId);
    		$("#classType").html(data.createClassObj.classType);
    		$("#className").html(data.createClassObj.className);
    		$("#startDate").html(data.createClassObj.startDate);
    		$("#applyDate").html(data.createClassObj.applyDate);
    		$("#applyName").html(data.createClassObj.applyName);
    		$("#studentChannelTypeVal").html(data.createClassObj.studentChannelTypeVal);
    		$("#higherSchoolName").html(data.createClassObj.higherSchoolName);
    		$("#Applyremark").html(data.createClassObj.remark);
    		
    		var type = $("#type").val();
    		if(type != "" && type != null && type != "null" && type != undefined) {
    			td = 1;
    		}
    		var schooltimeLength = data.schooltimeObj.total;
    		if(schooltimeLength > 0) {
    			var content = "";
    			$.each(data.schooltimeObj.rows, function(i, obj){
    				content += "<tr><td align='right' width='10%'><span id='schooltimeNameTd'>上课时段 "+ (i + 1) +"：</span></td>";
    				content += "<td width='20%'><span id='schooltimeName'>"+ obj.schooltimeName +"</span></td>";
    				content += "<td align='right' width='10%'><span>教室：</span></td>";
    				content += "<td width='5%'><span id='roomName'>"+ obj.roomName +"</span></td>";
    				content += "<td align='right' width='10%'><span>课时：</span></td>";
    				content += "<td width='5%'><span id='lessionHours'>"+ obj.lessionHours +"</span></td>";
    				content += "<td align='right' width='10%'><span>带班老师：</span></td>";
    				var teacherContent = "";
    				var schoolTeacherName = obj.schoolTeacherName;
    				if(schoolTeacherName != null && schoolTeacherName != "" && schoolTeacherName != undefined) {
    					teacherContent = schoolTeacherName + " 课时量 " + obj.lessionHours;
    				}
    				content += "<td width='30%'><span id='schoolTeacherName'>"+ teacherContent +"</span></td></tr>";
    			});
    			$("#cancelApplyClassTd tr:eq("+td+")").after(content);
    		}
    		
    		if(type == "" || type == null || type == "null" || type == undefined) {
    			var tacheHistLength = data.tacheHistObj.total;
    			var height = 0;
    			if(tacheHistLength > 0) {
    				var content = "";
    				$.each(data.tacheHistObj.rows, function(i, obj){
    					height += 75;
    					content += "<div style='height: 10px;'></div>";
    					$("#userName").html(obj.userName);
    					$("#approveType").html(obj.approveType);
    					$("#createDate").html(obj.createDate);
    					$("#applyClassApproveRemark").html(obj.remark);
    					content += $("#applyClassDiv").html();
    				});
    				$("#tacheHistDiv").html(content);
    				$("#tacheHistDiv").css("height", height);
    			}
    		}
		}
	});
	
	//取消放班申请
	$("#submit").click(function(){
		if($("#cancelApplyClassFm").form('validate')) {
			var obj = JSON.stringify($("#cancelApplyClassFm").serializeObject());
			obj = encodeURI(obj);
			$.ajax({
				url: "/sys/applyClass/cancelApplyClass.do",
				data: "param=" + obj,
				contentType: "charset=UTF-8",
    			dataType: "json",
    			async: false,
    			beforeSend: function()
    	    	{
    	    		$.messager.progress({title : '申请取消放班', msg : '正在申请取消放班，请稍等……'});
    	    	},
    	    	success: function (data) {
    	    		$.messager.progress('close'); 
    	    		var flag = data.flag
    	            if(flag) {
    	            	$.messager.alert('提示', "申请取消放班成功！", "info", function() {window.history.back();});
    	            } else {
    	            	$.messager.alert('提示', "申请取消放班失败！");
    	            }
    	        } 
			});
		}
	});
	
	//提交放班审批
	$("#approveSubmit").click(function() {
		var approveType = $('input:radio[name="approveType"]:checked').val();
		if(approveType == "" || approveType == null || approveType == undefined || approveType == "null") {
			$.messager.alert('提示', "请选择是否审批通过！");
		} else {
			if($("#cancelApplyClassFm").form('validate')) {
				var obj = JSON.stringify($("#cancelApplyClassFm").serializeObject());
				obj = encodeURI(obj);
				$.ajax({
					url: "/sys/applyClass/approveApplyClass.do",
					data: "param=" + obj,
					contentType: "charset=UTF-8",
					dataType: "json",
					async: false,
					beforeSend: function()
					{
						$.messager.progress({title : '审批申请', msg : '正在审批申请，请稍等……'});
					},
					success: function (data) {
						$.messager.progress('close'); 
						var flag = data.flag
						if(flag) {
							$.messager.alert('提示', "审批申请成功！", "info", function() {window.history.back();});
						} else {
							$.messager.alert('提示', data.msg);
						}
					} 
				});
			}
		}
	});
});