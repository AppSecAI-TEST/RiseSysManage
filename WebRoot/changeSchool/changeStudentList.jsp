<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/changeSchool/changeStudent.js"></script>
  	</head>
  
  	<body style="padding-top:5px">
  		<form id="qryFm" style="margin:0 auto;">
  			<table align="center" style="min-width:1100px;width:100%;border:1px solid #95B8E7;margin:0 auto;height:80px;">
  				<tr>
  					<td align="right"><span>学员姓名：</span></td>
					<td width="100px">
						<select id="studentId" name="studentId" class="easyui-combobox" style="width: 114px; height: 25px;">
				        </select>
					</td>
					<td align="right"><span>联系电话：</span></td>
					<td width="100px">
						<input name="phone" id="phone" type="text" class="easyui-textbox" style="width: 114px; height: 25px;"/>
					</td>
					<td align="right"><span>证件号码：</span></td>
					<td width="100px">
						<input name="identityId" id="identityId" type="text" class="easyui-textbox" style="width: 150px; height: 25px;"/>
					</td>
					<td width="40%">&nbsp;</td>
  				</tr>
  				<tr>
  					<td align="right"><span>校区：</span></td>
					<td width="100px">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 114px; height: 25px;" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
					      	onLoadSuccess:function(data){if(data.length > 0) $('#schoolId').combobox('setValue',data[0].schoolId);}"
					      	url="<%=path %>/pubData/qrySchoolList.do">
				        </select>
					</td>
					<td align="right"><span>带班老师：</span></td>
					<td width="100px">
						<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 114px; height: 25px;"
							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto',
	      					onLoadSuccess:function(data){if(data.length > 0) $('#teacherId').combobox('setValue',data[0].teacherId);}" 
	      					url="<%=path %>/pubData/qryTeacherList.do?schoolId=${sessionScope.StaffT.schoolId}&classType=">
				        </select>
					</td>
					<td colspan="2" align="right">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1015">查询</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
					</td>
					<td width="40%">&nbsp;</td>
  				</tr>
  			</table>
  		</form>
  		<div style="padding:5px 0;min-width:1100px; width:100%;">
		  	<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="list_data" url="<%=path %>/pubData/qryDataListByPage.do?funcNodeId=1015" 
		  		toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
						<th data-options="field:'byName',width:100,align:'center'">英文名</th>
						<th data-options="field:'phone',width:200,align:'center'">联系电话</th>
						<th data-options="field:'higherStageId',width:120,align:'center'">已升学阶段</th>
						<th data-options="field:'classType',width:100,align:'center'">当前课程</th>
						<th data-options="field:'feeTypeText',width:100,align:'center'">业绩类型</th>
						<th data-options="field:'adviserName',width:100,align:'center'">业绩顾问</th>
						<th data-options="field:'currentClassName',width:100,align:'center'">在读班</th>
						<th data-options="field:'adviserTeacherName',width:100,align:'center'">带班老师</th>
						<th data-options="field:'currentClassProgress',width:100,align:'center'">课程进度</th>
						<th data-options="field:'courseStateText',width:100,align:'center'">在读课程状态</th>
					</tr>
				</thead>
			</table>
	  	</div>
  		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: left;margin-left: 800px;">
	      		<a href="javascript:void(0)" id="applyChangeSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      		&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
  	</body>
</html>