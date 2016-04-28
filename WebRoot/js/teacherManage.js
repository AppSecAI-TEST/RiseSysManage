var url="";

function qryData()
{
	initPageNumber("list_data");
	var obj = JSON.stringify($("#qryFm").serializeObject());
	$('#list_data').datagrid({
		url : "qryArchivesInfo.do",
		queryParams:{
			json : obj
		},
		onLoadSuccess:function(){
			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
			$('#list_data').datagrid('clearSelections');
		}
	});
	
}

function addArchives()
{
	$('#dlg').dialog('open').dialog('setTitle', '新增教师档案')
	$('#fm').form('clear');
	url = "addArchivesInfo.do";
}

function updateArchives()
{
	var row = $('#list_data').datagrid('getSelected');
	if (row){
		$('#dlg').dialog('open').dialog('setTitle','修改教师档案');
		$('#fm').form('clear');
		$('#fm').form('load',row);
		url = "updateArchivesInfo.do";
	}
}

function saveArchives()
{
	$('#fm').form('submit',{
		url: url,
		onSubmit: function(){
			return $(this).form('validate');
		},
		success: function(result){
			if (result == "success"){
				$('#dlg').dialog('close');	
				window.location.reload();	
			} else {
				$.messager.alert('提示',result);
			}
		}
	});
}

function deleteArchives(){
	var row = $('#list_data').datagrid('getSelected');
	if (row){
		$.messager.confirm('提示','您确定要删除此教师信息吗?',function(r){
			if (r){
				$.post('deleteArchivesInfo.do',{teacherId:row.teacherId},function(result){
					if(result == "success")
					{
						window.location.reload();
					}
					else
					{
						$.messager.alert('提示', result);
					}
				});
			}
		});
	}
}