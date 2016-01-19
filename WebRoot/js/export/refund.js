$(document).ready(function() {
	$("#qryBtn").click(function() {
		var object = $("#qryFm").serializeObject();
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
    			//合并单元格
    			MergeCellWidthSchool("list_data","schoolName,totalNum");
    		}
    	});
    });
	initReportButton("reset","qryFm","schoolId")
});

function initDate()
{
	var curr_time = new Date();
	$('#endTime').datebox('setValue', myformatter(curr_time));
	curr_time.setMonth(curr_time.getMonth() - 1);
	$('#startTime').datebox('setValue', myformatter(curr_time));
}


 function MergeCellWidthSchool(tableID, fldList) {
            var Arr = fldList.split(",");
            var dg = $('#' + tableID);
            var fldName;
            var RowCount = dg.datagrid("getRows").length;
            var span;
            var PerValue = "";
            var PreSchool ="";
            var CurValue = "";
            var CurSchool ="";
            var length = Arr.length - 1;
            for (i = length; i >= 0; i--) {
                fldName = Arr[i];
                PerValue = "";
                PreSchool="";
                span = 1;
                for (row = 0; row <= RowCount; row++) {
                    if (row == RowCount) {
                        CurValue = "";
                        CurSchool="";
                    }
                    else {
                        CurValue = dg.datagrid("getRows")[row][fldName];
                        CurSchool =  dg.datagrid("getRows")[row]["schoolId"]
                    }
                    if (PerValue == CurValue&&PreSchool==CurSchool) {
                        span += 1;
                    }
                    else {
                        var index = row - span;
                        dg.datagrid('mergeCells', {
                            index: index,
                            field: fldName,
                            rowspan: span,
                            colspan: null
                        });
                        span = 1;
                        PerValue = CurValue;
                        PreSchool = CurSchool;
                    }
                }
            }
        }
 
