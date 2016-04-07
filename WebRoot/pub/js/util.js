 
var to = null;
var countProgress = null;
var schoolData = [1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013];
$(document).ready(function() {
	var tabs = $(".tabs").height();
	var height = $(document).height();
	var search = $(".search_tab").height();
	var header = $(".panel-header").height();
	$('#list_data').datagrid('resize', {// 适配高度
		height: height - search - header - tabs
	});
	$("#list_data").datagrid({
		pageList : [20, 30, 40],          // 可以设置每页记录条数的列表
		pageSize : 20                       // 每页显示的记录条数
	});
	$('#apply_list_data').datagrid('resize', {// 适配高度
		height: height - search - header - tabs
	});
	$("#apply_list_data").datagrid({
		pageList : [20, 30, 40],          // 可以设置每页记录条数的列表
		pageSize : 20                       // 每页显示的记录条数
	});
	$("#approve_list_data").datagrid({
		pageList : [20, 30, 40],          // 可以设置每页记录条数的列表
		pageSize : 20                       // 每页显示的记录条数
	});
	$('#goodsGift_data').datagrid('resize', {//适配高度
		height: height - search - header - tabs
	});
	$("#goodsGift_data").datagrid({
		pageList : [20, 30, 40],           
		pageSize : 20                    
	});
	$('#couponGift_data').datagrid('resize', {//适配高度
		height: height - search - header - tabs
	});
	$("#couponGift_data").datagrid({
	　	pageList : [20, 30, 40],           
		pageSize : 20                    
	});
	$('#courseGift_data').datagrid('resize', {//适配高度
		height: height - search - header - tabs
	});
	$("#courseGift_data").datagrid({
	　	pageList : [20, 30, 40],           
		pageSize : 20                    
	});
	$('#manList').datagrid('resize', {//适配高度
		height:height-search-header-tabs
	});
	$("#manList").datagrid({
	　	pageList : [20, 30, 40],           
		pageSize : 20                    
	});
	  $('#hisList').datagrid('resize',{//适配高度
		      height:height-search-header-tabs
	  		 });
			 
			 $("#hisList").datagrid({
		　		　pageList : [20, 30, 40],           
				  pageSize : 20                    
　			　});
			 
});
 
	
//禁用非输入框回退键
window.onload=function(){   
    document.getElementsByTagName("body")[0].onkeydown =function(){  
        if(event.keyCode==8){  
            var elem = event.srcElement;  
            var name = elem.nodeName;  
              
            if(name!='INPUT' && name!='TEXTAREA'){  
                event.returnValue = false ;  
                return ;  
            }  
            var type_e = elem.type.toUpperCase();  
            if(name=='INPUT' && (type_e!='TEXT' && type_e!='TEXTAREA' && type_e!='PASSWORD' && type_e!='FILE')){  
                event.returnValue = false ;  
                return ;  
            }  
            if(name=='INPUT' && (elem.readOnly==true || elem.disabled ==true)){  
                event.returnValue = false ;  
                return ;  
            }  
        }  
    }  
}  
$.extend($.fn.linkbutton.methods,{
	enable : function(jq) {
		return jq.each(function() {
			var state = $.data(this, 'linkbutton');
			if ($(this).hasClass('l-btn-disabled')) {
				var itemData = state._eventsStore;
				//恢复超链接 
				if (itemData.href) {
					$(this).attr("href", itemData.href);
				}
				//回复点击事件 
				if (itemData.onclicks) {
					for ( var j = 0; j < itemData.onclicks.length; j++) {
						$(this).bind('click',
								itemData.onclicks[j]);
					}
				}
				//设置target为null，清空存储的事件处理程序 
				itemData.target = null;
				itemData.onclicks = [];
				$(this).removeClass('l-btn-disabled');
			}
		});
	},
	disable : function(jq) {
		return jq.each(function() {
			var state = $.data(this, 'linkbutton');
			if (!state._eventsStore)
				state._eventsStore = {};
			if (!$(this).hasClass('l-btn-disabled')) {
				var eventsStore = {};
				eventsStore.target = this;
				eventsStore.onclicks = [];
				//处理超链接 
				var strHref = $(this).attr("href");
				if (strHref) {
					eventsStore.href = strHref;
					$(this).attr("href", "javascript:void(0)");
				}
				//处理直接耦合绑定到onclick属性上的事件 
				var onclickStr = $(this).attr("onclick");
				if (onclickStr && onclickStr != "") {
					eventsStore.onclicks[eventsStore.onclicks.length] = new Function(
							onclickStr);
					$(this).attr("onclick", "");
				}
				//处理使用jquery绑定的事件 
				var eventDatas = $(this).data("events")
						|| $._data(this, 'events');
				if (eventDatas["click"]) {
					var eventData = eventDatas["click"];
					for ( var i = 0; i < eventData.length; i++) {
						if (eventData[i].namespace != "menu") {
							eventsStore.onclicks[eventsStore.onclicks.length] = eventData[i]["handler"];
							$(this).unbind('click',
									eventData[i]["handler"]);
							i--;
						}
					}
				}
				state._eventsStore = eventsStore;
				$(this).addClass('l-btn-disabled');
			}
		});
	}
});

$.extend($.fn.datagrid.methods, {    
	addEditor : function(jq, param) {        
		if (param instanceof Array) {            
			$.each(param, function(index, item) {                
				var e = $(jq).datagrid('getColumnOption', item.field);                
				e.editor = item.editor;            
			});        
		} else {
			var e = $(jq).datagrid('getColumnOption', param.field);            
			e.editor = param.editor;        
		}    
	},    
	removeEditor : function(jq, param) {        
		if (param instanceof Array) {            
			$.each(param, function(index, item) {                
				var e = $(jq).datagrid('getColumnOption', item);                
				e.editor = {};            
			});
		} else {
			var e = $(jq).datagrid('getColumnOption', param);            
			e.editor = {};        
		}    
	}
});

var gPropertyObject = {
	staffId : "",
	funcNodeId : "",
	fieldId : "",
	filterFunc : function() {
		$.ajax( {
			url : "/sys/pub/pageCategory.do",
			type : "POST",
			data : "staffId=" + this.staffId + "&funcNodeId=" + this.funcNodeId
					+ "&fieldId=" + this.fieldId,
			dataType : "json",
			success : function(data) {
				var beforeFieldId = null;
				var beforeValArr = [];
				for ( var i = 0, n = data.length; i < n; i++) {
					var contFlag = false;
					if(beforeFieldId == data[i].fieldId)
					{
						if(data[i].val != "NORMAL")
						{
							for(var j = 0,m = beforeValArr.length;j < m;j++)
							{
								if(beforeValArr[j] == "NORMAL")
								{
									contFlag = true;
								}
							}
						}
					}
					else
					{
						beforeValArr = [];
					}
					beforeValArr.push(data[i].val);
					beforeFieldId = data[i].fieldId;
					if(contFlag)
					{
						continue;
					}
					if (data[i].widgetType == "textbox") {
						if (data[i].val == "READONLY") {
							$("#" + data[i].fieldId).textbox("readonly", true);
						} else if (data[i].val == "DISABLED") {
							$("#" + data[i].fieldId).textbox( {
								"disabled" : true
							});
						} else if (data[i].val == "HIDDEN") {
							var obj = $("#" + data[i].fieldId);
							obj.hide();
							obj.next().css("display", "none");
						} else if(data[i].val == "NORMAL") {
							$("#" + data[i].fieldId).textbox("readonly", false);
						}
					} else if (data[i].widgetType == "linkbutton") {
						if (data[i].val == "READONLY") {
							$("#" + data[i].fieldId).linkbutton('disable');
						} else if (data[i].val == "DISABLED") {
							$("#" + data[i].fieldId).linkbutton('disable');
						} else if (data[i].val == "HIDDEN") {
							$("#" + data[i].fieldId).hide();
						} else if(data[i].val == "NORMAL") {
							$("#" + data[i].fieldId).linkbutton('enable');
						}
					} else if (data[i].widgetType == "datebox") {
						if (data[i].val == "READONLY") {
							$("#" + data[i].fieldId).datebox( {
								"editable" : false
							});
						} else if (data[i].val == "DISABLED") {
							$("#" + data[i].fieldId).datebox( {
								"disabled" : true
							});
						} else if (data[i].val == "HIDDEN") {
							var obj = $("#" + data[i].fieldId);
							obj.hide();
							obj.next().css("display", "none");
						} else if(data[i].val == "NORMAL") {
							$("#" + data[i].fieldId).datebox( {
								"editable" : true
							});
						}
					} else if (data[i].widgetType == "datetimebox") {
						if (data[i].val == "READONLY") {
							$("#" + data[i].fieldId).attr("readonly",
									"readonly");
						} else if (data[i].val == "DISABLED") {
							$("#" + data[i].fieldId + " .easyui-datetimebox")
									.datetimebox( {
										disabled : true
									});
						} else if (data[i].val == "HIDDEN") {
							$("#" + data[i].fieldId).hide();
						} else if(data[i].val == "NORMAL") {
							$("#" + data[i].fieldId).attr("readonly",
									false);
						}
					}
				}
			},
			failure : function(data) {

			}
		});
	}
};

var gPrivCtrl = function(staffId , funcNodeId , fieldId){
	gPropertyObject.staffId = staffId;
	gPropertyObject.funcNodeId = funcNodeId;
	gPropertyObject.fieldId = fieldId;
	return gPropertyObject.filterFunc();
}

function myformatter(date) {
	var y = date.getFullYear();
	var m = date.getMonth() + 1;
	var d = date.getDate();
	return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
}

function myYearMonthformatter(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	return y+'-'+(m<10?('0'+m):m);
}

function settingYearMonthPanel() 
{
	//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
	var obj = $(this);
	var p = obj.datebox('panel'), //日期选择对象
	span = p.find('span.calendar-text'); //显示月份层的触发控件
	p.find(".calendar-menu-year").attr("readOnly","true");
	span.click(function(){
		p.find('div.calendar-menu').hide();
	});
    span.get(0).click(); //触发click事件弹出月份层
    p.find("div.datebox-button").find("td:eq(0)").css("visibility","hidden");//隐藏今天按钮
    var months = p.find(".calendar-menu-month-inner").find(".calendar-menu-month");
    months.unbind();
    months.click(function(){
    	var year = /\d{4}/.exec(span.html())[0]//得到年份
        , month = parseInt($(this).attr('abbr'))+1;
    	if(month<10)
    	{
    		month="0"+month;
    	}
    	var val =year + '-' + month+"-00";
        obj.datebox('setValue',val).datebox('hidePanel'); //设置日期的值
 	});
}

function myparser(s) {
	if (!s)
		return new Date();
	var ss = (s.split('-'));
	var y = parseInt(ss[0], 10);
	var m = parseInt(ss[1], 10);
	var d = parseInt(ss[2], 10);
	if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
		return new Date(y, m - 1, d);
	} else {
		return new Date();
	}
}

function yearFormatter(date) {
	var year = date.getFullYear();
	if($("#tableName").length > 0) {
		var tableName = $("#tableName").val();
		$("#month").combobox({
			url : "/sys/pubData/qryReportMonthList.do?tableName=" + tableName + "&year=" + year,//返回json数据的url
	    	valueField : "month",
	    	textField : "monthText",
	    	panelHeight : "auto",
	    	formatter : function(data) {
	    		return "<span>" + data.monthText + "</span>";
	    	},
	    	onLoadSuccess:function(data) {
	    		if(data.length > 0) {
					$('#month').combobox('setValue', data[data.length - 1].month);
				} else {
					$("#week").combobox('clear');
					$("#week").combobox("loadData", new Array());
				}
	    	},
	    	onChange : function(n, o) {
	    		$("#week").combobox({
	    			url : "/sys/pubData/qryReportWeekList.do?tableName=" + tableName + "&year=" + year + "&month=" + n,//返回json数据的url
	    			valueField : "weekName",
	    	    	textField : "weekNameText",
	    	    	panelHeight : "auto",
	    	    	formatter : function(data) {
	    	    		return "<span>" + data.weekNameText + "</span>";
	    	    	},
	    	    	onLoadSuccess:function(data) {
	    	    		if(data.length > 0) {
	    					$('#week').combobox('setValue', data[data.length - 1].weekName);
	    				}
	    	    	}
	    		});
	    	}
		});
	}
	return date.getFullYear();
}

function yearParser(s) {
	var year = "";
	var yearDate = null;
	if(s) {
		year = String(s).substring(0, 4);
		yearDate = new Date(year);
	} else {
		year = new Date().getFullYear();
		yearDate = new Date();
	}
	$("#yearDiv").html(year);
	return yearDate;
}

function monthFormatter(date) {
	var y = date.getFullYear();
	var m = date.getMonth() + 1;
	return y + '-' + (m < 10 ? ('0' + m) : m);
}

function monthParser(s) {
	if (!s)
		return new Date();
	var ss = (s.split('-'));
	var y = parseInt(ss[0], 10);
	var m = parseInt(ss[1], 10);
	if (!isNaN(y) && !isNaN(m)) {
		return new Date(y, m - 1);
	} else {
		return new Date();
	}
}

function formatTypeName(row) {
	var s = '<span>' + row.typeName + '</span>';
	return s;
}

function formatLinkNum(row) {
	var s = '<span>' + row.linkNum + '年连报</span>';
	return s;
}

function formatStageId(row) {
	var s = '<span>' + row.stageId + '</span>';
	return s;
}

function formatItem(row) {
	var s = '<span>' + row.codeName + '</span>';
	return s;
}

function formatSchool(row) {
	var s = '<span>' + row.schoolName + '</span>';
	return s;
}

function formatPost(row) {
	var s = '<span>' + row.postName + '</span>';
	return s;
}

function formatStaff(row) {
	var s = '<span>' + row.userName + '</span>';
	return s;
}

function formatClassInst(row) {
	var s = '<span>' + row.className + '</span>';
	return s;
}

function formatTeacher(row) {
	var s = '<span>' + row.byname + '</span>';
	return s;
}

function formatRoom(row) {
	var s = '<span>' + row.roomName + '</span>';
	return s;
}

function formatParam(row) {
	var s = '<span>' + row.param1 + '</span>';
	return s;
}

function formatTeacherName(row) {
	var s = '<span>' + row.teacherName + '</span>';
	return s;
}

function formatParaConfig(row) {
	var s = '<span>' + row.paramDesc + '</span>';
	return s;
}

function formatEfficiency(value, row, index) {
	if(value >= 0) {
		return value;
	} else {
		value = value.substring(1);
		return "<font color='red'>（" + value + "）</font>";
	}
}

function formatHigherNotInClass(value, row, index) {
	if(value > 0) {
		return "<a href='javascript:void(0)' onclick='viewNotInClassDetail(" + index + ", \"higher\")' style='text-decoration:none'>" + value + "</a>";
	} else {
		return value;
	}
}

function formatNewNotInClass(value, row, index) {
	if(value > 0) {
		return "<a href='javascript:void(0)' onclick='viewNotInClassDetail(" + index + ", \"new\")' style='text-decoration:none'>" + value + "</a>";
	} else {
		return value;
	}
}

function formatFinishBonus(value, row, index) {
	if(row.isApplyBonus == "N") {
		return "<a href='javascript:void(0)' onclick='getBonus(" + row.classInstId + ", \"APPLY\")' class='apply' style='width: 100px;'><span>申请奖金</span></a>";
	} else {
//		if(row.isGetBonus == "N") {
//			return "<a href='javascript:void(0)' onclick='getBonus(" + row.classInstId + ", \"GET\")' class='get' style='width: 100px;'><span>领取奖金</span></a>";
//		} else {
//			return "";
//		}
		return "";
	}
}

function formatExceptionIn(value, row, index) {
	var date = new Date;
	var month = date.getMonth() + 2;
	month = (month < 10 ? "0" + month : month);
	if(month == row.month) {
		return '<input class="number" id="exceptionIn' + index + '" data-options="min:0,max:100,precision:0" style="width:100%; height: 23px;" value="' + value + '"/>';
	} else {
		return value;
	}
}
function formatNewPlan(value, row, index) {
	var date = new Date;
	var month = date.getMonth() + 2;
	month = (month < 10 ? "0" + month : month);
	if(month == row.month) {
		return '<input class="number" id="newPlan' + index + '" data-options="min:0,max:100,precision:0" style="width:100%; height: 23px;" value="' + value + '"/>';
	} else {
		return value;
	}
}
function formatChangeOut(value, row, index) {
	var date = new Date;
	var month = date.getMonth() + 2;
	month = (month < 10 ? "0" + month : month);
	if(month == row.month) {
		return '<input class="number" id="changeOut' + index + '" data-options="min:0,max:100,precision:0" style="width:100%; height: 23px;" value="' + value + '"/>';
	} else {
		return value;
	}
}
function formatChangeIn(value, row, index) {
	var date = new Date;
	var month = date.getMonth() + 2;
	month = (month < 10 ? "0" + month : month);
	if(month == row.month) {
		return '<input class="number" id="changeIn' + index + '" data-options="min:0,max:100,precision:0" style="width:100%; height: 23px;" value="' + value + '"/>';
	} else {
		return value;
	}
}
function formatExceptionRefund(value, row, index) {
	var date = new Date;
	var month = date.getMonth() + 2;
	month = (month < 10 ? "0" + month : month);
	if(month == row.month) {
		return '<input class="number" id="exceptionRefund' + index + '" data-options="min:0,max:100,precision:0" style="width:100%; height: 23px;" value="' + value + '"/>';
	} else {
		return value;
	}
}
function formatStudyingRefund(value, row, index) {
	var date = new Date;
	var month = date.getMonth() + 2;
	month = (month < 10 ? "0" + month : month);
	if(month == row.month) {
		return '<input class="number" id="studyingRefund' + index + '" data-options="min:0,max:100,precision:0" style="width:100%; height: 23px;" value="' + value + '"/>';
	} else {
		return value;
	}
}
function formatFinishStudying(value, row, index) {
	var date = new Date;
	var month = date.getMonth() + 2;
	month = (month < 10 ? "0" + month : month);
	if(month == row.month) {
		return '<input class="number" id="finishStudying' + index + '" data-options="min:0,max:100,precision:0" style="width:100%; height: 23px;" value="' + value + '"/>';
	} else {
		return value;
	}
}
function formatFinishHigher(value, row, index) {
	var date = new Date;
	var month = date.getMonth() + 2;
	month = (month < 10 ? "0" + month : month);
	if(month == row.month) {
		return '<input class="number" id="finishHigher' + index + '" data-options="min:0,max:100,precision:0" style="width:100%; height: 23px;" value="' + value + '"/>';
	} else {
		return value;
	}
}

function formatChangeBaseNum(value, row, index) {
	if(row.studyingNum == "1") {
		return "<a href='javascript:void(0)' onclick='changeStudentBaseNum("+row.baseNumStudentId+")' class='edit' style='width: 100px;'><span>修改基数</span></a>";
	} else {
		return "";
	}
}

function myLoadFilter(data,parentId){
	function setData(){
		var todo = [];
		for(var i=0; i<data.length; i++){
			todo.push(data[i]);
		}
		while(todo.length){
			var node = todo.shift();
			if (node.children){
				node.state = 'closed';
				node.children1 = node.children;
				node.children = undefined;
				todo = todo.concat(node.children1);
			}
		}
	}
	setData(data);
	var tg = $(this);
	var opts = tg.treegrid('options');
	opts.onBeforeExpand = function(row){
		if (row.children1){
			tg.treegrid('append',{
				parent: row[opts.idField],
				data: row.children1
			});
			row.children1 = undefined;
			tg.treegrid('expand', row[opts.idField]);
		}
		return row.children1 == undefined;
	};
	return data;
}

$.extend($.fn.validatebox.defaults.rules, {  
    equalTo: {
        validator:function(value,param){
            return $(param[0]).val() == value;
        },
        message:'字段不匹配'
    }
});
function MergeCells(tableID, fldList) {
	var Arr = fldList.split(",");
	var dg = $('#' + tableID);
	var fldName;
	var RowCount = dg.datagrid("getRows").length;
	var span;
	var PerValue = "";
	var CurValue = "";
	var length = Arr.length - 1;
	for (i = length; i >= 0; i--) {
		fldName = Arr[i];
		PerValue = "";
		span = 1;
		for (row = 0; row <= RowCount; row++) {
			if (row == RowCount) {
				CurValue = "";
			} else {
				CurValue = dg.datagrid("getRows")[row][fldName];
			}
			if (PerValue == CurValue) {
				span += 1;
			} else {
				var index = row - span;
				dg.datagrid('mergeCells', {
					index : index,
					field : fldName,
					rowspan : span,
					colspan : null
				});
				span = 1;
				PerValue = CurValue;
			}
		}
	}
}

//请空name内所有控件的值
function clearData(name) 
{
	$('input,select,textarea', $("#"+name)).each(function(){
			var t = this.type, tag = this.tagName.toLowerCase();
			if (t == 'text' || t == 'hidden' || t == 'password' || tag == 'textarea'){
				this.value = '';
			} else if (t == 'file'){
				var file = $(this);
				if (!file.hasClass('textbox-value')){
					var newfile = file.clone().val('');
					newfile.insertAfter(file);
					if (file.data('validatebox')){
						file.validatebox('destroy');
						newfile.validatebox();
					} else {
						file.remove();
					}
				}
			} else if (t == 'checkbox' || t == 'radio'){
				this.checked = false;
			} else if (tag == 'select'){
				this.selectedIndex = -1;
			}
			
		});
		var arr =["textbox","numberbox","searchbox","slider","spinner","numberspinner","timespinner","datetimespinner","combo","datebox","datetimebox","combogrid","combotree","combobox"];
		for(var i=arr.length-1; i>=0; i--){
			var type = arr[i];
			var field = $("#"+name).find('.'+type+'-f');
			if (field.length && field[type]){
				field[type]('clear');
			}
		}
}

String.prototype.endWith = function(str) {
	if (str == null || str == "" || this.length == 0
			|| str.length > this.length)
		return false;
	if (this.substring(this.length - str.length) == str)
		return true;
	else
		return false;
	return true;
}

String.prototype.startWith = function(str) {
	if (str == null || str == "" || this.length == 0
			|| str.length > this.length)
		return false;
	if (this.substr(0, str.length) == str)
		return true;
	else
		return false;
	return true;
}

String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)/g, "");
}

String.prototype.ltrim = function() {
	return this.replace(/(^\s*)/g, "");
}

String.prototype.rtrim = function() {
	return this.replace(/(\s*$)/g, "");
}

function ajaxLoading(tipsValue){ 
    top.$("<div class=\"datagrid-mask\"></div>").css({display:"block",width:"100%",height:"100%"}).appendTo("body"); 
    top.$("<div class=\"datagrid-mask-msg\"></div>").html(tipsValue).appendTo("body").css({display:"block",left:"50%",top:"50%"}); 
} 

function ajaxLoadEnd(){ 
    top.$(".datagrid-mask").remove(); 
    top.$(".datagrid-mask-msg").remove();             
} 

function validateTeacher(teacherId, weekTime, hourRange, classInstId) {
	var flag = false;
	$.ajax({
		url: "/sys/openClass/validateTeacher.do",
		data: "param={teacherId:\""+teacherId+"\",weekTime:\""+weekTime+"\",hourRange:\""+hourRange+"\",classInstId:\""+classInstId+"\",queryCode:\"validateTeacher\"}",
		dataType: "json",
		async: false,
		beforeSend: function()
		{
			$.messager.progress({title : '校验老师', msg : '正在校验老师，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			flag = data;
		} 
	});
	return flag;
}

function validateRoom(weekTime, hourRange, roomId) {
	var flag = false;
	var param = "{'queryCode':'validateRoom','weekTime':'"+weekTime+"','hourRange':'"+hourRange+"','roomId':'"+roomId+"'}";
	$.ajax({
		url: "/sys/applyClass/validateRoom.do",
		data: "param=" + param,
		dataType: "json",
		contentType: "application/x-www-form-urlencoded; charset=utf-8", 
		async: false,
		beforeSend: function()
		{
			$.messager.progress({title : '校验上课时段和教室资源', msg : '正在校验上课时段和教室资源，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			flag = data;
		}
	});
	return flag;
}

//弹出进度框
function showProgressLoader(text,timer)
{
	var progress ="<div class='panel window messager-window' style='display: block;left:-144px;width: 288px; z-index: 9005;'><div class='messager-body panel-body panel-body-noheader panel-body-noborder window-body window-body-noheader' title='' style='width: 266px;'><div class='messager-progress'><div class='messager-p-msg'></div><div class='messager-p-bar progressbar' style='height: 20px;'><div class='progressbar-text' style='width: 244px; height: 20px; line-height: 20px;'>"+text+"</div><div class='progressbar-value' style='width: 0%; height: 20px; line-height: 20px;'><div class='progressbar-text' style='width: 244px; height: 20px; line-height: 20px;'>"+text+"</div></div></div></div></div></div>";
	$("<div id='loadings' style='z-index:8000;text-align:center'>"+progress+"</div>").bPopup({modalClose: false,modalColor:"#ccc",opacity:0.5,positionStyle:"fixed"});
	countProgress =0;
	to =setInterval("countProgressing()",timer);
}


function hideProgressLoader()
{
	try
	{
		clearInterval(to);

	}
	catch(e)
	{
		
	}
	$("#loadings").bPopup().close();
	$("#loadings").remove();
}

function countProgressing()
{
	$(".progressbar-value").css("width",countProgress+"%");
	countProgress+=10;
	if(countProgress==100)
	{
		countProgress =0;
	}
}

function showMessage(title,text,callBack)
{
	var message ="<div class='panel window messager-window' style='display: block; width: 288px; left: -144px; top:50%; z-index: 9005;'><div class='panel-header panel-header-noborder window-header' style='width: 288px;'><div class='panel-title'>"+title+"</div><div class='panel-tool'><a href='javascript:void(0)' onclick='hideMessage()' class='panel-tool-close'></a></div></div><div class='messager-body panel-body panel-body-noborder window-body' title='' style='width: 266px;'><div class=''></div><div>"+text+"</div><div style='clear:both;'></div><div class='messager-button'><a href='javascript:void(0)' style='margin-left:10px' class='l-btn l-btn-small' group='' id='messageBtn'><span class='l-btn-left'><span class='l-btn-text'>确定</span></span></a></div></div></div>";
	$("<div id='loadings' style='z-index:8000;text-align:center'>"+message+"</div>").bPopup({modalClose: false,modalColor:"#ccc",opacity:0.5,positionStyle:"fixed"});
	if(callBack!=null)
	{
		$("#messageBtn").click(function(){
			callBack();
		})
	}
	else
	{
		$("#messageBtn").click(function(){
			hideMessage();
		})
	}	
}

function hideMessage()
{
	$("#loadings").bPopup().close();
	$("#loadings").remove();
}

Date.prototype.Format = function(fmt) { //author: meizz 
	var o = {
		"M+" : this.getMonth() + 1, //月份 
		"d+" : this.getDate(), //日 
		"h+" : this.getHours(), //小时 
		"m+" : this.getMinutes(), //分 
		"s+" : this.getSeconds(), //秒 
		"q+" : Math.floor((this.getMonth() + 3) / 3), //季度 
		"S" : this.getMilliseconds()
	//毫秒 
	};
	if (/(y+)/.test(fmt))
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(fmt))
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
					: (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
}

// 身份证校验,成功返回true
function validateIdCard(obj) {
	var aCity = {11 : "北京", 12 : "天津", 13 : "河北", 14 : "山西", 15 : "内蒙古", 21 : "辽宁", 22 : "吉林", 23 : "黑龙江", 31 : "上海", 32 : "江苏", 33 : "浙江", 34 : "安徽", 35 : "福建", 36 : "江西", 37 : "山东", 41 : "河南", 42 : "湖北", 43 : "湖南", 44 : "广东", 45 : "广西", 46 : "海南", 50 : "重庆", 51 : "四川", 52 : "贵州", 53 : "云南", 54 : "西藏", 61 : "陕西", 62 : "甘肃", 63 : "青海", 64 : "宁夏", 65 : "新疆", 71 : "台湾", 81 : "香港", 82 : "澳门", 91 : "国外" };
	var iSum = 0;
	var strIDno = obj;
	var idCardLength = strIDno.length;
	if (!/^\d{17}(\d|x)$/i.test(strIDno) && !/^\d{15}$/i.test(strIDno))
		return false; // 非法身份证号
	if (aCity[parseInt(strIDno.substr(0, 2))] == null)
		return false;// 非法地区
	// 15位身份证转换为18位
	if (idCardLength == 15) {
		sBirthday = "19" + strIDno.substr(6, 2) + "-" + Number(strIDno.substr(8, 2)) + "-" + Number(strIDno.substr(10, 2));
		var d = new Date(sBirthday.replace(/-/g, "/"))
		var dd = d.getFullYear().toString() + "-" + (d.getMonth() + 1) + "-" + d.getDate();
		if (sBirthday != dd)
			return false; // 非法生日
		strIDno = strIDno.substring(0, 6) + "19" + strIDno.substring(6, 15);
		strIDno = strIDno + GetVerifyBit(strIDno);
	}
	// 判断是否大于2078年，小于1900年
	var year = strIDno.substring(6, 10);
	if (year < 1900 || year > 2078)
		return false;// 非法生日
	// 18位身份证处理
	// 在后面的运算中x相当于数字10,所以转换成a
	strIDno = strIDno.replace(/x$/i, "a");
	sBirthday = strIDno.substr(6, 4) + "-" + Number(strIDno.substr(10, 2))
			+ "-" + Number(strIDno.substr(12, 2));
	var d = new Date(sBirthday.replace(/-/g, "/"))
	if (sBirthday != (d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d
			.getDate()))
		return false; // 非法生日
	// 身份证编码规范验证
	for ( var i = 17; i >= 0; i--)
		iSum += (Math.pow(2, i) % 11) * parseInt(strIDno.charAt(17 - i), 11);
	if (iSum % 11 != 1)
		return false;// 非法身份证号
	// 判断是否屏蔽身份证
	var words = new Array();
	words = new Array("11111119111111111", "12121219121212121");
	for ( var k = 0; k < words.length; k++) {
		if (strIDno.indexOf(words[k]) != -1) {
			return false;
		}
	}
	return true;
}

function checkMobile(mobile) { 
	var isPhone = /^([0-9]{3,4}-)?[0-9]{7,8}$/;
	var isMob = /^(13[0-9]|14[0-9]|15[0-9]|18[0-9]|177)\d{8}$/;
	if(isMob.test(mobile) || isPhone.test(mobile)) {
		return true;
	} else{
		return false;
	}
}

function validateIsQry() {
	var year = $("#year").datebox("getValue");
	if(year == null || year == "" || year == undefined) {
		$.messager.alert('提示', "请选择您要查询的年份！");
		return false;
	}
	var month = $("#month").combobox("getValue");
	if(month == null || month == "" || month == undefined) {
		$.messager.alert('提示', "请选择您要查询的月份！");
		return false;
	}
	var week = $("#week").combobox("getValue");
	if(week == null || week == "" || week == undefined) {
		$.messager.alert('提示', "请选择您要查询的周！");
		return false;
	}
	return true;
}

//绑定查询页面的查询重置按钮事件
function initQryButton(qryName,resetName,formName,tableName)
{
	var schoolArr =['schoolId','schoolIds','approveSchoolId','actionSchoolId'];
	var stageArr =['stageId','stageIds'];
	$("#"+qryName+"").click(function() {
		var qryFlag =true;

		//判断查询校区是否有值
		for(var i=0;i<schoolArr.length;i++)
    	{
    		var schoolObj =$("#"+formName+"").find("#"+schoolArr[i]);
    		if(schoolObj.length>0)
    		{
    			if(schoolObj.combobox("getValue")=="")
	    		{
	    			qryFlag =false;
	    			break;
	    		}	
    		}
    	}
		if(qryFlag)
		{
			var obj = JSON.stringify($("#"+formName+"").serializeObject());
	    	obj = obj.substring(0, obj.length - 1);
	    	var funcNodeId = $("#"+qryName+"").attr("funcNodeId");
	    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
	    	$("#"+tableName+"").datagrid({
	    		url : "/sys/pubData/qryDataListByPage.do",
	    		queryParams:{
	    			param : obj
	    		},
	    		onLoadSuccess:function(){
	    			$("#"+tableName+"").datagrid('clearSelections');
	    		}
	    	}); 
		}
		else
		{
			showMessage("提示","没有有效的校区可供查询",null);
		}	
    });
	 
    $("#"+resetName+"").click(function() 
    {
    	$("#"+formName+"").form('clear');//清空窗体数据  
    	//校区赋默认值
    	for(var i=0;i<schoolArr.length;i++)
    	{
    		var schoolObj =$("#"+formName+"").find("#"+schoolArr[i]);
    		if(schoolObj.length>0)
    		{
    			if(schoolObj.combobox("getData").length>0)
    			{
    				schoolObj.combobox("select",schoolObj.combobox("getData")[0].schoolId);
    			}	
    		}	
    	}
    	//阶段赋默认值
    	for(var j=0;j<stageArr.length;j++)
    	{
    		var stageObj =$("#"+formName+"").find("#"+stageArr[j]);
	    	if(stageObj.length>0)
	    	{
	    		if(stageObj.combobox("getData").length>0)
	    		{
	    			 stageObj.combobox("select",stageObj.combobox("getData")[0].stageId);
	    		}	
	    	}
    	}	
    });
}


//初始化年月控件
function initYearAndMonth(yearName,monthName) {
	var data1 = [];
	var data2 =[];
	var year = new Date().getFullYear();
	for ( var i = 0; i < 20; i++) {
		var soption = {};
		soption.val = (year -5+ i);
		soption.text = soption.val+"年";
		data1.push(soption);
		if(i<12)
		{
			var moption={};
			moption.val=i+1;
			moption.text = moption.val+"月";
			data2.push(moption);
		}	
	}
	if($("#"+yearName).length>0)
	{
		$("#"+yearName).combobox("loadData", data1);
	}
	if($("#"+monthName).length>0)
	{
		$("#"+monthName).combobox("loadData", data2);
	}
	
}


function exportLink(btName,tableName)
{
	$("#"+btName).click(function(){
		if($("#"+tableName).datagrid("getData").total>0)
		{
			var fileName =parent.$("li.tabs-selected").find("span.tabs-title").html();
			try
			{
				window.location.href="/sys/export/normalExport.do?fileName="+fileName+"&param="+JSON.stringify($("#"+tableName).datagrid("options").queryParams.param);
			}
			catch(e)
			{
				$.messager.alert('提示', "模版不存在！",function(){
					window.history.back();
				});
			}
		}
		else
		{
			$.messager.alert('提示', "没有数据可以导出！");
		}	
	})
}



function exportMergeLink(btName,tableName,mergeName,mergeIndex)
{
	$("#"+btName).click(function(){
		if($("#"+tableName).datagrid("getData").total>0)
		{
			var fileName =parent.$("li.tabs-selected").find("span.tabs-title").html();
			try
			{
				window.location.href="/sys/export/normalMergeExport.do?fileName="+fileName+"&mergeName="+mergeName+"&mergeIndex="+mergeIndex+"&param="+JSON.stringify($("#"+tableName).datagrid("options").queryParams.param);
			}
			catch(e)
			{
				$.messager.alert('提示', "模版不存在！",function(){
					window.history.back();
				});
			}
		}
		else
		{
			$.messager.alert('提示', "没有数据可以导出！");
		}	
	})
}

function exportMergeLinks(btName,tableName,mergeName,mergeIndex)
{
	$("#"+btName).click(function(){
		if($("#"+tableName).datagrid("getData").total>0)
		{
			var fileName =parent.$("li.tabs-selected").find("span.tabs-title").html();
			try
			{
				window.location.href="/sys/export/normalMergeExports.do?fileName="+fileName+"&mergeName="+mergeName+"&mergeIndex="+mergeIndex+"&param="+JSON.stringify($("#"+tableName).datagrid("options").queryParams.param);
			}
			catch(e)
			{
				$.messager.alert('提示', "模版不存在！",function(){
					window.history.back();
				});
			}
		}
		else
		{
			$.messager.alert('提示', "没有数据可以导出！");
		}	
	})
}


//绑定报表重置按钮事件
function initReportButton(resetName,formName,schoolId)
{
	var clearFlag =true;
	$("#"+formName).find("#"+schoolId).combobox({
		loader:function(param,success,error){  
		    $.ajax({  
				url: "/sys/pub/pageCategory.do?staffId="+$("#staffId").val()+"&resourceId="+$("#resourceId").val()+"&fieldId=schoolId",  
				dataType: 'json',  
				success: function(data){
		    	if(data.length==schoolData.length)
		    	{
		    		data.unshift({schoolName:'所有校区',schoolId:""});  
		    	}	
				success(data);  
				}
			});  
   		},
		onLoadSuccess:function(){
			var arr =$("#"+formName).find("#"+schoolId).combobox("getData");
			if(arr.length<schoolData.length)
			{
				$("#"+formName).find("#"+schoolId).combobox("select",arr[0].schoolId);
				clearFlag =false;
			}	
		}
	});
    $("#"+resetName+"").click(function() 
    {
    	$("#"+formName+"").form('clear');//清空窗体数据  
    	if(!clearFlag)
    	{
    		$("#"+formName).find("#"+schoolId).combobox('select',$("#"+formName).find("#"+schoolId).combobox("getData")[0].schoolId);
    	}
    	else
    	{
    		$("#"+formName).find("#"+schoolId).combobox('setValue',"");
    	}	
    });
}


function scrolltoDom(obj)
{
	$("html,body").animate({scrollTop: obj.offset().top-50}, 100);
}


//绑定查询页面的查询重置按钮事件
function initRPQryButton(qryName,resetName,formName,tableName)
{
	$("#"+qryName+"").click(function() {
		var obj = JSON.stringify($("#"+formName+"").serializeObject());
	    obj = obj.substring(0, obj.length - 1);
	    var funcNodeId = $("#"+qryName+"").attr("funcNodeId");
	    obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
	    $("#"+tableName+"").datagrid({
	    	url : "/sys/pubData/qryDataListByPage.do",
	    	queryParams:{
	    		param : obj
	    	},
	    	onLoadSuccess:function(){
	    		$("#"+tableName+"").datagrid('clearSelections');
	    	}
	    }); 
    });
	 
    $("#"+resetName+"").click(function() 
    {
    	$("#"+formName+"").form('clear');//清空窗体数据  
    });
}

//绑定非报表页面重置按钮事件及重置后的校区阶段控制
function initResetButton(resetName,formName)
{
	var schoolArr =['schoolId','schoolIds','approveSchoolId','actionSchoolId'];
	var stageArr =['stageId','stageIds'];
	$("#"+resetName+"").click(function() 
    {
    	$("#"+formName+"").form('clear');//清空窗体数据  
    	//校区赋默认值
    	for(var i=0;i<schoolArr.length;i++)
    	{
    		var schoolObj =$("#"+formName+"").find("#"+schoolArr[i]);
    		if(schoolObj.length>0)
    		{
    			if(schoolObj.combobox("getData").length>0)
    			{
    				schoolObj.combobox("select",schoolObj.combobox("getData")[0].schoolId);
    			}	
    		}	
    	}
    	//阶段赋默认值
    	for(var j=0;j<stageArr.length;j++)
    	{
    		var stageObj =$("#"+formName+"").find("#"+stageArr[j]);
	    	if(stageObj.length>0)
	    	{
	    		if(stageObj.combobox("getData").length>0)
	    		{
	    			 stageObj.combobox("select",stageObj.combobox("getData")[0].stageId);
	    		}	
	    	}
    	}	
    });
}


function getFormatStr(str)
{
	if(str==undefined||str==null||str==""||str=="null")
	{
		return "";
	}
	else
	{
		return str;
	}	
}


function disableForm(formId,isDisabled) {
    
    var attr="disable";
	if(!isDisabled){
	   attr="enable";
	}
	$("form[id='"+formId+"'] :text").attr("disabled",isDisabled);
	$("form[id='"+formId+"'] textarea").attr("disabled",isDisabled);
	$("form[id='"+formId+"'] select").attr("disabled",isDisabled);
	$("form[id='"+formId+"'] :radio").attr("disabled",isDisabled);
	$("form[id='"+formId+"'] :checkbox").attr("disabled",isDisabled);
	$("form[id='"+formId+"'] a").attr("disabled",isDisabled);
	//禁用使用input生成的combox

	$("#" + formId + " input[class='combobox-f combo-f']").each(function () {
		if (this.id) 
		{
			$("#" + this.id).combobox(attr);
		}
	});
	
	//禁用使用select生成的combox
	$("#" + formId + " select[class='combobox-f combo-f']").each(function () {
		if (this.id) 
		{
			$("#" + this.id).combobox(attr);
		}
	});
	
	//禁用dataBox
	$("#" + formId + " input[class='datebox-f combo-f']").each(function () {
		if (this.id) 
		{
			$("#" + this.id).datebox(attr);
		}
	});
	//禁用linkbutton
	$("#" + formId + " a[class='easyui-linkbutton']").each(function () {
		if (this.id) 
		{
			try
			{
				$("#" + this.id).linkbutton(attr);				
			}
			catch(e)
			{
				$("#" + this.id).remove();
			}
		}
	});
}
