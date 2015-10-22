<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!doctype html>
<html>
	<head>
		<title>例子1</title>
		<%@ include file="common/head.jsp" %>
		<%@ include file="common/formvalidator.jsp" %>
		 
		<div id="dlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveExample()">保存</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
		</div>
	</body>
</html>
<script type="text/javascript">
  		$.ajax({
    			url: "/sys/student/validate.do",
    			data: "param=" + obj,
    			dataType: "json",
    			async: false,
    			beforeSend: function()
    	    	{
    	    		$.messager.progress({title : '验重', msg : '正在验重，请稍等……'});
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
</script>