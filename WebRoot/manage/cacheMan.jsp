<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.rise.pub.pubData.PubData" %>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript">
			function flushAllCache(){
				$.messager.confirm('提示','您确定要刷新全部缓存吗?',function(r){
					if (r){
						$.post('/sys/cache/flushAllCache.do',{},function(result){
							if(result == "success")
							{
								$("#manList").datagrid("reload");
								$.messager.alert('提示',"刷新成功");
							}
							else
							{
								$.messager.alert('提示', result);
							}
						});
					}
				});
			}
			function flushCache(){
				var row = $('#manList').datagrid('getSelected');
				if (row)
				{
					$.messager.confirm('提示','您确定要刷新选定缓存吗?',function(r){
						if (r){
							$.post('/sys/cache/flushCache.do',{cacheName:row.cacheName},function(result){
								if(result == "success")
								{
									$("#manList").datagrid("reload");
									$.messager.alert('提示',"刷新成功");
								}
								else
								{
									$.messager.alert('提示', result);
								}
							});
						}
					});
				}
				else
				{
					$.messager.alert('提示',"请先选择要刷新的缓存");
				}
			}
		</script>
	</head>
	<body class="easyui-layout userRoleMan">
		<table class="easyui-datagrid" title="查询结果" id="manList" url="/sys/cache/sysCacheList.do" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="cacheName" width="33%">缓存名称</th>
					<th field="cacheDesc" width="33%">缓存描述</th>
					<th field="cacheDate" width="33%">刷新时间</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" id="flushAllCacheBtn" onclick="flushAllCache()" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px;">刷新全部缓存</a>
   			<a href="javascript:void(0)" id="flushCacheBtn" onclick="flushCache()" class="easyui-linkbutton" iconCls="icon-edit" style="width: 120px;">刷新选定缓存</a>
		</div>
	</body>
</html>