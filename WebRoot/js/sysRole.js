var url = "";
var authArray = [{'value':'Y', 'allocAuth':'可授可用'}, {'value':'N', 'allocAuth':'可授不可用'}];
var alloc = [];
var notAlloc = [];
$(document).ready(function() {
	$.cookie("staffId", 1);
	
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
    
    $("#qryBtn").click(function(){
    	var obj = JSON.stringify($("#qryFm").serializeObject());
    	$('#list_data').datagrid({
    		url : "/sys/sysRole/qrySysRoleList.do",
    		queryParams:{
    			param : obj
    		},
    		onLoadSuccess:function(){
    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
    			$('#list_data').datagrid('clearSelections');
    		}
    	});
    });
    
    $("#addSysRole").click(function(){
    	$("#dlg").dialog('open').dialog('setTitle', '新增角色');//设定表头  
        $('#fm').form('clear');//清空窗体数据  
        url = "/sys/sysRole/addSysRole.do";
        $("#staffId").val($.cookie("staffId"));
    });
    
    $("#updateSysRole").click(function(){
    	if(!validate("修改"))
    	{
    		return;
    	}
    	else
    	{
    		var row = $('#list_data').datagrid('getSelected');
    		if (row) {
    			$('#dlg').dialog('open').dialog('setTitle','修改角色');
    			$('#fm').form('clear');
    			$('#fm').form('load', row);
    			url = "/sys/sysRole/updateSysRole.do";
    		}
    	}
    });
    
    $("#deleteSysRole").click(function(){
    	if(!validate("删除"))
    	{
    		return;
    	}
    	else
    	{
    		var row = $('#list_data').datagrid('getSelected');
    		if (row) {
    			$.messager.confirm('提示','您确定要删除当前选中的角色吗？',function(r) {
    				if(r) {
    					$.post('/sys/sysRole/deleteSysRole.do', {sysRoleId : row.sysRoleId, staffId : row.staffId}, function(result) {
    						var obj = JSON.parse(result);
    						if(obj.flag) {
    							window.location.reload();
    						} else {
    							$.messager.alert('提示', obj.msg);
    						}
    					});
    				}
    			});
    		}
    	}
    });
    
    $("#allocSysRole").click(function(){
    	var row = $('#list_data').datagrid('getSelected');
    	if (row) {
    		if(!validate("分配权限给")) {
    			return;
    		} else {
    			$("#allocDlg").dialog('open').dialog('setTitle', '分配权限');//设定表头  
    			$('#allocFm').form('clear');//清空窗体数据  
    			$("#allocTd").datagrid({
    				url : '/sys/sysRole/qrySysRoleAllocList.do',
    				queryParams:{
    					sysRoleId : row.sysRoleId,
    					staffId : row.staffId,
    	    		},
    	    		columns : [[
    	    		            {field:'ck', checkbox:true},
      				          	{field:'funcNodeId', title:'权限ID', width:80, align:'center'},
      				          	{field:'funcNodeName', title:'权限名称', width:120, align:'center'},
      				          	{field:'allocAuth', title:'授用类型', width:100, align:'center',
      				          		formatter: function(value, row, index) {
      									for(var i = 0; i < authArray.length; i++) {
      										if (authArray[i].value == value) return authArray[i].allocAuth;
      									}
      									return value;
      								}
      				          },
      			    ]],
      			    onLoadSuccess: function() {
      			    	//加载完数据关闭等待的div   
      			    	var rows = $("#allocTd").datagrid("getRows"); 
      			    	for(var i = 0, len = rows.length; i < len; i++) {
      			    		alloc.push(rows[i].funcNodeId);
      			    	}
      			    }
    			});
    			
    			$("#notAllocTd").datagrid({
    				url : '/sys/sysRole/qrySysRoleNotAllocList.do',
    				queryParams : {
    					sysRoleId : row.sysRoleId,
    					staffId : row.staffId,
    	    		},
    	    		columns : [[
    	    		            {field:'ck', checkbox:true},
    	    		            {field:'funcNodeId', title:'权限ID', width:80, align:'center'},
    	    		            {field:'funcNodeName', title:'权限名称', width:120, align:'center'},
    	    		            {field:'allocAuth', title:'授用类型', width:100, align:'center',
    	    		            	formatter: function(value, row, index) {
    									for(var i = 0; i < authArray.length; i++) {
    										if (authArray[i].value == value) return authArray[i].allocAuth;
    									}
    									return value;
    	    		            	},
    	    		            	editor : {
    	    		            		type : 'combobox',
    	    		            		options : {
    	    		            			valueField : 'value',
    	    		            			textField : 'allocAuth',
    	    		            			data : authArray,
    	    		            			required : true,
    	    		            			editable : false,
    	    		            			panelHeight : 'auto'
    	    		            		}
    	    		            	}
    	    		            },
    			    ]],
    			    onLoadSuccess: function() {
    			    	//加载完数据关闭等待的div   
    			    	var rows = $("#notAllocTd").datagrid("getRows"); 
    			    	for(var i = 0, len = rows.length; i < len; i++) {
    			    		$('#notAllocTd').datagrid('beginEdit', i);
    			    		notAlloc.push(rows[i].funcNodeId);
    			    	}
    			    }
    			});
    		}
    	}
    });
    
    //将未分配的权限增加到已分配的权限
    $("#alloc").click(function() {
    	var obj = $('#notAllocTd').datagrid('getSelections');
    	if(obj.length > 0) {
    		for(var i = 0, n = obj.length; i < n; i++) {
            	$("#notAllocTd").datagrid('deleteRow', $('#notAllocTd').datagrid("getRowIndex",obj[i]));
				$("#allocTd").datagrid('insertRow', {index: 0, row: obj[i]});
            }
    	} else {
    		$.messager.alert('提示', "请选择您想要要赋给该角色的未分配的权限！");
    	}
    });
    
    //将已分配的权限增加到未分配的权限
    $("#deleteAlloc").click(function() {
    	var obj = $('#allocTd').datagrid('getSelections');
    	if(obj.length > 0) {
    		var rows = $("#allocTd").datagrid("getRows").length; 
    		for(var i = 0, len = obj.length; i < len; i++) {
    			$("#allocTd").datagrid('deleteRow', $('#allocTd').datagrid("getRowIndex", obj[i]));
    			$("#notAllocTd").datagrid('insertRow', {index: 0, row: obj[i]});
    			$('#notAllocTd').datagrid('beginEdit', 0);
    		}
    		if(parseInt(rows) == parseInt(obj.length)) {
    			$('#allocTd').parent().find("div .datagrid-header-check").children("input[type='checkbox']").eq(0).attr("checked", false);
    		}
    	} else {
    		$.messager.alert('提示', "请选择您想要要删除该角色的已分配的权限！");
    	}
    });
    
    $("#submit").click(function() {
    	var obj = JSON.stringify($("#fm").serializeObject());
		$.post(url, {param : obj}, function(result) {
			var obj = JSON.parse(result);
			if(obj.flag) {
				window.location.reload();
			} else {
				$.messager.alert('提示', obj.msg);
			}
		});
    });
    
    $("#allocSubmit").click(function() {
    	var flag = false;
    	var allocArray = "[";
    	//查找所有新增的权限
    	var allocRows = $("#allocTd").datagrid("getRows");
    	if(allocRows.length > 0) {
    		for(var i = 0, len = allocRows.length; i < len; i++) {
    			var flags = false;
    			if(alloc.length > 0) {
    				for(var j = 0, l = alloc.length; j < l; j++) {
    					flags = alloc[j] == allocRows[i].funcNodeId
    					if(flags) {
    						break;
    					}
    				}
    			} 
    			if(!flags) {
    				flag = true;
					allocArray += "{\"funcNodeId\":\""+allocRows[i].funcNodeId+"\",\"allowAuth\":\""+allocRows[i].allocAuth+"\"},";
    			}
    		}
    		allocArray = allocArray.substring(0, allocArray.length - 1);
    	}
    	allocArray += "]";
    	
    	var sysRoleAllocId = ""; 
    	//查找删除的权限
    	var notAllocRows = $("#notAllocTd").datagrid("getRows"); 
    	if(notAllocRows.length > 0) {
    		for(var i = 0, len = notAllocRows.length; i < len; i++) {
    			var flags = false;
    			if(notAlloc.length > 0) {
    				for(var j = 0, l = notAlloc.length; j < l; j++) {
    					flags = notAlloc[j] == notAllocRows[i].funcNodeId;
    					if(flags) {
    						break;
    					}
    				}
    			} 
    			if(!flags) {
    				flag = true;
    				sysRoleAllocId += notAllocRows[i].sysRoleAllocId + ",";
    			}
    		}
    		if(sysRoleAllocId != "") {
    			sysRoleAllocId = sysRoleAllocId.substring(0, sysRoleAllocId.length - 1);
    		}
    	}
    	
    	if(flag) {
    		var row = $('#list_data').datagrid('getSelected');
    		if(row) {
    			$.post('/sys/sysRole/allocSysRole.do', {sysRoleId:row.sysRoleId, staffId:row.staffId, allocArray:allocArray, sysRoleAllocId:sysRoleAllocId}, function(result) {
					var obj = JSON.parse(result);
					if(obj.flag) {
						window.location.reload();
					} else {
						$.messager.alert('提示', obj.msg);
					}
				});
    		}
    	}
    });
});

function validate(msg)
{
	var row = $('#list_data').datagrid('getSelected');
	var creater = row.staffId;
	var staffId = $.cookie("staffId");
	if(creater != staffId) {
		$.messager.alert('提示', "该角色不是由您新建，您没有"+msg+"该角色的权限！");
		return false;
	}
	return true;
}