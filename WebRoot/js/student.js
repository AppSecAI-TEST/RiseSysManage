$(document).ready(function() {
	initDate();
	//设置分页控件 
    var p = $('#list_data').datagrid('getPager'); 
    $(p).pagination({
        pageSize: 10,//每页显示的记录条数，默认为10 
        pageList: [5, 10, 15],//可以设置每页记录条数的列表 -
        beforePageText: '第',//页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页', 
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
        /*onBeforeRefresh:function(){
            $(this).pagination('loading');
            alert('before refresh');
            $(this).pagination('loaded');
        }*/ 
        onSelectPage: function (pageNum, pageSize) { 
			alert('onSelectPage pageNumber:' + pageNum + ',pageSize:' + pageSize); 
		}
    }); 
    
    $("#qryBtn").click(function() {
    	var obj = JSON.stringify($("#qryFm").serializeObject());
    	$('#list_data').datagrid({
    		url : "/sys/student/qryStudentList.do",
    		queryParams:{
    			param : obj
    		},
    		onLoadSuccess:function(){
    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
    			$('#list_data').datagrid('clearSelections');
    		}
    	});
    });
    
    $("#reset").click(function() {
    	$('#qryFm').form('clear');//清空窗体数据  
    	initDate();
    });
    
    $("#addStudent").click(function() {
    	window.location.href = "/sys/student/addStudent.jsp";
    });
    
    $("#updateStudent").click(function() {
    	window.location.href = "/sys/student/updateStudent.jsp";
    });
    
    $("#viewStudent").click(function() {
    	window.location.href = "/sys/student/viewStudent.jsp";
    });
    
    $("#addActivity").click(function() {
    	window.location.href = "/sys/student/addActivity.jsp";
    });
});

function initDate()
{
	var curr_time = new Date();
	$('#endTime').datebox('setValue', myformatter(curr_time));
	curr_time.setMonth(curr_time.getMonth() - 1);
	$('#startTime').datebox('setValue', myformatter(curr_time));
}