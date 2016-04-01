<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/selectClass/selectClassList.js"></script>
  	</head>
  
  	<body>
  		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
		<input type="hidden" id="funcNodeId" value="${param.funcNodeId}"/>
		<div style="margin-right:5px;">
  		<form id="qryFm">
  			<table class="search_tab">
  				<tr>
  					<td align="right" style="min-width: 60px;"><span>校区：</span></td>
	  				<td style="min-width: 100px;">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
		        		</select>
					</td>
					<td align="right" style="min-width: 80px;"><span>学员姓名：</span></td>
					<td style="min-width: 110px;">
						<input id="studentId" name="studentId" class="easyui-textbox" style="width: 110px; height: 25px;">
					</td>
					<td align="right" style="min-width: 70px;"><span>联系电话：</span></td>
					<td style="min-width: 110px;">
						<input name="phone" id="phone" type="text" class="easyui-textbox" style="width: 109px; height: 25px;"/>
					</td>
					<td align="right" style="min-width: 60px;"><span>课程类型：</span></td>
					<td style="min-width: 220px;" colspan="2">
						<select id="courseType" name="courseType" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
		        		</select>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<select id="stageId" name="stageId" class="easyui-combobox" style="width: 100px; height: 25px;" disabled="disabled">
		        		</select>
		        	</td>
  				</tr>
  				<tr>
  					<td align="right" style="min-width: 60px;"><span>责任顾问：</span></td>
	  				<td style="min-width: 100px;">
						<select id="dutyAdvister" name="dutyAdvister" class="easyui-combobox" style="width: 100px; height: 25px;">
      					</select>
					</td>
					<td align="right" style="min-width: 80px;"><span>业绩老师：</span></td>
	  				<td style="min-width: 110px;">
						<select id="adviserTeacher" name="adviserTeacher" class="easyui-combobox" style="width: 110px; height: 25px;">
      					</select>
					</td>
					<td align="right" style="min-width: 70px;"><span>选班次数：</span></td>
					<td style="min-width: 110px;">
						<input name="minSelectNum" id="minSelectNum" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
						至
						<input name="maxSelectNum" id="maxSelectNum" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
					</td>
					<td align="right" style="min-width: 60px;"><span>缴费日期：</span></td>
	  				<td style="min-width: 220px;" colspan="2">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimePay" name="startTimePay" data-options="formatter:myformatter, parser:myparser"/>
						至
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimePay" name="endTimePay" data-options="formatter:myformatter, parser:myparser"/>
					</td>
  				</tr>
  				<tr>
					<td align="right" style="min-width: 60px;"><span>业绩类型：</span></td>
					<td style="min-width: 100px;">
						<select id="feeType" name="feeType" class="easyui-combobox" style="width: 100px; height: 25px;"
							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
		      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=FEE_TYPE">
		        		</select>
					</td>
					<td align="right" style="min-width: 80px;"><span><input type="radio" name="isNeed" value="'Y', 'N'"/>所有课程：</span></td>
					<td style="min-width: 110px;">
						<input type="checkbox" name="courseStateAll" value="001" disabled="disabled"/><span>未定班</span>
						<input type="checkbox" name="courseStateAll" value="002" disabled="disabled"/><span>已定班</span>
					</td>
					<td align="right" style="min-width: 70px;"><input type="radio" name="isNeed" value="'Y'"/><span>需选班：</span></td>
					<td style="min-width: 110px;">
						<input type="checkbox" name="courseStateNeed" value="001" disabled="disabled"/><span>未定班</span>
						<input type="checkbox" name="courseStateNeed" value="002" disabled="disabled"/><span>已定班</span>
					</td>
					<td align="right" style="min-width: 60px;"><span>选班日期：</span></td>
	  				<td style="min-width: 220px;">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeSelect" name="startTimeSelect" data-options="formatter:myformatter, parser:myparser"/>
						至
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeSelect" name="endTimeSelect" data-options="formatter:myformatter, parser:myparser"/>
					</td>
  				</tr>
  				<tr>
  					<td colspan="7">&nbsp;</td>
					<td style="min-width: 220px;">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1011">查询</a>
						&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
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
						<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
						<th data-options="field:'byName',width:100,align:'center'">英文名</th>
						<th data-options="field:'stageIdText',width:100,align:'center', formatter:function(value, row, index) {if (row.stageIdText == '') {return row.classType;} else {return row.stageIdText;}}">课程阶段或名称</th>
						<th data-options="field:'classType',width:100,align:'center'">班级类型</th>
						<th data-options="field:'isNeedSelectText',width:120,align:'center'">是否需要选班</th>
						<th data-options="field:'feeTypeText',width:100,align:'center'">业绩类型</th>
						<th data-options="field:'payDate',width:100,align:'center'">缴费日期</th>
						<th data-options="field:'dutyAdvisterName',width:100,align:'center'">责任顾问</th>
						<th data-options="field:'phone',width:200,align:'center'">联系电话</th>
						<th data-options="field:'className',width:100,align:'center'">当前选班</th>
						<th data-options="field:'courseStateText',width:120,align:'center'">课程状态</th>
						<th data-options="field:'adviserTeacherName',width:120,align:'center'">业绩老师</th>
						<th data-options="field:'selectClassNum',width:100,align:'center'">选班次数</th>
					</tr>
				</thead>
			</table>
	  	</div>
	  	<div id="toolbar" style="padding: 2px; height: auto">
   			<a href="javascript:void(0)" id="selectClassBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px;">选班</a>
   			<a href="javascript:void(0)" id="view" class="easyui-linkbutton" iconCls="icon-redo" style="width: 80px;">浏览</a>
		</div>
		</div>
  	</body>
</html>
