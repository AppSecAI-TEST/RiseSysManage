
function qryData()
{
	var obj = JSON.stringify($("#qryFm").serializeObject());
	$('#list_data').datagrid({
		url : "qryCourseInfo.do",
		queryParams:{
			json : obj
		},
		onLoadSuccess:function(){
			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
			$('#list_data').datagrid('clearSelections');
		}
	});
	
}