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
	
	//放班申请
	$("#applyClass").click(function() {
    	window.location.href = "/sys/applyClass/addApplyClass.jsp";
    });
	
	//取消放班申请
	$("#cancelApplyClass").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var classInstId = row.classInstId;
			var applyId = row.applyId;
			window.location.href = "/sys/applyClass/cancelApplyClass.jsp?classInstId="+classInstId+"&applyId="+applyId;
		} else {
			$.messager.alert('提示', "请先选择您要取消放班的班级！");
		}
    });
	
	//班级维护
	$("#updateApplyClass").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var classInstId = row.classInstId;
			var applyId = row.applyId;
			window.location.href = "/sys/applyClass/updateApplyClass.jsp?classInstId="+classInstId+"&applyId="+applyId;
		} else {
			$.messager.alert('提示', "请先选择您要维护的班级！");
		}
	});
	
	//学员来源类型
	$('#studentChannelType').combobox({
		onChange : function(n, o) {
			//新招
			if("001" == n) {
				$("#higherText").css("display", "none");
				$("#higherDiv").css("display", "none");
			} else {
				$("#higherText").css("display", "block");
				$("#higherDiv").css("display", "block");
			}
		}
	});
	
	//添加升学班级
	$("#addHigherClass").click(function() {
		$("#higherOptionSchoolTd").css("display", "block");
		$('#studentChannelType').combobox('getText');
		$("#higherOptionSchoolName").html();
	});
	
	//选择上课时段周标识
	$("#weekTime").combobox({
		onChange : function(n, o) {
			$("#hourRange").combobox({
        		url : "/sys/pubData/qryHourRangeList.do?weekTime=" + n,//返回json数据的url
        		valueField : "hourRange",
        		textField : "hourRangeVal",
        		panelHeight : "auto",
        		onLoadSuccess : function () { //数据加载完毕事件
                    var data = $('#hourRange').combobox('getData');
                    if (data.length > 0) {
                        $("#hourRange").combobox('select', data[0].hourRange);
                    }
                }
        	});
		}
	});
	
	//改变带班老师的校区
	$("#teacherSchoolId").combobox({
		onChange : function(n, o) {
			var classType = $('#classType').combobox('getValue');
			$("#teacherId").combobox({
        		url : "/sys/pubData/qryTeacherList.do?schoolId=" + n + "&classType=" + classType,//返回json数据的url
        		valueField : "teacherId",
        		textField : "byname",
        		panelHeight : "auto",
        		onLoadSuccess : function () { //数据加载完毕事件
                    var data = $('#teacherId').combobox('getData');
                    if (data.length > 0) {
                        $("#teacherId").combobox('select', data[0].teacherId);
                    }
                }
        	});
		}
	});
	
	//添加代班老师
	$("#addTeacher").click(function() {
		
	});
});