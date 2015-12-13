var td = 2;
var contactTd = 0;
var activityTd = 0;
$(document).ready(function() {
	var studentId = $("#studentId").val();
	var funcNodeId = $("#funcNodeId").val();
	$.ajax({
		url: "/sys/student/qryStudentById.do",
		data: "studentId=" + studentId + "&funcNodeId=" + funcNodeId,
		dataType: "json",
		async: false,
		beforeSend: function()
    	{
    		$.messager.progress({title : '查看学员资料', msg : '正在查询学员资料，请稍等……'});
    	},
    	success: function (data) {
    		$.messager.progress('close'); 
    		var studentObj = data.studentObj;
    		$("#nameText").html(studentObj.name);
    		$("#birthdayText").html(studentObj.birthday);
    		$("#sexText").html(studentObj.sexVal);
    		$("#identityIdText").html(studentObj.identity);
    		$("#advisterAText").html(studentObj.advisterNameA);
    		$("#advisterBText").html(studentObj.advisterNameB);
    		$("#dutyAdvisterNameText").html(studentObj.dutyAdvisterName);
    		$("#carerNameText").html(studentObj.carerName);
    		$("#byName").html(studentObj.byName);
    		$("#address").html(studentObj.address);
    		$("#remark").html(studentObj.remark);
    		$("#createDateText").html(studentObj.createDate);
    		$("#entranceDateText").html(studentObj.entranceDate);
    		
    		var len1 = data.realSchoolObj.total;
    		if(parseInt(len1) > 0)
    		{
    			var realSchoolArray = data.realSchoolObj.rows;
    			for(var i = 0; i < len1; i++)
    			{
    				var content = "<tr><td align='right' width='100px'><span>学校类型：</span></td><td><span>"+realSchoolArray[i].schoolTypeText+"</span></td>";
    	    		content += "<td align='right' width='100px'><span>学校名称：</span></td><td><span>"+realSchoolArray[i].realSchoolName+"</span></td>";
    	    		content += "<td align='right' width='100px'><span>添加时间：</span></td><td><span>"+realSchoolArray[i].createDate+"</span></td></tr>";
    	    		$("#studentTd tr:eq("+td+")").after(content);
    	    		td += 1;
    			}
    		}
    		
    		var contactLength = data.contactObj.total;
    		if(parseInt(contactLength) > 0)
    		{
    			var contactArray = data.contactObj.rows;
    			for(var i = 0; i < contactLength; i++)
    			{
    				var content = "<tr><td align='center'><span>"+contactArray[i].relationTypeVal+"</span></td>";
    				content += "<td align='center'><span>"+contactArray[i].name+"</span></td>";
    				content += "<td align='center'><span>"+contactArray[i].job+"</span></td>";
    				content += "<td align='center'>";
    				var used = contactArray[i].used;
    				if("Y" == used) {
    					content += "√";
    				}
    				content += "</td>";
    				content += "<td align='center'><span>"+contactArray[i].identity+"</span></td>";
    				content += "<td align='center'><span>"+contactArray[i].phone+"</span></td></tr>";
    				$("#contactTd tr:eq("+contactTd+")").after(content);
    				contactTd += 1;
    			}
    		}
    		
    		var len3 = data.activityObj.total;
    		if(parseInt(len3)  > 0)
    		{
    			var activityArray = data.activityObj.rows;
    			for(var i = 0; i < len3; i++)
    			{
    				var content = "<tr><td align='center'><span>"+activityArray[i].title+"</span></td>";
    				content += "<td align='center'><span>"+activityArray[i].activityDate+"</span></td>";
    				content += "<td align='center'><span>"+activityArray[i].award+"</span></td>";
    				content += "<td align='center'><span></span></td>";
    				content += "<td align='center'>"+activityArray[i].remark+"</td></tr>";
    				$("#activityTd tr:eq("+activityTd+")").after(content);
    				activityTd += 1;
    			}
    		}
    	}
	});
});