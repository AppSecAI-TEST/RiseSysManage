<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/timeResource/addResource.js"></script>		
	</head>
	<body>
		<div id ="baseInfo" class="easyui-panel" title="创建休假日期" style="width:1100px;">
		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<table id ="infoTab" width="100%;" class="maintable">
  				<tr>
  					<td colspan="3" align="left">&nbsp;<span>年份：</span>
  						<select class="easyui-combobox" name="year" id="year" style="width:80px;height: 28px;"
  							data-options="valueField:'val',textField:'text', panelHeight: 'auto',editable:false">
  						</select>
  					</td>
  				</tr>
  				<tr>
  					<td width="58px"  align="center"><span>月份</span></td>
  					<td width="100px" align="center"></td>
  					<td align="center"><span>休假日期</span></td>
  				</tr>
  				<tr month="1" days="" class="addTr">
  					<td align="center" ><span>1</span></td>
  					<td align="center">
  						<a href="javascript:void(0)" onclick="toaddDays(this)" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><span>添加</span></a>
  					</td>
  					<td><span></span></td>
  				</tr>
  				<tr month="2" days="" class="addTr">
  					<td align="center" ><span>2</span></td>
  					<td align="center">
  						<a href="javascript:void(0)" onclick="toaddDays(this)" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><span>添加</span></a>
  					</td>
  					<td><span></span></td>
  				</tr>
  				<tr month="3" days="" class="addTr">
  					<td align="center" ><span>3</span></td>
  					<td align="center">
  						<a href="javascript:void(0)" onclick="toaddDays(this)" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><span>添加</span></a>
  					</td>
  					<td><span></span></td>
  				</tr>
  				<tr month="4" days="" class="addTr">
  					<td align="center" ><span>4</span></td>
  					<td align="center">
  						<a href="javascript:void(0)" onclick="toaddDays(this)" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><span>添加</span></a>
  					</td>
  					<td><span></span></td>
  				</tr>
  				<tr month="5" days="" class="addTr">
  					<td align="center" ><span>5</span></td>
  					<td align="center">
  						<a href="javascript:void(0)" onclick="toaddDays(this)" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><span>添加</span></a>
  					</td>
  					<td><span></span></td>
  				</tr>
  				<tr month="6" days="" class="addTr">
  					<td align="center" ><span>6</span></td>
  					<td align="center">
  						<a href="javascript:void(0)" onclick="toaddDays(this)" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><span>添加</span></a>
  					</td>
  					<td><span></span></td>
  				</tr>
  				<tr month="7" days="" class="addTr">
  					<td align="center" ><span>7</span></td>
  					<td align="center">
  						<a href="javascript:void(0)" onclick="toaddDays(this)" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><span>添加</span></a>
  					</td>
  					<td><span></span></td>
  				</tr>
  				<tr month="8" days="" class="addTr">
  					<td align="center" ><span>8</span></td>
  					<td align="center">
  						<a href="javascript:void(0)" onclick="toaddDays(this)" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><span>添加</span></a>
  					</td>
  					<td><span></span></td>
  				</tr>
  				<tr month="9" days="" class="addTr">
  					<td align="center" ><span>9</span></td>
  					<td align="center">
  						<a href="javascript:void(0)" onclick="toaddDays(this)" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><span>添加</span></a>
  					</td>
  					<td><span></span></td>
  				</tr>
  				<tr month="10" days="" class="addTr">
  					<td align="center" ><span>10</span></td>
  					<td align="center">
  						<a href="javascript:void(0)" onclick="toaddDays(this)" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><span>添加</span></a>
  					</td>
  					<td><span></span></td>
  				</tr>
  				<tr month="11" days="" class="addTr">
  					<td align="center" ><span>11</span></td>
  					<td align="center">
  						<a href="javascript:void(0)" onclick="toaddDays(this)" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><span>添加</span></a>
  					</td>
  					<td><span></span></td>
  				</tr>
  				<tr month="12" days="" class="addTr">
  					<td align="center" ><span>12</span></td>
  					<td align="center">
  						<a href="javascript:void(0)" onclick="toaddDays(this)" class="easyui-linkbutton" iconCls="icon-add" style="width:80px"><span>添加</span></a>
  					</td>
  					<td><span></span></td>
  				</tr>
  			</table>
  		</div>
  		<div style="width:1100px;text-align:center;margin-top:50px;">
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:150px" id="submitBtn">提交</a>
  				&nbsp;&nbsp;&nbsp;&nbsp;
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:150px" id="backBtn" >返回</a>	
  		</div>
  		<iframe id="dlg" class="easyui-dialog" style="width:800px; height: 450px; padding: 10px 20px" closed="true" modal="true">
		</iframe>	
	</body>
</html>		