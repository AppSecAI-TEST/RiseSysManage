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
		<title>瑞思教务管理系统</title>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
	</head>
	<body class="easyui-layout">
		<c:if test="${empty sessionScope.StaffT}">
			<c:redirect url="login.jsp" />
		</c:if>
		<!-- 头部 -->
		<div id="toparea" style="display:block;" data-options="region:'north',border:false,height:109">
			<div id="topmenu" class="easyui-panel" data-options="fit:true,border:false" style="height:79px;">
				<img src="<%=path %>/pub/images/adm_logo.png" style="width:100%;height:79px;position:relative;border:none;">
				<img onclick="updatePassword()" src="<%=path %>/pub/images/adm_menu1.png" style="right:230px;top:16px;position:absolute;cursor:pointer;">
				<img src="<%=path %>/pub/images/adm_menu2.png" style="right:180px;top:16px;position:absolute;cursor:pointer;">
				<img onclick="viewFile()" src="<%=path %>/pub/images/adm_menu3.png" style="right:100px;top:16px;position:absolute;cursor:pointer;">
				<img onclick="logout()" src="<%=path %>/pub/images/adm_menu4.png" style="right:50px;top:16px;position:absolute;cursor:pointer;">
			</div>
			<div class="panel-header panel-header-noborder top-toolbar" style="position:absolute;bottom:0px;border-top-width:1px;border-bottom-width:0px;z-index:1;display:none;">
				<div id="infobar">
		            <span style="background-position: left; padding-left: 25px;background-image:url(<%=path %>/pub/images/user_business_boss.png);background-repeat:no-repeat;">
		            	您好 <b id="curname">${sessionScope.StaffT.userName}</b>
		            </span>
		        </div>
			</div>
		</div>
		<iframe id="fileDlg" class="easyui-dialog" style="width:1150px;height:600px;" modal="true" closed="true"></iframe>
		<div id="dlg" class="easyui-dialog dlgCls" style="width:0px;height:0px;padding:0px 0px" modal="true" closed="true" buttons="#buttons">
			<form id='form' method="post">
				<input id="staffId" type="hidden" name="staffId" value="${sessionScope.StaffT.staffId}" />
				<table width="98%" style="margin:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
					<tr>
						<td align="right">*旧密码:</td>
						<td align="left"><input name="oldPassword" id="oldPassword" type="password" style="width:246px" validType="length[4,20]" missingMessage="请输入旧密码" class="easyui-textbox easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td align="right">*新密码:</td>
						<td align="left"><input name="password" id="password" type="password" style="width:246px" validType="length[4,20]" missingMessage="请输入新密码" class="easyui-textbox easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td align="right">*确认新密码：</td>
						<td align="left"><input name="confirm" id="confirm" type="password" style="width:246px" validType="equalTo['#password']" missingMessage="请确认新密码" invalidMessage="两次输入密码不匹配" class="easyui-textbox easyui-validatebox" required="true" /></td>
					</tr>
				</table>
			</form>
		</div>
		<div id="buttons" class="buttonsCls">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="updatePasswordSubmit()">提交</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="cancelUpdatePassword()">取消</a>
		</div>
		<!-- 左侧菜单 -->
		<div id="leftarea" class="leftareaCls" data-options="iconCls:'icons-other-house',region:'west',title:'加载中...',split:true,width:200">
			<div id="leftmenu" class="easyui-accordion" data-options="fit:true,border:false"></div>
		</div>
		<!-- 内容 -->
		<div id="mainarea" class="mainareaCls" data-options="region:'center'" style="padding: 0px;background:#E0ECFF;min-width:800px">
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
		<script type="text/javascript">
			var gMenuArr = [];
			var MenuInfo = function(menuId , menuData){
				this.menuId = menuId;
				this.menuData = menuData;
			};
			$(function(){
				getLeft(${sessionScope.funcNodeInfo[0].funcNodeList[0].funcNodeId}, '导航菜单');
				$("#dlg").removeClass("dlgCls");
				$("#buttons").removeClass("buttonsCls");
				$("#leftarea").removeClass("leftareaCls");
				$("#mainarea").removeClass("mainareaCls");
				$.messager.show({			
					title:'登录提示',
					msg:'您好！${sessionScope.StaffT.userName} 欢迎回来！<br/>最后登录时间：<fmt:formatDate value="${sessionScope.StaffT.lastDate}" pattern="yyyy-MM-dd HH:mm:ss" /><br/>最后登录IP：${sessionScope.StaffT.remoteIp}',
					timeout:5000,
					showType:'slide'
				});
			});
			function logout(){
				$.messager.confirm('提示信息', '确定要退出登录吗？', function(result){
					if(result) window.location.href = '/sys/auth.do?method=logout';
				});
			}
			function updatePassword(){
				$('#dlg').dialog({
					width:"380px",
					height:"180px"
				})
				$('#dlg').dialog('open').dialog('setTitle','修改密码');
			}
			function updatePasswordSubmit(){
				if($("#form").form('validate')){
					var staffId = $("#staffId").val();
					var oldPassword = $("#oldPassword").textbox("getValue");
					var newPassword = $("#password").textbox("getValue");
					$.ajax({
						type : "POST",
						url: "/sys/staff/updatePassword.do",
						data: "staffId="+staffId+"&oldPassword="+oldPassword+"&newPassword="+newPassword,
						async: false,
						beforeSend: function()
				    	{
				    		$.messager.progress({title : '修改密码', msg : '修改密码中，请稍等……'});
				    	},
				    	success: function(data) {
				    		$.messager.progress('close'); 
				    		if(data == "success"){
				    			$.messager.alert('提示', "修改密码成功！","info",function(){
					    			window.location.href = "/sys/login.jsp";
								});
				    		}else {
				    			$.messager.alert('提示', data);
				    		}
				        } 
					});
				}
			}
			function cancelUpdatePassword(){
				$("#oldPassword").textbox("setValue","");
				$("#password").textbox("setValue","");
				$("#confirm").textbox("setValue","");
				$('#dlg').dialog('close');
			}
			function getLeft(menuId, title, that){
				var options = $('body').layout('panel', 'west').panel('options');
				//if(title == options.title) return false;
				var menuObj = getMenuArr(menuId);
				if(menuObj != null)
				{
					removeLeft();
					$('body').layout('panel', 'west').panel({title: title});
					var loading = '<div class="panel-loading">加载中...</div>';
					$("#leftmenu").accordion("add", {content: loading});
					removeLeft();
					menuFunc(menuObj);
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
							var loading = '<div class="panel-loading">加载中...</div>';
							$("#leftmenu").accordion("add", {content: loading});
						},
						success: function(data){
							removeLeft();
							if(data != "timeout")
							{
								try{
									data = eval("("+data+")"); 
								}catch(e){
									$.messager.alert('提示', '系统有误,请联系管理员!', 'error',function(){
										window.location.href = "/sys/login.jsp";
									});
								}
							}
							else
							{
								window.location.href = "/sys/login.jsp";
							}
							var dataObj = new MenuInfo(menuId , data); 
							gMenuArr.push(dataObj);
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
			function getMenuArr(valId)
			{
				for(var i = 0,n = gMenuArr.length;i < n;i++)
				{
					var menuObj = gMenuArr[i];
					if(parseInt(menuObj.menuId) == parseInt(valId))
					{
						return menuObj.menuData;
					}
				}
				return null;
			}
			function menuFunc(data)
			{
				for(var i = 0,n = data.length;i < n;i++)
				{
					var arr = [];
					arr.push('<ul class="easyui-tree" data-options=\'animate:true,lines:true,state:closed\'>');
					for(var j = 0,m = data[i].son.length;j < m;j++)
					{
						if(data[i].son[j].url != "#")
						{
							arr.push('<li><span><a href="javascript:void(0)" class="tree-hit txtNode" style="background-image:url();display:block;width:250px" onclick=openUrl("'+data[i].son[j].id+'","'+data[i].son[j].url+'","'+data[i].son[j].text+'")>'+data[i].son[j].text+'</a></span></li>');
						}
						else
						{
							var k = 0,t = data[i].son[j].items.length;
							if(t == 0)
							{
								arr.push('<li><span><a href="javascript:void(0)" class="tree-hit txtNode" style="background-image:url();display:block;width:250px">'+data[i].son[j].text+'</a></span></li>');
							}
							else
							{
								arr.push('<li><span><a href="javascript:void(0)" class="tree-hit txtNode" style="background-image:url();display:block;width:250px">'+data[i].son[j].text+'</a></span><ul>');
								for(;k < t;k++)
								{
									arr.push("<li><a href='javascript:void(0)' class='txtNode' url='"+data[i].son[j].items[k].itemPageUrl+"' text='"+data[i].son[j].items[k].itemName+"' onclick=openUrl('"+data[i].son[j].items[k].itemId+"','"+data[i].son[j].items[k].itemPageUrl+"','"+data[i].son[j].items[k].itemName+"')>"+data[i].son[j].items[k].itemName+"</a></li>")
								}
								arr.push('</ul></li>');
							}
						}
					}
					arr.push("</ul>");
					$("#leftmenu").accordion("add", {title: data[i].name, content: arr.join(""), iconCls:'icons-folder-folder_go'});
				}
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
			function openUrl(id , url , title)
			{
				if(url.lastIndexOf("&") != -1 || url.lastIndexOf("?") != -1)
				{
					url += "&funcNodeId="+id;
				}
				else
				{
					url += "?funcNodeId="+id;
				}
				if($('#pagetabs').tabs('exists', title)){
					$('#pagetabs').tabs('select', title);
					var current_tab = $('#pagetabs').tabs('getSelected');
					$('#pagetabs').tabs('update', {
						tab:current_tab,
						options : {
							content : '<iframe name="'+title+' "src="'+url+'" width="100%" height="99%" frameborder="0" scrolling="auto"></iframe>'
						}
					});
				}else{
					$('#pagetabs').tabs('add',{
						title: title,
						//href: url,
						closable: true,
						cache: false,
						content : '<iframe name="'+title+' "src="'+url+'" width="100%" height="99%" frameborder="0" scrolling="auto"></iframe>'
					});
				}
			}
			
			function closeUrl(title) {
				if($("#pagetabs").tabs("exists", title)) {
					$("#pagetabs").tabs("close", title);
				}
			}
			
			function viewFile()
			{
				$('#fileDlg').dialog({
					title:"管理规范",
				});
				$('#fileDlg').attr("src","/sys/standardManage.jsp");
				$('#fileDlg').dialog("open");
			}
		</script>
	</body>
</html>
