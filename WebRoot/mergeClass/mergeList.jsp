<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  	<body>
 		<form id="qryFm">
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="15">
  				<tr>
  					<td align="right">校区：</td>
  					<td>
  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:150px;">
  							
  						</select>
  					</td>
  					<td align="right">课程阶段：</td>
  					<td>
  						<select class="easyui-combobox" name="courseState" id="schoolId" style="width:150px;">
  							
  						</select>
  					</td>
  					<td align="right">计划审批时间：</td>
  					<td>
  						<input class="easyui-datebox" name="startPlanTime" id="startPlanTime"  style="width:150px;" />
  					</td>
  					<td align="center"  width="10px">至：</td>
  					<td>
  						<input class="easyui-datebox" name="endPlanTime" id="endPlanTime"  style="width:150px;" />
  					</td>
  				</tr>
  				<tr>
  					<td align="right">定伴率：</td>
  					<td>
  						<input class="easyui-textbox" id="lowLimit" name="lowLimit" style="width:58px;">%至
	  					<input class="easyui-textbox" id="limit" name="limit" style="width:58px;">%
  					</td>
  					<td align="right">合并状态：</td>
  					<td>
  						<select class="easyui-combobox" name="merState" id="merState" style="width:150px;">
  						
  						</select>
  					</td>
  					<td align="right">合并开始时间：</td>
  					<td>
  						<input class="easyui-datebox" name="startMergeTime" id="startMergeTime" style="width:150px;" />
  					</td>
  					<td align="center">至：</td>
  					<td>
  						<input class="easyui-datebox" name="endMergeTime" id="endMergeTime" style="width:150px;" />
  					</td>
  				</tr>
  				<tr>
  					<td colspan="5" >&nbsp;</td>
  					<td>	
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qryBtn" funcNodeId="3001">查询</a>
  					</td>
  					<td>&nbsp;</td>
  					<td>
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:150px" id="resetBtn" >重置</a>
  					</td>
  				</tr>
  			</table>
 		</form>
 		
 		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:300" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true">
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" id="applyMerge" class="easyui-linkbutton" iconCls="icon-add" plain="true">合并申请</a>
   			<a href="javascript:void(0)" id="cancelMerge" class="easyui-linkbutton" iconCls="icon-edit" plain="true">取消合并申请</a>
   			<a href="javascript:void(0)" id="centerMerge" class="easyui-linkbutton" iconCls="icon-add" plain="true">总部合并</a>
   			<a href="javascript:void(0)" id="linkClass" class="easyui-linkbutton" iconCls="icon-edit" plain="true">定班处理</a>
   			<a href="javascript:void(0)" id="checkMerge" class="easyui-linkbutton" iconCls="icon-edit" plain="true">审批</a>
   			<a href="javascript:void(0)" id="viewMerge" class="easyui-linkbutton" iconCls="icon-redo" plain="true">浏览</a>
 		</div>
  	</body>
</html>
