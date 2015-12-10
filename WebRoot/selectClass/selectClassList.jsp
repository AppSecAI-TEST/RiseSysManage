<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<%@ include file="../common/pub.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/selectClass/selectClassList.js"></script>
  	</head>
  
  	<body style="padding-top:5px">
  		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
		<input type="hidden" id="funcNodeId" value="${param.funcNodeId}"/>
  		<form id="qryFm" style="margin:0 auto;">
  			<table align="center" style="min-width:1100px;width:100%;border:1px solid #95B8E7;margin:0 auto;height:80px;">
  				<tr>
  					<td align="right"><span>校区：</span></td>
	  				<td width="100px">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;">
		        		</select>
					</td>
					<td align="right"><span>学员姓名：</span></td>
					<td width="114px">
						<select id="studentId" name="studentId" class="easyui-combobox" style="width: 100px; height: 25px;"
							data-options="formatter:function(data){return '<span>'+data.name+'</span>';}, valueField: 'studentId', textField: 'name', panelHeight: 'auto'"	
							url="<%=path %>/pub/paramComboxList.do?staffId=${sessionScope.StaffT.staffId}&schoolId=&funcNodeId=${param.funcNodeId}&fieldId=studentId">
		        		</select>
					</td>
					<td align="right"><span>联系电话：</span></td>
					<td width="130px">
						<input name="phone" id="phone" type="text" class="easyui-textbox" style="width: 117px; height: 25px;"/>
					</td>
					<td align="right"><span>课程类型：</span></td>
					<td width="100px">
						<select id="courseType" name="courseType" class="easyui-combobox" style="width: 100px; height: 25px;">
		        		</select>
		        	</td>
		        	<td align="center" width="14px">&nbsp;</td>
		        	<td width="100px" colspan="2">
						<select id="stageId" name="stageId" class="easyui-combobox" style="width: 100px; height: 25px;">
		        		</select>
					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>责任顾问：</span></td>
	  				<td width="100px">
						<select id="dutyAdvister" name="dutyAdvister" class="easyui-combobox" style="width: 100px; height: 25px;"
							data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', panelHeight: 'auto'"
     						url="<%=path %>/pubData/qryStaffList.do?schoolId=${sessionScope.StaffT.schoolId}">
      					</select>
					</td>
					<td align="right"><span>业绩老师：</span></td>
	  				<td width="114px">
						<select id="adviserTeacher" name="adviserTeacher" class="easyui-combobox" style="width: 100px; height: 25px;"
							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'"
      						url="<%=path %>/pubData/qryTeacherList.do?schoolId=${sessionScope.StaffT.schoolId}&classType=">
      					</select>
					</td>
					<td align="right"><span>选班次数：</span></td>
					<td width="130px">
						<input name="minSelectNum" id="minSelectNum" type="text" class="easyui-numberbox" style="width: 43px; height: 25px;"/>
						<span style="display: inline-block; text-align: center; width: 14px;">至</span>
						<input name="maxSelectNum" id="maxSelectNum" type="text" class="easyui-numberbox" style="width: 43px; height: 25px;"/>
					</td>
					<td align="right"><span>缴费日期：</span></td>
	  				<td width="100px">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimePay" name="startTimePay" ata-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center" width="14px"><span>至</span></td>
					<td width="100px" colspan="2">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimePay" name="endTimePay" ata-options="formatter:myformatter, parser:myparser"/>
					</td>
  				</tr>
  				<tr>
					<td align="right"><span>业绩类型：</span></td>
					<td width="100px">
						<select id="feeType" name="feeType" class="easyui-combobox" style="width: 100px; height: 25px;"
							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" 
		      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=FEE_TYPE">
		        		</select>
					</td>
					<td align="right"><span><input type="radio" name="isNeed" value="'Y', 'N'"/>所有课程：</span></td>
					<td width="130px">
						<input type="checkbox" name="courseStateAll" value="'001'" disabled="disabled"/><span>未定班</span>
						<input type="checkbox" name="courseStateAll" value="'002'" disabled="disabled"/><span>已定班</span>
					</td>
					<td align="right"><span><input type="radio" name="isNeed" value="'Y'"/>需选班：</span></td>
					<td width="114px">
						<input type="checkbox" name="courseStateNeed" value="'001'" disabled="disabled"/><span>未定班</span>
						<input type="checkbox" name="courseStateNeed" value="'002'" disabled="disabled"/><span>已定班</span>
					</td>
					<td align="right"><span>选班日期：</span></td>
	  				<td width="100px">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimeSelect" name="startTimeSelect" ata-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center" width="14px"><span>至</span></td>
					<td width="100px">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimeSelect" name="endTimeSelect" ata-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1011">查询</a>
						&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
					</td>
  				</tr>
  			</table>
  		</form>
  		
  		<div style="padding:5px 0;min-width:1100px; width:100%;">
		  	<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="list_data" url="<%=path %>/pubData/qryDataListByPage.do?funcNodeId=1011" 
		  		toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'schoolName',width:80,align:'center'">校区</th>
						<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
						<th data-options="field:'byName',width:100,align:'center'">英文名</th>
						<th data-options="field:'stageIdText',width:100,align:'center'">课程阶段或名称</th>
						<th data-options="field:'classType',width:100,align:'center'">班级类型</th>
						<th data-options="field:'isNeedSelectText',width:120,align:'center'">是否需要选班</th>
						<th data-options="field:'feeTypeText',width:100,align:'center'">业绩类型</th>
						<th data-options="field:'payDate',width:100,align:'center'">缴费日期</th>
						<th data-options="field:'dutyAdvisterName',width:100,align:'center'">责任顾问</th>
						<th data-options="field:'phone',width:200,align:'center'">联系电话</th>
						<th data-options="field:'currentClassName',width:100,align:'center'">当前选班</th>
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
  	</body>
</html>
