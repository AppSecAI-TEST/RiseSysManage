<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<!-- 
		<title>瑞思教务管理系统</title>
		 -->
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
	</head>
	<body class="easyui-layout">
		<c:if test="${empty sessionScope.UserInfo}">
			<c:redirect url="/login.jsp" />
		</c:if>
		<!-- 头部 -->
		<div id="toparea" data-options="region:'north',border:false,height:125">
			<div id="topmenu" class="easyui-panel" data-options="fit:true,border:false">
				<a class="logo"></a>
				<ul class="nav">
					<c:forEach items="${menuList}" var="node">
						<li>
							<c:choose>
								<c:when test="${node.menuId == 1}">
									<a class="focus" href="javascript:void(0);" onclick="getLeft(${node.menuId},'${node.menuName}', this)">${node.menuName}</a>
								</c:when>
								<c:otherwise>
									<a href="javascript:void(0);" onclick="getLeft(${node.menuId},'${node.menuName}', this)">${node.menuName}</a>
								</c:otherwise>
							</c:choose>
						</li>
					</c:forEach>
				</ul>
				<div class="nav-right">
					<a href="javascript:logout();" class="easyui-linkbutton" data-options="plain:true,iconCls:'logout',size:'large',iconAlign:'top'">退出</a>
			    </div>
			</div>
			<div class="panel-header panel-header-noborder top-toolbar" style="position:absolute;bottom:0px;border-top-width:1px;border-bottom-width:0px">
				<div id="infobar">
		            <span style="background-position: left; padding-left: 25px;background-image:url(<%=path %>/pub/images/user_business_boss.png);background-repeat:no-repeat;">
		            	您好 <b id="curname">${sessionScope.UserInfo.realName}</b>
		            </span>
		        </div>
			</div>
		</div>

		<!-- 左侧菜单 -->
		<div id="leftarea" data-options="iconCls:'icons-other-house',region:'west',title:'加载中...',split:true,width:320">
			<div id="leftmenu" class="easyui-accordion" data-options="fit:true,border:false"></div>
		</div>

		<!-- 内容 -->
		<div id="mainarea" data-options="region:'center'" style="padding: 0px; background: #E0ECFF;">
			<a href="#" id="mb1" class="easyui-menubutton" data-options="menu:'#mm1'">教务管理</a>
     		<a href="#" id="mb" class="easyui-menubutton" data-options="menu:'#mm'">销售管理</a>
     		<a href="#" id="mb2" class="easyui-menubutton" data-options="menu:'#mm2'">报表管理</a>
    		<a href="#" id="mb3" class="easyui-menubutton" data-options="menu:'#mm3'">系统管理</a>
    		<div id="mm" style="width:150px;background: #EDF7FF">
	           <div >客户管理</div>
	           <div >客户跟踪</div>
    		</div>
     		<div id="mm1" style="width:150px;background: #EDF7FF">
	           <div >学员管理</div>
	           <div >班级管理</div>
	           <div >异动管理</div>
	           <div >教师管理</div>
	           <div >资源管理</div>
	           <div >教质管理</div>
     		</div>
     		<div id="mm2" style="width:150px;background: #EDF7FF">
	           <div >教务报表</div>
	           <div >销售报表</div>
	           <div >财务报表</div>
     		</div>
     		<div id="mm3" style="width:150px;background: #EDF7FF">
	           <div >用户管理</div>
	           <div >角色管理</div>
	           <div >配置管理</div>
	           <div >日志管理</div>
     		</div>	
			<div id="pagetabs" class="easyui-tabs" data-options="tabPosition:'top',fit:true,border:false,plain:false">
				<div title="后台首页" href="main.jsp" data-options="cache:false"></div>
			</div>
		</div>

		<!-- 右键菜单 -->
		<div id="rightmenu" class="easyui-menu"
			data-options="onClick:rightMenuHandler">
			<div
				data-options="name:'home',iconCls:'icons-application-application_home'">
				访问前台
			</div>
			<div class="menu-sep"></div>
			<div data-options="name:'exit'">
				退出登录
			</div>
		</div>

		<script type="text/javascript">
			var gMenuArr = [];
			var gClassObj = null;
			$(function(){
				getLeft(1, '导航菜单');
				$(document).bind('contextmenu',function(e){
					e.preventDefault();
					$('#rightmenu').menu('show', {
						left: e.pageX,
						top: e.pageY
					});
				});
				$.messager.show({			
					title:'登录提示',
					msg:'您好！${sessionScope.UserInfo.realName} 欢迎回来！<br/>最后登录时间：${sessionScope.UserInfo.lastDate}<br/>最后登录IP：${sessionScope.UserInfo.userIp}',
					timeout:5000,
					showType:'slide'
				});
			});
			
			function rightMenuHandler(item){
			
				if(!item.name) return;
				switch(item.name){
					case 'home':
						window.open('admin.jsp');
						break;
					case 'refresh': //刷新后台
						window.location.href = window.location.href;
						break;
					case 'exit': //退出登录
						logout();
						break;
				}
			
			}
			
			function logout(){
				$.messager.confirm('提示信息', '确定要退出登录吗？', function(result){
					if(result) window.location.href = '/sys/auth.do?method=logout';
				});
			}
			
			function getLeft(menuId, title, that){
				var options = $('body').layout('panel', 'west').panel('options');
				if(title == options.title) return false;
				if(gMenuArr[menuId-1] != null)
				{
					removeLeft();
					$('body').layout('panel', 'west').panel({title: title});
					var loading = '<div class="panel-loading">Loading...</div>';
					$("#leftmenu").accordion("add", {content: loading});
					removeLeft();
					menuFunc(gMenuArr[menuId-1]);
				}
				else
				{
					$.ajax({
						type: 'POST',
						url: '/sys/auth.do?method=menuLeft',
						data: {menuId: menuId},
						cache: false,
						beforeSend: function(){
							removeLeft();
							$('body').layout('panel', 'west').panel({title: title});
							var loading = '<div class="panel-loading">Loading...</div>';
							$("#leftmenu").accordion("add", {content: loading});
						},
						dataType: "json",
						success: function(data){
							removeLeft();
							gMenuArr.push(data);
							menuFunc(data)
						}
					});
				}
				if(that){
					$('#topmenu .nav li').each(function(){
						$(this).children().removeClass('focus');
					})
					$(that).addClass('focus');
				}
			}
			
			function menuFunc(data)
			{
				$.each(data, function(i, menu) {
					var content = '';
					if(menu.son){
						var treedata = $.toJSON(menu.son);
						content = '<ul class="easyui-tree" data-options=\'data:' + treedata + ',animate:true,lines:true,onClick:function(node){openUrl(node.url, node.text)}\'></ul>';
					}
					$("#leftmenu").accordion("add", {title: menu.name, content: content, iconCls:'icons-folder-folder_go'});
				});
			}
			
			function removeLeft(stop){
				var pp = $("#leftmenu").accordion("panels");
				$.each(pp, function(i, n) {
					if(n){
						var t = n.panel("options").title;
						$("#leftmenu").accordion("remove", t);
					}
			    });
				var pp = $('#leftmenu').accordion('getSelected');
			    if(pp) {
			        var t = pp.panel('options').title;
			        $('#leftmenu').accordion('remove', t);
			    }
			    if(!stop) removeLeft(true)
			}
			
			function openUrl(url , title)
			{
				if(gClassObj != null)
				{
					var tabObj = $('#pagetabs').tabs('getTab',gClassObj);
					$('#pagetabs').tabs('update',{
						tab:tabObj,
						options:{
							title: title,
							content : '<iframe name="'+title+' "src="'+url+'" width="100%" height="100%" frameborder="0" scrolling="auto" ></iframe>'
						}
					});
				}
				else
				{
					$('#pagetabs').tabs('add',{
						title: title,
						//href: url,
						closable: true,
						cache: false,
						content : '<iframe name="'+title+' "src="'+url+'" width="100%" height="100%" frameborder="0" scrolling="auto" ></iframe>'
					});
				}
				gClassObj = title;
			}
		</script>
	</body>
</html>
