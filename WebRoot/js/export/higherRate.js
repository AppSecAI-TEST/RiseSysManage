$(document).ready(function() {
	$("#schoolId").combobox({
		url : "/sys/pubData/qrySchoolList.do?schoolId=",//返回json数据的url
    	valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
    	onLoadSuccess:function(data) {
    		if(data.length > 0) {
    			$('#schoolId').combobox('setValue',data[0].schoolId);
    		}
    	},
		onChange : function(n, o) {
			//学校的教师
			$("#teacherId").combobox({
        		url : "/sys/pubData/qryTeacherList.do?schoolId="+n+"&classType=",//返回json数据的url
        		valueField : "teacherId",
        		textField : "byname",
        		panelHeight : "auto",
        		formatter : function(data) {
            		return "<span>" + data.byname + "</span>";
            	}
        	});
		}
	});
	
	$("#year").datebox({
		editable : false,
		formatter : function(date) {
			var y = date.getFullYear();
			return y;
		},
		parser : function(s) {
			if(s) {
				return new Date(String(s).substring(0,4));
			}	else	{
				return new Date();
			}
		}
	});
	
	$("#qryBtn").click(function() {
		var object = $("#qryFm").serializeObject();
		if($("[name='isAttend']").length > 0) {
			var s = "";
			$('input[name="isAttend"]:checked').each(function() {
				s += $(this).val() + ",";
			});
			s = s.substring(0, s.length - 1);
			object.courseState = s;
		}
    	var obj = JSON.stringify(object);
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
});