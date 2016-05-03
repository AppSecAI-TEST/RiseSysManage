$(document).ready(function(){
	//首页面查询
    $("#qryBtn").click(function() {
    	var schoolId = $("#schoolId").combobox("getValue");
	    if(schoolId != "") {
	    	initPageNumber("list_data");
	    	var json = $("#qryFm").serializeObject();
	    	json.byName = $("#byName").combobox('getText');
			var obj = JSON.stringify(json);
			obj = obj.substring(0, obj.length - 1);
			var funcNodeId = $("#qryBtn").attr("funcNodeId");
			obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
			$('#list_data').datagrid({
				url : "/sys/licenseManage/qryDataListByPage.do",
				queryParams:{
					param : obj
				},
				onLoadSuccess:function(){
					//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
					$('#list_data').datagrid('clearSelections');
				}
			});
	    } else {
			showMessage("提示","没有有效的校区可供查询",null);
		}
    });
	
     //首页面重置
    $("#resetBtn").click(function() 
    {
    	$("#qryFm").form('clear');//清空窗体数据  
    	//校区赋默认值
    	if($("#schoolId").combobox("getData").length>0){
    		$("#schoolId").combobox("select",$("#schoolId").combobox("getData")[0].schoolId);
    	}
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
		url : "/sys/pub/pageCategory.do?staffId="+staffId+"&resourceId=506&fieldId=schoolId&headFlag=N",//返回json数据的url 
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
	window.location.href = "/sys/licenseManage/locateTeacher.jsp";
}

//跳转新增持证页面
//function addLicense()
//{
//	if(validateSelect("teacher_list")) {
//		var row = $("#teacher_list").datagrid('getSelected');
//		var teacherId = row.teacherId;
//		window.location.href = "/sys/licenseManage/addLicense.jsp?teacherId="+teacherId;
//	}
//}

//删除相对应的行  
function delRow(rows)  
{  
    $(rows).parent("td").parent("tr").remove();  
}

//增加行
function addRow()
{
	var licenseModelTR=$("#licenseModelTR").clone();
	var flag=true;
	var licenseTR=$("#addLicense").clone();
	licenseTR.css("display",'table-row');
	licenseTR.attr("val","license");
	licenseTR.find("td").each(function(n,node)
	{
		if(n==0)//持证阶段	
		{
			var stageId=$("#stageId").combobox('getText');
			if(stageId == undefined || stageId == ""){
				flag=false;
				$.messager.alert('提示', "请选择课程阶段！");
				return false;
			}
			$(node).html(""+stageId+"");	
		}else if(n==1)//开始时间
		{
			var startDate=$("#startDate").datebox('getText');
			if(startDate == undefined || startDate == ""){
				flag=false;
				$.messager.alert('提示', "请选择持证开始时间！");
				return false;
			}
			$(node).html(""+startDate+"");
		}
	});
	if(flag)
	{
		$("#addLicense").after(licenseTR);
		clearData("licenseModelTR");
    }
}

//新增持证提交
function addLicenseSubmit()
{
	var teacherId = $("#teacherId").val();
	var handlerId = $("#handlerId").val();
	var licenseArray = new Array();
	var aStageId = "";
	$("#licenseTab").find('tr').each(function(i,node)
	{
		var trName=$(this).attr("val");
 
		if('license'==trName)
		{
			 var tds=$(this).children('td');
		 
			 var stageId=tds.eq(0).html();
			 var startDate=tds.eq(1).html();
			 
			 if(aStageId.indexOf(stageId) != -1){
				$.messager.alert('提示', "课程阶段"+stageId+"重复添加，请删除重复的信息");
				return false;
			 }else{
				 aStageId += "," + stageId;
			 }
			 
			 var license = {};
			 license.teacherId = teacherId;
			 license.stageId = stageId;
			 license.startDate = startDate;
			 license.handlerId=handlerId;
			 licenseArray.push(license);  
		 }
	});
	if(licenseArray.length == 0){
		$.messager.alert('提示', "请至少添加一行持证信息！");
		return;
	}else{
		$.ajax({
			type : "POST",
			url: "/sys/licenseManage/addLicense.do",
			data: "json="+JSON.stringify(licenseArray),
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '添加新教师持证', msg : '添加教师持证中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "添加新教师持证成功！","info",function(){
		    			window.location.href = "/sys/licenseManage/licenseManage.jsp";
					});
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "添加新教师持证失败！");
	    		}
	        } 
		});
	}
}

//浏览教师持证
function viewTeacherLicense()
{
	if(validateSelect("list_data")) {
		var row = $("#list_data").datagrid('getSelected');
		var teacherId = row.teacherId;
		window.location.href = "/sys/licenseManage/viewLicenseInfo.do?teacherId="+teacherId;
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