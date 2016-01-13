$(document).ready(function(){
	
	//首页面查询
    $("#qryBtn").click(function() {
    	var json = $("#qryFm").serializeObject();
    	json.byName = $("#byName").combobox('getText');
    	var pay = json.pay;
    	if(pay == "Y"){
    		json.reparation = "1";
    	}
    	if(pay == "N"){
    		json.noreparation = "1";
    	}
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
	
//	initDate();
//	//定位教师页面查询
//    $("#qryTeaBtn").click(function() {
//    	var json = $("#qryTeaFm").serializeObject();
//    	json.byName = $("#byName").combobox('getText');
//		var obj = JSON.stringify(json);
//		obj = obj.substring(0, obj.length - 1);
//		var funcNodeId = $("#qryTeaBtn").attr("funcNodeId");
//		obj += ",\"teacherState\":\"P\",\"funcNodeId\":\""+funcNodeId+"\"}";
//		$('#teacher_list').datagrid({
//			url : "/sys/pubData/qryDataListByPage.do",
//			queryParams:{
//				param : obj
//			},
//			onLoadSuccess:function(){
//				//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
//				$('#teacher_list').datagrid('clearSelections');
//			}
//		});
//    });
    
    var staffId = $("#staffId").val();
	$("#schoolId").combobox({
		url : "/sys/pub/pageCategory.do?staffId="+staffId+"&resourceId=508&fieldId=schoolId&headFlag=N",//返回json数据的url 
		valueField : "schoolId",
		textField : "schoolName",
		panelHeight : "auto",
		formatter : formatSchool,
		onLoadSuccess : function(data) {
			$("#schoolId").combobox('setValue',data[0].schoolId);
		},
		onChange : function(n, o) {
			if(n != "" && n != null && n != undefined) {
//				$("#byName").combobox({disabled: false});
				$("#byName").combobox({
					url : "/sys/pubData/qryTeacherList.do?schoolId="+n,//返回json数据的url
					valueField : "teacherId",
					textField : "byname",
					panelHeight : "auto",
					formatter : function(data) {
						return "<span>" + data.byname + "</span>";
					}
				});
			} else {
				$("#schoolId").combobox("setText", "");
				$("#byName").combobox('clear');
				$("#byName").combobox("loadData", new Array());
//				$("#byName").combobox({disabled: true});
			}
		}
	});
});


//跳转到定位老师页面
function locateTeacher()
{
	window.location.href = "/sys/trainManage/locateTeacher.jsp";
}

//跳转新增培训页面
//function addTrain()
//{
//	if(validateSelect("teacher_list")) {
//		var row = $("#teacher_list").datagrid('getSelected');
//		var teacherId = row.teacherId;
//		var name = row.teacherName;
//		var byName = row.byname;
//		var stateVal = row.stateVal;
//		window.location.href = "/sys/trainManage/addTrain.jsp?teacherId="+teacherId+"&name="+name+"&byName="+byName+"&stateVal="+stateVal;
//	}
//}

//新增培训提交
function addTrainSubmit()
{
	if($("#addTrainForm").form('validate')) {
		var json = $("#addTrainForm").serializeObject();
		var trainStartDate = json.trainStartDate;
		var trainEndDate = json.trainEndDate;
		if(trainEndDate <= trainStartDate){
			$.messager.alert('提示', "培训结束时间不能小于培训开始时间！");
			return;
		}
		var obj = JSON.stringify(json);
		obj = obj.substring(0, obj.length - 1);
		var teacherId = $("#teacherId").val();
		var handlerId = $("#handlerId").val();
		obj += ",\"teacherId\":\""+teacherId+"\",\"handlerId\":\""+handlerId+"\"}";
		obj = encodeURI(obj);
		$.ajax({
			type : "POST",
			url: "/sys/trainManage/addTrain.do",
			data: "json="+obj,
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '新增教师培训', msg : '新增教师培训，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "新增教师培训成功！","info",function(){
		    			window.location.href = "/sys/trainManage/trainManage.jsp";
					});
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "新增教师培训失败！");
	    		}
	        } 
		});
	}
}

//跳转培训修改页面
function updateTeacherTrain()
{
	if(validateSelect("list_data")) {
		var row = $("#list_data").datagrid('getSelected');
		var trainId = row.trainId;
		var name = row.teacherName;
		var byName = row.byname;
		var stateVal = row.stateVal;
		window.location.href = "/sys/trainManage/viewTrainInfo.do?trainId="+trainId+"&name="+name+"&byName="+byName+"&stateVal="+stateVal+"&type=update";
	}
}

//培训修改提交
function updateTrainSubmit()
{
	if($("#updateTrainForm").form('validate')) {
		var json = $("#updateTrainForm").serializeObject();
		var trainStartDate = json.trainStartDate;
		var trainEndDate = json.trainEndDate;
		if(trainEndDate <= trainStartDate){
			$.messager.alert('提示', "培训结束时间不能小于培训开始时间！");
			return;
		}
		var obj = JSON.stringify(json);
		obj = obj.substring(0, obj.length - 1);
		var trainId = $("#trainId").val();
		var handlerId = $("#handlerId").val();
		obj += ",\"trainId\":\""+trainId+"\",\"handlerId\":\""+handlerId+"\"}";
		obj = encodeURI(obj);
		$.ajax({
			type : "POST",
			url: "/sys/trainManage/updateTrain.do",
			data: "json="+obj,
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '修改教师培训', msg : '修改教师培训，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "修改教师培训成功！","info",function(){
		    			window.location.href = "/sys/trainManage/trainManage.jsp";
					});
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "修改教师培训失败！");
	    		}
	        } 
		});
	}
}

//浏览培训修改
function viewTeacherTrain()
{
	if(validateSelect("list_data")) {
		var row = $("#list_data").datagrid('getSelected');
		var trainId = row.trainId;
		var name = row.teacherName;
		var byName = row.byname;
		var stateVal = row.stateVal;
		window.location.href = "/sys/trainManage/viewTrainInfo.do?trainId="+trainId+"&name="+name+"&byName="+byName+"&stateVal="+stateVal+"&type=view";
	}
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