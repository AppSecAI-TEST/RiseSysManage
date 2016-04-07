<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/finishClass/finishClassList.js"></script>
  	</head>
  
  	<body>
  		<div style ="margin-right:5px;">
  		<form id="qryFm">
  			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId }"/>
  			<table class="search_tab">
  				<tr>
  					<td align="right" style="min-width: 65px;"><span>校区：</span></td>
	  				<td style="min-width: 110px;">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
			      			url="<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=5061&fieldId=schoolId">
		        		</select>
					</td>
					<td align="right" style="min-width: 65px;"><span>班级：</span></td>
					<td style="min-width: 110px;">
						<input id="classInstId" name="classInstId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
					</td>
					<td align="right" style="min-width: 65px;"><span>班级性质：</span></td>
					<td style="min-width: 110px;">
						<select id="handType" name="handType" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=HAND_TYPE">
		        		</select>
					</td>
					<td align="right" style="min-width: 65px;"><span>开课日期：</span></td>
					<td align="left" style="min-width: 220px;">
						<input class="easyui-datebox" type="text" style="width:100; height: 25px;" id="startTimeOpenClass" name="startTimeOpenClass" data-options="formatter:myformatter, parser:myparser"/>
						至
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeOpenClass" name="endTimeOpenClass" data-options="formatter:myformatter, parser:myparser"/>
					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>课程阶段：</span></td>
					<td>
						<select id="stageId" name="stageId" class="easyui-combobox" editable="false" style="width: 100px; height: 25px;">
		        		</select>
					</td>
					<td align="right"><span>带班老师：</span></td>
					<td>
						<select id="teacherId" name="teacherId" class="easyui-combobox" editable="false" style="width: 100px; height: 25px;">
		        		</select>
					</td>
					<td align="right"><span>班级状态 ：</span></td>
	  				<td>
						<select id="classState" name="classState" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=FINISH_CLASS_STATE">
		        		</select>
					</td>
					<td align="right"><span>结课日期：</span></td>
					<td align="left">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeFinishClass" name="startTimeFinishClass" data-options="formatter:myformatter, parser:myparser"/>
						至
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeFinishClass" name="endTimeFinishClass" data-options="formatter:myformatter, parser:myparser"/>
					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>开班类型 ：</span></td>
	  				<td>
						<select id="openClassType" name="openClassType" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=OPEN_CLASS_TYPE">
		        		</select>
					</td>
					<td align="right"><span>开班人数 ：</span></td>
					<td>
						<input name="minOpenClassNum" id="minOpenClassNum" type="text" class="easyui-textbox numberbox" style="width: 39px; height: 25px;"/>
						<span style="display: inline-block; text-align: center; width: 14px;">至</span>
						<input name="maxOpenClassNum" id="maxOpenClassNum" type="text" class="easyui-textbox numberbox" style="width: 39px; height: 25px;"/>
					</td>
					<td align="right" ><span>在读人数 ：</span></td>
					<td>
						<input name="minClassStudentNum" id="minClassStudentNum" type="text" class="easyui-textbox numberbox" style="width: 39px; height: 25px;"/>
						<span style="display: inline-block; text-align: center; width: 14px;">至</span>
						<input name="maxClassStudentNum" id="maxClassStudentNum" type="text" class="easyui-textbox numberbox" style="width: 39px; height: 25px;"/>
					</td>
					<td align="right"><span>解散日期：</span></td>
					<td align="left">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeDisbandClass" name="startTimeDisbandClass" data-options="formatter:myformatter, parser:myparser"/>
						至
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeDisbandClass" name="endTimeDisbandClass" data-options="formatter:myformatter, parser:myparser"/>
					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>课时进度 ：</span></td>
					<td>
						<input name="minClassProgress" id="minClassProgress" type="text" class="easyui-textbox numberbox" style="width: 39px; height: 25px;"/>
						<span style="display: inline-block; text-align: center; width: 14px;">至</span>
						<input name="maxClassProgress" id="maxClassProgress" type="text" class="easyui-textbox numberbox" style="width: 39px; height: 25px;"/>
					</td>
  					<td align="right"><span>升学率 ：</span></td>
					<td>
						<input name="minHigherRate" id="minHigherRate" type="text" class="easyui-textbox numberbox" style="width: 35px; height: 25px;" data-options="min:0, max:100, precision:0"/>
						%-
						<input name="maxHigherRate" id="maxHigherRate" type="text" class="easyui-textbox numberbox" style="width: 35px; height: 25px;" data-options="min:0, max:100, precision:0"/>
						%
					</td>
					<td align="right"><span>持证率 ：</span></td>
					<td>
						<input name="minLicenseRate" id="minLicenseRate" type="text" class="easyui-textbox numberbox" style="width: 35px; height: 25px;" data-options="min:0, max:100, precision:0"/>
						%-
						<input name="maxLicenseRate" id="maxLicenseRate" type="text" class="easyui-textbox numberbox" style="width: 35px; height: 25px;" data-options="min:0, max:100, precision:0"/>
						%
					</td>
					<td align="right"><span>结课日期：</span></td>
					<td align="left">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeFinish" name="startTimeFinish" data-options="formatter:myformatter, parser:myparser"/>
						至
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeFinish" name="endTimeFinish" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="left" style="min-width: 210px;">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1022">查询</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
					</td>
  				</tr>
  			</table>
  		</form>
  			<table class="easyui-datagrid" title="查询结果" id="list_data" 
		  		toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
		  		<thead>
		  			<tr>
		  				<th data-options="field:'ck',checkbox:true"></th>
		  				<th data-options="field:'schoolName',width:80,align:'center'">校区</th>
		  				<th data-options="field:'className',width:100,align:'center'">班级名称</th>
		  				<th data-options="field:'openDate',width:100,align:'center'">开班日期</th>
		  				<th data-options="field:'finishDate',width:100,align:'center'">结课日期</th>
		  				<th data-options="field:'classProgress',width:100,align:'center'">课时进度</th>
		  				<th data-options="field:'teacherName',width:150,align:'center'">带班老师</th>
		  				<th data-options="field:'handTypeText',width:100,align:'center'">班级性质</th>
		  				<th data-options="field:'openClassNum',width:100,align:'center'">开班人数</th>
		  				<th data-options="field:'classStudentNum',width:80,align:'center'">在读人数</th>
		  				<th data-options="field:'higherBaseNum',width:80,align:'center'">升学基数</th>
		  				<th data-options="field:'higherNum',width:80,align:'center'">已升学人数</th>
		  				<th data-options="field:'higherRateText',width:100,align:'center'">升学率</th>
		  			</tr>
		  		</thead>
		  	</table>
  		<div id="toolbar" style="padding: 2px; height: auto">
   			<a href="javascript:void(0)" id="finishClassBtn" class="easyui-linkbutton" iconCls="icon-edit" style="width: 120px;">取消毕业典礼</a>
   			<a href="javascript:void(0)" id="view" class="easyui-linkbutton" iconCls="icon-redo" style="width: 80px;">浏览</a>
		</div>
		</div>
  	</body>
</html>
