$(document).ready(function() {
	$.extend($.fn.validatebox.defaults.rules, {
		// 学生姓名校验
		stuName : {
			validator : function(value, param) {
				if (value.length > 15) {
					$.fn.validatebox.defaults.rules.stuName.message = "输入的姓名长度不能超过15";
					return false;
				} else {
					if (!/^[A-Za-z\u4e00-\u9fa5]+$/.test(value)) {
						$.fn.validatebox.defaults.rules.stuName.message = "输入的姓名只能为中文和英文";
						return false;
					} else if (value.length > 12) {
						$.fn.validatebox.defaults.rules.stuName.message = "输入的姓名不能超过十二个字";
						return false;
					}
					return true;
				}
			}
		},
		// 英文名校验
		byname : {
			validator : function(value, param) {
				if (!/^[A-Za-z.]+$/.test(value)) {
					$.fn.validatebox.defaults.rules.byname.message = "英文名只能输入英文和.";
					return false;
				} else if (value.length > 24) {
					$.fn.validatebox.defaults.rules.byname.message = "英文名长度不能超过24";
					return false;
				}
				return true;
			}
		},
		// 证件类型为身份证时身份证信息校验
		certNo : {
			validator : function(value, param) {
				if ($("#" + param[0]).length > 0) {
					if (value.length > 20) {
						$.fn.validatebox.defaults.rules.certNo.message = "证件号码长度不能超过20";
						return false;
					} else {
						if ($("#" + param[0]).combobox("getText") == "身份证") {
							if (!validateIdCard(value)) {
								$.fn.validatebox.defaults.rules.certNo.message = "请输入有效的身份证号码";
								return false;
							}
						}
					}
				}
				return true;
			}
		},
		// 日期格式校验
		date : {
			validator : function(value, param) {
				if (!/^(\d{4})-(\d{2})-(\d{2})$/.test(value)) {
					$.fn.validatebox.defaults.rules.certNo.message = "请输入正确的日期格式";
					return false;
				}
				return true;
			}
		},
		phone : {
			validator : function(value, param) {
				if (!checkMobile(value)) {	
					$.fn.validatebox.defaults.rules.phone.message = "请输入正确的电话格式";
					return false;
				}
				return true;
			}
		},
		checkNull : {
			validator : function(value, param) {
				if ($("#courseType").combobox("getValue") == "001") {
					if (param[1].indexOf($("#" + param[0]).combobox("getValue")) != -1 && value == "") {
						if (param[1] == "001") {
							$.fn.validatebox.defaults.rules.checkNull.message = "请选择一位业绩顾问";
						} else {
							$.fn.validatebox.defaults.rules.checkNull.message = "请选择一位业绩老师";	
						}
						return false;
					}
				}
				return true;
			}
		},
		checkSame : {
			validator : function(value, param) {
				if ($("#courseType").combobox("getValue") == "001") {
					if (param[1].indexOf($("#" + param[0]).combobox("getValue")) != -1
						&& value != "" && value == $("#"+ param[2]).combobox("getValue")) {
						if (param[1] == "001") {
							$.fn.validatebox.defaults.rules.checkSame.message = "不能选相同的业绩顾问";
						} else {
							$.fn.validatebox.defaults.rules.checkSame.message = "不能选相同的业绩老师";
						}
						return false;
					}
				}
				return true;
			}
		},
		normalNull : {
			validator : function(value, param) {
				if ($("#courseType").combobox("getValue") == "001") {
					if (value == "") {
						$.fn.validatebox.defaults.rules.normalNull.message = "该选项不能为空";
						return false;
					}
				}
				return true;
			}
		}
	});
});
