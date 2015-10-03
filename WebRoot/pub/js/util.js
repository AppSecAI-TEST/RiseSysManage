$
		.extend(
				$.fn.linkbutton.methods,
				{
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
				for ( var i = 0, n = data.length; i < n; i++) {
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
						}
					} else if (data[i].widgetType == "linkbutton") {
						if (data[i].val == "READONLY") {
							$("#" + data[i].fieldId).linkbutton('disable');
						} else if (data[i].val == "DISABLED") {
							$("#" + data[i].fieldId).linkbutton('disable');
						} else if (data[i].val == "HIDDEN") {
							$("#" + data[i].fieldId).hide();
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
						}
					}
				}
			},
			failure : function(data) {

			}
		});
	}
};

function myformatter(date) {
	var y = date.getFullYear();
	var m = date.getMonth() + 1;
	var d = date.getDate();
	return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
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

function formatStaff(row) {
	var s = '<span>' + row.staffName + '</span>';
	return s;
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
