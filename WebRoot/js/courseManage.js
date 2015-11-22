$(document).ready(function() {
	$("#qryBtn").click(function() {
    	var obj = JSON.stringify($("#qryFm").serializeObject());
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
	
	$("#womType").combobox({
		url : "/sys/pubData/qryCodeNameList.do?tableName=STUDENT_WOM_T&codeType=WOM_TYPE",//返回json数据的url
    	valueField : "codeFlag",
    	textField : "codeName",
    	panelHeight : "auto",
    	onLoadSuccess : function () { //数据加载完毕事件
            var data = $('#womType').combobox('getData');
            if (data.length > 0) {
                $("#womType").combobox('select', data[0].codeFlag);
            }
        },
		onChange : function(n, o) {
			$("#womTypeDetail").combobox({
				url : "/sys/pubData/qryCodeNameList.do?tableName=STUDENT_WOM_T&codeType=WOM_CHANNEL_" + n,//返回json数据的url
		    	valueField : "codeFlag",
		    	textField : "codeName",
		    	panelHeight : "auto",
		    	onLoadSuccess : function () { //数据加载完毕事件
		            var data = $('#womTypeDetail').combobox('getData');
		            if (data.length > 0) {
		                $("#womTypeDetail").combobox('select', data[0].codeFlag);
		            }
		        }
			});	
		}
	});	
	
	$("#addCourse").click(function() {
		addCourse();
	});
});
function qryData()
{
	var obj = JSON.stringify($("#qryFm").serializeObject());
	$('#list_data').datagrid({
		url : "qryCourseInfo.do",
		queryParams:{
			json : obj
		},
		onLoadSuccess:function(){
			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
			$('#list_data').datagrid('clearSelections');
		}
	});
	
}

function addCourse()
{
	window.location.href="addCourseList.jsp";
}

function getOldCourse() 
{
	var courses;
	var stu = {};
	stu.studentId = $("#studentId").val();
	stu.queryCode = 'Qry_Student_Courses';
	var str = JSON.stringify(stu);
	$.ajax( {
		url : "/sys/course/getStuCourses.do?",
		data : "param=" + str,
		dataType : "json",
		async : false,
		success : function(data)
		{
		 courses= data.data;//学员已有课程
		}
	});
	return courses;
}

//修改课程
function updateCourse()
{
	if(validateSelect("list_data"))
	{
		var oldCourses=getOldCourse();
		for(var i=0;i<oldCourses.length;i++)
		{
			var course = oldCourses[i];
			var order = course.stageOrder;
			var courseState=course.courseState;
			var stageName =course.stageId;
			var linkId=course.linkId;
		}
	}
	
}
function validateSelect(object)
{
	var flag = false;
	var obj = $("#"+object+"").datagrid('getSelections');
	if(obj.length > 0) {
		if(obj.length > 1) {
			$.messager.alert('提示', "只能选择一条记录操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择一条记录！");
	}
	return flag;
}
