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
    			$("#qryBtn").click();
    		}
    	},
		onChange : function(n, o) {
			if($("#teacherId").length > 0) {
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
		}
	});
	
	if($("#quarter").length > 0 && $("#month").length > 0 ) {
		$("#quarter").combobox({
			url : "/sys/pubData/qryQuarterList.do",//返回json数据的url
			valueField : "quarter",
	    	textField : "quarterText",
	    	panelHeight : "auto",
	    	formatter : function(data) {
	    		return "<span>" + data.quarterText + "</span>";
	    	},
	    	onChange : function(n, o) {
	    		$("#month").combobox({
	    			url : "/sys/pubData/qryMonthList.do?quarter="+n,//返回json数据的url
					valueField : "month",
					textField : "monthText",
					panelHeight : "auto",
					formatter : function(data) {
						return "<span>" + data.monthText + "</span>";
					}
	    		});
	    	}
		});
	}

	var curr_time = new Date();
	$('#year').datebox('setValue', yearFormatter(curr_time));
	
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
    			onLoadSuccess();
    		}
    	});
    	
    	var higherType = $("#higherType").val();
    	if("quarter" == higherType) {
    		var year = $('#year').datebox('getValue');
    		$("#yearDiv").html(year);
    	} else if("allQuarter" == higherType) {
    		
    	}
    });
	
	var higherType = $("#higherType").val();
	if("allStage" == higherType || "allQuarter" == higherType || "allRegion" == higherType) {
		$("#qryBtn").click();
	}
});

function onLoadSuccess() {
	var higherType = $("#higherType").val();
	if("quarter" == higherType) {
		var merges = [{index: 0, rowspan: 3},
		              {index: 3, rowspan: 3},
		              {index: 6, rowspan: 3},
		              {index: 9, rowspan: 3}];
		for(var i = 0; i < merges.length; i++) {
			$('#list_data').datagrid('mergeCells', {
				index: merges[i].index,
				field: 'quarterHigherRate',
				rowspan: merges[i].rowspan
			});
		}
	} else if("allStage" == higherType) {
		var stageId = $("#stageId").combobox("getValue");
		if(stageId != null && stageId != "" && stageId != undefined) {
			var merges = [{index: 0, rowspan: 2},
			              {index: 2, rowspan: 2},
			              {index: 4, rowspan: 2},
			              {index: 6, rowspan: 2},
			              {index: 8, rowspan: 2},
			              {index: 10, rowspan: 2},
			              {index: 12, rowspan: 2},
			              {index: 14, rowspan: 2},
			              {index: 16, rowspan: 2},
			              {index: 18, rowspan: 2},
			              {index: 20, rowspan: 2},
			              {index: 22, rowspan: 2},
			              {index: 24, rowspan: 2},
			              {index: 26, rowspan: 2}];
		} else {
			var merges = [{index: 0, rowspan: 11},
			              {index: 11, rowspan: 11},
			              {index: 22, rowspan: 11},
			              {index: 33, rowspan: 11},
			              {index: 44, rowspan: 11},
			              {index: 55, rowspan: 11},
			              {index: 66, rowspan: 11},
			              {index: 77, rowspan: 11},
			              {index: 88, rowspan: 11},
			              {index: 99, rowspan: 11},
			              {index: 110, rowspan: 11},
			              {index: 121, rowspan: 11},
			              {index: 132, rowspan: 11},
			              {index: 143, rowspan: 11}];
		}
		for(var i = 0; i < merges.length; i++) {
			$('#list_data').datagrid('mergeCells', {
				index: merges[i].index,
				field: 'schoolName',
				rowspan: merges[i].rowspan
			});
		}
	} else if("allQuarter" == higherType) {
		var month = $("#month").combobox("getValue");
		if(month == null || month == "" || month == undefined) {
			//选择了季度
			var quarter = $("#quarter").combobox("getValue");
			if(quarter != null && quarter != "" && quarter != undefined) {
				var merges = [{index: 0, rowspan: 3},
				              {index: 3, rowspan: 3},
				              {index: 6, rowspan: 3},
				              {index: 9, rowspan: 3},
				              {index: 12, rowspan: 3},
				              {index: 15, rowspan: 3},
				              {index: 18, rowspan: 3},
				              {index: 21, rowspan: 3},
				              {index: 24, rowspan: 3},
				              {index: 27, rowspan: 3},
				              {index: 30, rowspan: 3},
				              {index: 33, rowspan: 3},
				              {index: 36, rowspan: 3}];
				for(var i = 0; i < merges.length; i++) {
					$('#list_data').datagrid('mergeCells', {
				  		index: merges[i].index,
				  			field: 'quarterHigherRate',
				  			rowspan: merges[i].rowspan
				  		});
				}
				for(var i = 0; i < merges.length; i++) {
					$('#list_data').datagrid('mergeCells', {
						index: merges[i].index,
						field: 'schoolName',
						rowspan: merges[i].rowspan
					});
				}
			} else {
				var merges = [{index: 0, rowspan: 12},
				              {index: 12, rowspan: 12},
				              {index: 24, rowspan: 12},
				              {index: 36, rowspan: 12},
				              {index: 48, rowspan: 12},
				              {index: 60, rowspan: 12},
				              {index: 72, rowspan: 12},
				              {index: 84, rowspan: 12},
				              {index: 96, rowspan: 12},
				              {index: 108, rowspan: 12},
				              {index: 120, rowspan: 12},
				              {index: 132, rowspan: 12},
				              {index: 144, rowspan: 12}];
				for(var i = 0; i < merges.length; i++) {
					$('#list_data').datagrid('mergeCells', {
						index: merges[i].index,
						field: 'schoolName',
						rowspan: merges[i].rowspan
					});
					if(i == 0) {
						var merges2 = [{index: i * 3, rowspan: 3},
						               {index: (i + 1) * 3, rowspan: 3},
						               {index: (i + 2) * 3, rowspan: 3},
						               {index: (i + 3) * 3, rowspan: 3}];
					} else {
						var merges2 = [{index: i * 3 + i * 9, rowspan: 3},
						               {index: (i + 1) * 3 + i * 9, rowspan: 3},
						               {index: (i + 2) * 3 + i * 9, rowspan: 3},
						               {index: (i + 3) * 3 + i * 9, rowspan: 3}];
					}
					for(var j = 0; j < merges2.length; j++) {
						$('#list_data').datagrid('mergeCells', {
							index: merges2[j].index,
							field: 'quarterHigherRate',
							rowspan: merges2[j].rowspan
						});
					}
				}
			}
		}
	} else if("allRegion" == higherType) {
		var month = $("#month").combobox("getValue");
		if(month == null || month == "" || month == undefined) {
			var regionId = $("#regionId").combobox("getValue");
			//选了片区
			if(regionId != null && regionId != "" && regionId != undefined) {
				//选择了季度
				var quarter = $("#quarter").combobox("getValue");
				if(quarter != null && quarter != "" && quarter != undefined) {
					var merges = [{index: 0, rowspan: 3}];
					var merges2 = [{index: 0, rowspan: 3}];
				} else {
					var merges = [{index: 0, rowspan: 12}];
					var merges2 = [{index: 0, rowspan: 3},
					              {index: 3, rowspan: 3},
					              {index: 6, rowspan: 3},
					              {index: 9, rowspan: 3}];
				}
				for(var i = 0; i < merges.length; i++) {
					$('#list_data').datagrid('mergeCells', {
						index: merges[i].index,
						field: 'regionName',
						rowspan: merges[i].rowspan
					});
				}
				for(var j = 0; j < merges2.length; j++) {
					$('#list_data').datagrid('mergeCells', {
						index: merges2[j].index,
						field: 'quarterHigherRate',
						rowspan: merges2[j].rowspan
					});
				}
			} else {
				//选择了季度
				var quarter = $("#quarter").combobox("getValue");
				if(quarter != null && quarter != "" && quarter != undefined) {
					var merges = [{index: 0, rowspan: 3}, {index: 3, rowspan: 6}];
				} else {
					var merges = [{index: 0, rowspan: 12}, {index: 12, rowspan: 12}];
					for(var i = 0; i < merges.length; i++) {
						$('#list_data').datagrid('mergeCells', {
							index: merges[i].index,
							field: 'regionName',
							rowspan: merges[i].rowspan
						});
						if(i == 0) {
							var merges2 = [{index: i * 3, rowspan: 3},
							               {index: (i + 1) * 3, rowspan: 3},
							               {index: (i + 2) * 3, rowspan: 3},
							               {index: (i + 3) * 3, rowspan: 3}];
						} else {
							var merges2 = [{index: i * 3 + i * 9, rowspan: 3},
							               {index: (i + 1) * 3 + i * 9, rowspan: 3},
							               {index: (i + 2) * 3 + i * 9, rowspan: 3},
							               {index: (i + 3) * 3 + i * 9, rowspan: 3}];
						}
						for(var j = 0; j < merges2.length; j++) {
							$('#list_data').datagrid('mergeCells', {
								index: merges2[j].index,
								field: 'quarterHigherRate',
								rowspan: merges2[j].rowspan
							});
						}
					}
				}
			}
		}
	} 
}