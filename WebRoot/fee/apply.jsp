<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
    String processInstId=request.getParameter("processInstId");
    String approveId=request.getParameter("approveId");
%>
<!doctype html>
<html>
	<head>
		<title>例子1</title>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		 
		<body>
		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="学员基础信息">
			<form id="studentFm">
	      		<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
	      		<input type="hidden" id="schoolId" name="schoolId" value="${sessionScope.StaffT.schoolId}"/>
	      		<table width="100%" cellpadding="5px" class="maintable" id="addStudentTd">
	      			<tr>
	      				<td align="right"><span style="color: red;">*</span><span>学员姓名：</span></td>
	      				<td>
	      					<input name="name" id="name" type="text" class="easyui-textbox validatebox" required="true" style="width: 200px; height: 28px;"/>
	      				</td>
	      				<td align="right"><span>在读班级：</span></td>
	      				<td colspan="2">
	      					 <span>K</span>
	      				</td>
	      			</tr>
	      			<tr>
	      				<td align="right">&nbsp;</td>
	      				<td>&nbsp;</td>
	      				<td align="right">&nbsp;</td>
	      				<td colspan="2">&nbsp;</td>
	      			</tr>
	      			 
	      			<tr>
	      				<td align="right"><span>学员备注：</span></td>
	      				<td colspan="4">
	      					<input id="remark" name="remark" type="text" class="easyui-textbox" style="width: 969px; height: 28px;"/>
	      				</td>
	      			</tr>
	      		</table>
	      	</form>
	    </div>
      	<div style="height: 10px;"></div>
      		
      	<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: left;margin-left: 800px;">
	      		<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      		<a href="javascript:void(0)" id="agree" onclick="approveRefundFee('Y')" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">同意</a>
	      		<a href="javascript:void(0)" id="disagree"  onclick="approveRefundFee('N')" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">不同意</a>
	      		&nbsp;<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onClick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
  	</body>
</html>
<script type="text/javascript">
  		
	$("#submit").click(function()
	{
		$.ajax({
    			url: "/sys/fee/apply.do",
    			data: "param=" + "",
    			dataType: "json",
    			async: false,
    			beforeSend: function()
    	    	{
    	    		 
    	    	},
    	    	success: function (data) {
    	    		var flag = data.flag
    	            if(flag) 
    	            {
    	            	//$.messager.alert('提示', "该学员暂未注册，资料有效！");
    	            } else
    	            {
    	            	isExists = true;
    	            	//$.messager.alert('提示', data.msg);
    	            }
    	    		$.messager.progress('close'); 
    	    		validateFlag = true;
    	        } 
    		});
	});
	
      
	function approveRefundFee(flag)
	{
		var approve={};
		approve.processInstId="<%=processInstId%>";
		approve.approveId="<%=approveId%>";
		approve.approveResult="批准";
		
		$.ajax({
    			url: "/sys/fee/approve.do?",
    			data: "param=" +JSON.stringify(approve),
    			dataType: "json",
    			async: false,
    			beforeSend: function()
    	    	{
    	    		 
    	    	},
    	    	success: function (data) {
    	    		var flag = data.flag
    	            if(flag) {
    	            	$.messager.alert('提示', "该学员暂未注册，资料有效！");
    	            } else {
    	            	isExists = true;
    	            	$.messager.alert('提示', data.msg);
    	            }
    	    		$.messager.progress('close'); 
    	    		validateFlag = true;
    	        } 
    		});
	}
	
</script>