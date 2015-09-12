var td = 3;
var contactTd = 1;
var validateFlag = false;
var isExists = false;
$(document).ready(function() {
	initDate();
    $("#qryBtn").click(function() {
    	var obj = JSON.stringify($("#qryFm").serializeObject());
    	obj = obj.substring(0, obj.length - 1);
    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
    	$('#list_data').datagrid({
    		url : "/sys/student/qryStudentList.do",
    		queryParams:{
    			param : obj
    		},
    		onLoadSuccess:function(){
    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
    			$('#list_data').datagrid('clearSelections');
    		}
    	});
    });
    
    $("#reset").click(function() {
    	$('#qryFm').form('clear');//清空窗体数据  
    	initDate();
    });
    
    $("#addStudent").click(function() {
    	window.location.href = "/sys/student/addStudent.jsp";
    });
    
    $("#updateStudent").click(function() {
    	if(validateSelect()) {
    		window.location.href = "/sys/student/updateStudent.jsp";
    	}
    });
    
    $("#viewStudent").click(function() {
    	if(validateSelect()) {
    		window.location.href = "/sys/student/viewStudent.jsp";
    	}
    });
    
    $("#addActivity").click(function() {
    	if(validateSelect()) {
    		var row = $('#list_data').datagrid('getSelected');
    		var studentId = row.studentId;
    		window.location.href = "/sys/student/addActivity.jsp?studentId="+studentId;
    	}
    });
    
    $("#batchUpdate").click(function() {
    	if(validate()) {
    		$("#dlg").dialog('open').dialog('setTitle', '批量修改客户关怀和责任顾问');//设定表头  
    		$('#batchUpdateFm').form('clear');//清空窗体数据  
    		var data = $('#updateAdvisterId').combobox('getData');
			$('#updateAdvisterId').combobox('setValue',data[0].staffId);
			data = $('#updateCarer').combobox('getData');
			$('#updateCarer').combobox('setValue',data[0].staffId);
			$("#handlerId").val($("#staffId").val());
    		var obj = $('#list_data').datagrid('getSelections');
    		for(var i = 0, n = obj.length; i < n; i++)
    		{
    			$("#batch_update_data").datagrid('insertRow', {index: i, row: obj[i]});
    		}
    	}
    });
    
    $("#setVip").click(function() {
    	if(validateIsSelect()) {
    		var row = $('#list_data').datagrid('getSelected');
    		var studentId = row.studentId;
    		$.ajax({
    			url: "/sys/student/setVip.do",
    			data: "studentId=" + studentId,
    			dataType: "json",
    			async: false,
    			beforeSend: function()
    	    	{
    	    		$.messager.progress({title : 'VIP学员设置', msg : '正在设置VIP学员，请稍等……'});
    	    	},
    	    	success: function (data) {
    	    		$.messager.progress('close'); 
    	    		var flag = data.flag
    	            if(flag)
    	            {
    	            	$.messager.alert('提示', "VIP学员设置成功！");
    	            	window.location.reload();
    	            }
    	            else
    	            {
    	            	$.messager.alert('提示', "VIP学员设置失败！");
    	            }
    	        } 
    		});
    	}
    });
    
    $("#addVipRematk").click(function() {
    	if(validateIsSelect()) {
    		var row = $('#list_data').datagrid('getSelected');
    		var vip = row.vip;
    		if("Y" == vip) {
    			var studentId = row.studentId;
    			window.location.href = "/sys/vip/addVipRemark.jsp?studentId="+studentId;
    		} else {
    			$.messager.alert('提示', "您选择的学员不是VIP学员，请先将该学员设置为VIP学员或者选择一个VIP学员进行添加VIP维护信息！");
    		}
    	}
    });
    
    $("#viewVip").click(function() {
    	if(validateIsSelect()) {
    		window.location.href = "/sys/vip/viewVipRemarkList.jsp";
    	}
    });
    
    //招生顾问A的学校发生变化时执行的操作
    $('#advisterASchoolId').combobox({    
        onChange : function(n, o) {
        	$("#advisterIdA").combobox({
        		url : "/sys/pubData/qryStaffList.do?post=001&schoolId=" + n,//返回json数据的url
        		valueField : "staffId",
        		textField : "staffName",
        		panelHeight : "auto",
        		onLoadSuccess : function () { //数据加载完毕事件
                    var data = $('#advisterIdA').combobox('getData');
                    if (data.length > 0) {
                        $("#advisterIdA").combobox('select', data[0].staffId);
                    }
                }
        	});
        }  
    });
    
    //招生顾问B的学校发生变化时执行的操作
    $('#advisterBSchoolId').combobox({    
        onChange : function(n, o) {
        	$("#advisterIdB").combobox({
        		url : "/sys/pubData/qryStaffList.do?post=001&schoolId=" + n,//返回json数据的url
        		valueField : "staffId",
        		textField : "staffName",
        		panelHeight : "auto",
        		onLoadSuccess : function () { //数据加载完毕事件
                    var data = $('#advisterIdB').combobox('getData');
                    if (data.length > 0) {
                        $("#advisterIdB").combobox('select', data[0].staffId);
                    }
                }
        	});
        }  
    });
    
    //就读学校类型发生变化时执行的操作
    $("#schoolType").combobox({
    	onChange : function(n, o) {
    		$("#realSchoolId").combobox({
    			url : "/sys/pubData/qryParaConfigList.do?paramType=REAL_SCHOOL_ID&paramValue=" + n,//返回json数据的url
        		valueField : "param1",
        		textField : "param2",
        		panelHeight : "auto",
        		onLoadSuccess : function () { //数据加载完毕事件
                    var data = $('#realSchoolId').combobox('getData');
                    if (data.length > 0) {
                        $("#realSchoolId").combobox('select', data[0].staffId);
                    }
                }
    		});
    	}
    });
    
    //点击“添加就读信息”按钮
    $("#addRealSchool").click(function() {
    	var realSchoolId = $('#realSchoolId').combobox('getValue');
    	if(realSchoolId != "" && realSchoolId != null && realSchoolId != undefined)
    	{
    		var schoolType = $('#schoolType').combobox('getValue');
    		var schoolTypeText = $('#schoolType').combobox('getText');
    		var realSchoolName = $('#realSchoolId').combobox('getText');
    		var delTd = td + 1;
    		var content = "<tr><td align='right'><span>学校类型：</span></td><td><span>"+schoolTypeText+"</span></td>";
    		content += "<td align='right'><span>学校名称：</span></td><td><span>"+realSchoolName+"</span></td>";
    		content += "<input type='hidden' name='realSchools' schoolType='"+schoolType+"' realSchoolId='"+realSchoolId+"'/>";
    		content += "<td align='center'><a href='javascript:void(0)' class='linkmore' onclick='deleteRealSchool(this)'><span>删除</span></a></td></tr>";
    		$("#addStudentTd tr:eq("+td+")").after(content);
    		td += 1;
    	}
    	else
    	{
    		$.messager.alert('提示', "请选择一个就读学校名称！");
    	}
    });
    
    //点击联系人信息中的“添加”按钮
    $("#addContact").click(function() {
    	if($("#contactFm").form('validate'))
    	{
    		var flag = true;
    		var relationType = $('#relationType').combobox('getValue');
    		var relationTypeText = $('#relationType').combobox('getText');
    		if($("[name='contacts']").length > 0)
    		{
    			$("[name='contacts']").each(function() {
    				if(relationType == $(this).attr("relationType"))
    				{
    					flag = false;
    				}
    			});
    		}
    		if(flag)
    		{
    			var used = $("[name='used']").prop("checked");
    			var usedName = "";
    			if(used)
    			{
    				$("[name='contacts']").each(function() {
    					if("Y" == $(this).attr("used"))
    					{
    						usedName = $(this).attr("contactName")
    						flag = false;
    					}
    				});
    			}
    			if(flag)
    			{
    				var contactName = $("#contactName").textbox("getValue");
    				var job = $("#job").textbox("getValue");
    				var contactIdentityType = $('#contactIdentityType').combobox('getValue');
    				var contactIdentityTypeText = $('#contactIdentityType').combobox('getText');
    				var contactIdentityId = $("#contactIdentityId").textbox("getValue");
    				var phone = $("#phone").textbox("getValue");
    				var content = "<tr><td align='center'><span>"+relationTypeText+"</span>";
    				content += "<td align='center'><span>"+contactName+"</span></td>";
    				content += "<td align='center'><span>"+job+"</span></td>";
    				content += "<td align='center'>";
    				var contactUsed = "N";
    				if(used)
    				{
    					content += "<input type='checkbox' checked='checked'/>";
    					contactUsed = "Y";
    				}
    				else
    				{
    					content += "<input type='checkbox'/>";
    				}
    				content += "</td>";
    				content += "<td align='center'><span>"+contactIdentityTypeText+"："+contactIdentityId+"</span>";
    				content += "<td align='center'><span>"+phone+"</span></td>";
    				content += "<input type='hidden' name='contacts' relationType='"+relationType+"' job='"+job+"' used='"+contactUsed+"' contactName='"+contactName+"' identityType='"+contactIdentityType+"' identityId='"+contactIdentityId+"' phone='"+phone+"'/></td>"
    				content += "<td align='center'><a href='javascript:void(0)' class='linkmore' onclick='deleteContact(this)'><span>删除</span></a></td></tr>";
    				$("#addContactTd tr:eq("+contactTd+")").after(content);
    				contactTd += 1;
    				//初始化第一列
    				var data = $('#relationType').combobox('getData');
    				$('#relationType').combobox('setValue',data[0].codeFlag);
    				data = $('#contactIdentityType').combobox('getData');
    				$('#contactIdentityType').combobox('setValue',data[0].codeFlag);
    				$("#contactName").textbox("setValue", "");
    				$("#job").textbox("setValue", "");
    				$("#contactIdentityId").textbox("setValue", "");
    				$("#phone").textbox("setValue", "");
    				$("[name='used']").removeAttr("checked");
    			}
    			else
    			{
    				$.messager.alert('提示', "您已设置了"+usedName+"为常用联系人！");
    			}
    		}
    		else
    		{
    			$.messager.alert('提示', "联系人关系为“" + relationTypeText + "”的联系人已存在，请更换联系人关系！");
    		}
    	}
    });
    
    //学员验重
    $("#validate").click(function() {
    	var flag = false;
    	var identityType = $('#identityType').combobox('getValue');
    	var identityId = $("#identityId").textbox("getValue");
    	if(identityType != null && identityType != "" && identityType != undefined
    			&& identityId != null && identityId != "" && identityId != undefined)
    	{
    		flag = true;
    	}
    	if(!flag)
    	{
    		var name = $("#name").textbox("getValue");
			var birthday = $("#birthday").datebox("getValue");
			var sex = $("input[name='sex']:checked").val();
			if(name != null && name != "" && name != undefined
					&& birthday != null && birthday != "" && birthday != undefined
					&& sex != null && sex != "" && sex != undefined)
			{
				flag = true;
			}
    	}
    	if(flag)
    	{
    		var obj = JSON.stringify($("#studentFm").serializeObject());
    		$.ajax({
    			url: "/sys/student/validate.do",
    			data: "param=" + obj,
    			dataType: "json",
    			async: false,
    			beforeSend: function()
    	    	{
    	    		$.messager.progress({title : '验重', msg : '正在验重，请稍等……'});
    	    	},
    	    	success: function (data) {
    	    		var flag = data.flag
    	            if(flag)
    	            {
    	            	$.messager.alert('提示', "该学员暂未注册，资料有效！");
    	            }
    	            else
    	            {
    	            	isExists = true;
    	            	$.messager.alert('提示', data.msg);
    	            }
    	    		$.messager.progress('close'); 
    	    		validateFlag = true;
    	        } 
    		});
    	}
    	else
    	{
    		$.messager.alert('提示', "请输入学员的证件号码或者学员姓名、性别和出生日期！");
    	}
    });
    
    //学员注册
    $("#studentSubmit").click(function() {
    	if(validateFlag)
    	{
    		if(isExists)
    		{
    			$.messager.alert('提示', "该学员已存在资料，不需要再进行注册！");
    		}
    		else
    		{
    			if($("#studentFm").form('validate'))
    			{
    				if($("[name='contacts']").length > 0)
    				{
    					var obj = JSON.stringify($("#studentFm").serializeObject());
    					var contactArray = "[";
    					$("[name='contacts']").each(function() {
    						contactArray += "{identityId:\""+$(this).attr("identityId")+"\",identityType:\""+$(this).attr("identityType")+"\",name:\""+$(this).attr("contactName")+"\",phone:\""+$(this).attr("phone")+"\",relationType:\""+$(this).attr("relationType")+"\",job:\""+$(this).attr("job")+"\",used:\""+$(this).attr("used")+"\"},";
    					});
    					contactArray = contactArray.substring(0, contactArray.length - 1) + "]";
    					var realSchoolArray = "[";
    					if($("[name='realSchools']").length > 0)
    					{
    						$("[name='realSchools']").each(function() {
    							realSchoolArray += "{schoolType:\""+$(this).attr("schoolType")+"\",realSchoolId:\""+$(this).attr("realSchoolId")+"\"},";
    						});
    						realSchoolArray = realSchoolArray.substring(0, realSchoolArray.length - 1);
    					}
    					realSchoolArray += "]";
    					var param = "{studentInfo:"+obj+",contactArray:"+contactArray+",realSchoolArray:"+realSchoolArray+"}";
    					$.ajax({
    		    			url: "/sys/student/addStudent.do",
    		    			data: "param=" + param,
    		    			dataType: "json",
    		    			async: false,
    		    			beforeSend: function()
    		    	    	{
    		    	    		$.messager.progress({title : '学员注册', msg : '学员正在注册，请稍等……'});
    		    	    	},
    		    	    	success: function (data) {
    		    	    		$.messager.progress('close'); 
    		    	    		var flag = data.flag
    		    	            if(flag)
    		    	            {
    		    	            	$.messager.alert('提示', "学员注册成功！");
    		    	            	window.location.reload();
    		    	            }
    		    	            else
    		    	            {
    		    	            	$.messager.alert('提示', "学员注册失败！");
    		    	            }
    		    	        } 
    		    		});
    				}
    				else
    				{
    					$.messager.alert('提示', "请至少添加一个联系人信息！");
    				}
    			}
    		}
    	}
    	else
    	{
    		$.messager.alert('提示', "请先对学员进行验重！");
    	}
    });
    
    //添加活动
    $("#activitySubmit").click(function(){
    	if($("#activityFm").form('validate')) {
    		var obj = JSON.stringify($("#activityFm").serializeObject());
    		var activityName = $("#title").combobox("getValue");
    		obj = obj.substring(0, obj.length - 1);
    		obj += ",\"activityName\":\""+activityName+"\"}";
    		$.ajax({
    			url: "/sys/student/addActivity.do",
    			data: "param=" + obj,
    			dataType: "json",
    			async: false,
    			beforeSend: function()
    	    	{
    	    		$.messager.progress({title : '活动信息', msg : '正在添加活动信息，请稍等……'});
    	    	},
    	    	success: function (data) {
    	    		$.messager.progress('close'); 
    	    		var flag = data.flag
    	            if(flag)
    	            {
    	            	$.messager.alert('提示', "成功添加活动信息！");
    	            	window.location.reload();
    	            }
    	            else
    	            {
    	            	$.messager.alert('提示', "添加活动信息失败！");
    	            }
    	        } 
    		});
    	}
    });
    
    //VIP维护信息添加
    $("#vipRemarkSubmit").click(function() {
    	if($("#vipRemarkFm").form('validate')) {
    		var obj = JSON.stringify($("#vipRemarkFm").serializeObject());
    		$.ajax({
    			url: "/sys/student/addVipRemark.do",
    			data: "param=" + obj,
    			dataType: "json",
    			async: false,
    			beforeSend: function()
    	    	{
    	    		$.messager.progress({title : 'VIP维护信息', msg : '正在添加VIP维护信息，请稍等……'});
    	    	},
    	    	success: function (data) {
    	    		$.messager.progress('close'); 
    	    		var flag = data.flag
    	            if(flag)
    	            {
    	            	$.messager.alert('提示', "成功添加VIP维护信息！");
    	            	window.location.reload();
    	            }
    	            else
    	            {
    	            	$.messager.alert('提示', "添加VIP维护信息失败！");
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
    	alert($("#handlerId").val());
    	alert(obj);
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
	            if(flag)
	            {
	            	$.messager.alert('提示', "成功批量修改客户关怀和责任顾问！");
	            	window.location.reload();
	            }
	            else
	            {
	            	$.messager.alert('提示', "批量修改客户关怀和责任顾问失败！");
	            }
	        } 
		});
    });
});

//删除就读学校记录
function deleteRealSchool(obj)
{
	$(obj).parent().parent().remove(); 
	td = td - 1;
}

//删除联系人信息
function deleteContact(obj)
{
	$(obj).parent().parent().remove(); 
	contactTd = contactTd - 1;
}

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