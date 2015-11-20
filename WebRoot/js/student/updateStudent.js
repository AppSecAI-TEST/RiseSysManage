var td = 3;
var contactTd = 1;
var activityTd = 1;
var realIds = "";
var contactIds = "";
var activityIds = "";
var updateFlag = false;
var identityValidateFlag = false;
var validateFlag = false;
var contactLength = 0;
var studentObj = null;
var array = new Array();
$(document).ready(function() {
	var studentId = $("#studentId").val();
	var funcNodeId = $("#funcNodeId").val();
	$.ajax({
		url: "/sys/student/qryStudentById.do",
		data: "studentId=" + studentId + "&funcNodeId=" + funcNodeId,
		dataType: "json",
		async: false,
		beforeSend: function()
    	{
    		$.messager.progress({title : '修改学员资料', msg : '正在查询学员资料，请稍等……'});
    	},
    	success: function (data) {
    		$.messager.progress('close'); 
    		var schoolId = $("#schoolId").val();
    		//分校区
    		if(schoolId.length > 2)
    		{
    			$("#nameDiv").css('display', "none");
        		$("#nameText").css('display', "block");
        		
        		$("#birthdayDiv").css('display', "none");
        		$("#birthdayText").css('display', "block");
        		
        		$("#sexDiv").css('display', "none");
        		$("#sexText").css('display', "block");
        		
        		$("#advisterADiv").css('display', "none");
        		$("#advisterAText").css('display', "block");
        		
        		$("#advisterBDiv").css('display', "none");
        		$("#advisterBText").css('display', "block");
    		}
    		
    		studentObj = data.studentObj;
    		$("#nameText").html(studentObj.name);
    		$("#name").textbox('setValue', studentObj.name);
    		$("#birthdayText").html(studentObj.birthday);
    		$("#birthday").datebox('setValue', studentObj.birthday);
    		$("#sexText").html(studentObj.sexVal);
    		$("input[name='sex'][value="+studentObj.sex+"]").attr("checked", true); 
    		$("#advisterAText").html(studentObj.advisterNameA);
    		$("#advisterBText").html(studentObj.advisterNameB);
    		$("#identityId").textbox('setValue', studentObj.identityId);
    		$("#byName").textbox('setValue', studentObj.byName);
    		$("#address").textbox('setValue', studentObj.address);
    		$("#remark").textbox('setValue', studentObj.remark);
    		
    		array.push({"key": "address", "value": studentObj.address});
    		array.push({"key": "advisterIdA", "value": studentObj.advisterIdA});
    		array.push({"key": "advisterIdB", "value": studentObj.advisterIdB});
    		array.push({"key": "birthday", "value": studentObj.birthday});
    		array.push({"key": "byName", "value": studentObj.byName});
    		array.push({"key": "carer", "value": studentObj.carer});
    		array.push({"key": "dutyAdvister", "value": studentObj.dutyAdvister});
    		array.push({"key": "identityId", "value": studentObj.identityId});
    		array.push({"key": "identityType", "value": studentObj.identityType});
    		array.push({"key": "name", "value": studentObj.name});
    		array.push({"key": "remark", "value": studentObj.remark});
    		array.push({"key": "sex", "value": studentObj.sex});
    		
    		var len1 = data.realSchoolObj.total;
    		if(len1 > 0)
    		{
    			var realSchoolArray = data.realSchoolObj.rows;
    			for(var i = 0; i < len1; i++)
    			{
    				var content = "<tr><td align='right'><span>学校类型：</span></td><td><span>"+realSchoolArray[i].schoolTypeText+"</span></td>";
    	    		content += "<td align='right'><span>学校名称：</span></td><td><span>"+realSchoolArray[i].realSchoolName+"</span></td>";
    	    		content += "<td align='center'><a href='javascript:void(0)' class='linkmore' onclick='deleteRealSchool(this, "+realSchoolArray[i].realId+")'><span>删除</span></a></td></tr>";
    	    		$("#studentTd tr:eq("+td+")").after(content);
    	    		td += 1;
    			}
    		}
    		
    		contactLength = data.contactObj.total;
    		if(contactLength > 0)
    		{
    			var contactArray = data.contactObj.rows;
    			for(var i = 0; i < contactLength; i++)
    			{
    				var content = "<tr><td align='center'><span>"+contactArray[i].relationTypeVal+"</span></td>";
    				content += "<td align='center'><span>"+contactArray[i].name+"</span></td>";
    				content += "<td align='center'><span>"+contactArray[i].job+"</span></td>";
    				content += "<td align='center'>";
    				var used = contactArray[i].used;
    				if("Y" == used)
    				{
    					content += "<input type='checkbox' checked='checked'/>";
    				}
    				else
    				{
    					content += "<input type='checkbox'/>";
    				}
    				content += "</td>";
    				content += "<td align='center'><span>"+contactArray[i].identity+"</span></td>";
    				content += "<td align='center'><span>"+contactArray[i].phone+"</span></td>";
    				content += "<td align='center'><a href='javascript:void(0)' class='linkmore' onclick='deleteContact(this, "+contactArray[i].contactId+")'><span>删除</span></a></td></tr>";
    				$("#contactTd tr:eq("+contactTd+")").after(content);
    				contactTd += 1;
    			}
    		}
    		
    		var len3 = data.activityObj.total;
    		if(len3 > 0)
    		{
    			var activityArray = data.activityObj.rows;
    			for(var i = 0; i < len3; i++)
    			{
    				var content = "<tr><td align='center'><span>"+activityArray[i].titleText+"</span></td>";
    				content += "<td align='center'><span>"+activityArray[i].activityDate+"</span></td>";
    				content += "<td align='center'><span>"+activityArray[i].awardText+"</span></td>";
    				content += "<td align='center'><span>"+activityArray[i].remark+"</span></td>";
    				content += "<td align='center'><a href='javascript:void(0)' class='linkmore' onclick='deleteActivity(this, "+activityArray[i].activityId+")'><span>删除</span></a></td></tr>";
    				$("#activityTd tr:eq("+activityTd+")").after(content);
    				activityTd += 1;
    			}
    		}
        } 
	});
	
	//招生顾问A的学校发生变化时执行的操作
    $('#advisterASchoolId').combobox({
    	url : "/sys/pubData/qrySchoolList.do?schoolId=",//返回json数据的url
    	valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	onLoadSuccess : function () { //数据加载完毕事件
            var data = $('#advisterASchoolId').combobox('getData');
            if (data.length > 0) {
                $("#advisterASchoolId").combobox('select', $("#updateAdvisterBSchoolId").val());
            }
        },
        onChange : function(n, o) {
        	$("#advisterIdA").combobox({
        		url : "/sys/pubData/qryStaffList.do?schoolId=" + n,//返回json数据的url
        		valueField : "staffId",
        		textField : "userName",
        		panelHeight : "auto",
        		onLoadSuccess : function () { //数据加载完毕事件
                    var data = $('#advisterIdA').combobox('getData');
                    if (data.length > 0) {
                        $("#advisterIdA").combobox('select', $("#updateAdvisterIdA").val());
                    }
                }
        	});
        }  
    });
    
    //招生顾问B的学校发生变化时执行的操作
    $('#advisterBSchoolId').combobox({
    	url : "/sys/pubData/qrySchoolList.do?schoolId=",//返回json数据的url
    	valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	onLoadSuccess : function () { //数据加载完毕事件
            var data = $('#advisterBSchoolId').combobox('getData');
            if (data.length > 0) {
                $("#advisterBSchoolId").combobox('select', $("#updateAdvisterBSchoolId").val());
            }
        },
        onChange : function(n, o) {
        	$("#advisterIdB").combobox({
        		url : "/sys/pubData/qryStaffList.do?schoolId=" + n,//返回json数据的url
        		valueField : "staffId",
        		textField : "userName",
        		panelHeight : "auto",
        		onLoadSuccess : function () { //数据加载完毕事件
                    var data = $('#advisterIdB').combobox('getData');
                    if (data.length > 0) {
                        $("#advisterIdB").combobox('select', $("#updateAdvisterIdB").val());
                    }
                }
        	});
        }  
    });
	
	//就读学校类型发生变化时执行的操作
    $("#schoolType").combobox({
    	url : "/sys/pubData/qryCodeNameList.do?tableName=REAL_SCHOOL_T&codeType=SCHOOL_TYPE",//返回json数据的url
    	valueField : "codeFlag",
    	textField : "codeName",
    	panelHeight : "auto",
    	onLoadSuccess : function () { //数据加载完毕事件
            var data = $('#schoolType').combobox('getData');
            if (data.length > 0) {
                $("#schoolType").combobox('select', data[0].codeFlag);
            }
        },
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
	
	//学员验重
	$("#validate").click(function() {
    	var identityId = $("#identityId").textbox("getValue");
    	if(studentObj.identityId != identityId) {
    		updateFlag = true;
    		var obj = JSON.stringify($("#studentFm").serializeObject());
    		obj = obj.substring(0, obj.length - 1);
    		var funcNodeId = $("#validate").attr("funcNodeId");
    		obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
    		obj = encodeURI(obj);
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
    	            	$.messager.alert('提示', "该证件号码还暂未注册，资料有效！");
    	            	identityValidateFlag = true;
    	            }
    	            else
    	            {
    	            	$.messager.alert('提示', "该证件号码已注册，请输入其他未注册的证件号码！");
    	            }
    	    		$.messager.progress('close'); 
    	    		validateFlag = true;
    	        } 
    		});
    	} else {
    		$.messager.alert('提示', "请先修改该学员的证件号码再进行验重！");
    	}
	});
	
	//学员修改提交
	$("#updateSubmit").click(function() {
		contactLength += $("[name='contacts']").length;
		if(contactLength > 0) {
			if($("[name='contacts']").length > 0)
			{
				updateFlag = true;
			}
			if($("[name='realSchools']").length > 0)
			{
				updateFlag = true;
			}
			if($("[name='activitys']").length > 0)
			{
				updateFlag = true;
			}
			if(!updateFlag)
			{
				updateFlag = validateStudent();
			}
			if(updateFlag) {
				var flag = true;
				var identityId = $("#identityId").textbox("getValue");
				if(identityId != null && identityId != "" && identityId != undefined && identityId != studentObj.identityId) {
					if(validateFlag) {
						if(!identityValidateFlag) {
							flag = false;
							$.messager.alert('提示', "您修改的证件号码验重不通过，请输入其他证件号码！");
						} 
					} else {
						flag = false;
						$.messager.alert('提示', "请先对学员进行验重！");
					}
				}
				if(flag) {
					if($("#studentFm").form('validate')) {
						var contactArray = "[";
						if($("[name='contacts']").length > 0)
						{
							$("[name='contacts']").each(function() {
								contactArray += "{identityId:\""+$(this).attr("identityId")+"\",identityType:\""+$(this).attr("identityType")+"\",name:\""+$(this).attr("contactName")+"\",phone:\""+$(this).attr("phone")+"\",relationType:\""+$(this).attr("relationType")+"\",job:\""+$(this).attr("job")+"\",used:\""+$(this).attr("used")+"\"},";
							});
							contactArray = contactArray.substring(0, contactArray.length - 1);
						}
						contactArray += "]";
    					var realSchoolArray = "[";
    					if($("[name='realSchools']").length > 0)
    					{
    						$("[name='realSchools']").each(function() {
    							realSchoolArray += "{schoolType:\""+$(this).attr("schoolType")+"\",realSchoolId:\""+$(this).attr("realSchoolId")+"\"},";
    						});
    						realSchoolArray = realSchoolArray.substring(0, realSchoolArray.length - 1);
    					}
    					realSchoolArray += "]";
    					var activityArray = "[";
    					if($("[name='activitys']").length > 0)
    					{
    						$("[name='activitys']").each(function() {
    							activityArray += "{title:\""+$(this).attr("title")+"\",activityDate:\""+$(this).attr("activityDate")+"\",award:\""+$(this).attr("award")+"\",remark:\""+$(this).attr("remark")+"\",activityName:\""+$(this).attr("activityName")+"\"},";
    						});
    						activityArray = activityArray.substring(0, activityArray.length - 1);
    					}
    					activityArray += "]";
    					if(contactIds != "" && contactIds != null && contactIds != undefined && contactIds != "null")
    					{
    						contactIds = contactIds.substring(0, contactIds.length - 1);
    					}
    					if(activityIds != "" && activityIds != null && activityIds != undefined && activityIds != "null")
    					{
    						activityIds = activityIds.substring(0, activityIds.length - 1);
    					}
    					if(realIds != "" && realIds != null && realIds != undefined && realIds != "null")
    					{
    						realIds = realIds.substring(0, realIds.length - 1);
    					}
    					var obj = JSON.stringify($("#studentFm").serializeObject());
						obj = obj.substring(0, obj.length - 1);
    					obj += ",\"contactId\":\""+contactIds+"\",\"activityId\":\""+activityIds+"\",\"realId\":\""+realIds+"\",\"contactArray\":"+contactArray+",\"realSchoolArray\":"+realSchoolArray+",\"activityArray\":"+activityArray+"}";
    					obj = encodeURI(obj);
    					$.ajax({
    		    			url: "/sys/student/updateStudent.do",
    		    			data: "param=" + obj,
    		    			dataType: "json",
    		    			async: false,
    		    			beforeSend: function()
    		    	    	{
    		    	    		$.messager.progress({title : '修改档案', msg : '正在修改学员档案，请稍等……'});
    		    	    	},
    		    	    	success: function (data) {
    		    	    		$.messager.progress('close'); 
    		    	    		var flag = data.flag
    		    	            if(flag) {
    		    	            	$.messager.alert('提示', "修改学员档案成功！", "info", function() {window.location.reload();});
    		    	            } else {
    		    	            	$.messager.alert('提示', "修改学员档案失败！");
    		    	            }
    		    	        } 
    		    		});
					}
				}
			} else {
				$.messager.alert('提示', "请先对该学员做一些修改之后，再进行提交！");
			}
		} else {
			$.messager.alert('提示', "请至少添加一个联系人信息！");
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
    		var content = "<tr><td align='right'><span>学校类型：</span></td><td><span>"+schoolTypeText+"</span></td>";
    		content += "<td align='right'><span>学校名称：</span></td><td><span>"+realSchoolName+"</span></td>";
    		content += "<input type='hidden' name='realSchools' schoolType='"+schoolType+"' realSchoolId='"+realSchoolId+"'/>";
    		content += "<td align='center'><a href='javascript:void(0)' class='linkmore' onclick='delRealSchool(this)'><span>删除</span></a></td></tr>";
    		$("#studentTd tr:eq("+td+")").after(content);
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
    				var content = "<tr><td align='center'><span>"+relationTypeText+"</span></td>";
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
    				content += "<td align='center'><span>"+contactIdentityTypeText+"："+contactIdentityId+"</span></td>";
    				content += "<td align='center'><span>"+phone+"</span>";
    				content += "<input type='hidden' name='contacts' relationType='"+relationType+"' job='"+job+"' used='"+contactUsed+"' contactName='"+contactName+"' identityType='"+contactIdentityType+"' identityId='"+contactIdentityId+"' phone='"+phone+"'/></td>";
    				content += "<td align='center'><a href='javascript:void(0)' class='linkmore' onclick='delContact(this)'><span>删除</span></a></td></tr>";
    				$("#contactTd tr:eq("+contactTd+")").after(content);
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
    
    $("#addActivity").click(function() {
    	if($("#activityFm").form('validate')) {
    		var title = $('#title').combobox('getValue');
    		var titleText = $('#title').combobox('getText');
    		var activityDate = $("#activityDate").datebox("getValue");
    		var award = $('#award').combobox('getValue');
    		var awardText = $('#award').combobox('getText');
    		var remark = $("#activityRemark").textbox("getValue");
    		var content = "<tr><td align='center'><span>"+titleText+"</span></td>";
    		content += "<td align='center'><span>"+activityDate+"</span></td>";
    		content += "<td align='center'><span>"+awardText+"</span></td>";
    		content += "<td align='center'><span>"+remark+"</span>";
    		content += "<input type='hidden' name='activitys' title='"+title+"' activityDate='"+activityDate+"' award='"+award+"' remark='"+remark+"' activityName='"+title+"'/></td>";
    		content += "<td align='center'><a href='javascript:void(0)' class='linkmore' onclick='delActivity(this)'><span>删除</span></a></td></tr>";
    		$("#activityTd tr:eq("+activityTd+")").after(content);
    		activityTd += 1;
    		
    		//初始化第一列
			var data = $('#title').combobox('getData');
			$('#title').combobox('setValue',data[0].codeFlag);
			data = $('#award').combobox('getData');
			$('#award').combobox('setValue',data[0].codeFlag);
			$("#activityDate").datebox("setValue", "");
			$("#remark").textbox("setValue", "");
    	}
    });
});

function deleteRealSchool(obj, realId)
{
	updateFlag = true;
	$(obj).parent().parent().remove(); 
	td = td - 1;
	realIds += realId + ",";
}

function deleteContact(obj, contactId)
{
	updateFlag = true;
	$(obj).parent().parent().remove(); 
	contactTd = contactTd - 1;
	contactIds += contactId + ",";
	contactLength = contactLength - 1;
}

function deleteActivity(obj, activityId)
{
	updateFlag = true;
	$(obj).parent().parent().remove(); 
	activityTd = activityTd - 1;
	activityIds += activityId + ",";
}

function delRealSchool(obj)
{
	$(obj).parent().parent().remove(); 
	td = td - 1;
}

function delContact(obj)
{
	$(obj).parent().parent().remove(); 
	contactTd = contactTd - 1;
}

function delActivity(obj)
{
	$(obj).parent().parent().remove(); 
	activityTd = activityTd - 1;
}

function validateStudent()
{
	var flag = false;
	var obj = $("#studentFm").serializeArray();
	for(var i = 0, len = obj.length; i < len; i++) {
		var key = obj[i].name;
		var value = obj[i].value;
		if(flag) {
			break;
		} else {
			for(var j = 0, l = array.length; j < l; j++) {
				if(key == array[j].key) {
					if(value != array[j].value) {
						flag = true;
						break;
					}
				}
			}
		}
	}
	return flag;
}