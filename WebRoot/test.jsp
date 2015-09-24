<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!doctype html>
<html>
	<head>
		<title>例子</title>
		<%@ include file="common/head.jsp" %>
		<%@ include file="common/formvalidator.jsp" %>
	</head>
	<body>
		<h2>Multiple Accordion Panels</h2>
	<p>Enable 'multiple' mode to expand multiple panels at one time.</p>
	<div style="margin:20px 0 10px 0;"></div>
	<div class="easyui-accordion" data-options="multiple:true" style="width:500px;height1:300px;">
		<div title="Language" data-options="iconCls:'icon-ok'" style="overflow:auto;padding:10px;">
			<p>A programming language is a formal language designed to communicate instructions to a machine, particularly a computer. Programming languages can be used to create programs that control the behavior of a machine and/or to express algorithms precisely.</p>
		</div>
		<div title="Java" style="padding:10px;position:relative">
			<div style="position:absolute;top:-10px;z-index:9999;"><input type="checkbox"></div>
			<p>Java (Indonesian: Jawa) is an island of Indonesia. With a population of 135 million (excluding the 3.6 million on the island of Madura which is administered as part of the provinces of Java), Java is the world's most populous island, and one of the most densely populated places in the world.</p>
		</div>
		<div title="C#" style="padding:10px;">
			<p>C# is a multi-paradigm programming language encompassing strong typing, imperative, declarative, functional, generic, object-oriented (class-based), and component-oriented programming disciplines.</p>
		</div>
		<div title="Ruby" style="padding:10px;">
			<p>A dynamic, reflective, general-purpose object-oriented programming language.</p>
		</div>
		<div title="Fortran" style="padding:10px;">
			<p>Fortran (previously FORTRAN) is a general-purpose, imperative programming language that is especially suited to numeric computation and scientific computing.</p>
		</div>
	</div>
	</body>
</html>		