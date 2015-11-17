<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/refund/refundStudentCourseList.js"></script>
  	</head>
  
  	<body style="padding-top:5px">
  		<form id="qryFm" style="margin:0 auto;">
  			<table align="center" style="min-width:1100px;width:100%;border:1px solid #95B8E7;margin:0 auto;height:80px;">
  				<tr>
  					<td align="right"><span>校区：</span></td>
			  		<td width="130px">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 130px; height: 25px;" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
					      	onLoadSuccess:function(data){if(data.length > 0) $('#schoolId').combobox('setValue',data[0].schoolId);}"
					      	url="<%=path %>/pubData/qrySchoolList.do?schoolId=${sessionScope.StaffT.schoolId}">
				        </select>
					</td>
					<td align="right"><span>学员姓名：</span></td>
					<td width="130px">
						<select id="studentId" name="studentId" class="easyui-combobox" style="width: 130px; height: 25px;">
		        		</select>
					</td>
					<td align="right"><span>证件号码：</span></td>
					<td width="210px">
						<input name="identityId" id="identityId" type="text" class="easyui-textbox" style="width: 210px; height: 25px;"/>
					</td>
					<td align="right"><span>缴费日期：</span></td>
			  		<td width="100px">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimePay" name="startTimePay" ata-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center"><span>至</span></td>
					<td width="100px">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimePay" name="endTimePay" ata-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td width="150px">&nbsp;</td>
  				</tr>
  				<tr>
  					<td align="right"><span>业绩顾问：</span></td>
			  		<td width="130px">
						<select id="adviserId" name="adviserId" class="easyui-combobox" style="width: 130px; height: 25px;" editable="false">
				       	</select>
					</td>
					<td align="right"><span>联系电话：</span></td>
					<td width="130px">
						<input name="phone" id="phone" type="text" class="easyui-textbox" style="width: 130px; height: 25px;"/>
					</td>
					<td align="right"><span>课程类型：</span></td>
					<td width="100px" colspan="5">
						<select id="courseType" name="courseType" class="easyui-combobox" style="width: 100px; height: 25px;"
							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
				      		onLoadSuccess:function(data){$('#courseType').combobox('setValue',data[0].codeFlag);}" 
				      		url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=COURSE_TYPE">
				        </select>
				        <select id="stageId" name="stageId" class="easyui-combobox" style="width: 100px; height: 25px;"
							data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto',
				      		onLoadSuccess:function(data){if(data.length > 0) $('#stageId').combobox('setValue',data[0].stageId);}" 
				      		url="<%=path %>/pubData/qryStage.do">
		        		</select>
		        	</td>
  				</tr>
  				<tr>
  					<td align="right"><span>课程状态：</span></td>
  					<td colspan="5">
  						<input type="checkbox" name="courseState" value="'001'"/><span>未定班</span>&nbsp;
						<input type="checkbox" name="courseState" value="'002'"/><span>已定班</span>&nbsp;
						<input type="checkbox" name="courseState" value="'003'"/><span>在读</span>&nbsp;
						<input type="checkbox" name="courseState" value="'004'"/><span>休学</span>&nbsp;
						<input type="checkbox" name="courseState" value="'005'"/><span>异常</span>&nbsp;
						<input type="checkbox" name="courseState" value="'006'"/><span>转班</span>&nbsp;
						<input type="checkbox" name="courseState" value="'007'"/><span>转校</span>&nbsp;
  					</td>
  					<td colspan="4" align="right">
  						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1024">查询</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
  					</td>
  					<td width="150px">&nbsp;</td>
  				</tr>
  			</table>
  		</form>
  		<div style="padding:5px 0;min-width:1100px; width:100%;">
		  	<table class="easyui-datagrid" title="查询结果" style="height:435px;" id="list_data" 
		  		url="<%=path %>/pubData/qryDataListByPage.do?funcNodeId=1024" 
		  		toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'schoolName',width:100,align:'center'">校区</th>
						<th data-options="field:'name',width:100,align:'center'">学员姓名</th>
						<th data-options="field:'byName',width:100,align:'center'">英文名</th>
						<th data-options="field:'identityId',width:180,align:'center'">证件号码</th>
						<th data-options="field:'feeTypeText',width:120,align:'center'">业绩类型</th>
						<th data-options="field:'classType',width:100,align:'center'">班级类型</th>
						<th data-options="field:'payDate',width:100,align:'center'">缴费日期</th>
						<th data-options="field:'adviserName',width:100,align:'center'">业绩顾问</th>
						<th data-options="field:'teacherName',width:100,align:'center'">带班老师</th>
						<th data-options="field:'dutyAdvisterName',width:100,align:'center'">责任顾问</th>
						<th data-options="field:'courseStateText',width:100,align:'center'">课程状态</th>
						<th data-options="field:'className',width:100,align:'center'">当前班级</th>
						<th data-options="field:'phone',width:200,align:'center'">联系电话</th>
					</tr>
				</thead>
			</table>
	  	</div>
	  	<div id="toolbar" style="padding: 2px; height: auto">
		   	<a href="javascript:void(0)" id="refundSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">退费</a>
	      	<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
		</div>
  	</body>
</html>
