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
  			<input type="hidden" id="tableName" value="report_academic_grade_director"/>
  			<input id="staffId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<input type="hidden" id="resourceId" value="807">	
  			<form id="qryFm">
  				<table align="center" class="search_tab">
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
						<td align="right" width="100px"><span>教师学员比：</span></td>
						<td width="130px">
							<input name="minRate" id="minRate" type="text" class="easyui-numberbox" style="width: 53px; height: 25px;"/>
							<span style="display: inline-block; text-align: center; width: 14px;">至</span>
							<input name="maxRate" id="maxRate" type="text" class="easyui-numberbox" style="width: 53px; height: 25px;"/>
						</td>
						<td align="left" width="250px">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1069">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
  					</tr>
  				</table>
  			</form>
  				<table class="easyui-datagrid" style="height:auto;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th field="schoolName" align="center" width="10%">校区</th>
							<th field="postName" align="center" width="20%">入职时间</th>
							<th field="teacherNum" align="center" width="15%">教师人数</th>
							<th field="classNum" align="center" width="15%">带班量</th>
							<th field="studyingNum" align="center" width="20%">带班学员数</th>
							<th field="rate" align="center" width="20%">教师学员比</th>
						</tr>
					</thead>
				</table>
  			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
			</div>
  		</div>
  	</body>
</html>
<script>
exportMergeLink("export","list_data","schoolId","0");
</script>