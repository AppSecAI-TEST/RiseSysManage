var handlerId =null;
var operate =null;
var roomId =null;
$(document).ready(function(){
	handlerId =$("#handlerId").val();
	operate =$("#operate").val();
	roomId =$("#roomId").val();
	$("#submitBtn").click(function(){
		if(operate=="A")
		{
			addClassroom();
		}
		else
		{
			updateClassroom();
		}	
	});
	$("#addBtn").click(function(){
		addTrInfo(); 
	});
	$("#backBtn").click(function(){
		window.location.href="classroomList.jsp";
	});
	$("#state").combobox({
		url : "../pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=SINGLE_COURSE_TYPE",
		onChange:function(){
			var urls ="";
			var stateValue=$("#state").combobox("getValue");
			if(stateValue=="001")
			{
				urls ="../pubData/getClassType.do?";
				$("#classType").combobox({
				url:urls,
				valueField : "classType",
				textField : "classType",
				panelHeight : "auto"
				});
			}
			
		}
	});
	if(operate=="U")
	{
		initPage();
	}	
});


function addTrInfo() 
{
	var tr = $("#modelTr").clone();
	if ($("#state").combobox("getValue") == "") 
	{
		$.messager.alert("提示", "请选择课程类型");
		return false;
	}
	if ($("#classType").combobox("getValue") == "") 
	{
		$.messager.alert("提示", "请选择班级类型");
		return false;
	}
	if(checkTypeOnly($("#classType").combobox("getValue")))
	{
		tr.addClass("addTr");
		tr.attr("classType",$("#classType").combobox("getValue"));
		tr.find("td:eq(1)").html("<span>"+tr.attr("classType")+"</span>")
		tr.css("display","table-row");
		$("#modelTr").after(tr);
		clearData("modelTr");
	}	
	else 
	{
		$.messager.alert("提示", "不能重复选择班级类型");
		return false;
	}

}

function deleteTr(obj) 
{
	$(obj).closest("tr").remove();
}


function checkTypeOnly(val)
{
	flag =true;
	$(".addTr").each(function(){
		if($(this).attr("classType")==val)
		{
			flag =false;
			return false;
		}	
	})
	return flag;
}



function addClassroom()
{
	if($("#schoolId").combobox("getValue")=="")
	{
		$.messager.alert("提示", "请选择校区");
		return false;
	}
	if($("#roomState").combobox("getValue")=="")
	{
		$.messager.alert("提示", "请选择教室状态");
		return false;
	}
	if($("#roomName").textbox("getValue")=="")
	{
		$.messager.alert("提示", "请填写教室名称");
		return false;
	}
	var room={};
	room.handlerId =handlerId;
	room.schoolId =$("#schoolId").combobox("getValue");
	room.roomState =$("#roomState").combobox("getValue");
	room.roomName =$("#roomName").textbox("getValue");
	room.roomCode =$("#roomCode").textbox("getValue");
	var classType="";
	$(".addTr").each(function(){
		classType+=$(this).attr("classType")+",";
	})
	if(classType!="")
	{
		classType =classType.substring(0,classType.length-1);
	}
	room.classType =classType;
	$.ajax( {
		type : "POST",
		url : "/sys/classroom/addClassroom.do",
		data :"param="+JSON.stringify(room),
		async : false,
		beforeSend : function() {
			showProgressLoader("正在添加教室资源,请稍等...", 400);
		},
		success : function(data) {
			hideProgressLoader()
			if (data == "true") {
				showMessage('提示', "添加教室资源成功！", function() {
					window.location.href = "classroomList.jsp";
				});
			} else {
				showMessage('提示', "添加教室资源失败！", null);
			}

		},
		error : function() {
			hideProgressLoader();
			showMessage('提示', "调用添加教室资源服务失败！", null);
		}
	});
}


function initPage()
{
	$.ajax( {
		type : "POST",
		url : "/sys/classroom/getClassroomInfo.do",
		data :"roomId="+roomId,
		async : false,
		dataType:"json",
		beforeSend : function() {
			showProgressLoader("正在加载数据,请稍等...", 400);
		},
		success : function(data) {
			hideProgressLoader()
			if(data.roomId!=undefined&&data.roomId!="")
			{
				$("#schoolId").combobox("setValue",data.schoolId);
				$("#roomState").combobox("setValue",data.roomState);
				$("#roomName").textbox("setValue",data.roomName);
				$("#roomCode").textbox("setValue",data.roomCode);
				$("#schoolId").combobox("setValue",data.schoolId);
				var classType =data.classType;
				if(classType!="")
				{
					var typeArr =classType.split(",");
					for(var i=0;i<typeArr.length;i++)
					{
						var tr = $("#modelTr").clone();
						tr.addClass("addTr");
						tr.attr("classType",typeArr[i]);
						tr.find("td:eq(1)").html("<span>"+tr.attr("classType")+"</span>")
						tr.css("display","table-row");
						$("#modelTr").after(tr);
					}	
				}	
			}	

		},
		error : function() {
			hideProgressLoader();
		}
	});
}


function updateClassroom()
{
	if($("#schoolId").combobox("getValue")=="")
	{
		$.messager.alert("提示", "请选择校区");
		return false;
	}
	if($("#roomState").combobox("getValue")=="")
	{
		$.messager.alert("提示", "请选择教室状态");
		return false;
	}
	if($("#roomName").textbox("getValue")=="")
	{
		$.messager.alert("提示", "请填写教室名称");
		return false;
	}
	var room={};
	room.roomId =roomId;
	room.handlerId =handlerId;
	room.schoolId =$("#schoolId").combobox("getValue");
	room.roomState =$("#roomState").combobox("getValue");
	room.roomName =$("#roomName").textbox("getValue");
	room.roomCode =$("#roomCode").textbox("getValue");
	room.state="00A";
	var classType="";
	$(".addTr").each(function(){
		classType+=$(this).attr("classType")+",";
	})
	if(classType!="")
	{
		classType =classType.substring(0,classType.length-1);
	}
	room.classType =classType;
	$.ajax( {
		type : "POST",
		url : "/sys/classroom/updateClassroom.do",
		data :"param="+JSON.stringify(room),
		async : false,
		beforeSend : function() {
			showProgressLoader("正在修改教室资源,请稍等...", 400);
		},
		success : function(data) {
			hideProgressLoader()
			if (data == "true") {
				showMessage('提示', "修改教室资源成功！", function() {
					window.location.href = "classroomList.jsp";
				});
			} else {
				showMessage('提示', "修改教室资源失败！", null);
			}

		},
		error : function() {
			hideProgressLoader();
			showMessage('提示', "调用修改教室资源服务失败！", null);
		}
	});
}