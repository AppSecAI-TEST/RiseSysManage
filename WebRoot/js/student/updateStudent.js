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
	var funcNodeId = 1002;
	$.ajax({
		url: "/sys/student/qryStudentById.do",
		data: "studentId=" + studentId + "&funcNodeId=" + funcNodeId,
		dataType: "json",
		async: true,
		beforeSend: function() {
    		$.messager.progress({title : '修改学员资料', msg : '正在查询学员资料，请稍等……'});
    	},
    	success: function (data) {
    		$.messager.progress('close'); 
    		var schoolId = $("#schoolId").val();
    		//分校区
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
    		$("#entranceDateText").html(studentObj.entranceDate);
    		$("#entranceDate").datebox('setValue', studentObj.entranceDate);
    		$("#createDateText").html(studentObj.createDate);
    		
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
    		if(len1 > 0) {
    			var realSchoolArray = data.realSchoolObj.rows;
    			for(var i = 0; i < len1; i++) {
    				var content = "<tr><td align='right' width='114px'><span>学校类型：</span></td><td><span>"+realSchoolArray[i].schoolTypeText+"</span></td>";
    	    		content += "<td align='right' width='114px'><span>学校名称：</span></td><td><span>"+realSchoolArray[i].realSchoolName+"</span></td>";
    	    		content += "<td align='right' width='114px'><span>添加时间：</span></td><td><span>"+realSchoolArray[i].createDate+"</span></td>";
    	    		content += "<td align='center'><a href='javascript:void(0)' class='linkmore' onclick='deleteRealSchool(this, "+realSchoolArray[i].realId+")'><span>删除</span></a></td></tr>";
    	    		$("#studentTd tr:eq("+td+")").after(content);
    	    		td += 1;
    			}
    		}
    		
    		contactLength = data.contactObj.total;
    		if(contactLength > 0) {
    			var contactArray = data.contactObj.rows;
    			for(var i = 0; i < contactLength; i++) {
    				var job = contactArray[i].job;
    				var phone = contactArray[i].phone;
    				var contactName = contactArray[i].name;
    				var relationType = contactArray[i].relationType;
    				var identityId = contactArray[i].identityId;
    				var identityType = contactArray[i].identityType;
    				var content = "<tr><td align='center'><span>"+contactArray[i].relationTypeVal+"</span></td>";
    				content += "<td align='center'><span>"+contactName+"</span></td>";
    				content += "<td align='center'><span>"+job+"</span></td>";
    				content += "<td align='center'>";
    				var used = contactArray[i].used;
    				if("Y" == used) {
    					content += "<input type='checkbox' checked='checked'/>";
    				} else {
    					content += "<input type='checkbox'/>";
    				}
    				content += "</td>";
    				content += "<td align='center'><span>"+contactArray[i].identity+"</span></td>";
    				content += "<td align='center'><span>"+phone+"</span>";
    				content += "<input type='hidden' name='contacts' relationType='"+relationType+"' job='"+job+"' used='"+used+"' contactName='"+contactName+"' identityType='"+identityType+"' identityId='"+identityId+"' phone='"+phone+"'/></td>";
    				content += "<td align='center'><a href='javascript:void(0)' class='linkmore' onclick='deleteContact(this, "+contactArray[i].contactId+")'><span>删除</span></a></td></tr>";
    				$("#contactTd tr:eq("+contactTd+")").after(content);
    				contactTd += 1;
    			}
    		}
    		
    		var len3 = data.activityObj.total;
    		if(len3 > 0) {
    			var activityArray = data.activityObj.rows;
    			for(var i = 0; i < len3; i++) {
    				var content = "<tr><td align='center' width='150px'><span>"+activityArray[i].title+"</span></td>";
    				content += "<td align='center' width='100px'><span>"+activityArray[i].activityDate+"</span></td>";
    				content += "<td align='center' width='150px'><span>"+activityArray[i].award+"</span></td>";
    				content += "<td align='center' width='300px'><span>"+activityArray[i].remark+"</span></td>";
    				content += "<td align='center' width='363px'><span>"+activityArray[i].gift+"</span></td>";
    				content += "<td align='center' width='80px'><a href='javascript:void(0)' class='linkmore' onclick='deleteActivity(this, "+activityArray[i].activityId+")'><span>删除</span></a></td></tr>";
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
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
    	onLoadSuccess : function () { //数据加载完毕事件
    		var updateAdvisterASchoolId = $("#updateAdvisterASchoolId").val();
    		if(updateAdvisterASchoolId != null && updateAdvisterASchoolId != null && updateAdvisterASchoolId != undefined) {
    			var data = $('#advisterASchoolId').combobox('getData');
    			if (data.length > 0) {
    				$("#advisterASchoolId").combobox('select', updateAdvisterASchoolId);
    			}
    		}
        },
        onChange : function(n, o) {
        	$("#advisterIdA").combobox({
        		url : "/sys/pubData/qryStaffList.do?schoolId=" + n,//返回json数据的url
        		valueField : "staffId",
        		textField : "userName",
        		panelHeight : "auto",
        		formatter : function(data) {
            		return "<span>" + data.userName + "</span>";
            	},
        		onLoadSuccess : function () { //数据加载完毕事件
        			var updateAdvisterIdA = $("#updateAdvisterIdA").val();
        			if(updateAdvisterIdA != null && updateAdvisterIdA != null && updateAdvisterIdA != undefined) {
        				var data = $('#advisterIdA').combobox('getData');
        				if (data.length > 0) {
        					$("#advisterIdA").combobox('select', updateAdvisterIdA);
        				}
        			}
                }
        	});
        }  
    });
    
    //加载学员证件类型
    $("#identityType").combobox({
    	url : "/sys/pubData/qryCodeNameList.do?tableName=STUDENT_T&codeType=IDENTITY_TYPE",//返回json数据的url
    	valueField : "codeFlag",
    	textField : "codeName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.codeName + "</span>";
    	},
    	onLoadSuccess : function () { //数据加载完毕事件
    		var updateIdentityType = $("#updateIdentityType").val();
    		if(updateIdentityType != null && updateIdentityType != "" && updateIdentityType != undefined) {
    			var data = $('#identityType').combobox('getData');
    			if (data.length > 0) {
    				$("#identityType").combobox('select', updateIdentityType);
    			}
    		}
        },
    	onChange : function(n, o) {
    		if("2BA" == n && o != "") {
    			var identityId = $("#identityId").textbox("getValue");
    			if(identityId != "" && identityId != null && identityId != undefined) {
    				if(!validateIdCard(identityId)) {
        				$.messager.alert('提示', "请输入有效的身份证号码！");
        			}
    			}
    		}
    	}
    });
    
    //加载联系人证件类型
    $("#contactIdentityType").combobox({
    	url : "/sys/pubData/qryCodeNameList.do?tableName=STUDENT_T&codeType=IDENTITY_TYPE",//返回json数据的url
    	valueField : "codeFlag",
    	textField : "codeName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.codeName + "</span>";
    	},
    	onChange : function(n, o) {
    		if("2BA" == n) {
    			var contactIdentityId = $("#contactIdentityId").textbox("getValue");
    			if(contactIdentityId != "" && contactIdentityId != null && contactIdentityId != undefined) {
    				if(!validateIdCard(contactIdentityId)) {
        				$.messager.alert('提示', "请输入有效的身份证号码！");
        			}
    			}
    		}
    	}
    });
    
    var schoolId = $("#schoolId").val();
    //加载责任顾问
    $("#dutyAdvister").combobox({
    	url : "/sys/pubData/qryStaffList.do?schoolId="+schoolId,//返回json数据的url
    	valueField : "staffId",
    	textField : "userName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.userName + "</span>";
    	},
    	onLoadSuccess : function () { //数据加载完毕事件
    		var updateDutyAdvister = $("#updateDutyAdvister").val();
    		if(updateDutyAdvister != null && updateDutyAdvister != "" && updateDutyAdvister != undefined) {
    			var data = $('#dutyAdvister').combobox('getData');
    			if (data.length > 0) {
    				$("#dutyAdvister").combobox('select', updateDutyAdvister);
    			}
    		}
        }
    });
    
    //加载客户关怀
    $("#carer").combobox({
    	url : "/sys/pubData/qryStaffList.do?schoolId="+schoolId,//返回json数据的url
    	valueField : "staffId",
    	textField : "userName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.userName + "</span>";
    	},
    	onLoadSuccess : function () { //数据加载完毕事件
    		var updateCarer = $("#updateCarer").val();
    		if(updateCarer != null && updateCarer != "" && updateCarer != undefined) {
    			var data = $('#carer').combobox('getData');
    			if (data.length > 0) {
    				$("#carer").combobox('select', updateCarer);
    			}
    		}
        }
    });
    
    //招生顾问B的学校发生变化时执行的操作
    $('#advisterBSchoolId').combobox({
    	url : "/sys/pubData/qrySchoolList.do?schoolId=",//返回json数据的url
    	valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
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
        		formatter : function(data) {
            		return "<span>" + data.userName + "</span>";
            	},
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
    	formatter : function(data) {
    		return "<span>" + data.codeName + "</span>";
    	},
    	onChange : function(n, o) {
    		$("#realSchoolId").combobox({
    			url : "/sys/pubData/qryParaConfigList.do?paramType=REAL_SCHOOL_ID&paramValue=" + n,//返回json数据的url
        		valueField : "param1",
        		textField : "param2",
        		panelHeight : "auto",
        		formatter : function(data) {
            		return "<span>" + data.param2 + "</span>";
            	}
    		});
    	}
    });
    
    //验证学员身份证信息
    $("input", $("#identityId").next("span")).blur(function() {
    	var identityType = $('#identityType').combobox('getValue');
    	if("2BA" == identityType) {
    		var identityId = $("#identityId").textbox("getValue");
    		if(identityId != "" && identityId != null && identityId != undefined) {
    			if(!validateIdCard(identityId)) {
    				$.messager.alert('提示', "请输入有效的身份证号码！");
    			}
			}
    	}
	});
    
    //验证联系人身份证信息
    $("input", $("#contactIdentityId").next("span")).blur(function() {
    	var contactIdentityType = $('#contactIdentityType').combobox('getValue');
    	if("2BA" == contactIdentityType) {
    		var identityId = $("#contactIdentityId").textbox("getValue");
    		if(!validateIdCard(identityId)) {
    			$.messager.alert('提示', "请输入有效的身份证号码！");
    		}
    	}
	});
    
    //验证联系人联系电话
    $("input", $("#phone").next("span")).blur(function() {
    	var phone = $("#phone").textbox("getValue");
    	if(!checkMobile(phone)) {
    		$.messager.alert('提示', "请输入完整的11位手机号或者正确的手机号前七位！");
    	}
    });
	
	//学员验重
	$("#validate").click(function() {
    	var identityId = $("#identityId").textbox("getValue");
    	if(studentObj.identityId != identityId) {
    		var flags = true;
    		var identityType = $('#identityType').combobox('getValue');
    		if("2BA" == identityType) {
        		var identityId = $("#identityId").textbox("getValue");
        		if(identityId != "" && identityId != null && identityId != undefined) {
        			if(!validateIdCard(identityId)) {
        				flags = false;
        			}
    			}
        	}
    		if(flags) {
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
    				async: true,
    				beforeSend: function() {
    					$.messager.progress({title : '验重', msg : '正在验重，请稍等……'});
    				},
    				success: function (data) {
    					var flag = data.flag
    					if(flag) {
    						$.messager.alert('提示', "该证件号码还暂未注册，资料有效！");
    						identityValidateFlag = true;
    					} else {
    						$.messager.alert('提示', "该证件号码已注册，请输入其他未注册的证件号码！");
    					}
    					$.messager.progress('close'); 
    					validateFlag = true;
    				} 
    			});
    		} else {
    			$.messager.alert('提示', "请输入有效的身份证号码！");
    		}
    	} else {
    		$.messager.alert('提示', "请先修改该学员的证件号码再进行验重！");
    	}
	});
	
	//学员修改提交
	$("#updateSubmit").click(function() {
		contactLength += $("[name='contacts']").length;
		if(contactLength > 0) {
			var usedFlag = false;
			if($("[name='contacts']").length > 0) {
				$("[name='contacts']").each(function() {
					if("add" == $(this).attr("add")) {
						updateFlag = true;
					}
					var used = $(this).attr("used");
					if("Y" == used) {
						usedFlag = true;
					}
				});
			}
			if(usedFlag) {
				if($("[name='realSchools']").length > 0) {
					updateFlag = true;
				}
				if(!updateFlag) {
					updateFlag = validateStudent();
				}
				if(updateFlag) {
					if($("#studentFm").form('validate')) {
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
							var identityId = $("#identityId").textbox("getValue");
							var identityType = $('#identityType').combobox('getValue');
							if(identityId != null && identityId != "" && identityId != undefined && identityType == "2BA"
								&& identityType != null && identityType != "" && identityType != undefined) {
								var birthday = $("#birthday").datebox("getValue");
								birthday = birthday.replace(/-/g, "");
								if(birthday != identityId.substring(6, 14)) {
									flag = false;
								}
							}
							if(flag) {
								var contactArray = "[";
								if($("[name='contacts']").length > 0) {
									$("[name='contacts']").each(function() {
										if("add" == $(this).attr("add")) {
											contactArray += "{identityId:\""+$(this).attr("identityId")+"\",identityType:\""+$(this).attr("identityType")+"\",name:\""+$(this).attr("contactName")+"\",phone:\""+$(this).attr("phone")+"\",relationType:\""+$(this).attr("relationType")+"\",job:\""+$(this).attr("job")+"\",used:\""+$(this).attr("used")+"\"},";
										}
									});
									if(contactArray.length > 1) {
										contactArray = contactArray.substring(0, contactArray.length - 1);
									}
								}
								contactArray += "]";
								var realSchoolArray = "[";
								if($("[name='realSchools']").length > 0) {
									$("[name='realSchools']").each(function() {
										realSchoolArray += "{schoolType:\""+$(this).attr("schoolType")+"\",realSchoolName:\""+$(this).attr("realSchoolName")+"\"},";
									});
									realSchoolArray = realSchoolArray.substring(0, realSchoolArray.length - 1);
								}
								realSchoolArray += "]";
								if(contactIds != "" && contactIds != null && contactIds != undefined && contactIds != "null") {
									contactIds = contactIds.substring(0, contactIds.length - 1);
								}
								if(activityIds != "" && activityIds != null && activityIds != undefined && activityIds != "null") {
									activityIds = activityIds.substring(0, activityIds.length - 1);
								}
								if(realIds != "" && realIds != null && realIds != undefined && realIds != "null") {
									realIds = realIds.substring(0, realIds.length - 1);
								}
								
								var obj = getParam();
								obj = obj.substring(0, obj.length - 1);
								obj += ",\"contactId\":\""+contactIds+"\",\"activityId\":\""+activityIds+"\",\"realId\":\""+realIds+"\",\"contactArray\":"+contactArray+",\"realSchoolArray\":"+realSchoolArray+",\"activityArray\":[]}";
								obj = encodeURI(obj);
								$.ajax({
									url: "/sys/student/updateStudent.do",
									data: "param=" + obj,
									dataType: "json",
									async: true,
									beforeSend: function()
									{
										$.messager.progress({title : '修改档案', msg : '正在修改学员档案，请稍等……'});
									},
									success: function (data) {
										$.messager.progress('close'); 
										var flag = data.flag
										if(flag) {
											$.messager.alert('提示', "修改学员档案成功！", "info", function() {window.history.back();});
										} else {
											$.messager.alert('提示', "修改学员档案失败！");
										}
									} 
								});
							} else {
								$.messager.alert('提示', "出生日期需要与本人身份证号码中的出生日期一致！");
							}
						}
					}
				} else {
					$.messager.alert('提示', "请先对该学员做一些修改之后，再进行提交！");
				}
			} else {
				$.messager.alert('提示', "请至少设置一位联系人为常用联系人！");
			}
		} else {
			$.messager.alert('提示', "请至少添加一个联系人信息！");
		}
	});
	
	//点击“添加就读信息”按钮
    $("#addRealSchool").click(function() {
    	var schoolType = $('#schoolType').combobox('getValue');
    	if(schoolType != "" && schoolType != null && schoolType != undefined) {
    		var realSchoolName = $('#realSchoolId').combobox('getText');
    		if(realSchoolName != "" && realSchoolName != null && realSchoolName != undefined) {
    			var schoolTypeText = $('#schoolType').combobox('getText');
    			var content = "<tr><td align='right'><span>学校类型：</span></td><td><span>"+schoolTypeText+"</span></td>";
    			content += "<td align='right'><span>学校名称：</span></td><td colspan='3'><span>"+realSchoolName+"</span></td>";
    			content += "<input type='hidden' name='realSchools' schoolType='"+schoolType+"' realSchoolName='"+realSchoolName+"'/>";
    			content += "<td align='center'><a href='javascript:void(0)' class='linkmore' onclick='delRealSchool(this)'><span>删除</span></a></td></tr>";
    			$("#studentTd tr:eq("+td+")").after(content);
    			td += 1;
    		} else {
    			$.messager.alert('提示', "请选择一个就读学校名称！");
    		}
    	} else {
    		$.messager.alert('提示', "请选择一个就读学校类型！");
    	}
    });
	
    //点击联系人信息中的“添加”按钮
    $("#addContact").click(function() {
    	if($("#contactFm").form('validate')) {
    		var flag = true;
    		var relationType = $('#relationType').combobox('getValue');
    		var relationTypeText = $('#relationType').combobox('getText');
    		if($("[name='contacts']").length > 0) {
    			$("[name='contacts']").each(function() {
    				if(relationType == $(this).attr("relationType")) {
    					flag = false;
    				}
    			});
    		}
    		if(flag) {
    			var identityId = $("#identityId").textbox("getValue");
    			var contactIdentityId = $("#contactIdentityId").textbox("getValue");
    			if((identityId == null || identityId == "" || identityId == undefined)
    					&& (contactIdentityId == null || contactIdentityId == "" || contactIdentityId == undefined)) {
    				if($("[name='contacts']").length > 0) {
    	    			$("[name='contacts']").each(function() {
    	    				if($(this).attr("identityId") == null || $(this).attr("identityId") == "" || $(this).attr("identityId") == undefined) {
    	    					flag = false;
    	    				}
    	    			});
    	    		}
    			}
    			if(flag) {
    				var flags = true;
    				var contactIdentityType = $('#contactIdentityType').combobox('getValue');
    				if(contactIdentityId != "" && contactIdentityId != null && contactIdentityId != undefined) {
    					if(contactIdentityType == "" || contactIdentityType == null || contactIdentityType == undefined) {
    						flag = false;
    					}
    				} else {
    					if(contactIdentityType != "" && contactIdentityType != null && contactIdentityType != undefined) {
    						flags = false;
    					}
    				}
    				if(flag) {
    					if(flags) {
    						var phone = $("#phone").textbox("getValue");
    						if(phone == null || phone == "" || phone == undefined) {
    							if($("[name='contacts']").length > 0) {
    								$("[name='contacts']").each(function() {
    									if($(this).attr("phone") == null || $(this).attr("phone") == "" || $(this).attr("phone") == undefined) {
    										flag = false;
    									}
    								});
    							} else {
    								flag = false;
    							}
    						}
    						if(flag) {
    							var used = $("input:checkbox[name='used']:checked").val();
    							if(used && (phone == null || phone == "" || phone == undefined)) {
    								flag = false;
    							}
    							if(flag) {
    								var contactName = $("#contactName").textbox("getValue");
    								var job = $("#job").textbox("getValue");
    								var contactIdentityTypeText = $('#contactIdentityType').combobox('getText');
    								var content = "<tr><td align='center'><span>"+relationTypeText+"</span></td>";
    								content += "<td align='center'><span>"+contactName+"</span></td>";
    								content += "<td align='center'><span>"+job+"</span></td>";
    								content += "<td align='center'>";
    								var contactUsed = "N";
    								if(used) {
    									content += "<input type='checkbox' checked='checked'/>";
    									contactUsed = "Y";
    								} else {
    									content += "<input type='checkbox'/>";
    								}
    								content += "</td>";
    								if(contactIdentityId != "" && contactIdentityId != null && contactIdentityId != undefined) {
    									content += "<td align='center'><span>"+contactIdentityTypeText+"："+contactIdentityId+"</span></td>";
    								} else {
    									content += "<td align='center'><span></span></td>";
    								}
    								content += "<td align='center'><span>"+phone+"</span>";
    								content += "<input type='hidden' name='contacts' relationType='"+relationType+"' job='"+job+"' used='"+contactUsed+"' contactName='"+contactName+"' identityType='"+contactIdentityType+"' identityId='"+contactIdentityId+"' phone='"+phone+"' add='add'/></td>";
    								content += "<td align='center'><a href='javascript:void(0)' class='linkmore' onclick='deleteContact(this)'><span>删除</span></a></td></tr>";
    								$("#contactTd tr:eq("+contactTd+")").after(content);
    								contactTd++;
    								//初始化第一列
    								$('#relationType').combobox('setValue', "");
    								$('#contactIdentityType').combobox('setValue', "");
    								$("#contactName").textbox("setValue", "");
    								$("#job").textbox("setValue", "");
    								$("#contactIdentityId").textbox("setValue", "");
    								$("#phone").textbox("setValue", "");
    								$("[name='used']").removeAttr("checked");
    							} else {
    								$.messager.alert('提示', "常用联系人必须提供联系电话！");
    							}
    						} else {
    							$.messager.alert('提示', "必须提供一个联系电话！");
    						}
    					} else {
    						$.messager.alert('提示', "请填写联系人的证件号码！");
    					}
    				} else {
    					$.messager.alert('提示', "请选择联系人的证件类型！");
    				}
    			} else {
    				$.messager.alert('提示', "学员证件号码和家长证件号码信息必具其一！");
    			}
    		} else {
    			$.messager.alert('提示', "联系人关系为“" + relationTypeText + "”的联系人已存在，请更换联系人关系！");
    		}
    	}
    });
    
    $("#addActivity").click(function() {
    	if($("#activityFm").form('validate')) {
    		var title = $('#title').textbox('getValue');
    		var activityDate = $("#activityDate").datebox("getValue");
    		var award = $('#award').textbox('getValue');
    		var remark = $("#activityRemark").textbox("getValue");
    		var content = "<tr><td align='center'><span>"+title+"</span></td>";
    		content += "<td align='center'><span>"+activityDate+"</span></td>";
    		content += "<td align='center'><span>"+award+"</span></td>";
    		content += "<td align='center'><span>"+remark+"</span>";
    		content += "<input type='hidden' name='activitys' title='"+title+"' activityDate='"+activityDate+"' award='"+award+"' remark='"+remark+"' activityName='"+title+"'/></td>";
    		content += "<td align='center'><a href='javascript:void(0)' class='linkmore' onclick='delActivity(this)'><span>删除</span></a></td></tr>";
    		$("#activityTd tr:eq("+activityTd+")").after(content);
    		activityTd++;
    		
    		//初始化第一列
			$('#title').combobox('setValue', "");
			$('#award').combobox('setValue', "");
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

function getParam() {
	var nameDisabled = $("#name").attr("disabled");
	if("disabled" == nameDisabled) {
		$("#name").textbox({disabled : false});
	}
	var birthdayDisabled = $("#birthday").attr("disabled");
	if("disabled" == birthdayDisabled) {
		$("#birthday").textbox({disabled : false});
	}
	var sexDisabled = $(".sex").attr("disabled");
	if("disabled" == sexDisabled) {
		$(".sex").removeAttr("disabled");
	}
	var identityTypeDisabled = $("#identityType").attr("disabled");
	if("disabled" == identityTypeDisabled) {
		$("#identityType").combobox({disabled : false});
	}
	var identityIdDisabled = $("#identityId").attr("disabled");
	if("disabled" == identityIdDisabled) {
		$("#identityId").textbox({disabled : false});
	}
	var byNameDisabled = $("#byName").attr("disabled");
	if("disabled" == byNameDisabled) {
		$("#byName").textbox({disabled : false});
	}
	var addressDisabled = $("#address").attr("disabled");
	if("disabled" == addressDisabled) {
		$("#address").textbox({disabled : false});
	}
	var entranceDateDisabled = $("#entranceDate").attr("disabled");
	if("disabled" == entranceDateDisabled) {
		$("#entranceDate").textbox({disabled : false});
	}
	var advisterIdADisabled = $("#advisterIdA").attr("disabled");
	if("disabled" == advisterIdADisabled) {
		$("#advisterIdA").combobox({disabled : false});
	}
	var advisterIdBDisabled = $("#advisterIdB").attr("disabled");
	if("disabled" == advisterIdBDisabled) {
		$("#advisterIdB").combobox({disabled : false});
	}
	var dutyAdvisterDisabled = $("#dutyAdvister").attr("disabled");
	if("disabled" == dutyAdvisterDisabled) {
		$("#dutyAdvister").combobox({disabled : false});
	}
	var carerDisabled = $("#carer").attr("disabled"); 
	if("disabled" == carerDisabled) {
		$("#carer").combobox({disabled : false});
	}
	var obj = JSON.stringify($("#studentFm").serializeObject());
	nameDisabled = $("#name").attr("disabled");
	if(nameDisabled == "" || nameDisabled == null || nameDisabled == undefined) {
		$("#name").textbox({disabled : true});
	}
	birthdayDisabled = $("#birthday").attr("disabled");
	if(birthdayDisabled == "" || birthdayDisabled == null || birthdayDisabled == undefined) {
		$("#birthday").textbox({disabled : true});
	}
	sexDisabled = $(".sex").attr("disabled");
	if(sexDisabled == "" || sexDisabled == null || sexDisabled == undefined) {
		$(".sex").attr("disabled", "disabled");
	}
	identityTypeDisabled = $("#identityType").attr("disabled");
	if(identityTypeDisabled == "" || identityTypeDisabled == null || identityTypeDisabled == undefined) {
		$("#identityType").combobox({disabled : true});
	}
	identityIdDisabled = $("#identityId").attr("disabled");
	if(identityIdDisabled == "" || identityIdDisabled == null || identityIdDisabled == undefined) {
		$("#identityId").textbox({disabled : true});
	}
	byNameDisabled = $("#byName").attr("disabled");
	if(byNameDisabled == "" || byNameDisabled == null || byNameDisabled == undefined) {
		$("#byName").textbox({disabled : true});
	}
	addressDisabled = $("#address").attr("disabled");
	if(addressDisabled == "" || addressDisabled == null || addressDisabled == undefined) {
		$("#address").textbox({disabled : true});
	}
	entranceDateDisabled = $("#entranceDate").attr("disabled");
	if(entranceDateDisabled == "" || entranceDateDisabled == null || entranceDateDisabled == undefined) {
		$("#entranceDate").textbox({disabled : true});
	}
	advisterIdADisabled = $("#advisterIdA").attr("disabled");
	if(advisterIdADisabled == "" || advisterIdADisabled == null || advisterIdADisabled == undefined) {
		$("#advisterIdA").combobox({disabled : true});
	}
	advisterIdBDisabled = $("#advisterIdB").attr("disabled");
	if(advisterIdBDisabled == "" || advisterIdBDisabled == null || advisterIdBDisabled == undefined) {
		$("#advisterIdB").combobox({disabled : true});
	}
	dutyAdvisterDisabled = $("#dutyAdvister").attr("disabled");
	if(dutyAdvisterDisabled == "" || dutyAdvisterDisabled == null || dutyAdvisterDisabled == undefined) {
		$("#dutyAdvister").combobox({disabled : true});
	}
	var carerDisabled = $("#carer").attr("disabled"); 
	if(carerDisabled == "" || carerDisabled == null || carerDisabled == undefined) {
		$("#carer").combobox({disabled : true});
	}
	return obj;
}