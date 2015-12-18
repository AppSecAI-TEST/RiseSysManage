<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/mergeClass/mergeList.js"></script>
		<style>
			.datagrid-cell
			{
				padding:0;
				height:100%;
			}	
			.datagrid-cell>div
			{
				magrin:0;
				padding:0;
				width:100%;
				border-top:1px dotted #ddd;
				min-height:40px;
				overflow:hidden;
			}
		</style>
  	</head>
  	<body>
  		<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  		<div id="tt" class="easyui-tabs" style="min-width:1110px;width:98%;height:auto;">
  			<div title="合并班级管理" style="padding:5px;display:block;">
		 		<form id="merFm">
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
		  					<td align="right">定班率：</td>
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
		  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qryBtn" funcNodeId="3111">查询</a>
		  					</td>
		  					<td>&nbsp;</td>
		  					<td>
		  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:150px" id="resetBtn" >重置</a>
		  					</td>
		  				</tr>
		  			</table>
		 		</form>
		 		
		 		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:500" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true">
					<thead>
						<tr>
							<th data-options="field:'ck',checkbox:true"></th>
							<th field="applyId" align="center" width="10%">编号</th>
							<th field="applyDate" align="center" width="8%">申请日期</th>
							<th field="approveDate" align="center" width="8%">审批日期</th>
							<th field="schoolName" align="center" width="8%">校区</th>
							<th field="classesName" align="center" width="8%">班级名称</th>
							<th field="finishDate" align="center" width="8%">结课日期</th>
							<th field="classTime" align="center" width="15%">上课时段</th>
							<th field="studyingNum" align="center" width="5%">在读人数</th>
							<th field="higherNum" align="center" width="5%">已升学人数</th>
							<th field="higherPer" align="center" width="5%">升学率</th>
							<th field="startDate" align="center" width="8%">开始日期</th>
							<th field="startHours" align="center" width="8%">开始课时</th>
							<th field="weeks" align="center" width="5%">合并时长</th>
							<th field="comboType" align="center" width="10%">合并形式</th>
							<th field="comboFinishDate" align="center" width="10%">合并后结课日期</th>
							<th field="className" align="center" width="8%">合并后班级</th>
							<th field="orderNum" align="center" width="5%">定班人数</th>
							<th field="orderPer" align="center" width="5%">定班率</th>
							<th field="times" align="center" width="15%">合并后上课时段</th>
							<th field="teachers" align="center" width="15%">带班老师</th>
							<th field="openClassDate" align="center" width="8%">开课日期</th>
							<th field="comboState" align="center" width="8%">合并状态</th>
						</tr>
					</thead>
				</table>
				<div id="toolbar" style="padding: 2px;height:auto;">
		   			<a href="javascript:void(0)" id="applyMerge" class="easyui-linkbutton" style="width: 100px;" iconCls="icon-add">合并申请</a>
		   			<a href="javascript:void(0)" id="cancelMerge" class="easyui-linkbutton" style="width: 150px;" iconCls="icon-edit">取消合并申请</a>
		   			<a href="javascript:void(0)" id="HeadMerge" class="easyui-linkbutton" style="width: 100px;" iconCls="icon-add">总部合并</a>
		   			<a href="javascript:void(0)" id="changeTime" class="easyui-linkbutton" style="width: 150px;" iconCls="icon-edit">调整上课时段</a>
		   			<a href="javascript:void(0)" id="orderClass" class="easyui-linkbutton" style="width: 100px;" iconCls="icon-edit">定班处理</a>
		   			<a href="javascript:void(0)" id="viewMerge" class="easyui-linkbutton" style="width: 100px;" iconCls="icon-redo">浏览</a>
		 		</div>
		 	</div>	
		 	<div title="审批管理" style="padding:5px;display:block;">
		 		<form id="appFm">
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
		  					<td align="right">定班率：</td>
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
		  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qryBtns" funcNodeId="3112">查询</a>
		  					</td>
		  					<td>&nbsp;</td>
		  					<td>
		  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:150px" id="resetBtns" >重置</a>
		  					</td>
		  				</tr>
		  			</table>
		 		</form>
		 		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:500" id="list_datas" toolbar="#toolbars" pagination="true" rownumbers="true" fitColumns="true">
					<thead>
						<tr>
							<th data-options="field:'ck',checkbox:true"></th>
							<th field="applyId" align="center" width="10%">编号</th>
							<th field="comboState" align="center" width="8%">合并状态</th>
							<th field="applyDate" align="center" width="8%">申请日期</th>
							<th field="approveDate" align="center" width="8%">审批日期</th>
							<th field="schoolName" align="center" width="8%">校区</th>
							<th field="classesName" align="center" width="8%">班级名称</th>
							<th field="finishDate" align="center" width="8%">结课日期</th>
							<th field="classTime" align="center" width="15%">上课时段</th>
							<th field="studyingNum" align="center" width="5%">在读人数</th>
							<th field="higherNum" align="center" width="5%">已升学人数</th>
							<th field="higherPer" align="center" width="5%">升学率</th>
							<th field="startDate" align="center" width="8%">开始日期</th>
							<th field="startHours" align="center" width="8%">开始课时</th>
							<th field="weeks" align="center" width="5%">合并时长</th>
							<th field="comboType" align="center" width="10%">合并形式</th>
							<th field="comboFinishDate" align="center" width="10%">合并后结课日期</th>
							<th field="className" align="center" width="8%">合并后班级</th>
							<th field="orderNum" align="center" width="5%">定班人数</th>
							<th field="orderPer" align="center" width="5%">定班率</th>
							<th field="times" align="center" width="15%">合并后上课时段</th>
							<th field="teachers" align="center" width="15%">带班老师</th>
							<th field="openClassDate" align="center" width="8%">开课日期</th>
						</tr>
					</thead>
				</table>
				<div id="toolbars">
		   			<a href="javascript:void(0)" id="approve" class="easyui-linkbutton" iconCls="icon-edit" plain="true">审批</a>
		   			<a href="javascript:void(0)" id="viewApprove" class="easyui-linkbutton" iconCls="icon-redo" plain="true">浏览</a>
		 		</div>
		 	</div>
 		</div>	
  	</body>
</html>
