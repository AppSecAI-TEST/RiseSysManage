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
    
    //重置
    $("#reset").click(function() {
    	$('#qryFm').form('clear');//清空窗体数据  
    });
    
    //校区
    var funcNodeId = $("#funcNodeId").val();
    if(funcNodeId != null && funcNodeId != "" && funcNodeId != undefined) {
    	var staffId = $("#staffId").val();
    	$("#schoolId").combobox({
    		url : "/sys/pubData/qrySchoolList.do?schoolId=",//返回json数据的url
    		valueField : "schoolId",
    		textField : "schoolName",
    		panelHeight : "auto",
    		formatter : function(data) {
    			return "<span>" + data.schoolName + "</span>";
    		},
    		onLoadSuccess : function() {
    			$("#schoolId").combobox("setValue", "");
    			$("#schoolId").combobox("setText", "全部校区");
    		},
    		onChange : function(n, o) {
    			if(n != "" && n != null && n != undefined) {
    				$("#classInstId").combobox({disabled: false});
    				$("#classInstId").combobox({
    					url : "/sys/pubData/qryClassInstList.do?schoolId="+n+"&courseType=&stageId=&classType=&classState='001','002','003','004','005'&classInstId=",//返回json数据的url
    					valueField : "classInstId",
    					textField : "className",
    					panelHeight : "auto",
    					formatter : function(data) {
    						return "<span>" + data.className + "</span>";
    					},
    					onChange : function(newVal, oldVal) {
    						$("#studentId").combobox({
    							url : "/sys/pubData/qryStudentListByClassInstId.do?classInstId="+newVal,
    							valueField : "studentId",
    							textField : "name",
    							panelHeight : "auto",
    							formatter : function(data) {
    								return "<span>" + data.name + "</span>";
    							}
    						});
    					}
    				});
    				var classInstId = $("#classInstId").combobox("getValue");
    				if(classInstId == null || classInstId == "" || classInstId == undefined) {
    					alert(funcNodeId)
    					$("#studentId").combobox({
    						url : "/sys/pub/paramComboxList.do?staffId="+staffId+"&schoolId="+n+"&funcNodeId="+funcNodeId+"&fieldId=studentId",
    						valueField : "studentId",
    						textField : "name",
    						panelHeight : "auto",
    						formatter : function(data) {
    							return "<span>" + data.name + "</span>";
    						}
    					});
    				}
    			} else {
    				$("#schoolId").combobox("setText", "全部校区");
    				$("#classInstId").combobox('clear');
    				$("#classInstId").combobox("loadData", new Array());
    				$("#classInstId").combobox({disabled: true});
    			}
    		}
    	});
    }
    
    $("#addStudent").click(function() {
    	window.location.href = "/sys/student/addStudent.jsp";
    });
    
    $("#updateStudent").click(function() {
    	if(validateSelect()) {
    		var row = $('#list_data').datagrid('getSelected');
    		var schoolId = row.schoolId;
    		var studentId = row.studentId;
    		var funcNodeId = $("#updateStudent").attr("funcNodeId");
    		var dutyAdvister = row.dutyAdvister;
    		var carer = row.carer;
    		var advisterIdA = row.advisterIdA;
    		var advisterIdB = row.advisterIdB;
    		var identityType = row.identityType;
    		var advisterASchoolId = row.advisterASchoolId;
    		var advisterBSchoolId = row.advisterBSchoolId;
    		window.location.href = "/sys/student/updateStudent.jsp?studentId="+studentId+"&funcNodeId="+funcNodeId+"&dutyAdvister="+dutyAdvister+"&carer="+carer+"&advisterIdA="+advisterIdA+"&advisterIdB="+advisterIdB+"&identityType="+identityType+"&advisterASchoolId="+advisterASchoolId+"&advisterBSchoolId="+advisterBSchoolId+"&schoolId="+schoolId;
    	}
    });
    
    $("#viewStudent").click(function() {
    	if(validateSelect()) {
    		var row = $('#list_data').datagrid('getSelected');
    		var studentId = row.studentId;
    		window.location.href = "/sys/view.jsp?studentId="+studentId+"&title=基础信息";
    	}
    });
    
    $("#addActivity").click(function() {
    	if(validateSelect()) {
    		var row = $('#list_data').datagrid('getSelected');
    		var studentId = row.studentId;
    		var name = row.name;
    		window.location.href = "/sys/student/addActivity.jsp?studentId="+studentId+"&name="+name;
    	}
    });
    
    $("#batchUpdate").click(function() {
    	if(validate()) {
    		$("#dlg").dialog('open').dialog('setTitle', '批量修改客户关怀和责任顾问');//设定表头  
    		$('#batchUpdateFm').form('clear');//清空窗体数据  
    		$('#batch_update_data').datagrid('loadData',{total:0, rows:[]}); 
    		var data = $('#updateAdvisterId').combobox('getData');
    		if(data.length > 0) {
    			$('#updateAdvisterId').combobox('setValue',data[0].staffId);
    		}
			data = $('#updateCarer').combobox('getData');
			if(data.length > 0) {
    			$('#updateCarer').combobox('setValue',data[0].staffId);
    		}
			$("#handlerId").val($("#staffId").val());
    		var obj = $('#list_data').datagrid('getSelections');
    		for(var i = 0, n = obj.length; i < n; i++) {
    			$("#batch_update_data").datagrid('insertRow', {index: i, row: obj[i]});
    		}
    	}
    });
    
    $("#setVip").click(function() {
    	var row = $('#list_data').datagrid('getSelected');
    	if(row) {
    		var vip = row.vip;
    		if("N" == vip) {
    			var studentId = row.studentId;
    			var phone = row.phone;
    			var schoolName = row.schoolName;
    			window.location.href = "/sys/student/qryStudentVipById.do?type=ADD&studentId="+studentId+"&phone="+phone+"&schoolName="+schoolName;
    		} else {
    			$.messager.alert('提示', "您选择的学员已是VIP学员，不能再设置该学员！");
    		}
    	} else {
    		$.messager.alert('提示', "请您选择您要设置VIP信息的学员！");
    	}
    });
    
    $("#addVipRematk").click(function() {
    	var row = $('#list_data').datagrid('getSelected');
    	if(row) {
    		var vip = row.vip;
    		if("Y" == vip) {
    			var studentId = row.studentId;
    			var phone = row.phone;
    			var schoolName = row.schoolName;
    			window.location.href = "/sys/student/qryStudentVipById.do?type=UPDATE&studentId="+studentId+"&phone="+phone+"&schoolName="+schoolName;
    		} else {
    			$.messager.alert('提示', "您选择的学员不是VIP学员，请先将该学员设置为VIP学员或者选择一个VIP学员进行添加VIP维护信息！");
    		}
    	} else {
    		$.messager.alert('提示', "请您选择您要维护VIP信息的学员！");
    	}
    });
    
    $("#viewVip").click(function() {
    	var row = $('#list_data').datagrid('getSelected');
    	if(row) {
    		var vip = row.vip;
    		var studentId = row.studentId;
			window.location.href = "/sys/view.jsp?studentId="+studentId+"&title=VIP信息";
    	} else {
    		$.messager.alert('提示', "请您选择您要浏览的学员！");
    	}
    });
    
    //VIP维护信息添加
    $("#setVipSubmit").click(function() {
    	if($("#setVipFm").form('validate')) {
    		var obj = JSON.stringify($("#setVipFm").serializeObject());
    		obj = encodeURI(obj);
    		$.ajax({
    			url: "/sys/student/setVip.do",
    			data: "param=" + obj,
    			dataType: "json",
    			async: false,
    			beforeSend: function()
    	    	{
    	    		$.messager.progress({title : 'VIP学员设置', msg : '正在设置VIP学员，请稍等……'});
    	    	},
    	    	success: function (data) {
    	    		$.messager.progress('close'); 
    	    		var flag = data.flag
    	            if(flag) {
    	            	$.messager.alert('提示', "VIP学员设置成功！", "info", function() {window.history.back();});
    	            } else {
    	            	$.messager.alert('提示', data.msg);
    	            }
    	        } 
    		});
    	}
    });
    
    //VIP维护信息修改
    $("#updateVipSubmit").click(function() {
    	if($("#updateVipFm").form('validate')) {
    		var obj = JSON.stringify($("#updateVipFm").serializeObject());
    		obj = encodeURI(obj);
    		$.ajax({
    			url: "/sys/student/updateVip.do",
    			data: "param=" + obj,
    			dataType: "json",
    			async: false,
    			beforeSend: function()
    	    	{
    	    		$.messager.progress({title : 'VIP维护信息', msg : '正在维护VIP信息，请稍等……'});
    	    	},
    	    	success: function (data) {
    	    		$.messager.progress('close'); 
    	    		var flag = data.flag
    	            if(flag) {
    	            	$.messager.alert('提示', "成功添加VIP维护信息！", "info", function() {window.history.back();});
    	            } else {
    	            	$.messager.alert('提示', data.msg);
    	            }
    	        } 
    		});
    	}
    });
    
    $("#batchUpdateSubmit").click(function() {
    	var studentId = "";
    	var obj = $('#list_data').datagrid('getSelections');
    	for(var i = 0, n = obj.length; i < n; i++)
    	{
    		studentId += obj[i].studentId + ",";
    	}
    	studentId = studentId.substring(0, studentId.length - 1);
    	$("#updateStudentId").val(studentId);
    	var obj = JSON.stringify($("#batchUpdateFm").serializeObject());
    	obj = encodeURI(obj);
		$.ajax({
			url: "/sys/student/batchUpdateAdvister.do",
			data: "param=" + obj,
			dataType: "json",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '批量修改', msg : '正在批量修改客户关怀和责任顾问，请稍等……'});
	    	},
	    	success: function (data) {
	    		$.messager.progress('close'); 
	    		var flag = data.flag
	            if(flag) {
	            	$.messager.alert('提示', "成功批量修改客户关怀和责任顾问！", "info", function() {window.location.reload();});
	            } else {
	            	$.messager.alert('提示', data.msg);
	            }
	        } 
		});
    });
});

function validateIsSelect()
{
	var flag = false;
	var row = $('#list_data').datagrid('getSelected');
	if(row) {
		flag = true;
	} else {
		$.messager.alert('提示', "请先选择您要操作的学员！");
	}
	return flag;
}

function validate()
{
	var flag = false;
	var obj = $('#list_data').datagrid('getSelections');
	if(obj.length > 0) {
		flag = true;
	}
	else {
		$.messager.alert('提示', "请先选择您要操作的学员！");
	}
	return flag;
}

function validateSelect()
{
	var flag = false;
	var obj = $('#list_data').datagrid('getSelections');
	if(obj.length > 0) {
		if(obj.length > 1) {
			$.messager.alert('提示', "只能选择一个学员进行操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择您要操作的学员！");
	}
	return flag;
}

function initDate()
{
	var curr_time = new Date();
	$('#endTime').datebox('setValue', myformatter(curr_time));
	curr_time.setMonth(curr_time.getMonth() - 1);
	$('#startTime').datebox('setValue', myformatter(curr_time));
}
