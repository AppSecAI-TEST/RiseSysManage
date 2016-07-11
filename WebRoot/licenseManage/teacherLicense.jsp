<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  	<body>
  		<div style="margin-right:5px">
  		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
 		<form id="qryFm">
  			<table class="search_tab">
  				<tr>
  					<td align="right" width="8%"><span>组织：</span></td>
  					<td align="left" width="8%">
  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width:100px;height:25px;" editable="false">
        				</select>
  					</td>
  					<td align="right" width="10%"><span>教师英文名：</span></td>
  					<td align="left" width="8%">
  						<select name="teacherId" id="teacherId" class="easyui-combobox" style="width:100px;height:25px;">
						</select>
  					</td>
  					 
  					<td align="left">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px;" id="qryBtn" funcNodeId="500471"><span>查询</span></a>
						&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px;" id="resetBtn" ><span>重置</span></a>
					</td>
  				</tr>
  			</table>
 		</form>
 		
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:570" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="10%"><span>组织</span></th>
					<th field="staffName" align="center" width="8%"><span>教师姓名</span></th>
					<th field="byname" align="center" width="9%"><span>教师英文名</span></th>
					<th field="stageId" align="center" width="12%"><span>持证阶段</span></th>
					<th field="joinDate" align="center" width="7%"><span>入职时间</span></th>
					<th field="phone" align="center" width="11%"><span>电话</span></th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
   			<a href="javascript:void(0)" id="deleteLicense" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;"><span>删除持证</span></a>
 		</div>
 		</div>
  	</body>
</html>
<script type="text/javascript">
$(document).ready(function(){
	//首页面查询
    $("#qryBtn").click(function() {
    	var schoolId = $("#schoolId").combobox("getValue");
	    if(schoolId != "") {
	    	initPageNumber("list_data");
	    	var json = $("#qryFm").serializeObject();
			var obj = JSON.stringify(json);
			obj = obj.substring(0, obj.length - 1);
			var funcNodeId = $("#qryBtn").attr("funcNodeId");
			obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
			$('#list_data').datagrid({
				url : "/sys/licenseManage/qryDataListByPage.do",
				queryParams:{
					param : obj
				},
				onLoadSuccess:function(){
					//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
					$('#list_data').datagrid('clearSelections');
				}
			});
	    } else {
			showMessage("提示","没有有效的校区可供查询",null);
		}
    });
	
     //首页面重置
    $("#resetBtn").click(function() 
    {
    	$("#qryFm").form('clear');//清空窗体数据  
    	//校区赋默认值
    	if($("#schoolId").combobox("getData").length>0){
    		$("#schoolId").combobox("select",$("#schoolId").combobox("getData")[0].schoolId);
    	}
    });
    
    $("#deleteLicense").click(function()
	{
	deleteLicense();
    	
	});
    
    var staffId = $("#staffId").val();
	$("#schoolId").combobox({
		url : "/sys/pub/pageCategory.do?staffId="+staffId+"&resourceId=506&fieldId=schoolId&headFlag=N",//返回json数据的url 
		valueField : "schoolId",
		textField : "schoolName",
		panelHeight : "auto",
		formatter : formatSchool,
		onLoadSuccess : function(data) {
			$("#schoolId").combobox('setValue',data[0].schoolId);
		},
		onChange : function(n, o) {
			if(n != "" && n != null && n != undefined) {
//				$("#byName").combobox({disabled: false});
				$("#teacherId").combobox({
					url : "/sys/pubData/qryTeacherList.do?schoolId="+n,//返回json数据的url
					valueField : "teacherId",
					textField : "byname",
					panelHeight : "auto",
					formatter : function(data) {
						return "<span>" + data.byname + "</span>";
					}
				});
			} else {
				$("#schoolId").combobox("setText", "");
				$("#teacherId").combobox('clear');
				$("#teacherId").combobox("loadData", new Array());
//				$("#byName").combobox({disabled: true});
			}
		}
	});
    
});

function deleteLicense()
{
	if(validateSelect("list_data"))
	{
		var row = $("#list_data").datagrid('getSelected');
		var licenseId=row.licenseId;
		$.messager.confirm('提示','您确定要删除当前选中持证吗?',function(r) {
    			if(r)
    			{
    				var obj ={};
					obj.licenseId=row.licenseId;
					obj.staffId=$("#staffId").val();
					var str=JSON.stringify(obj);
					$.ajax( {
						url : "/sys/licenseManage/delLicense.do",
						data : "param=" + str,
						dataType : "json",
						async : true,
						success : function(data)
						{
						 if(data.flag=='true');//学员已有课程
						 {
							 showMessage("提示","删除持证成功",null);
						 }
						} 
					});
    			}
    		});
		
	}
}

function validateSelect(object)
{
	var flag = false;
	var obj = $("#"+object+"").datagrid('getSelections');
	if(obj.length > 0) {
		if(obj.length > 1) {
			$.messager.alert('提示', "只能选择一个教师进行操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择您要操作的教师！");
	}
	return flag;
}
</script>