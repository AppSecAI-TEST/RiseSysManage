<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/attendClass/attendClassList.js"></script>
  	</head>
  
  	<body>
  		<div style="margin-right:5px;">
  		<form id="qryFm">
  			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId }"/>
  			<input type="hidden" id="funcNodeId" value="${param.funcNodeId}"/>
  			<table class="search_tab">
  				<tr>
  					<td align="right" style="min-width: 70px;"><span>校区：</span></td>
	  				<td style="min-width: 100px;">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;">
		        		</select>
					</td>
					<td align="right" style="min-width: 70px;"><span>课程阶段：</span></td>
					<td style="min-width: 117px;">
						<select id="stageId" name="stageId" class="easyui-combobox" style="width: 117px; height: 25px;">
		        		</select>
					</td>
					<td align="right" style="min-width: 70px;"><span>班级：</span></td>
					<td style="min-width: 130px;">
						<input id="classInstId" name="classInstId" type="text" class="easyui-textbox" style="width: 127px; height: 25px;"/>
					</td>
					<td align="right" style="min-width: 70px;"><span>开课日期：</span></td>
					<td style="min-width: 117px;">
						<input class="easyui-datebox" type="text" style="width:117px; height: 25px;" id="startTimeOpenClass" name="startTimeOpenClass" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center"><span>至</span></td>
					<td style="min-width: 250px;">
						<input class="easyui-datebox" type="text" style="width:117px; height: 25px;" id="endTimeOpenClass" name="endTimeOpenClass" data-options="formatter:myformatter, parser:myparser"/>
					</td>
  				</tr>
  				<tr>
  					<td align="right" style="min-width: 70px;"><span>开班类型 ：</span></td>
	  				<td style="min-width: 100px;">
						<select id="openClassType" name="openClassType" class="easyui-combobox" style="width: 100px; height: 25px;"
							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=OPEN_CLASS_TYPE">
		        		</select>
					</td>
					<td align="right" style="min-width: 70px;"><span>课时进度 ：</span></td>
					<td style="min-width: 117px;">
						<input name="minClassProgress" id="minClassProgress" type="text" class="easyui-textbox" style="width: 43px; height: 25px;"/>
						<span style="display: inline-block; text-align: center; width: 14px;">至</span>
						<input name="maxClassProgress" id="maxClassProgress" type="text" class="easyui-textbox" style="width: 43px; height: 25px;"/>
					</td>
					<td align="right" style="min-width: 70px;"><span>升学率 ：</span></td>
					<td style="min-width: 130px;">
						<input name="minHigherRate" id="minHigherRate" type="text" class="easyui-textbox numberbox" style="width: 39px; height: 25px;" data-options="min:0, max:100, precision:0"/>
						<span style="display: inline-block; text-align: center; width: 32px;">%&nbsp;至&nbsp;</span>
						<input name="maxHigherRate" id="maxHigherRate" type="text" class="easyui-textbox numberbox" style="width: 39px; height: 25px;" data-options="min:0, max:100, precision:0"/>
						<span style="display: inline-block; text-align: center; width: 3px;">%</span>
					</td>
					<td align="right" style="min-width: 70px;"><span>在读人数 ：</span></td>
					<td style="min-width: 117px;">
						<input name="minClassStudentNum" id="minClassStudentNum" type="text" class="easyui-textbox" style="width: 43px; height: 25px;"/>
						<span style="display: inline-block; text-align: center; width: 14px;">至</span>
						<input name="maxClassStudentNum" id="maxClassStudentNum" type="text" class="easyui-textbox" style="width: 43px; height: 25px;"/>
					</td>
					<td colspan="2">&nbsp;</td>
  				</tr>
  				<tr>
  					<td align="right" style="min-width: 70px;"><span>带班老师：</span></td>
					<td style="min-width: 100px;">
						<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 100px; height: 25px;" disabled="disabled">
		        		</select>
					</td>
					<td align="right" style="min-width: 70px;"><span>班级性质：</span></td>
					<td style="min-width: 117px;">
						<select id="handType" name="handType" class="easyui-combobox" style="width: 117px; height: 25px;"
							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=HAND_TYPE">
		        		</select>
					</td>
					<td align="right" style="min-width: 70px;"><span>持证率 ：</span></td>
					<td style="min-width: 130px;">
						<input name="minLicenseRate" id="minLicenseRate" type="text" class="easyui-textbox numberbox" style="width: 39px; height: 25px;" data-options="min:0, max:100, precision:0"/>
						<span style="display: inline-block; text-align: center; width: 32px;">%&nbsp;至&nbsp;</span>
						<input name="maxLicenseRate" id="maxLicenseRate" type="text" class="easyui-textbox numberbox" style="width: 39px; height: 25px;" data-options="min:0, max:100, precision:0"/>
						<span style="display: inline-block; text-align: center; width: 3px;">%</span>
					</td>
					<td align="right" style="min-width: 70px;"><span>开班人数：</span></td>
					<td style="min-width: 117px;">
						<input name="minOpenClassNum" id="minOpenClassNum" type="text" class="easyui-textbox" style="width: 43px; height: 25px;"/>
						<span style="display: inline-block; text-align: center; width: 14px;">至</span>
						<input name="maxOpenClassNum" id="maxOpenClassNum" type="text" class="easyui-textbox" style="width: 43px; height: 25px;"/>
					</td>
					<td align="center" colspan="2">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1020">查询</a>
						&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
					</td>
  				</tr>
  			</table>
  		</form>
  			<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="list_data"
		  		toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'schoolName',width:80,align:'center'">校区</th>
						<th data-options="field:'className',width:100,align:'center'">班级名称</th>
						<th data-options="field:'openDate',width:100,align:'center'">开班日期</th>
						<th data-options="field:'schooltimeName',width:200,align:'center'">上课时段与教室</th>
						<th data-options="field:'teacherName',width:150,align:'center'">带班老师</th>
						<th data-options="field:'licenseRateText',width:100,align:'center'">持证率</th>
						<th data-options="field:'handTypeText',width:100,align:'center'">班级性质</th>
						<th data-options="field:'openClassNum',width:100,align:'center'">开班人数</th>
						<th data-options="field:'classStudentNum',width:80,align:'center'">在读人数</th>
						<th data-options="field:'classProgress',width:100,align:'center'">课时进度</th>
						<th data-options="field:'higherBaseNum',width:80,align:'center'">升学基数</th>
						<th data-options="field:'higherNum',width:80,align:'center'">已升学人数</th>
						<th data-options="field:'higherRateText',width:100,align:'center'">升学率</th>
					</tr>
				</thead>
			</table>
  		<div id="toolbar" style="padding: 2px; height: auto">
   			<a href="javascript:void(0)" id="maintenanceBtn" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;">班级维护</a>
   			<a href="javascript:void(0)" id="disbandBtn" class="easyui-linkbutton" iconCls="icon-cancel" style="width: 120px;">班级解散</a>
   			<a href="javascript:void(0)" id="view" class="easyui-linkbutton" iconCls="icon-redo" style="width: 80px;">浏览</a>
		</div>
	</div>
  	</body>
</html>
