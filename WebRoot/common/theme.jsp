<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String themePath = request.getContextPath();
%>
<link rel="stylesheet" type="text/css" href="<%=themePath %>/pub/css/icons.css" />
<link rel="stylesheet" type="text/css" href="<%=themePath %>/pub/js/easyui/themes/default/easyui.css" title="default" />
<link rel="stylesheet" type="text/css" href="<%=themePath %>/pub/js/easyui/themes/gray/easyui.css" title="gray" />
<link rel="stylesheet" type="text/css" href="<%=themePath %>/pub/js/easyui/themes/bootstrap/easyui.css" title="bootstrap" />
<link rel="stylesheet" type="text/css" href="<%=themePath %>/pub/js/easyui/themes/metro/easyui.css" title="metro" />
<link rel="stylesheet" type="text/css" href="<%=themePath %>/pub/css/default.css" title="default" />
<link rel="stylesheet" type="text/css" href="<%=themePath %>/pub/css/gray.css" title="gray" />
<link rel="stylesheet" type="text/css" href="<%=themePath %>/pub/css/bootstrap.css" title="bootstrap" />
<link rel="stylesheet" type="text/css" href="<%=themePath %>/pub/css/metro.css" title="metro" />
<script type="text/javascript">
var theme = $.cookie('theme') || 'bootstrap';	//全局变量
$(document).ready(function(){
	$('link[rel*=style][title]').each(function(i){
		this.disabled = true;
		if (this.getAttribute('title') == theme) this.disabled = false;
	});
});
</script>