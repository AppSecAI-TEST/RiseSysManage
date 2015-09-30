<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!doctype html>
<html>
	<head>
		<title>例子</title>
		<%@ include file="common/head.jsp"%>
		<%@ include file="common/formvalidator.jsp"%>
</script>
	</head>
	<body>
		<select name="courseTypeName" data-options="onChange:changeCourseType"
			class="easyui-combobox" id="courseTypeName"
			style="width: 150px; height: 28px;">
			<option value="normal">
				常规课
			</option>
			<option value="short">
				短期课
			</option>
		</select>
	</body>
</html>
<script>
function changeCourseType() {
	alert(123)
};
</script>