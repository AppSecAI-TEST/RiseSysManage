<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<style>
			a{cursor:pointer;}
		</style>
  	</head>
  	<body>
  		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<div style="margin-right:5px">
 		<form id="qryFm">
  			<table class="search_tab">
  				<tr>
  					<td width="80px" align="right"><span>文件名称：</span></td>
  					<td width="110px">
  						<input class="easyui-textbox" id="fileName" name="fileName" style="width:200px;height:25px">
  					</td>
  					<td align="left">
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:100px" id="qryBtn" funcNodeId="3750"><span>查询</span></a>
  					</td>
  				</tr>
  			</table>
  		</form>	
 		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:400" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="rownum" align="center" width="5%"><span>序号</span></th>
					<th field="fileName" align="center" width="30%"><span>文件名称</span></th>
					<th field="creator" align="center" width="20%"><span>上传人</span></th>
					<th field="createDate" align="center" width="15%"><span>上传时间</span></th>
					<th field="operate" align="center" width="30%"><span>操作</span></th>
				</tr>		
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
			  <form id="uploadFm" method="post" enctype="multipart/form-data">
	   			 <input style="width: 500px; height: 28px;" class="easyui-filebox" name="fileNames" id="fileNames" data-options="prompt:''"/>
	             <a href="javascript:void(0)" class="easyui-linkbutton" id="uploadBtn" iconCls="icon-save" iconCls="icon-save" style="width: 100px; height: 25px;"><span>上传</span></a>
	             <a href="javascript:void(0)" class="easyui-linkbutton" id="cancelUploadBtn" iconCls="icon-cancel" iconCls="icon-cancel" style="width: 100px; height: 25px;"><span>取消</span></a>
 			 </form>	
 		</div>
 		</div>
  	</body>
</html>
<script type="text/javascript">
var downloadFrame;
$(document).ready(function(){
	$("#qryBtn").click(function() {
		initPageNumber("list_data");
		var obj = JSON.stringify($("#qryFm").serializeObject());
    	obj = obj.substring(0, obj.length - 1);
    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
    	$('#list_data').datagrid({
    		url : "/sys/pubData/qryDataListByPage.do",
    		queryParams:{
    			param : obj
    		}    	
    	});
    });
	//上传
    $("#uploadBtn").click(function() {
    	var fileName = $("#fileNames").filebox("getValue");
    	if(fileName != "" && fileName != null && fileName != undefined) 
    	{
    		var handlerId = $("#handlerId").val();
    		$("#uploadFm").form("submit", {
    			url: "/sys/fileUpload?type=upload&schoolId=&handlerId="+handlerId,
    			onSubmit: function () {
    				
    			},
    			success: function (result) {
    				var data = JSON.parse(result);
    				if(data.flag)
    				{
    					$.messager.alert('提示', "文件上传成功！", "info", function() {$("#qryBtn").trigger("click");});
    				}
    				else
    				{
    					$.messager.alert('提示', data.msg);
    				}
    			}
    		});
    	} 
    	else 
    	{
    		$.messager.alert('提示', "请您先选择一个文件！");
    	}
    });
    
    //取消上传
    $("#cancelUploadBtn").click(function() {
    	var fileName = $("#fileNames").filebox("setValue", "");
    });
})


function downloadFile(val)
{
	document.body.innerHTML += "<iframe id='downloadFrame' style='display:none' width=0 height=0 />"
	downloadFrame = document.getElementById("downloadFrame");
	downloadFrame.src = "/sys/pub/downloadFile.do?fileId="+val;
}

function deleteFile(val)
{
	$.ajax({
		type : "POST",
		url: "/sys/pub/deleteFile.do",
		data: "fileId="+val,
		async: false,
		success: function(data) 
		{
			if(data == "true")
			{
				parent.showMessage("提示","删除文件成功",function(){
					parent.hideMessage();
					$("#qryBtn").trigger("click");
				});
			}
			else 
			{
				parent.showMessage("提示","删除文件失败",function(){
					parent.hideMessage();
				});   
			}
		} 
	});
}
</script>