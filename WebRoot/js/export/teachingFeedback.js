$(document).ready(function() {
	$("#qryBtn").click(function() {
		initPageNumber("list_data");
		var json = $("#qryFm").serializeObject();
		var meetingIsAttend = json.meetingIsAttend;
		var openIsAttend = json.openIsAttend;
		var gradIsAttend = json.gradIsAttend;
		if(meetingIsAttend == "Y,N") {
			json.meetingIsAttend = "";
		}
		if(openIsAttend == "Y,N") {
			json.openIsAttend = "";
		}
		if(gradIsAttend == "Y,N") {
			json.gradIsAttend = "";
		}
		var time= $("#time").datebox('getValue');
    	var obj = JSON.stringify(json);
    	obj = obj.substring(0, obj.length - 1);
    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
    	obj += ",\"month\":\""+time+"\",\"funcNodeId\":\""+funcNodeId+"\"}";
    	$('#list_data').datagrid({
    		url : "/sys/teaFeebackManage/qryDataListByPage.do",
    		queryParams: {
    			param : obj
    		},
    		onLoadSuccess:function() {
				//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
				$('#list_data').datagrid('clearSelections');
    		}
    	 });
   	 });
	
	
	initReportButton("resetBtn","qryFm","schoolId");
	
	$("#resetBtn").click(function() 
    {
    	$("#teacherId").combobox('clear');
    	$("#teacherId").combobox("loadData", new Array());
    	$('#time').datebox('setValue',new Date().format("yyyy-MM"));
    });
	
	$("#schoolId").combobox({
		valueField : "schoolId",
		textField : "schoolName",
		panelHeight : "auto",
		formatter : formatSchool,
		onChange : function(n, o) {
			if(n != "" && n != null && n != undefined) {
				$("#teacherId").combobox({
					url : "/sys/pubData/qryData.do?param={'queryCode':'qryClassTeacherInfo','schoolId':'"+n+"'}",//返回json数据的url
					valueField : "teacherId",
					textField : "byname",
					panelHeight : "auto",
					formatter : function(data) {
						return "<span>" + data.byname + "</span>";
					}
				});
			} else {
				$("#teacherId").combobox('clear');
				$("#teacherId").combobox("loadData", new Array());
			}
		}
	});
	
});
