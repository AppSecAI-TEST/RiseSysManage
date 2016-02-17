<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="accessPath" value="<%=request.getServletPath() %>" />
<c:if test="${accessPath != '/login.jsp' && accessPath != '/admin.jsp'}">
	<script type="text/javascript">
		$(document).ready(function(){
			new gPrivCtrl('${sessionScope.StaffT.staffId}','${param.funcNodeId}',"");
		});
	</script>
</c:if>