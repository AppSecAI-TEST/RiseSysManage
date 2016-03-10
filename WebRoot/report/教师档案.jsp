<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/teacherArchives.js"></script>
  	</head>
  	<body>
  		<div style="margin-right:5px;">
  			<input type="hidden" id="tableName" value="report_teacher_archives"/>
  			<form id="qryFm">
  				<input id="staffId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  				<input type="hidden" id="resourceId" value="735">	
	  			<table class="search_tab">
	  				<tr>
	  					<td align="right" width="70px"><span>校区：</span></td>
	  					<td width="110px">
		  					<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
									data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
					        </select>					
						</td>
	  					<td align="right" width="60px"><span>英文名：</span></td>
	  					<td width="110px">
	  						<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 110px; height: 25px;">
	  						</select>
	  					</td>
	  					<td align="right" width="25px"><span>周：</span></td>
						<td width="280px">
							<input class="easyui-datebox" type="text" style="width:80px; height: 25px;" id="year" name="year" data-options="formatter:yearFormatter, parser:yearParser"/>
							<select id="month" name="month" class="easyui-combobox" style="width: 80px; height: 25px;">
	  						</select>
	  						<select id="week" name="week" class="easyui-combobox" style="width: 80px; height: 25px;">
	  						</select>
						</td>
						<td align="right" width="110px"><span>在读带班持证率：</span></td>
						<td>
							<input name="minLicenseRate" id="minLicenseRate" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
							<span style="display: inline-block; text-align: center; width: 32px;">%&nbsp;至&nbsp;</span>
							<input name="maxLicenseRate" id="maxLicenseRate" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
							<span style="display: inline-block; text-align: center; width: 3px;">%</span>
						</td>
	  				</tr>
	  				<tr>
	  					<td align="right"><span>持证数量：</span></td>
						<td>
							<input name="minLicenseNum" id="minLicenseNum" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
							<span style="display: inline-block; text-align: center; width: 14px;">至</span>
							<input name="maxLicenseNum" id="maxLicenseNum" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
						</td>
	  					<td align="right"><span>带班量：</span></td>
						<td>
							<input name="minClassNum" id="minClassNum" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
							<span style="display: inline-block; text-align: center; width: 14px;">至</span>
							<input name="maxClassNum" id="maxClassNum" type="text" class="easyui-numberbox" style="width: 45px; height: 25px;"/>
						</td>
						<td align="right"><span>入职日期：</span></td>
	  					<td>
							<input class="easyui-datebox" type="text" style="width:115px; height: 25px;" id="startTimeHireDate" name="startTimeHireDate" data-options="formatter:myformatter, parser:myparser"/>
							至
							<input class="easyui-datebox" type="text" style="width:115px; height: 25px;" id="endTimeHireDate" name="endTimeHireDate" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td colspan="2">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1071">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
	  				</tr>
	  				<tr>	
	  					<td align="right"><span>持证阶段：</span></td>
	  					<td colspan="7" id="licenseStageTd"></td>
	  				</tr>
	  				<tr>	
	  					<td align="right"><span>带班阶段：</span></td>
	  					<td colspan="7" id="stageTd"></td>
	  				</tr>
	  			</table>
  			</form>
				<table class="easyui-datagrid" title="查询结果" style="height: 435px" id="list_data" 
				  		toolbar="#toolbar" pagination="false" rownumbers="false" fitColumns="true">
					<thead>
						<tr>
							<th field="baseInfo" align="center" width="5%" colspan="11">教师带班基本信息</th>
							<th field="classInfo" align="center" width="5%" colspan="6">教师带班情况（只统计教师所带在读班级明细）</th>
							<th field="licenseInfo" align="center" width="5%" colspan="11">教师持证明细（实时的持证情况）</th>
							<th field="rateInfo" align="center" width="15%">带班持证率</th>
							<th field="rateInfo" align="center" width="600" colspan="5">周一</th>
							<th field="rateInfo" align="center" width="600" colspan="5">周二</th>
							<th field="rateInfo" align="center" width="600" colspan="5">周三</th>
							<th field="rateInfo" align="center" width="600" colspan="5">周四</th>
							<th field="rateInfo" align="center" width="600" colspan="5">周五</th>
							<th field="rateInfo" align="center" width="600" colspan="5">周六</th>
							<th field="rateInfo" align="center" width="600" colspan="5">周日</th>
						</tr>
						<tr>
							<th field="schoolName" align="center" width="5%" >校区</th>
							<th field="rownum" align="center" width="3%" >序号</th>
							<th field="teacherName" align="center" width="5%" >中文名字</th>
							<th field="byname" align="center" width="10%" >英文名字</th>
							<th field="jobProperty" align="center" width="6%" >兼职or全职</th>
							<th field="postName" align="center" width="7%" >职位</th>
							<th field="tState" align="center" width="5%" >状态</th>
							<th field="hireDate" align="center" width="10%" >入职日期</th>
							<th field="workMonths" align="center" width="5%" >工作时长</th>
							<th field="gradeTeam" align="center" width="10%" >教师所在组别</th>
							<th field="finishClassNum" align="center" width="8%" >已结课班级</th>
							<th field="className" align="center" width="10%" >带班明细</th>
							<th field="hours" align="center" width="5%" >主T</th>
							<th field="stageNum" align="center" width="10%" >带班阶段数量</th>
							<th field="classNum" align="center" width="10%" >带班量合计</th>
							<th field="studyingNum" align="center" width="10%" >带班学员人数</th>
							<th field="totalHours" align="center" width="10%" >主T总计</th>
							<th field="Pre-K" align="center" width="5%" >Pre-K</th>
							<th field="K" align="center" width="5%" >K</th>
							<th field="PreRISE" align="center" width="8%" >PreRISE</th>
							<th field="S1" align="center" width="5%" >S1</th>
							<th field="S2" align="center" width="5%" >S2</th>
							<th field="S3" align="center" width="5%" >S3</th>
							<th field="S4" align="center" width="5%" >S4</th>
							<th field="S5" align="center" width="5%" >S5</th>
							<th field="PreMiddle" align="center" width="10%" >PreMiddle</th>
							<th field="RiseUp" align="center" width="8%" >RiseUp</th>
							<th field="licenseNum" align="center" width="8%" >持证数量</th>
							<th field="licenseRate" align="center" width="15%" >所带班级中持证数量/带班数量</th>
							<th field="H001" align="center" width="120">上午1</th>
							<th field="H002" align="center" width="120">上午2</th>
							<th field="H003" align="center" width="120">下午1</th>
							<th field="H004" align="center" width="120">下午2</th>
							<th field="H005" align="center" width="120">晚上</th>
							<th field="H001" align="center" width="120">上午1</th>
							<th field="H002" align="center" width="120">上午2</th>
							<th field="H003" align="center" width="120">下午1</th>
							<th field="H004" align="center" width="120">下午2</th>
							<th field="H005" align="center" width="120">晚上</th>
							<th field="H001" align="center" width="120">上午1</th>
							<th field="H002" align="center" width="120">上午2</th>
							<th field="H003" align="center" width="120">下午1</th>
							<th field="H004" align="center" width="120">下午2</th>
							<th field="H005" align="center" width="120">晚上</th>
							<th field="H001" align="center" width="120">上午1</th>
							<th field="H002" align="center" width="120">上午2</th>
							<th field="H003" align="center" width="120">下午1</th>
							<th field="H004" align="center" width="120">下午2</th>
							<th field="H005" align="center" width="120">晚上</th>
							<th field="H001" align="center" width="120">上午1</th>
							<th field="H002" align="center" width="120">上午2</th>
							<th field="H003" align="center" width="120">下午1</th>
							<th field="H004" align="center" width="120">下午2</th>
							<th field="H005" align="center" width="120">晚上</th>
							<th field="H001" align="center" width="120">上午1</th>
							<th field="H002" align="center" width="120">上午2</th>
							<th field="H003" align="center" width="120">下午1</th>
							<th field="H004" align="center" width="120">下午2</th>
							<th field="H005" align="center" width="120">晚上</th>
							<th field="H001" align="center" width="120">上午1</th>
							<th field="H002" align="center" width="120">上午2</th>
							<th field="H003" align="center" width="120">下午1</th>
							<th field="H004" align="center" width="120">下午2</th>
							<th field="H005" align="center" width="120">晚上</th>
						</tr>
					</thead>
				</table>
			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
			</div>
  		</div>
  	</body>
</html>
