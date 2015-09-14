<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		<link href="<%=path %>/pub/css/admin.css" rel="stylesheet" type="text/css"/>
	</head>
	<body class="easyui-layout">
		<c:if test="${empty sessionScope.StaffT}">
			<c:redirect url="login.jsp" />
		</c:if>
		<!-- 头部 -->
		<div id="toparea" style="display:block;" data-options="region:'north',border:false,height:125">
			<div id="topmenu" class="easyui-panel" data-options="fit:true,border:false">
				<a class="logo"></a>
				<!-- 
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
				 -->
				<div class="nav-right">
					<a href="javascript:logout();" class="easyui-linkbutton" data-options="plain:true,iconCls:'logout',size:'large',iconAlign:'top'">退出</a>
			    </div>
			</div>
			<div class="panel-header panel-header-noborder top-toolbar" style="position:absolute;bottom:0px;border-top-width:1px;border-bottom-width:0px;z-index:1;display:none;">
				<div id="infobar">
		            <span style="background-position: left; padding-left: 25px;background-image:url(<%=path %>/pub/images/user_business_boss.png);background-repeat:no-repeat;">
		            	您好 <b id="curname">${sessionScope.StaffT.staffName}</b>
		            </span>
		        </div>
			</div>
		</div>

		<!-- 左侧菜单 -->
		<div id="leftarea" data-options="iconCls:'icons-other-house',region:'west',title:'加载中...',split:true,width:200">
			<div id="leftmenu" class="easyui-accordion" data-options="fit:true,border:false"></div>
		</div>

		<!-- 内容 -->
		<div id="mainarea" data-options="region:'center'" style="padding: 0px;background:#E0ECFF;min-width:800px">
			<div class="easyui-layout" data-options="fit:true,border:false,plain:false">
				<div data-options="region:'north',height:28" style="min-width:800px;background:#E0ECFF">
					<c:forEach items="${sessionScope.funcNodeInfo}" var="funcNodeTree" varStatus="i">
						<a href="#" id="mb${i.count}" class="easyui-menubutton" data-options="menu:'#mm${i.count}'">${funcNodeTree.funcNodeObj.funcNodeName}</a>
			     		<div id="mm${i.count}" style="width:150px;background:#EDF7FF">
			     			<c:forEach items="${funcNodeTree.funcNodeList}" var="obj" varStatus="j">
			     				<div id="${obj.funcNodeId}">${obj.funcNodeName}</div>
			     			</c:forEach>
			     		</div>
			     		<script language="javascript">
			     			var ddlMenu${i.count} = $('#mb${i.count}').menubutton({menu:'#mm${i.count}'}); 
							$(ddlMenu${i.count}.menubutton('options').menu).menu({
            					onClick: function (item){
                					getLeft(item.id, '导航菜单');
            					}
							});
			     		</script>
					</c:forEach>
	     		</div>
	     		<div data-options="region:'center'">
					<div id="pagetabs" class="easyui-tabs" data-options="tabPosition:'top',fit:true,border:false,plain:false">
						<div title="后台首页" href="main.jsp" data-options="cache:false"></div>
					</div>
	     		</div>
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
			$(function(){
				getLeft(${sessionScope.funcNodeInfo[0].funcNodeList[0].funcNodeId}, '导航菜单');
				$(document).bind('contextmenu',function(e){
					e.preventDefault();
					$('#rightmenu').menu('show', {
						left: e.pageX,
						top: e.pageY
					});
				});
				$.messager.show({			
					title:'登录提示',
					msg:'您好！${sessionScope.StaffT.staffName} 欢迎回来！<br/>最后登录时间：<fmt:formatDate value="${sessionScope.StaffT.lastDate}" pattern="yyyy-MM-dd HH:mm:ss" /><br/>最后登录IP：${sessionScope.StaffT.remoteIp}',
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
				//if(title == options.title) return false;
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
				if($('#pagetabs').tabs('exists', title)){
					$('#pagetabs').tabs('select', title);
					var current_tab = $('#pagetabs').tabs('getSelected');
					$('#pagetabs').tabs('update', {
						tab:current_tab,
						options : {
							content : '<iframe name="'+title+' "src="'+url+'" width="100%" height="97%" frameborder="0" scrolling="auto" style="margin-bottom:10px"></iframe>'
						}
					});
				}else{
					$('#pagetabs').tabs('add',{
						title: title,
						//href: url,
						closable: true,
						cache: false,
						content : '<iframe name="'+title+' "src="'+url+'" width="100%" height="97%" frameborder="0" scrolling="auto" style="margin-bottom:10px"></iframe>'
					});
				}
			}
		</script>
	</body>
</html>
