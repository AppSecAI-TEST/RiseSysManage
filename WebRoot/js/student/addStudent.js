var td = 3;
var contactTd = 1;
var isExists = false;
$(document).ready(function() {
	var currDate = new Date();
	$('#entranceDate').datebox('setValue', myformatter(currDate));
	
	//招生顾问A的学校发生变化时执行的操作
    $('#advisterASchoolId').combobox({
    	url : "/sys/pubData/qrySchoolList.do?schoolId=",//返回json数据的url
    	valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
        onChange : function(n, o) {
        	$("#advisterIdA").combobox({
        		url : "/sys/pubData/qryStaffList.do?post=16,17&schoolId=" + n,//返回json数据的url
        		valueField : "staffId",
        		textField : "userName",
        		panelHeight : "auto",
        		formatter : function(data) {
            		return "<span>" + data.userName + "</span>";
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
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
        onChange : function(n, o) {
        	$("#advisterIdB").combobox({
        		url : "/sys/pubData/qryStaffList.do?post=16,17&schoolId=" + n,//返回json数据的url
        		valueField : "staffId",
        		textField : "userName",
        		panelHeight : "auto",
        		formatter : function(data) {
            		return "<span>" + data.userName + "</span>";
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
    
    //点击“添加就读信息”按钮
    $("#addRealSchool").click(function() {
    	var schoolType = $('#schoolType').combobox('getValue');
    	if(schoolType != "" && schoolType != null && schoolType != undefined) {
    		var realSchoolName = $('#realSchoolId').combobox('getText');
    		if(realSchoolName != "" && realSchoolName != null && realSchoolName != undefined)  {
    			var schoolTypeText = $('#schoolType').combobox('getText');
    			var content = "<tr><td align='right'><span>学校类型：</span></td><td><span>"+schoolTypeText+"</span></td>";
    			content += "<td align='right'><span>学校名称：</span></td><td><span>"+realSchoolName+"</span></td>";
    			content += "<input type='hidden' name='realSchools' schoolType='"+schoolType+"' realSchoolName='"+realSchoolName+"'/>";
    			content += "<td align='center'><a href='javascript:void(0)' class='linkmore' onclick='deleteRealSchool(this)'><span>删除</span></a></td></tr>";
    			$("#addStudentTd tr:eq("+td+")").after(content);
    		} else {
    			$.messager.alert('提示', "请选择一个就读学校名称！");
    		}
    	} else {
    		$.messager.alert('提示', "请选择一个就读学校类型！");
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
    
    //验证学员身份证信息
    $("input", $("#identityId").next("span")).blur(function() {
    	var identityType = $('#identityType').combobox('getValue');
    	if(identityType != "" && identityType != null && identityType != undefined) {
    		if("2BA" == identityType) {
    			var identityId = $("#identityId").textbox("getValue");
    			if(identityId != "" && identityId != null && identityId != undefined) {
    				if(!validateIdCard(identityId)) {
    					$.messager.alert('提示', "请输入有效的身份证号码！");
    				}
    			}
    		}
    	} else {
    		$.messager.alert('提示', "请选择学员的证件类型！");
    	}
	});
    
    //验证联系人身份证信息
    $("input", $("#contactIdentityId").next("span")).blur(function() {
    	var contactIdentityType = $('#contactIdentityType').combobox('getValue');
    	if(identityType != "" && identityType != null && identityType != undefined) {
    		if("2BA" == contactIdentityType) {
    			var identityId = $("#contactIdentityId").textbox("getValue");
    			if(!validateIdCard(identityId)) {
    				$.messager.alert('提示', "请输入有效的身份证号码！");
    			}
    		}
    	} else {
    		$.messager.alert('提示', "请选择联系人的证件类型！");
    	}
	});
    
    //验证联系人联系电话
//    $("input", $("#phone").next("span")).blur(function() {
//    	var phone = $("#phone").textbox("getValue");
//    	if(!checkMobile(phone)) {
//    		$.messager.alert('提示', "请输入完整的11位手机号或者正确的手机号前七位！");
//    	}
//    });
    
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
    						var contactIdentityType = $('#contactIdentityType').combobox('getValue');
    						var contactIdentityId = $("#contactIdentityId").textbox("getValue");
    						if(contactIdentityId != '' && contactIdentityType == '') {
    							$.messager.alert('提示', "请选择联系人证件类型");
    							return false;
    						}
    						var content = "<tr><td align='center'><span>"+relationTypeText+"</span></td>";
    						content += "<td align='center'><span>"+contactName+"</span></td>";
    						content += "<td align='center'><span>"+job+"</span></td>";
    						content += "<td align='center'>";
    						var contactUsed = "N";
    						//第一个默认主要联系人
    						if($("[name='contacts']").length == 0) {
    							used = true;
    						}
    						if(used) {
    							content += "<input type='checkbox' checked='checked' disabled='disabled'/>";
    							contactUsed = "Y";
    						} else {
    							content += "<input type='checkbox' disabled='disabled'/>";
    						}
    						content += "</td>";
    						if(contactIdentityId != "" && contactIdentityId != null && contactIdentityId != undefined) {
    							content += "<td align='center'><span>"+contactIdentityTypeText+"："+contactIdentityId+"</span></td>";
    						} else {
    							content += "<td align='center'><span></span></td>";
    						}
    						content += "<td align='center'><span>"+phone+"</span>";
    						content += "<input type='hidden' name='contacts' relationType='"+relationType+"' job='"+job+"' used='"+contactUsed+"' contactName='"+contactName+"' identityType='"+contactIdentityType+"' identityId='"+contactIdentityId+"' phone='"+phone+"'/></td>";
    						content += "<td align='center'><a href='javascript:void(0)' class='linkmore' onclick='deleteContact(this)'><span>删除</span></a></td></tr>";
    						$("#addContactTd tr:eq("+contactTd+")").after(content);
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
    					$.messager.alert('提示', "学员证件号码和家长证件号码信息必具其一！");
    				}
    			} else {
    				$.messager.alert('提示', "必须提供一个联系电话！");
    			}
    		} else {
    			$.messager.alert('提示', "联系人关系为“" + relationTypeText + "”的联系人已存在，请更换联系人关系！");
    		}
    	} else {
    		$("#contactFm").find(".textbox-text.validatebox-text.validatebox-invalid:first").trigger("mouseover");
    	}	
    });
    
    //学员验重
    $("#validate").click(function() {
    	var flag = false;
    	var identityId = $("#identityId").textbox("getValue");
    	var identityType = $('#identityType').combobox('getValue');
    	//输入证件号码
		if(identityId != null && identityId != "" && identityId != undefined) {
			if(identityType != "" && identityType != null && identityType != undefined) {
				flag = true;
			} else {
				$.messager.alert('提示', "请选择学员的证件类型！");
			}
		} else { //没有输入证件号码
			var name = $("#name").textbox("getValue");
			var birthday = $("#birthday").datebox("getValue");
			var sex = $("input[name='sex']:checked").val();
			if(name != null && name != "" && name != undefined
					&& birthday != null && birthday != "" && birthday != undefined
					&& sex != null && sex != "" && sex != undefined) {
				flag = true;
			} else {
				$.messager.alert('提示', "请输入学员的证件号码或者学员姓名、性别和出生日期！");
			}
		}
		if(flag) {
			if(identityType != "" && identityType != null && identityType != undefined 
					&& "2BA" == identityType && identityId != "" && identityId != null && identityId != undefined) {
				if(!validateIdCard(identityId)) {
    				flag = false;
    			}
			}
			if(flag) {
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
							$.messager.alert('提示', "该学员暂未注册，资料有效！");
						} else {
							isExists = true;
							$.messager.alert('提示', data.msg);
						}
						$.messager.progress('close'); 
					} 
				});
			} else {
				$.messager.alert('提示', "请输入有效的身份证号码！");
			}
		}
    });
    
    //学员注册
    $("#studentSubmit").click(function() {
    	if($("#studentFm").form('validate')) {
    		var sex = $("input:radio[name='sex']:checked").val();
    		if(sex != "" && sex != null && sex != undefined) {
    			if($("[name='contacts']").length > 0) {
    				var flag = true;
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
    					var usedFlag = false;
    					var contactsNo = true;
    					$("[name='contacts']").each(function() {
    						if($(this).attr("identityId") != '' && contactsNo) {
    							contactsNo = false;
    						}
    						if(!usedFlag && $(this).attr("used") == "Y") {
    							usedFlag = true;
    						}
    					});
    					if((identityId == null || identityId == "" || identityId == undefined) && contactsNo) {
    						$.messager.alert({title : '学员注册', msg : '学员证件号码和联系人证件号码不能同时为空，至少填写一项'});
    						return false;
    					} else {
    						var advisterIdA = $("#advisterIdA").combobox("getValue");
    						var advisterIdB = $("#advisterIdB").combobox("getValue");
    						if(advisterIdA != advisterIdB) {
    							if(usedFlag) {
    								var object = $("#studentFm").serializeObject();
    								var remark = object.remark;
    								remark = string2Json(remark);
    								object.remark = remark;
    								var obj = JSON.stringify(object);
    								var contactArray = "[";
    								$("[name='contacts']").each(function() {
    									contactArray += "{identityId:\""+$(this).attr("identityId")+"\",identityType:\""+$(this).attr("identityType")+"\",name:\""+$(this).attr("contactName")+"\",phone:\""+$(this).attr("phone")+"\",relationType:\""+$(this).attr("relationType")+"\",job:\""+$(this).attr("job")+"\",used:\""+$(this).attr("used")+"\"},";
    								});
    								contactArray = contactArray.substring(0, contactArray.length - 1) + "]";
    								var realSchoolArray = "[";
    								if($("[name='realSchools']").length > 0) {
    									$("[name='realSchools']").each(function() {
    										realSchoolArray += "{schoolType:\""+$(this).attr("schoolType")+"\",realSchoolName:\""+$(this).attr("realSchoolName")+"\"},";
    									});
    									realSchoolArray = realSchoolArray.substring(0, realSchoolArray.length - 1);
    								}
    								realSchoolArray += "]";
    								var param = "{studentInfo:"+obj+",contactArray:"+contactArray+",realSchoolArray:"+realSchoolArray+"}";
    								param = encodeURI(param);
    								$.ajax({
    									url: "/sys/student/addStudent.do",
    									data: "param=" + param,
    									dataType: "json",
    									async: true,
    									beforeSend: function() {
    										$.messager.progress({title : '学员注册', msg : '学员正在注册，请稍等……'});
    									},
    									success: function (data) {
    										$.messager.progress('close'); 
    										var flag = data.flag
    										if(flag) {
    											$.messager.confirm('提示', '学员注册成功，是否为该学员购买课程?', function(r) {
    												if(r) {
    													var sexText = "男";
    													var sex = $("input:radio[name='sex']:checked").val();
    													if("0" == sex) {
    														sexText = "女";
    													}
    													var studentId = data.studentId;
    													var schoolId = $("#schoolId").val();
    													var name = $("#name").textbox("getValue");
    													var byName = $("#byName").textbox("getValue");
    													var birthday = $("#birthday").datebox("getValue");
    													var identityId = $("#identityId").textbox("getValue");
    													var studentInfo = name + ";;" + byName + ";;" + birthday + ";;" + identityId + ";;" + sexText;
    													window.location.href = "/sys/course/addCourse.jsp?schoolId=" + schoolId + "&studentId=" + studentId + "&studentInfo=" + studentInfo;
    												} else {
    													window.history.back();
    												}
    											});
    										} else {
    											$.messager.alert('提示', data.msg);
    										}
    									} 
    								});
    							} else {
    								$.messager.alert('提示', "请至少设置一个常用联系人！");
    							}
    						} else {
    							$.messager.alert('提示', "招生顾问A和招生顾问B不能选择同一人！");
    						}
    					}
    				} else {
    					$.messager.alert('提示', "出生日期需要与本人身份证号码中的出生日期一致！");
    				}
    			} else {
    				$.messager.alert('提示', "请至少添加一个联系人信息！");
    			}
    		} else {
    			$.messager.alert('提示', "请先选择学员的性别！");
    		}
    	} else {
    		$("#studentFm").find(".textbox-text.validatebox-text.validatebox-invalid:first").trigger("mouseover");
    	}	
    });
});

//删除就读学校记录
function deleteRealSchool(obj) {
	$(obj).parent().parent().remove(); 
}

//删除联系人信息
function deleteContact(obj) {
	$(obj).parent().parent().remove(); 
}