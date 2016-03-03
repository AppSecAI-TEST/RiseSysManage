<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/exceptionManage/exceptionManage.js"></script>
  	</head>
  	<body>
  		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
  		<div style="margin-right:5px">
	 		<form id="qryFm">
	  			<table class="search_tab">
	  				<tr>
	  					<td align="right" style="width: 70px"><span>校区：</span></td>
	  					<td align="left" style="width: 100px">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;">
	        				</select>
	  					</td>
	  					<td align="right" style="width: 80px"><span>课程阶段：</span></td>
	  					<td align="left" style="width: 100px">
	  						<select id="stageId" name="stageId" class="easyui-combobox"  style="width:100px; height: 25px;"
								data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'" 
		      					url="<%=path %>/pubData/qryStage.do">
		      				</select>
	  					</td>
	  					<td align="right" style="width: 80px"><span>老师：</span></td>
	  					<td align="left" style="width: 120px">
	  						<select name="teacherId" id="teacherId" class="easyui-combobox" style="width: 120px; height: 25px;">
							</select>
	  					</td>
	  					<td align="right" style="width: 80px"><span>缴费日期：</span></td>
	  					<td align="left">
	  						<input class="easyui-datebox" name="startTimePay" id="startTimePay" style="width:100px; height: 25px;" />
	  						至
	  						<input class="easyui-datebox" name="endTimePay" id="endTimePay" style="width:100px; height: 25px;" />
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right"><span>责任顾问：</span></td>
	  					<td align="left">
	  						<select id="dutyAdvister" name="dutyAdvister" class="easyui-combobox" style="width: 100px; height: 25px;">
	      					</select>
	  					</td>
	  					<td align="right"><span>客户关怀：</span></td>
	  					<td align="left">
	  						<select id="carer" name="carer" class="easyui-combobox" style="width: 100px; height: 25px;">
	     					</select>
	  					</td>
	  					<td align="right"><span>异动类型：</span></td>
	  					<td align="left">
	     					<select id="expType" name="expType" class="easyui-combobox"  style="width:120px; height: 25px;" editable="false"
		  						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
		  						onLoadSuccess:function(data){$('#expType').combobox('setValue',data[0].codeFlag);}"
		      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_CARE_T&codeType=EXCEPTION_TYPE">
	        				</select>
	  					</td>
	  					<td align="right"><span>异动日期：</span></td>
	  					<td align="left">
	  						<input class="easyui-datebox" name="startTimeExp" id="startTimeExp" style="width:100px; height: 25px;" />
	  						至
	  						<input class="easyui-datebox" name="endTimeExp" id="endTimeExp" style="width:100px; height: 25px;" />
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right"><span>学员姓名：</span></td>
	  					<td align="left">
	  						<input id="studentName" name="studentName" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
	  					</td>
	  					<td align="right"><span>联系电话：</span></td>
	  					<td align="left">
	  						<input class="easyui-numberbox" name="phone" id="phone" style="width:100px; height: 25px;" />
	  					</td>
	  					<td colspan="3">
	  					<td align="left">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="4200">查询</a>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset" >重置</a>
						</td>
	  				</tr>
	  			</table>
	 		</form>
	 		<table class="easyui-datagrid" title="学员列表" style="height:435px;" id="list_data" 
				toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false">
				<thead>
					<tr>
						<th field="ck" align="center" checkbox="true" width="1%"></th>
						<th field="schoolName" align="center" width="6%">校区</th>
						<th field="name" align="center" width="7%">学员姓名</th>
						<th field="byName" align="center" width="6%">英文名</th>
						<th field="exceptionTypeText" align="center" width="8%">异动类型</th>
						<th field="stageId" align="center" width="7%">课程阶段</th>
						<th field="payDate" align="center" width="7%">缴费日期</th>
						<th field="dutyAdvisterName" align="center" width="7%">责任顾问</th>
						<th field="carerName" align="center" width="7%">客户关怀</th>
						<th field="teacherName" align="center" width="7%">老师</th>
						<th field="className" align="center" width="7%">当前班级</th>
						<th field="careNum" align="center" width="7%">跟进次数</th>
						<th field="exceptionBeginDate" align="center" width="8%">异动开始时间</th>
						<th field="exceptionDays" align="center" width="8%">异动时长（天）</th>
						<th field="lastCareDate" align="center" width="8%">最后跟进时间</th>
						<th field="lastCareRemark" align="center" width="10%">最后跟进内容</th>
					</tr>
				</thead>
			</table>
			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="updateBtn" class="easyui-linkbutton" iconCls="icon-edit" onclick="updateExp()">客户维护</a>
	 			<a href="javascript:void(0)" id="viewBtn" class="easyui-linkbutton" iconCls="icon-redo" onclick="viewExpInfo()">浏览</a>
	 		</div>
  		</div>
  	</body>
</html>
