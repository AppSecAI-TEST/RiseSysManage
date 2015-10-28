var currentYear = null;
$(document).ready(function() {
	initPage();
	$("#qryBtn").click(function() {
		initTimeTab(true);
	});
	$("#addBtn").click(function() {
		addTimeResource();
	});
	$("#updateBtn").click(function() {
		updateTimeResource();
	});
	$("#timeConfig").click(function() {
		configTime();
	});
});

function initPage() {
	initYearSelect();
	initTimeTab(true);
}

function initYearSelect() {
	var data = [];
	var year = new Date().getFullYear();
	for ( var i = 0; i < 20; i++) {
		var soption = {};
		soption.val = (year - 10 + i);
		soption.text = soption.val;
		data.push(soption);
	}
	$("#year").combobox("loadData", data);
	$("#year").combobox("setValue", year);
	currentYear = year;
}

function initTimeTab(flag) {
	if (flag) {
		currentYear = $("#year").combobox("getValue");
	}
	else
	{
		hideMessage();
	}	
	$("#list_data").datagrid( {
		url : "/sys/timeResource/getYearTimeResource.do?",
		queryParams : {
			year : currentYear
		},
		onLoadSuccess : function() {
			$('#list_data').datagrid('clearSelections');
		},
		title : currentYear + "年休假时间"
	});
}

function addTimeResource() {
	window.location.href = "addResource.jsp";
}

function updateTimeResource() {
if(validateSelect("list_data"))
	{
		var row = $('#list_data').datagrid('getSelected');
		if(parseInt(currentYear)<new Date().getFullYear()||(parseInt(currentYear)==new Date().getFullYear()&&parseInt(row.month)<=(new Date().getMonth()+1)))
		{
			$.messager.alert("提示", "不能修改已经过去的时间");
			return false;
		}
		$('#dlg').dialog({
			title:currentYear+"年"+row.month+"月休假日期",
		});
		$('#dlg').attr("src","/sys/timeResource/addDays.jsp?year="+currentYear+"&month="+row.month+"&days="+row.days+"&operate=U&schoolTimeId="+row.schoolTimeId);
		$('#dlg').dialog("open");
	}	
}

function closeDig()
{
	$('#dlg').attr("src","");
	$('#dlg').dialog("close");
}

function updateDays(yearValue,monthValue,daysValue,idValue)
{
	closeDig();
	var param={};
	param.year =yearValue;
	param.month=monthValue;
	param.days =daysValue;
	param.schoolTimeId =idValue;
	param.handlerId =$("#handlerId").val();
	$.ajax( {
		type : "POST",
		url : "/sys/timeResource/updateTimeResource.do",
		data :"param="+JSON.stringify(param),
		async : false,
		beforeSend : function() {
			showProgressLoader("正在修改休假时间,请稍等...", 400);
		},
		success : function(data) {
			hideProgressLoader()
			if (data == "true") {
				showMessage('提示', "修改休假时间成功！", function() {
						initTimeTab(false);
					});
				} else {
					showMessage('提示', "修改休假时间失败！", null);
				}
	
			},
			error : function() {
				hideProgressLoader();
				showMessage('提示', "调用修改休假时间服务失败！", null);
			}
		});
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

 function configTime()
 {
	 window.location.href="classTimeConfig.jsp";
 }