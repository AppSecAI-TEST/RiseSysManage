<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
  		<link type="text/css" rel="stylesheet" href="<%=path%>/pub/css/pub.css"/>
  		<link type="text/css" rel="stylesheet" href="<%=path%>/pub/css/login.css"/>
  		<script type="text/javascript" src="<%=path %>/pub/js/jquery.min.js"></script>
    	<script type="text/javascript" src="<%=path %>/pub/js/public.js"></script>
    	<script type="text/javascript" src="<%=path %>/pub/js/bpopup.js"></script>
    	<script type="text/javascript" src="<%=path %>/js/login.js"></script>
  	</head>
  
  	<body style="background-image: url('pub/images/bg.jpg');">
  		<div style="margin-top: 35%; margin-left: 15%; float: left;">
	  		<img src="<%=path%>/pub/images/nlst.png" style="cursor:pointer;" onclick="view()">
	  		<div id="left" class="select">
	  			<img src="<%=path%>/pub/images/selected.png">
	  		</div>
	  	</div>
	  	<div style="margin-top: 35%; margin-left: 30%; float: left;">
	  		<img src="<%=path%>/pub/images/ptgl.png" style="cursor:pointer;" onclick="login()">
	  		<div id="right" class="select">
	  			<img src="<%=path%>/pub/images/selected.png">
	  		</div>
	  	</div>
	  	<div class="ui-dialog-popup" id="loginPage" style="width: 500px; height: 400px;">
    		<div style="text-align: center; margin-top: 50px;"><img src="<%=path %>/pub/images/login_title.png"/></div>
    		<div style="margin-top: 20px;">
    			<table width="95%" cellpadding="10">
    				<tr>
    					<td align="right" width="35%">账号:</td>
    					<td align="left" colspan="2"><input type="text" id="userName" class="subtext" onkeydown="keyDown(1)"/></td>
    				</tr>
    				<tr>
    					<td align="right">密码:</td>
    					<td align="left" colspan="2"><input type="password" id="password" class="subtext" onkeydown="keyDown(2)"/></td>
    				</tr>
    				<tr>
    					<td align="right">验证码:</td>
    					<td align="left" colspan="2">
    						<input type="text" id="securityCode" class="subtext1" onkeydown="keyDown(3)"/>&nbsp;&nbsp;<img id="codeImage" style="vertical-align: middle;" height="24px" width="60px">&nbsp;&nbsp;&nbsp;&nbsp;<a class="linkmore" href="javascript:void(0)" onclick="getSecurityCode()">换一张</a>
    					</td>
    				</tr>
    				<tr>
    					<td></td>
    					<td align="left" colspan="2" style="vertical-align: middle;"><img src="<%=path %>/pub/images/unchoice.png" id="remember" style="position: relative; top: 3px;"/>&nbsp;<span>记住我的登录状态</span></td>
    				</tr>
    				<tr>
    					<td></td>
    					<td align="left" colspan="2"><input type="button" value="登录" class="button" onclick="realLogin()"/></td>
    				</tr>
    				<tr style="display: none;">
    					<td></td>
    					<td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="linkmore1" href="javascript:void(0)">忘记密码</a></td>
    				</tr>
    			</table>
    		</div>
    	</div>
  	</body>
</html>

