$(document).ready(function() {
	$("input:radio[name='isNeed']").change(function() {
		var isNeed = $("input:radio[name='isNeed']:checked").val();
		if("'Y'" == isNeed) {
			$("[name='courseStateNeed']").each(function() {
				$(this).removeAttr("disabled");
			});
			$("[name='courseStateAll']").each(function() {
				$(this).attr("disabled", "disabled");
				$(this).removeAttr("checked");
			});
		} else {
			$("[name='courseStateAll']").each(function() {
				$(this).removeAttr("disabled");
			});
			$("[name='courseStateNeed']").each(function() {
				$(this).attr("disabled", "disabled");
				$(this).removeAttr("checked");
			});
		}
	});
	
	$("#qryBtn").click(function() {
    	var obj = JSON.stringify($("#qryFm").serializeObject());
    	obj = obj.substring(0, obj.length - 1);
    	var isNeed = $("input:radio[name='isNeed']:checked").val();
    	if(isNeed != null && isNeed != null && isNeed != undefined) {
    		var courseState = "";
    		if("'Y'" == isNeed) {
    			$("[name='courseStateNeed']:checked").each(function() {
    				courseState += $(this).val()+",";
    			});
    		} else {
    			$("[name='courseStateAll']:checked").each(function() {
    				courseState += $(this).val()+",";
    			});
    		}
    		courseState = courseState.substring(0, courseState.length - 1);
    		obj += ",\"courseState\":\""+courseState+"\"";
    	}
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
	
	//选班
	$("#selectClassBtn").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var isNeedSelect = row.isNeedSelect;
			if("Y" == isNeedSelect) {
				var studentCourseId = row.studentCourseId;
				window.location.href = "/sys/selectClass/selectClass.jsp?studentCourseId="+studentCourseId;
			} else {
				$.messager.alert('提示', "您选择的班级暂时还不需要选班！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要选班的班级！");
		}
	});
});