<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/baseChange/qryBaseChange.js"></script>
  	</head>
  
  	<body style="padding-top:5px">
  		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
  		<form id="qryFm" style="margin:0 auto;">
  			<table class="search_tab">
  				<tr>
  					<td align="right" style="min-width: 80px"><span>校区：</span></td>
	  				<td style="min-width: 100px">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
		        		</select>
					</td>
					<td align="right" style="min-width: 80px"><span>课程阶段：</span></td>
					<td style="min-width: 100px">
						<select id="stageId" name="stageId" class="easyui-combobox" style="width: 100px; height: 25px;"
							data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'" 
				      		url="<%=path %>/pubData/qryStage.do">
				        </select>
					</td>
					<td align="right" style="min-width: 80px"><span>班级：</span></td>
					<td style="min-width: 100px" colspan="4">
						<input id="className" name="className" type="text" class="easyui-textbox validatebox"  style="width: 100px; height: 25px;"/>
					</td>
  				</tr>
  				<tr>
					<td align="right" style="min-width: 80px"><span>带班老师：</span></td>
					<td style="min-width: 100px">
						<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 100px; height: 25px;">
		        		</select>
					</td>
					<td align="right" style="min-width: 80px"><span>班级状态 ：</span></td>
	  				<td style="min-width: 100px">
						<select id="classState" name="classState" class="easyui-combobox" style="width: 100px; height: 25px;"
							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=CLASS_STATE&codeFlag=003,004">
		        		</select>
					</td>
					<td align="right" style="min-width: 80px"><span>开课日期：</span></td>
					<td style="min-width: 100px">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeOpenClass" name="startTimeOpenClass" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center"><span>至</span></td>
					<td style="min-width: 100px">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeOpenClass" name="endTimeOpenClass" data-options="formatter:myformatter, parser:myparser"/>
					</td>
  					<td align="center"  style="min-width: 210px">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1084">查询</a>
						&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
					</td>
					<td style="min-width: 200px">&nbsp;</td>
  				</tr>
  			</table>
  		</form>
  		<div style="padding:5px 0;min-width:1100px; width:100%;">
  			<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="list_data" 
		  		toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
		  		<thead>
		  			<tr>
		  				<th data-options="field:'ck',checkbox:true"></th>
		  				<th data-options="field:'schoolName',width:80,align:'center'">校区</th>
		  				<th data-options="field:'className',width:100,align:'center'">班级名称</th>
		  				<th data-options="field:'openDate',width:100,align:'center'">开课日期</th>
		  				<th data-options="field:'schooltimeName',width:200,align:'center'">上课时间与教室</th>
		  				<th data-options="field:'teacherName',width:150,align:'center'">带班老师</th>
		  				<th data-options="field:'licenseRate',width:80,align:'center'">持证率</th>
		  				<th data-options="field:'classStateText',width:80,align:'center'">班级状态</th>
		  				<th data-options="field:'openClassNum',width:80,align:'center'">开班人数</th>
		  				<th data-options="field:'studyingNum',width:80,align:'center'">在读人数</th>
		  				<th data-options="field:'classProgress',width:80,align:'center'">课时进度</th>
		  				<th data-options="field:'higherBaseNum',width:80,align:'center'">升学基数</th>
		  				<th data-options="field:'higherNum',width:80,align:'center'">已升学人数</th>
		  				<th data-options="field:'higherRate',width:80,align:'center'">升学率</th>
		  			</tr>
		  		</thead>
		  	</table>
  		</div>
  		<div id="toolbar">
   			<a href="javascript:void(0)" id="changeBase" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;">基数调整</a>
   			<a href="javascript:void(0)" id="viewChange" class="easyui-linkbutton" iconCls="icon-redo" style="width: 120px;">查看调整历史</a>
 		</div>
  	</body>
</html>
