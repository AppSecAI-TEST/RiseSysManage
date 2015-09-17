$.extend($.fn.linkbutton.methods, {
    enable: function(jq){
        return jq.each(function(){
            var state = $.data(this, 'linkbutton');
            if ($(this).hasClass('l-btn-disabled')) {
                var itemData = state._eventsStore;
                //恢复超链接 
               if (itemData.href) {
                    $(this).attr("href", itemData.href);
                }
                //回复点击事件 
               if (itemData.onclicks) {
                    for (var j = 0; j < itemData.onclicks.length; j++) {
                        $(this).bind('click', itemData.onclicks[j]);
                    }
                }
                //设置target为null，清空存储的事件处理程序 
               itemData.target = null;
                itemData.onclicks = [];
                $(this).removeClass('l-btn-disabled');
            }
        });
    },
    disable: function(jq){
        return jq.each(function(){
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
                    eventsStore.onclicks[eventsStore.onclicks.length] = new Function(onclickStr);
                    $(this).attr("onclick", "");
                }
                //处理使用jquery绑定的事件 
               var eventDatas = $(this).data("events") || $._data(this, 'events');
                if (eventDatas["click"]) {
                    var eventData = eventDatas["click"];
                    for (var i = 0; i < eventData.length; i++) {
                        if (eventData[i].namespace != "menu") {
                            eventsStore.onclicks[eventsStore.onclicks.length] = eventData[i]["handler"];
                            $(this).unbind('click', eventData[i]["handler"]);
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
	staffId:"",
	funcNodeId:"",
	fieldId:"",
	filterFunc:function(){
		$.ajax({
			url:"/sys/pub/pageCategory.do",
			type:"POST",
			data:"staffId="+this.staffId+"&funcNodeId="+this.funcNodeId+"&fieldId="+this.fieldId,
			dataType:"json",
			success:function(data){
				for(var i = 0,n = data.length;i < n;i++)
				{
					if(data[i].widgetType == "textbox")
					{
						if(data[i].val == "READONLY")
						{
							$("#"+data[i].fieldId).textbox("readonly",true);
						}
						else if(data[i].val == "DISABLED")
						{
							$("#"+data[i].fieldId).textbox({"disabled":true});
						}
						else if(data[i].val == "HIDDEN")
						{
							var obj = $("#"+data[i].fieldId);
							obj.hide();
							obj.next().css("display","none");
						}
					}
					else if(data[i].widgetType == "linkbutton")
					{
						if(data[i].val == "READONLY")
						{
							$("#"+data[i].fieldId).linkbutton('disable'); 
						}
						else if(data[i].val == "DISABLED")
						{
							$("#"+data[i].fieldId).linkbutton('disable'); 
						}
						else if(data[i].val == "HIDDEN")
						{
							$("#"+data[i].fieldId).hide();
						}
					}
					else if(data[i].widgetType == "datebox")
					{
						if(data[i].val == "READONLY")
						{
							$("#"+data[i].fieldId).datebox({"editable":false});
						}
						else if(data[i].val == "DISABLED")
						{
							$("#"+data[i].fieldId).datebox({"disabled":true});
						}
						else if(data[i].val == "HIDDEN")
						{
							var obj = $("#"+data[i].fieldId);
							obj.hide();
							obj.next().css("display","none");
						}
					}
					else if(data[i].widgetType == "datetimebox")
					{
						if(data[i].val == "READONLY")
						{
							$("#"+data[i].fieldId).attr("readonly", "readonly"); 
						}
						else if(data[i].val == "DISABLED")
						{
							$("#"+data[i].fieldId+" .easyui-datetimebox").datetimebox({disabled: true});
						}
						else if(data[i].val == "HIDDEN")
						{
							$("#"+data[i].fieldId).hide();
						}
					}
				}
			},
			failure:function(data){
				
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
	}else{
		return new Date();
	}
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