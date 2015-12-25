<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/newRecruit.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				$("#list_data").datagrid({
					onClickRow : function(index, row) {
						var classInstId = row.classInstId;
						$("#class_list_data").datagrid({
							url : "/sys/pubData/qryDataListByPage.do?param={'funcNodeId':'1046', 'classInstId':'"+classInstId+"'}"
						});
						$("#dlg").dialog("open").dialog("setTitle", "班级学员列表");//设定表头  
	    				$("#studentFm").form("clear");//清空窗体数据  
					}
				});
			});
		</script>
  	</head>
  
  	<body>
  		<div style="padding:5px 0;">
  			<form id="qryFm" style="margin:0 auto;">
	  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:80px;" cellspacing="2">
	  				<tr>
	  					<td align="right"><span>校区：</span></td>
	  					<td width="100px">
							<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
					      		url="<%=path %>/pubData/qrySchoolList.do?schoolId=">
				        	</select>
						</td>
	  					<td align="right"><span>课程阶段：</span></td>
						<td width="100px">
							<select id="stageId" name="stageId" class="easyui-combobox" style="width: 114px; height: 25px;"
								data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'" 
			      				url="<%=path %>/pubData/qryStage.do">
				        	</select>
						</td>
	  					<td align="right"><span>定班人数：</span></td>
						<td width="130px">
							<input name="minClassStudentNum" id="minClassStudentNum" type="text" class="easyui-textbox" style="width: 43px; height: 25px;"/>
							<span style="display: inline-block; text-align: center; width: 14px;">至</span>
							<input name="maxClassStudentNum" id="maxClassStudentNum" type="text" class="easyui-textbox" style="width: 43px; height: 25px;"/>
						</td>
	  					<td align="right"><span>开课日期：</span></td>
						<td width="114px">
							<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="startTimeOpenClass" name="startTimeOpenClass" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="center" width="14px"><span>至</span></td>
						<td width="114px">
							<input class="easyui-datebox" type="text" style="width:114px; height: 25px;" id="endTimeOpenClass" name="endTimeOpenClass" data-options="formatter:myformatter, parser:myparser"/>
						</td>
						<td align="center">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1045">查询</a>
							&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
						</td>
	  				</tr>	
	  			</table>
  			</form>
			<div style="padding:5px 0;min-width:1100px; width:100%;">
				<table class="easyui-datagrid" style="height:435px;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th data-options="field:'schoolName',width:100,align:'center'">校区</th>
							<th data-options="field:'className',width:100,align:'center'">班级</th>
							<th data-options="field:'schooltimeName',width:250,align:'center'">上课时间</th>
							<th data-options="field:'classStudentNum',width:100,align:'center'">班级人数</th>
							<th data-options="field:'minSubNum',width:120,align:'center'">距最低开班人数</th>
							<th data-options="field:'startDate',width:100,align:'center'">开课日期</th>
						</tr>
					</thead>
				</table>
			</div>
			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
			</div>
  		</div>
  		<div id="dlg" class="easyui-dialog" style="width: 900px; height: auto;" closed="true" data-options="modal:true">
  			<form id="studentFm">
				<table class="easyui-datagrid" style="width: 100%;height: auto; overflow: auto;" id="class_list_data"  
					pagination="false" rownumbers="true" fitColumns="true" singleSelect="false">
					<thead>
						<tr>
							<th data-options="field:'payDate',width:100,align:'center'">缴费日期</th>
							<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
							<th data-options="field:'studentChannelType',width:100,align:'center'">学员来源</th>
							<th data-options="field:'identityId',width:150,align:'center'">本人身份证号</th>
							<th data-options="field:'phone',width:150,align:'center'">联系方式</th>
							<th data-options="field:'adviserName',width:150,align:'center'">业绩顾问</th>
							<th data-options="field:'adviserTeacherName',width:150,align:'center'">业绩老师</th>
						</tr>
					</thead>
				</table>
  			</form>
		</div>
  	</body>
</html>
<script>
	exportLink("export","list_data");
</script>