<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title>出错了</title>
    <style type="text/css">
    	body{
    		margin:0 auto;
    		padding:0 0;
    	}
    	#errorTitle{
    		margin:0 auto;
    		padding:0 0;
    		background-image: url('../pub/img/wrong_img.png');
    		width:300px;
    		height:153px;
    		text-align:center;
    	}
    	
    	#errorContent{
    		text-align:center;
    		font-family:"微软雅黑";
    	}
    </style>
	<script language="javascript">
		function showErrors() 
		{
			var err_el = document.getElementById('errors');
			if (err_el.style.display == 'none')
				 {
				err_el.style.display = '';
			} else {
				err_el.style.display = 'none';
			}
		}
			
	</script>
  </head>
  
  <body>
  	<div id="errorTitle">
  		&nbsp;
  	</div>
	<div id="errorContent">
		处理失败，您可以
		<a href="javascript:showErrors();">查看详情</a>
		<div style="display: none;" id="errors">
			<c:set var="result" value=""/>
			<c:choose>
				<c:when test="${empty exception.message && empty exception.cause}">
					<c:set var="result" value="系统内部问题具体请联系系统管理人员!" />
				</c:when>
				<c:when test="${empty exception.message}">
					<c:set var="result" value="${exception.cause}" />
				</c:when>
				<c:otherwise>
					<c:set var="result" value="${exception.message}" />
				</c:otherwise>
			</c:choose>
			<textarea cols="50" rows="10" style="text-align:left;vertical-align:top;color:#ff0000"><c:out value="${result}" /></textarea>
		</div>
	</div>
  </body>
</html>
