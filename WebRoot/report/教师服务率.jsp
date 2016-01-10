<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/excDetail.js"></script>
  	</head>
  
  	<body>
  		<div style="padding:5px 0;">
  			<form id="qryFm" style="margin:0 auto;">
  				<input type="hidden" id="tableName" value="report_teacher_service_rate"/>
  				<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:80px;" cellspacing="2">
  					<tr>
  						<td align="right" width="50px"><span>校区：</span></td>
	  					<td width="115px">
							<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
					      		url="<%=path %>/pubData/qrySchoolList.do?schoolId=">
				        	</select>
						</td>
						<td align="right" width="25px"><span>周：</span></td>
						<td width="270px">
							<input class="easyui-datebox" type="text" style="width:80px; height: 25px;" id="year" name="year" data-options="formatter:yearFormatter, parser:yearParser"/>
							<select id="month" name="month" class="easyui-combobox" style="width: 80px; height: 25px;">
	  						</select>
	  						<select id="week" name="week" class="easyui-combobox" style="width: 80px; height: 25px;">
	  						</select>
						</td>
						<td align="left" width="250px">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1072">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
						<td align="left" width="400px">&nbsp;</td>
  					</tr>
  				</table>
  			</form>
  			<div style="padding:5px 0;min-width:1100px; width:100%;">
  				<table class="easyui-datagrid" style="height:470px;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th field="schoolName" align="center" width="5%" >校区</th>
							<th field="studentInSchoolNum" align="center" width="4%" >在校</br>生人数</th>
							<th field="studyingNum" align="center" width="3%" >在读</br>人数</th>
							<th field="studyingClassNum" align="center" width="3%" >在读</br>班级</br>总数</th>
							<th field="avgClassStudyingNum" align="center" width="6%" >平均班级人</br>数=班级数/</br>在读班级数</th>
							<th field="avgClassNum" align="center" width="6%" >平均带班量</br>=在职中教/</br>在读班级数</th>
							<th field="teacherNum" align="center" width="6%" >在职教师</br>总数（中教</br>+外教）</th>
							<th field="nativeTeacherNum" align="center" width="5%" >在职教</br>师-中教</th>
							<th field="lower3TeacherNum" align="center" width="5%" >入职3个</br>月内教</br>师人数</th>
							<th field="lower3ServiceNum" align="center" width="6%" >入职3个月</br>内教师</br>服务人数</th>
							<th field="avgLower3ServiceRate" align="center" width="8%" >入职3个月内</br>教师在读平</br>均服务效率</th>
							<th field="above3TeacherNum" align="center" width="6%" >入职3个月</br>以上普通</br>教师人数</th>
							<th field="above3ServiceNum" align="center" width="7%" >入职3个月</br>以上普通</br>教师服务人数</th>
							<th field="avgAbove3ServiceRate" align="center" width="8%" >入职3个月</br>以上在读</br>平均服务效率</th>
							<th field="avgSchoolServiceRate" align="center" width="8%" >普通教师在</br>校服务效率</br>=在校人数/在</br>职中教人数</th>
							<th field="teacherCompilation" align="center" width="5%" >教师编制</br>=在校人数</br>/36</th>
							<th field="preLeaveNum" align="center" width="11%" >1个月内待离职人数</br>（此处信息由校区反馈</br>教师待离职状态生成）</th>
							<th field="avgLeaveServiceRate" align="center" width="13%" >离职后在读服务效率=</br>3个月以上老师服务人数/</br>（入职3个月以上教师人数-</br>1个月内待离职教师人数）</th>
							<th field="avgLeaveSchoolServiceRate" align="center" width="12%" >离职后在校服务</br>效率=在校人数/（在职</br>中教-1个月内待离职）</th>
							<th field="efficiencyVariance" align="center" width="11%" data-options="formatter:formatEfficiency">效率差异需补给</br> = 教师编制 -（在职人数</br>-1个月内待离职人数）</th>
							<th field="foreignTeacherNum" align="center" width="9%" >美籍教师=在职教</br>师总数-中教人数</th>
						</tr>
					</thead>
				</table>
  			</div>
  		</div>
  	</body>
</html>
