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
  
  	<body>
  		<div style="margin-right:5px;">
  		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
  		<form id="qryFm">
  			<table class="search_tab">
  				<tr>
  					<td align="right" width="70px"><span>校区：</span></td>
			  		<td width="100px">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
				        </select>
					</td>
					<td align="right" width="70px"><span>学员姓名：</span></td>
					<td width="100px">
						<input name="studentId" id="studentId" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
					</td>
					<td align="right" width="70px"><span>证件号码：</span></td>
					<td width="210px">
						<input name="identityId" id="identityId" type="text" class="easyui-textbox" style="width: 210px; height: 25px;"/>
					</td>
					<td align="right" width="70px"><span>缴费日期：</span></td>
			  		<td width="225px">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTimePay" name="startTimePay" data-options="formatter:myformatter, parser:myparser"/>
						至
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTimePay" name="endTimePay" data-options="formatter:myformatter, parser:myparser"/>
					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>业绩顾问：</span></td>
			  		<td>
						<select id="adviserId" name="adviserId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
				       	</select>
					</td>
					<td align="right"><span>联系电话：</span></td>
					<td>
						<input name="phone" id="phone" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
					</td>
					<td align="right"><span>课程类型：</span></td>
					<td>
						<select id="courseType" name="courseType" class="easyui-combobox" style="width: 100px; height: 25px;">
				        </select>
				        <select id="stageId" name="stageId" class="easyui-combobox" style="width: 100px; height: 25px;">
		        		</select>
		        	</td>
		        	<td colspan="2" align="left">
  						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="1024">查询</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
  					</td>
		        	
  				</tr>
  				<tr>
  					<td align="right"><span>课程状态：</span></td>
  					<td colspan="7">
  						<input type="checkbox" name="courseState" value="'001'"/><span>未定班</span>&nbsp;
						<input type="checkbox" name="courseState" value="'002'"/><span>已定班</span>&nbsp;
						<input type="checkbox" name="courseState" value="'003'"/><span>在读</span>&nbsp;
						<input type="checkbox" name="courseState" value="'004'"/><span>休学</span>&nbsp;
						<input type="checkbox" name="courseState" value="'005'"/><span>异常</span>&nbsp;
						<input type="checkbox" name="courseState" value="'006'"/><span>转班</span>&nbsp;
						<input type="checkbox" name="courseState" value="'007'"/><span>转校</span>&nbsp;
  					</td>
  				</tr>
  			</table>
  		</form>
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
