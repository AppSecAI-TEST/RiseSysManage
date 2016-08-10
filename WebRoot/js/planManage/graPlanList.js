$(document).ready(function() {
	initYearAndMonth("year","month");
	initYearAndMonth("planYear","planMonth");
	initQryButton("qryBtn","resetBtn","qryFm","list_data");
	$("#addPlan").click(function(){
		showAdd();
	});
	$("#updatePlan").click(function(){
		showUpdate();
	});
	$("#deletePlan").click(function(){
		del();
	});
	
});

function showAdd()
{
	$("#dlg").dialog('open').dialog('setTitle', '新增计划');
    $('#fm').form('clear');
    $("#submitBtn").unbind();
    $("#submitBtn").click(function(){
    	add();
    });
}

function add()
{
	if(checkParam())
	{
		var param=
		{
			schoolId:$("#schoolIds").combobox("getValue"),
			planYear:$("#planYear").combobox("getValue"),
			planMonth:$("#planMonth").combobox("getValue"),
			stageId:$("#stageIds").combobox("getValue"),
			firstValue:$("#firstValue").numberbox("getValue"),
			secondValue:$("#secondValue").numberbox("getValue"),
			planType:"gra",
			state:"00A",
			handlerId:$("#handlerId").val()
		}
		$.ajax({
			type : "POST",
			url : "/sys/planManage/addPlan.do",
			data :"param="+JSON.stringify(param),
			async : false,
			beforeSend : function() {
				showProgressLoader("正在添加计划,请稍等...", 400);
			},
			success : function(data) 
			{
				hideProgressLoader()
				if (data == "true")
				{
					showMessage('提示', "添加计划成功！", function() 
					{
						hideMessage();
						$("#dlg").dialog('close');
						$("#qryBtn").trigger("click");
					});
				} 
				else 
				{
					showMessage('提示', "添加计划失败！", null);
				}
	
			},
			error : function() 
			{
				hideProgressLoader();
				showMessage('提示', "调用添加计划服务失败！", null);
			}
		});
	}
}

function showUpdate()
{
	if(validateSelect())
	{
		var row = $('#list_data').datagrid('getSelected');
		$("#planId").val(row.planId);
		$("#schoolIds").combobox("setValue",row.schoolId);
		$("#planYear").combobox("setValue",row.planYear);
		$("#planMonth").combobox("setValue",row.planMonth);
		$("#stageIds").combobox("setValue",row.stageId);
		$("#firstValue").numberbox("setValue",row.firstValue);
		$("#secondValue").numberbox("setValue",row.secondValue);
		$("#dlg").dialog('open').dialog('setTitle', '修改计划');
	    $("#submitBtn").unbind();
	    $("#submitBtn").click(function(){
	    	update();
	    });
	}	
}

function update()
{
	if(checkParam())
	{
		var param=
		{
			planId:$("#planId").val(),
			schoolId:$("#schoolIds").combobox("getValue"),
			planYear:$("#planYear").combobox("getValue"),
			planMonth:$("#planMonth").combobox("getValue"),
			stageId:$("#stageIds").combobox("getValue"),
			firstValue:$("#firstValue").numberbox("getValue"),
			secondValue:$("#secondValue").numberbox("getValue"),
			planType:"gra",
			state:"00A",
			handlerId:$("#handlerId").val()
		}
		$.ajax({
			type : "POST",
			url : "/sys/planManage/updatePlan.do",
			data :"param="+JSON.stringify(param),
			async : false,
			beforeSend : function() {
				showProgressLoader("正在修改计划,请稍等...", 400);
			},
			success : function(data) 
			{
				hideProgressLoader()
				if (data == "true")
				{
					showMessage('提示', "修改计划成功！", function() 
					{
						hideMessage();
						$("#dlg").dialog('close');
						$("#qryBtn").trigger("click");
					});
				} 
				else 
				{
					showMessage('提示', "修改计划失败！", null);
				}
	
			},
			error : function() 
			{
				hideProgressLoader();
				showMessage('提示', "调用添加计划服务失败！", null);
			}
		});
	}
}


function del()
{
	if(validateSelect())
	{
		var row = $('#list_data').datagrid('getSelected');
		var planId =row.planId;
		$.messager.confirm('提示','您确定要删除当前选中的计划吗？',function(r)
		{
			if(r)
			{
				$.post('/sys/planManage/deletePlan.do', {planId : planId}, function(result) 
				{
					if(result=="true") 
					{
						$.messager.alert('提示',"删除计划成功");
						$("#qryBtn").trigger("click");
					} 
					else 
					{
						$.messager.alert('提示', "删除计划失败");
					}
				});
			}
		});
	}	
}


function validateSelect()
{
	var flag = false;
	var obj = $("#list_data").datagrid('getSelections');
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


function checkParam()
{
	if($("#schoolIds").combobox("getValue")=="")
	{
		$.messager.alert('提示', "请先选择校区");
		return false;
	}
	if($("#planYear").combobox("getValue")=="")
	{
		$.messager.alert('提示', "请先选择年份");
		return false;
	}
	if($("#planMonth").combobox("getValue")=="")
	{
		$.messager.alert('提示', "请先选择月份");
		return false;
	}
	if($("#stageIds").combobox("getValue")=="")
	{
		$.messager.alert('提示', "请先选择课程阶段");
		return false;
	}
	if($("#firstValue").numberbox("getValue")=="")
	{
		$.messager.alert('提示', "请先填写计划升学(个数)");
		return false;
	}
	if($("#secondValue").numberbox("getValue")=="")
	{
		$.messager.alert('提示', "请先填写计划升学(年数)");
		return false;
	}
	return true;
}