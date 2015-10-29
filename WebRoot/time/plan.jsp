<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<%@ include file="../common/pub.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/student/student.js"></script>
  	</head>
  
  	<body>
		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
		<form id="qryFm" style="margin:0 auto;">
			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:30px;" cellspacing="2">
				<tr>
					<td align="right">
						<span>校区：</span>
					</td>
					<td align="right">
						<span>创建月份：</span>
					</td>
					<td width="8px">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTime" name="startTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center" width="14px;">
						<span>至</span>
					</td>
					<td width="90px">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTime" name="endTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center" colspan="2">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1000">查询</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
					</td>
				</tr>
			</table>
		</form>
		<div style="padding:5px 0;min-width:1100px; width:100%;">
			<table class="easyui-datagrid" title="排课列表" style="height:435px;" id="list_data"   
				toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false">
				 
			</table>
		</div>
		<div id="toolbar" style="padding: 2px; height: auto">
   			<a href="javascript:void(0)" id="createPlan" href="" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">创建排课</a>
   			<a href="javascript:void(0)" id="updateStudent" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;" funcNodeId="1002">维护排课</a>
   			<a href="javascript:void(0)" id="viewStudent" class="easyui-linkbutton" iconCls="icon-redo" style="width: 100px;">浏览排课</a>
		</div>
  		<div id="dlgBtn">
    		<a href="javascript:void(0)" id="batchUpdateSubmit" class="easyui-linkbutton" iconCls="icon-ok">提交</a> 
    		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
  		</div>
 	</body>
</html>
<<script type="text/javascript">
    
    $("#createPlan").click(function() {
    	 
    		window.location.href = "/sys/time/createPlan.jsp";
    	}
    );

</script>
