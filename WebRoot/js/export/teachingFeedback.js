$(document).ready(function() {
	$("#qryBtn").click(function() {
		var json = $("#qryFm").serializeObject();
		var teachingNum = json.teachingNum;
		var meetingIsAttend = json.meetingIsAttend;
		var openIsAttend = json.openIsAttend;
		var gradIsAttend = json.gradIsAttend;
		if(teachingNum == "0,1,2"){
			json.teachingNum = "";
		}
		if(teachingNum == "0,1"){
			json.teachingNum = "0,1";
		}
		if(teachingNum == "1,2"){
			json.teachingNum = "1,2";
		}
		if(teachingNum == "0,2"){
			json.teachingNum = "0,2";
		}
		if(meetingIsAttend == "Y,N"){
			json.meetingIsAttend = "";
		}
		if(openIsAttend == "Y,N"){
			json.openIsAttend = "";
		}
		if(gradIsAttend == "Y,N"){
			json.gradIsAttend = "";
		}
		var time= $("#time").datebox('getValue');
    	var obj = JSON.stringify(json);
    	obj = obj.substring(0, obj.length - 1);
    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
    	obj += ",\"month\":\""+time+"\",\"funcNodeId\":\""+funcNodeId+"\"}";
    	alert(obj)
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
	
	var staffId = $("#staffId").val();
	$("#schoolId").combobox({
		url : "/sys/pubData/qrySchoolList.do?schoolId",//返回json数据的url
		valueField : "schoolId",
		textField : "schoolName",
		panelHeight : "auto",
		formatter : formatSchool,
		onLoadSuccess : function() {
			$("#schoolId").combobox("setValue", "");
			$("#schoolId").combobox("setText", "");
		},
		onChange : function(n, o) {
			if(n != "" && n != null && n != undefined) {
				$("#classInstId").combobox({disabled: false});
				$("#classInstId").combobox({
					url : "/sys/pubData/qryClassInstList.do?schoolId="+n+"&courseType=&stageId=&classType=&classState='003','004','005'&classInstId=",//返回json数据的url
					valueField : "classInstId",
					textField : "className",
					panelHeight : "auto",
					formatter : function(data) {
						return "<span>" + data.className + "</span>";
					}
				});
				$("#studentId").combobox({
					url : "/sys/pub/paramComboxList.do?staffId="+staffId+"&schoolId="+n+"&funcNodeId=20&fieldId=studentId",
					valueField : "studentId",
					textField : "name",
					panelHeight : "auto",
					formatter : function(data) {
						return "<span>" + data.name + "</span>";
					}
				});
			} else {
				$("#schoolId").combobox("setText", "");
				$("#classInstId").combobox('clear');
				$("#classInstId").combobox("loadData", new Array());
				$("#classInstId").combobox({disabled: true});
			}
		}
	});
	
});