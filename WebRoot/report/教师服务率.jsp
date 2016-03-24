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
  		<div style="margin-right:5px;">
  			<input type="hidden" id="resourceId" value="805">	
  			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId}"/>
  			<input type="hidden" id="tableName" value="report_teacher_service_rate"/>
  			<form id="qryFm">
  				<table class="search_tab">
  					<tr>
  						<td align="right" width="50px"><span>校区：</span></td>
	  					<td width="115px">
		  					<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
									data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
						      		
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
  				<table class="easyui-datagrid" style="height:470px;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th field="schoolName" align="center" width="5%" >校区</th>
							<th field="studentInSchoolNum" align="center" width="4%" >在校</br>生人数</th>
							<th field="studyingNum" align="center" width="3%" >在读</br>人数</th>
							<th field="studyingClassNum" align="center" width="5%" >在读班</br>级总数</th>
							<th field="avgClassStudyingNum" align="center" width="4%" >平均班</br>级人数</th>
							<th field="avgClassNum" align="center" width="4%" >平均带</br>班量</th>
							<th field="teacherNum" align="center" width="4%" >在职教</br>师总数</th>
							<th field="nativeTeacherNum" align="center" width="5%" >在职教</br>师-中教</th>
							<th field="lower3TeacherNum" align="center" width="5%" >入职3个</br>月内教</br>师人数</th>
							<th field="lower3ServiceNum" align="center" width="6%" >入职3个月</br>内教师</br>服务人数</th>
							<th field="avgLower3ServiceRate" align="center" width="8%" >入职3个月内</br>教师在读平</br>均服务效率</th>
							<th field="above3TeacherNum" align="center" width="6%" >入职3个月</br>以上普通</br>教师人数</th>
							<th field="above3ServiceNum" align="center" width="7%" >入职3个月</br>以上普通教</br>师服务人数</th>
							<th field="avgAbove3ServiceRate" align="center" width="8%" >入职3个月</br>以上在读平</br>均服务效率</th>
							<th field="avgSchoolServiceRate" align="center" width="8%" >普通教师在</br>校服务效率</th>
							<th field="teacherCompilation" align="center" width="5%" >教师编制</th>
							<th field="preLeaveNum" align="center" width="6%" >1个月内</br>待离职人数</th>
							<th field="avgLeaveServiceRate" align="center" width="6%" >离职后在读</br>服务效率</th>
							<th field="avgLeaveSchoolServiceRate" align="center" width="6%" >离职后在校</br>服务效率</th>
							<th field="efficiencyVariance" align="center" width="6%" data-options="formatter:formatEfficiency">效率差异</br>需补给</th>
							<th field="foreignTeacherNum" align="center" width="5%" >美籍教师</th>
						</tr>
					</thead>
				</table>
				<div id="toolbar" style="padding: 2px; height: auto">
	   				<a href="javascript:void(0)" id="export" class="easyui-linkbutton" onclick="exportData()" iconCls="icon-add" style="width: 100px;">导出全部</a>
				</div>
  		</div>
  	</body>
</html>
<script type="text/javascript">
	function exportData()
	{
		if($("#list_data").datagrid("getData").total>0)
		{
			var fileName =parent.$("li.tabs-selected").find("span.tabs-title").html();
			var array =JSON.stringify($("#list_data").datagrid("getData").rows);
			try
			{
				window.location.href="/sys/export/exportServiceRate.do?fileName="+fileName+"&array="+array;
			}
			catch(e)
			{
				$.messager.alert('提示', "模版不存在",function(){
					window.history.back();
				});
			}
		}
		else
		{
			$.messager.alert('提示', "没有数据可以导出");
		}	
	}
</script>